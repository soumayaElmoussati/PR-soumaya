<template>
  <div class="housing">
    <div class="edit-wrap">
      <div class="side">
        <h1 class="title-side">
          {{ $t("offer.titles.service") }}
        </h1>

        <form
          @submit.prevent="submitted"
        >

          <h2 class="headline">
            {{ $t("offer.titles.serviceProposed") }}
          </h2>

          <benefit-select
            v-model="data.benefits"
          />

          <div class="spacer-parts"/>

          <h2 class="headline">
            {{ $t("offer.titles.availableService") }}
          </h2>
          <p class="body-1">
            {{ $t("offer.paragraphs.equipmentSpecify") }}
          </p>

          <service-select
            v-model="data.services"
          />

          <fieldset v-if="Array.isArray(data.services)">

            <div class="offer-service__price__fields">

              <input
                v-if="data.services.includes('breakfast')"
                :id="breakfastOpt"
                v-model="data.servicesIndex.breakfastopt"
                :value="breakfastopt"
                name="breakfastOpt"
                type="checkbox"
              >
              <label
                v-if="data.services.includes('breakfast')"
                :for="breakfastOpt"
                class="body-1"
              >
                {{ $t("offer.infos.breakfast") }}
              </label>

              <wi-input
                v-if="data.services.includes('breakfast')"
                id="breakfastPrice"
                v-model="data.servicesIndex.breakfast_price"
                :error="errors.first('breakfastPrice')"
                data-vv-as="prix supplémentaire"
                name="breakfastPrice"
                type="number"
                step="0.01"
                label="Prix supplémentaire pour le petit-déjeuner."
                caption="Indiquez le prix par personne et par nuité du petit-déjeuner, 0 ou vide si inclus."
              />

            </div>

            <div class="offer-service__linens__fields">

              <input
                v-if="data.services.includes('linens')"
                :id="linensOpt"
                v-model="data.servicesIndex.linensopt"
                :value="linensopt"
                name="linensOpt"
                type="checkbox"
              >
              <label
                v-if="data.services.includes('linens')"
                :for="linensOpt"
                class="body-1"
              >
                {{ $t("offer.infos.linen") }}
              </label>

              <wi-input
                v-if="data.services.includes('linens')"
                id="linensPrice"
                v-model="data.servicesIndex.linens_price"
                :error="errors.first('linensPrice')"
                data-vv-as="prix supplémentaire"
                name="linensPrice"
                type="number"
                step="0.01"
                label="Prix supplémentaire pour le linge de lit."
                caption="Indiquez le prix par personne pour le séjour, 0 ou vide si inclus."
              />
            </div>

            <div class="offer-service__cleaning__fields">

              <input
                v-if="data.services.includes('cleaning')"
                :id="cleaningOpt"
                v-model="data.servicesIndex.cleaningopt"
                :value="cleaningopt"
                name="cleaningOpt"
                type="checkbox"
              >
              <label
                v-if="data.services.includes('cleaning')"
                :for="cleaningOpt"
                class="body-1"
              >
                {{ $t("offer.infos.cleaning") }}
              </label>

              <wi-input
                v-if="data.services.includes('cleaning')"
                id="cleaningPrice"
                v-model="data.servicesIndex.cleaning_price"
                :error="errors.first('cleaningPrice')"
                data-vv-as="prix supplémentaire"
                name="cleaningPrice"
                type="number"
                step="0.01"
                label="Prix supplémentaire pour le ménage."
                caption="Indiquez le prix pour le séjour, 0 ou vide si inclus."
              />
            </div>
          </fieldset>

          <br>

          <div class="buttons">
            <button
              type="submit"
              class="btn btn-agri-previous"
              @click.stop.prevent="previous"
            >
              <span
                v-if="!$wait.is('creating offer')"
              >
                {{ $t("offer.buttons.previous") }}
              </span>
              <wi-spinner
                v-else
              />
            </button>
            <button
              :disabled="$wait.is('updating farm')"
              type="submit"
              class="btn btn-agri-yellow"
            >
              <span
                v-if="!$wait.is('updating farm')"
              >
                {{ $t("offer.buttons.continue") }}
              </span>
              <wi-spinner
                v-else
              />
            </button>
          </div>
        </form>

      </div>
    </div>
  </div>
</template>

<script>
  import { mapGetters } from 'vuex'
  import ServiceSelect from '@/components/NewOffer/ServiceSelect'
  import BenefitSelect from '@/components/NewOffer/BenefitSelect'

  export default {
    name: 'EditService',
    middleware: 'auth',
    components: {
      ServiceSelect, BenefitSelect
    },
    data () {
      return {
        data2: {},
        data: {
          services: [],
          servicesIndex: {},
          benefits: [],
          benefitsIndex: {}
        }
      }
    },
    fetch ({ app, route, store }) {
      return app.$axios.get(`/offers/${store.state.currentOffer.id}`)
        .then(res => {
          if (res.status === 200) {
            store.commit('SET_CURRENT_OFFER', res.data)
          }
        })
    },
    computed: {
      ...mapGetters([
        'getCurrentOffer'
      ])
    },
    mounted () {
      this.data2 = this.getCurrentOffer

      if (typeof (this.getCurrentOffer.service) === 'undefined') {
        this.getCurrentOffer.service = {}
      }

      if (typeof (this.getCurrentOffer.benefit) === 'undefined') {
        this.getCurrentOffer.benefit = {}
      }

      this.data.benefitsIndex = this.getCurrentOffer.benefit

      this.data.servicesIndex = this.getCurrentOffer.service

      this.data.servicesIndex.breakfast_price = Math.round(this.data.servicesIndex.breakfast_price / 100)
      this.data.servicesIndex.linens_price = Math.round(this.data.servicesIndex.linens_price / 100)
      this.data.servicesIndex.cleaning_price = Math.round(this.data.servicesIndex.cleaning_price / 100)
      this.data.servicesIndex.host_table_price = Math.round(this.data.servicesIndex.host_table_price / 100)

      var self = this

      for (var prop in this.data.benefitsIndex) {
        if (this.data.benefitsIndex[prop] === true) {
          self.data.benefits.push(prop)
          self.$children[0].selection.push(prop)
        }
      }

      for (prop in this.data.servicesIndex) {
        if (this.data.servicesIndex[prop] === true) {
          self.data.services.push(prop)
          self.$children[1].selection.push(prop)
        }
      }
    },
    methods: {
      previous () {
        this.$router.push({
          name: 'Farm'
        })
      },
      submitted () {
        this.$validator.validateAll()
          .then((valid) => {
            if (valid) {
              const offer = this.getCurrentOffer

              const baseServices = [
                'breakfast',
                'breakfast_price',
                'breakfastopt',
                'linens',
                'linens_price',
                'linensopt',
                'host_table',
                'host_table_price',
                'esprit_ferme',
                'esprit_link',
                'cleaning',
                'cleaningopt',
                'cleaning_price'
              ]
              const services = {}
              baseServices.forEach((service) => {
                services[service] = this.data.services.includes(service)
              })

              const baseBenefits = [
                'cleaning_kit',
                'toilet_paper',
                'soap',
                'household_linen'
              ]
              const benefits = {}
              baseBenefits.forEach((benefit) => {
                benefits[benefit] = this.data.benefits.includes(benefit)
              })

              this.$wait.start('updating housing')
              this.$axios.put(`/offers/${offer.id}`, {
                offer: {
                  offer_benefit: benefits,
                  offer_service: {
                    breakfast: this.data.services.includes('breakfast'),
                    breakfast_price: Math.round(this.data.servicesIndex.breakfast_price * 100),
                    breakfastopt: this.data.servicesIndex.breakfastopt,
                    linens: this.data.services.includes('linens'),
                    linens_price: Math.round(this.data.servicesIndex.linens_price * 100),
                    linensopt: this.data.servicesIndex.linensopt,
                    host_table: this.data.services.includes('host_table'),
                    host_table_price: Math.round(this.data.servicesIndex.host_table_price * 100),
                    esprit_ferme: this.data.services.includes('esprit_ferme'),
                    cleaning: this.data.services.includes('cleaning'),
                    cleaning_price: Math.round(this.data.servicesIndex.cleaning_price * 100),
                    cleaningopt: this.data.servicesIndex.cleaningopt
                  }
                }
              })
                .catch((err) => {
                  console.error('err', err)
                })
                .finally(() => {
                  this.$wait.end('updating housing')
                  this.$router.push({
                    name: 'Price'
                  })
                })
            }
          })
      }
    }
  }
</script>

<style lang="scss" scoped>
@import "@/assets/scss/_variables.scss";
@import "@/assets/scss/_mixins.scss";

.title-side {
  color: black;
  font-size: 26px;
  font-weight: bold;
  text-transform: uppercase;
  font-family: 'Avenir', -apple-system, BlinkMacSystemFont, 'Segoe UI', Oxygen, Ubuntu, Cantarell, 'Open Sans', 'Helvetica Neue', sans-serif;
}

.subtitle {
  font-size: 20px;
  color: black;
  font-family: 'Avenir', -apple-system, BlinkMacSystemFont, 'Segoe UI', Oxygen, Ubuntu, Cantarell, 'Open Sans', 'Helvetica Neue', sans-serif;
  font-weight: bold;
  text-transform: uppercase;
}

.side {
  background-color:white;
  margin:0 auto;
  padding:30px;
  width:90%
}

.body-1 em {
  font-size: 12px;
  font-family: 'Avenir', -apple-system, BlinkMacSystemFont, 'Segoe UI', Oxygen, Ubuntu, Cantarell, 'Open Sans', 'Helvetica Neue', sans-serif;
  color: #476458;
}

.spacer-parts {
  margin-top: 45px;
}

.housing-types__item label{
  font-size:13px;
}

span.wi-textarea__label__wordcount {
  font-size:12px;
}

.headline{
  padding-top:20px;
  text-transform: uppercase;
  font-size: 18px;
  font-family: 'Avenir', -apple-system, BlinkMacSystemFont, 'Segoe UI', Oxygen, Ubuntu, Cantarell, 'Open Sans', 'Helvetica Neue', sans-serif;
}

.wi-input__caption{
  font-size:14px!important;
}

.done{
  padding-top:40px
}

.housing{
  padding-top: 0px;

  .side{
    width: 65%;
  }

  fieldset{
    border: none;
    margin: 0;
    padding: 0;
  }

  .buttons{
    display: flex;
    justify-content: space-between;

    .btn:first-child{
      margin-right: 16px;
    }
  }
}

.time-label{
  &__fields{
    display: grid;
    grid-template-columns: repeat(2, calc(25%));
    grid-gap: 5px;
    text-align: center;

    @media only screen and (max-width: 768px) {
      grid-template-columns: repeat(2, calc(50%));
    }
  }
}

.time-field{
  &__fields{
    display: grid;
    grid-template-columns: repeat(2, calc(25%));
    grid-gap: 5px;
    margin-left: 5vh;

    @media only screen and (max-width: 768px) {
      grid-template-columns: repeat(2, calc(50%));
      margin-left: 1vh;
    }

    @media only screen and (max-width: 1024px) {
      margin-left: 1vh;
    }
  }
}

.time-separator {
  @media only screen and (max-width: 768px) {
    margin-top: 5vh;
  }
}

.arrival-fields {
  display: grid;
  grid-template-columns: 65px 10px 65px;
  grid-column-gap: 5px;

  @media (min-width: 768px) and (max-width: 1024px) {
    // margin-left: 5vh;
  }
}

.departure-fields {
  display: grid;
  grid-template-columns: 65px 10px 65px;
  grid-column-gap: 5px;

  @media (min-width: 768px) and (max-width: 1024px) {
    margin-left: 5vh;
  }
}

@media screen and (max-width: 600px) {
  .side {
    width: 100%;
    margin:0;
    padding:0px;
  }

  .housing{

    .side{
      width: 100%;
    }
  }
}
</style>
