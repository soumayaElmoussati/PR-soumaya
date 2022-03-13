<template>
  <div class="edit-offer-price">
    <div class="side">
      <h1 class="title-side">
        {{ $t("activity.titles.rate") }}
      </h1>

      <form
        @submit.prevent="submitted"
      >
        <div class="price-box">

          <p class="price-label">{{ $t("activity.paragraphs.price") }}</p>

          <div class="price-field">

            <wi-input
              v-validate="'required|decimal:2'"
              id="pricePerPerson"
              v-model="formData.pricePerPerson"
              :error="errors.first('pricePerPerson')"
              data-vv-as="prix de base"
              type="tel"
              name="pricePerPerson"
              placeholder="80"
              required
            />

            <p class="price-night">€</p>

          </div>

        </div>

        <div class="price-box">

          <p class="price-label">{{ $t("activity.paragraphs.person") }}</p>

          <div class="price-field">

            <wi-input
              v-validate="'required|numeric|min_value:1'"
              id="peopleCount"
              v-model="formData.peopleCount"
              :error="errors.first('peopleCount')"
              data-vv-as="nombre de personnes"
              type="tel"
              name="peopleCount"
              required
            />

            <p class="price-night">{{ $t("activity.paragraphs.people") }}</p>

          </div>

        </div>

        <div class="price-box">

          <p class="price-label">{{ $t("activity.paragraphs.travel") }}</p>

          <div class="price-field">

            <wi-input
              v-validate="'required|decimal:2'"
              id="additionalTravelerPrice"
              v-model="formData.additionalTravelerPrice"
              :error="errors.first('additionalTravelerPrice')"
              data-vv-as="prix voyageur supplémentaire"
              name="additionalTravelerPrice"
              required
            />

            <p class="price-night">€</p>

          </div>

        </div>

        <div class="price-box">

          <p class="price-label">{{ $t("activity.paragraphs.moreTravel") }}</p>

          <div class="price-field">

            <wi-input
              v-validate="'required|numeric'"
              id="additionalMaxPeople"
              v-model="formData.additionalMaxPeople"
              :error="errors.first('additionalMaxPeople')"
              data-vv-as="visiteurs supplémentaires"
              type="tel"
              name="additionalMaxPeople"
              required
            />

            <p class="price-night">{{ $t("activity.paragraphs.people") }}</p>

          </div>

        </div>

        <div class="buttons">
          <button
            type="submit"
            class="btn btn-agri-yellow"
            @click="next"
          >
            Suivant
          </button>
          <button
            type="submit"
            class="btn btn-agri-yellow"
            @click="submitted"
          >
            {{ $t("activity.buttons.save") }}
          </button>
        </div>
      </form>

    </div>
    <CustomDialog
      v-model="showDialog"
      @close="closeDialog"
      @discard-changes="discardChanges"
      @save-changes="saveChanges"
    />

</div></template>

<script>
  import { mapGetters } from 'vuex'
  import WiInput from '@/components/WiUI/Input'
  import CustomDialog from '@/components/CustomDialog'

  export default {
    name: 'EditOfferPrice',
    components: {
      WiInput, CustomDialog
    },
    data () {
      return {
        showDialog: false,
        testValue: null,
        formData: {
          peopleCount: 2,
          pricePerPerson: null,
          minDays: 1,
          additionalMaxPeople: 0,
          additionalTravelerPrice: 0
        }
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
      return app.$axios.get(`/activities/${route.params.id}`)
        .then(res => {
          if (res.status === 200) {
            store.commit('SET_CURRENT_ACTIVITY', res.data)
          }
        })
    },
    computed: {
      ...mapGetters([
        'getCurrentActivity'
      ])
    },
    mounted () {
      this.formData = {
        ...this.formData,
        peopleCount: this.getCurrentActivity.people_count,
        pricePerPerson: Math.round(this.getCurrentActivity.price_per_person / 100),
        minDays: this.getCurrentActivity.min_days,
        additionalMaxPeople: this.getCurrentActivity.additional_max_people,
        additionalTravelerPrice: Math.round(this.getCurrentActivity.additional_traveler_price / 100)
      }
    },
    methods: {
      closeDialog () {
        this.showDialog = false
        this.to = null
      },
      saveChanges () {
        this.saveActivity()
          .then(() => {
            this.showDialog = false
            this.$router.push(this.to)
          })
      },
      discardChanges () {
        this.showDialog = false
        this.$router.push(this.to)
      },
      next () {
        this.saveActivity()
          .then(() => {
            this.$router.push({
              name: 'EditActivityPictures'
            })
            this.showDialog = false
            this.$router.push(this.to)
          })
      },
      submitted () {
        this.saveActivity()
          .then(() => {
            this.$router.push({
              name: 'DashboardActivities'
            })
            this.showDialog = false
            this.$router.push(this.to)
          })
      },
      saveActivity () {
        return new Promise(resolve => {
          this.$validator.validateAll()
            .then((valid) => {
              if (valid) {
                if (this.$wait.is('saving price infos')) return

                this.$wait.start('saving price infos')

                const data = {
                  people_count: this.formData.peopleCount,
                  price_per_person: Math.round(this.formData.pricePerPerson * 100),
                  additional_traveler_price: Math.round(this.formData.additionalTravelerPrice * 100),
                  additional_max_people: this.formData.additionalMaxPeople
                }

                this.$axios.put(`/activities/${this.$route.params.id}`, {
                  activity: data
                })
                  .then((res) => {
                    resolve(res)
                  })
                  .catch(err => {
                    this.$toast.error({
                      title: 'Sauvegarde tarif',
                      message: 'Impossible de sauvegarder les informations.',
                      position: 'bottom center',
                      timeOut: 8000
                    })
                    console.error('Error occured', err)
                  })
                  .finally(() => {
                    this.$wait.end('saving price infos')
                  })
              }
            })
        })
      }
    }
  }
</script>

<style lang="scss" scoped>
@import "@/assets/scss/_variables.scss";

.table-season {
  text-align: center;
}

.td-season {
  border: 1px solid #79BC53;
  border-radius: 8px;
  color: #79BC53 !important;
}

.price-box {
  margin-bottom: 55px;
}

.price-field {
  display: grid;
  grid-template-columns: 75px auto;
  grid-column-gap: 25px;
}

.price-field-weekend {
  display: grid;
  grid-template-columns: 75px 80px 300px 120px;
  grid-column-gap: 25px;
}

.price-field-discount {
  display: grid;
  grid-template-columns: 75px 240px 75px;
  grid-column-gap: 25px;
}

.price-label {
  font-size: 20px;
  font-family: 'Avenir', -apple-system, BlinkMacSystemFont, 'Segoe UI', Oxygen, Ubuntu, Cantarell, 'Open Sans', 'Helvetica Neue', sans-serif;
  text-transform: uppercase;
  color: black;
}

.price-night {
  font-size: 20px;
  font-family: 'Avenir', -apple-system, BlinkMacSystemFont, 'Segoe UI', Oxygen, Ubuntu, Cantarell, 'Open Sans', 'Helvetica Neue', sans-serif;
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
  font-family: 'Avenir', -apple-system, BlinkMacSystemFont, 'Segoe UI', Oxygen, Ubuntu, Cantarell, 'Open Sans', 'Helvetica Neue', sans-serif;
}

.subtitle {
  margin-top: 20px;
  margin-bottom: 20px;
  font-size: 12px;
  font-family: 'Avenir', -apple-system, BlinkMacSystemFont, 'Segoe UI', Oxygen, Ubuntu, Cantarell, 'Open Sans', 'Helvetica Neue', sans-serif;
}

.cat-title {
  font-weight: 400;
}
.price-period {
  position: fixed;
  display: flex;
  left: 0;
  top: 0;
  width: 100vw;
  height: 100vh;
  background-color: rgba(black, 0.5);

  &__content {
    max-width: 400px;
    margin: auto;
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
  background-color:white;
  margin:0 auto;
  padding:30px;
  width:90%
}

.body-1 em {
  font-size:14px;
}

.housing-types__item label{
  font-size:13px;
}

span.wi-textarea__label__wordcount {
  font-size:12px;
}

.headline{
  padding-top:20px;
}

.wi-input__caption{
  font-size:14px!important;
}

.done{
  padding-top:40px
}

.price{
  padding-top: 32px;

  .side{
    width: 90%;
  }

  .wi-input{
    margin-bottom: 16px;
  }
}
.buttons{
  display: flex;
  justify-content: space-between;

  .btn:first-child{
    margin-right: 16px;
  }
}
</style>
