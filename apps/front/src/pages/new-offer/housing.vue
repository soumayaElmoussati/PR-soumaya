<template>
  <div class="housing">
    <div class="wrap">
      <div class="side">
        <h1 class="title-side">
          {{ $t("offer.titles.featureResidence") }}
        </h1>

        <form
          @submit.prevent="submitted"
        >

          <h2 class="headline">
            {{ $t("offer.titles.adjective") }}
          </h2>

          <p class="body-1 subtitle">
            <em>{{ $t("offer.paragraphs.adjectiveSignificant") }}</em>
          </p>

          <p class="body-1">
            <em>{{ $t("offer.paragraphs.adjectiveBenefit") }}</em>
          </p>

          <adjectif-select
            v-model="data.adjectifs"
          />

          <br>

          <hr style="border: 1px solid #476458">

          <h2 class="headline">
            {{ $t("offer.titles.equipment") }}
          </h2>
          <p class="body-1">
            <em>{{ $t("offer.paragraphs.equipment") }}</em>
          </p>

          <equipment-select
            v-model="data.equipments"
          />

          <br>

          <div class="buttons">
            <button
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
              :disabled="$wait.is('updating housing')"
              type="submit"
              class="btn btn-agri-yellow"
            >
              <span
                v-if="!$wait.is('updating housing')"
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
  import AdjectifSelect from '@/components/NewOffer/AdjectifSelect'
  import EquipmentSelect from '@/components/NewOffer/EquipmentSelect'

  export default {
    name: 'Housing',
    middleware: 'auth',
    components: {
      EquipmentSelect, AdjectifSelect
    },
    data () {
      return {
        data2: {},
        data3: {},
        data: {
          equipmentsIndex: {},
          equipments: [],
          adjectifsIndex: {},
          adjectifs: []
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

      this.data.equipmentsIndex = this.getCurrentOffer.equipment
      this.data.adjectifsIndex = this.getCurrentOffer.adjectif

      var self = this
      for (var prop in this.data.equipmentsIndex) {
        if (this.data.equipmentsIndex[prop] && prop !== 'id') {
          self.data.equipments.push(prop)
          self.$children[1].selection.push(prop)
        }
      }
      for (prop in this.data.adjectifsIndex) {
        if (this.data.adjectifsIndex[prop] && prop !== 'id') {
          self.data.adjectifs.push(prop)
          self.$children[0].selection.push(prop)
        }
      }
    },
    methods: {
      previous () {
        this.$router.push({
          name: 'OfferIndex'
        })
      },
      submitted () {
        this.$validator.validateAll()
          .then((valid) => {
            if (valid) {
              const offer = this.getCurrentOffer

              const baseEquipments = [
                'kitchen',
                'wifi',
                'tv',
                'washing_machine',
                'fireplace',
                'parking',
                'swimming_pool',
                'domestic_animals',
                'english_speaking',
                'private_garden',
                'shared_garden',
                'internet',
                'dvd_player',
                'games',
                'dryer',
                'hair_dryer',
                'drying_rack',
                'iron',
                'wardrobe',
                'shower',
                'bath',
                'baby_bath',
                'heater',
                'clim',
                'fitness',
                'garden_lounge',
                'bbq',
                'oven',
                'hotplates',
                'microwaves',
                'toaster',
                'kettle',
                'coffee_machine',
                'cutlery',
                'dishwasher',
                'baby_chair',
                'fridge',
                'deep_freezer',
                'freezer',
                'garage',
                'secure_local',
                'train'
              ]
              const equipments = {}
              baseEquipments.forEach((equipment) => {
                equipments[equipment] = this.data.equipments.includes(equipment)
              })

              const baseAdjectifs = [
                'rustic',
                'luxurious',
                'confortable',
                'clean',
                'friendly',
                'calm',
                'exotic',
                'romantic',
                'cheap',
                'insolit',
                'simple',
                'luminous'
              ]
              const adjectifs = {}
              baseAdjectifs.forEach((adjectif) => {
                adjectifs[adjectif] = this.data.adjectifs.includes(adjectif)
              })

              this.$wait.start('updating housing')
              this.$axios.put(`/offers/${offer.id}`, {
                offer: {
                  offer_equipment: equipments,
                  offer_adjectif: adjectifs
                }
              })
                .then((res) => {
                  this.$router.push({
                    name: 'Rules'
                  })
                })
                .catch((err) => {
                  console.error('err', err)
                })
                .finally(() => {
                  this.$wait.end('updating housing')
                })
            }
          })
      }
    }
  }
</script>

<style lang="scss" scoped>
@import "@/assets/scss/_variables.scss";

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

.headline{
  padding-top:20px;
  text-transform: uppercase;
  font-size: 18px;
  font-family: 'Avenir', -apple-system, BlinkMacSystemFont, 'Segoe UI', Oxygen, Ubuntu, Cantarell, 'Open Sans', 'Helvetica Neue', sans-serif;
}

  .side {
    background-color:white;
    margin:0 auto;
    padding:30px;
    width:75%;
    @media screen and (max-width: 768px) {
      padding: 10px;
    }
  }

  .body-1 em {
    font-size: 12px;
    font-family: 'Avenir', -apple-system, BlinkMacSystemFont, 'Segoe UI', Oxygen, Ubuntu, Cantarell, 'Open Sans', 'Helvetica Neue', sans-serif;
    color: $agri-green;
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

  .housing{
    padding-top: 32px;

    .side{
      width: 70%;
    }

    fieldset{
      border: none;
      margin: 0;
      padding: 0;
    }

    .buttons{
      display: flex;
      justify-content: space-between;
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
      margin-left: 5vh;
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

  @media screen and (max-width: 768px) {

    .housing{
      padding-top: 0px;

      .side{
        width: 100%;
      }
    }
  }
</style>
