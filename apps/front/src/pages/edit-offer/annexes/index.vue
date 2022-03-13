<template>
  <div class="edit-offer-price">
    <div class="side">
      <h1 class="title-side">
        {{ $t("offer.titles.annexeServices") }}
      </h1>
      <p class="subtitle">
        <em
        >{{ $t("offer.paragraphs.annexeServices") }}</em>
      </p>

      <div class="price-period">
        <form
          class="price-period__content"
          @submit.prevent="addAnnexe">
          <div class="price-period__content__header">
            <h3>
              {{ $t("offer.titles.addAnnexe") }}
            </h3>
          </div>

          <label
            for="name"
            class="name-label">
            Nom du service
          </label>

          <br>

          <select
            id="name"
            v-model="tmp.offerAnnexeService.name">
            <option
              v-for="service in services"
              :key="service"
              :value="service.value">{{ service.text }}</option>
          </select>

          <br>

          <wi-input
            v-validate="'required|decimal:2|min_value:0'"
            id="annexeService"
            v-model="tmp.offerAnnexeService.price"
            :error="errors.first('annexe-service.price')"
            data-vv-scope="annexe-service"
            data-vv-as="prix"
            name="price"
            label="Prix du service annexe"
            type="number"
          />

          <br>

          <label
            for="description"
            class="name-label">
            Description du service
          </label>

          <wi-textarea
            v-validate="'max:1500'"
            id="description"
            v-model="tmp.offerAnnexeService.description"
            :error="errors.first('description')"
            data-vv-as="description"
            name="description"
            rows="5"
            word-count
            required
          />

          <br>

          <button
            type="button"
            class="btn btn-agri-yellow-secondary"
            @click="addAnnexe"
          >
            {{ $t("offer.buttons.addAnnexe") }}
          </button>
        </form>
      </div>

      <hr>

      <h3>
        Vos services annexes
      </h3>

      <table
        v-if="
          formData.offerAnnexeService.length > 0
        "
        class="table-season"
      >
        <thead>
          <tr>
            <td class="price-label td-season">
              {{ $t("offer.annexes.name") }}
            </td>
            <td class="price-label td-season">
              {{ $t("offer.annexes.price") }}
            </td>
            <td class="price-label td-season">
              {{ $t("offer.annexes.description") }}
            </td>
            <td />
          </tr>
        </thead>
        <tbody>
          <tr
            v-for="annexe in formData.offerAnnexeService"
            :key="annexe.id">
            <td>
              {{ annexe.name }}
            </td>
            <td>
              {{ annexe.price | currency }}
            </td>
            <td>{{ annexe.description }}</td>
            <td>
              <button
                v-if="annexe.id"
                :disabled="
                  $wait.is(`removing annexe service with id ${annexe.id}`)
                "
                type="button"
                @click="removeAnnexe(annexe.id)"
              >
                {{ $t("offer.buttons.delete") }}
              </button>
            </td>
          </tr>
        </tbody>
      </table>

      <br>

      <div class="buttons">
        <button
          type="submit"
          class="btn btn-agri-yellow"
          @click="next">
          {{ $t("offer.buttons.next") }}
        </button>
        <button
          type="submit"
          class="btn btn-agri-yellow"
          @click="submitted">
          {{ $t("offer.buttons.save") }}
        </button>
      </div>

    </div>
    <CustomDialog
      v-model="showDialog"
      @close="closeDialog"
      @discard-changes="discardChanges"
      @save-changes="saveChanges"
    />
  </div>
</template>

<script>
import { mapGetters } from 'vuex'
import WiInput from '@/components/WiUI/Input'
import WiTextarea from '@/components/WiUI/Textarea'
import CustomDialog from '@/components/CustomDialog'

export default {
  name: 'EditOfferAnnexes',
  components: {
    WiInput,
    WiTextarea,
    CustomDialog
  },
  data () {
    return {
      showDialog: false,
      tmp: {
        offerAnnexeService: {
          name: null,
          price: 0,
          description: null
        }
      },
      formData: {
        offerAnnexeService: []
      },
      services: [
        { text: 'Panier garnis', value: 'Panier garnis' },
        { text: 'Location de vélo', value: 'Location de vélo' },
        { text: 'Panier repas', value: 'Panier repas' },
        { text: 'Atelier cuisine', value: 'Atelier cuisine' },
        { text: 'Activité bien-être', value: 'Activité bien-être' },
        { text: 'Accès SPA', value: 'Accès SPA' },
        { text: 'Location de voiture', value: 'Location de voiture' },
        { text: 'Trajet gare-ferme', value: 'Trajet gare-ferme' },
        { text: 'Petit déjeuner', value: 'Petit déjeuner' },
        { text: 'Espace nuit pour animaux', value: 'Espace nuit pour animaux' },
        { text: 'Table d\'hôte', value: 'Table d\'hôte' },
        { text: 'Lave-linge / sèche-linge', value: 'Lave-linge / sèche-linge' },
        { text: 'Barbecue', value: 'Barbecue' },
        { text: 'Cours d\'équitation', value: 'Cours d\'équitation' },
        { text: 'Balade à cheval / en âne', value: 'Balade à cheval / en âne' },
        { text: 'Stage d\'équitation', value: 'Stage d\'équitation' },
        { text: 'Initiation à l\'équitation', value: 'Initiation à l\'équitation' },
        { text: 'Immersion à la ferme', value: 'Immersion à la ferme' }
      ]
    }
  },
  beforeRouteLeave (to, from, next) {
    if (this.to) {
      next()
    } else {
      this.to = to
      this.showDialog = true
    }
  },
  fetch ({ app, route, store }) {
    return app.$axios.get(`/offers/${route.params.id}`).then(res => {
      if (res.status === 200) {
        store.commit('SET_CURRENT_OFFER', res.data)
      }
    })
  },
  computed: {
    ...mapGetters(['getCurrentOffer'])
  },
  mounted () {
    const {
      annexe_service: annexeService
    } = this.getCurrentOffer

    this.formData = {
      ...this.formData
    }

    /**
     * Handle price periods
     */
    if (annexeService) {
      this.formData.offerAnnexeService = [...annexeService]
    }
  },
  methods: {
    closeDialog () {
      this.showDialog = false
      this.to = null
    },
    saveChanges () {
      this.showDialog = false
      this.$router.push(this.to)
    },
    discardChanges () {
      this.showDialog = false
      this.$router.push(this.to)
    },
    addAnnexe () {
      this.$validator.validate('price-period.*').then(valid => {
        if (!valid) return false
        if (this.$wait.is('adding annexe service')) return

        const annexeService = this.tmp.offerAnnexeService
        this.$wait.start('adding annexe service')
        this.$axios
          .post(`/offers/${this.getCurrentOffer.id}/annexe_services`, {
            annexe_service: Object.assign(
              {},
              {
                name: annexeService.name,
                price: annexeService.price * 100,
                description: annexeService.description
              }
            )
          })
          .then(res => {
            if (res.status === 201) {
              if (res.data) {
                this.$set(
                  this.formData,
                  'offerAnnexeService',
                  res.data.annexe_service
                )
              }
            }

            this.tmp.offerAnnexeService = {
              name: null,
              price: 0,
              description: null
            }
          })
          .finally(() => {
            this.$wait.end('adding annexe service')
          })
      })
    },
    removeAnnexe (id) {
      if (this.$wait.is(`removing annexe with id ${id}`)) return

      this.$wait.start(`removing annexe with id ${id}`)
      this.$axios
        .delete(`/offers/${this.getCurrentOffer.id}/annexe_services/${id}`)
        .then(res => {
          if (res.status === 200) {
            if (res.data) {
              this.$set(
                this.formData,
                'offerAnnexeService',
                res.data.annexe_service
              )
              this.$forceUpdate()
            }
          }
        })
        .finally(() => {
          this.$wait.end(`removing annexe service with id ${id}`)
        })
    },
    next () {
      this.$router.push({
        name: 'EditOfferCalendar'
      })
      this.showDialog = false
      this.$router.push(this.to)
    },
    submitted () {
      this.$router.push({
        name: 'DashboardOffers'
      })
      this.showDialog = false
      this.$router.push(this.to)
    }
  }
}
</script>

<style lang="scss" scoped>
@import "@/assets/scss/_variables.scss";

.name-label {
  margin: auto 0;
  color: #476458;
  font-family: 'Avenir', -apple-system, BlinkMacSystemFont, 'Segoe UI', Oxygen, Ubuntu, Cantarell, 'Open Sans', 'Helvetica Neue', sans-serif;
  font-weight: bold;
  white-space: nowrap;
  overflow: hidden;
  text-overflow: ellipsis;
}

.simulator-box {
  display: grid;
  grid-template-columns: auto auto;
  grid-column-gap: 2ch;
}

.simulator {
  border: 1px solid grey;
  padding: 1ch;
}

.simulator-price {
  color: $agri-green-light;
}

.table-season {
  width: 100%;
  text-align: center;
}

.td-season {
  border: 1px solid $agri-green-light;
  border-radius: 8px;
  color: $agri-green-light !important;
}

.price-box {
  margin-bottom: 55px;
}

.price-field {
  display: grid;
  grid-template-columns: 75px 150px;
}

.price-field-tax {
  display: grid;
  grid-template-columns: 250px 50px;
}

.caution-field {
  display: grid;
  grid-template-columns: 75px 25px 150px;
  grid-column-gap: 5px;
}

.caution-mark {
  width: 15px;
  height: 15px;
  margin: auto;
}

.price-field-weekend {
  display: grid;
  grid-template-columns: 75px 85px 300px 120px;
}

.price-field-discount {
  display: grid;
  grid-template-columns: 75px 240px 75px;
  grid-column-gap: 25px;
}

.price-label {
  font-size: 20px;
  font-family: "Avenir", -apple-system, BlinkMacSystemFont, "Segoe UI", Oxygen,
    Ubuntu, Cantarell, "Open Sans", "Helvetica Neue", sans-serif;
  text-transform: uppercase;
  color: black;
}

.price-night {
  font-size: 20px;
  font-family: "Avenir", -apple-system, BlinkMacSystemFont, "Segoe UI", Oxygen,
    Ubuntu, Cantarell, "Open Sans", "Helvetica Neue", sans-serif;
}

.price-align {
  align-self: center;
  justify-self: center;
}

.title-side {
  color: black;
  font-size: 26px;
  font-weight: bold;
  text-transform: uppercase;
  font-family: "Avenir", -apple-system, BlinkMacSystemFont, "Segoe UI", Oxygen,
    Ubuntu, Cantarell, "Open Sans", "Helvetica Neue", sans-serif;
}

.subtitle {
  margin-top: 20px;
  margin-bottom: 20px;
  font-size: 12px;
  font-family: "Avenir", -apple-system, BlinkMacSystemFont, "Segoe UI", Oxygen,
    Ubuntu, Cantarell, "Open Sans", "Helvetica Neue", sans-serif;
}

.cat-title {
  font-weight: 400;
}
.price-period {
  left: 0;
  top: 0;

  &__content {
    max-width: 400px;
    background-color: white;
    padding: 16px;
    border-radius: 4px;

    &__header {
      display: flex;
      justify-content: space-between;
    }
  }
}

.side {
  background-color: white;
  margin: 0 auto;
  padding: 30px;
  width: 90%;
}

.body-1 em {
  font-size: 14px;
}

.housing-types__item label {
  font-size: 13px;
}

span.wi-textarea__label__wordcount {
  font-size: 12px;
}

.headline {
  padding-top: 20px;
}

.wi-input__caption {
  font-size: 14px !important;
}

.done {
  padding-top: 40px;
}

.price {
  padding-top: 32px;

  .side {
    width: 90%;
  }

  .wi-input {
    margin-bottom: 16px;
  }
}
.buttons {
  display: flex;
  justify-content: space-between;

  .btn:first-child {
    margin-right: 16px;
  }
}
</style>
