<template>
  <div class="housing">
    <div class="edit-wrap">
      <div class="side">
        <h1 class="title-side">
          {{ $t("offer.titles.featureResidence") }}
        </h1>

        <form
          @submit.prevent="submitted"
        >

          <h2 class="headline">
            {{ $t("offer.titles.adjectiveResidence") }}
          </h2>

          <p class="body-1 subtitle">
            <em>{{ $t("offer.paragraphs.adjectiveSignificantResidence") }}</em>
          </p>

          <p class="body-1">
            <em>{{ $t("offer.paragraphs.adjectiveBenefit") }}</em>
          </p>

          <adjectif-select
            v-model="data.adjectifs"
          />

          <div class="spacer-parts"/>

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
              type="submit"
              class="btn btn-agri-yellow"
              @click.stop.prevent="next"
            >
              <span
                v-if="!$wait.is('creating offer')"
              >
                {{ $t("offer.buttons.next") }}
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
                {{ $t("offer.buttons.save") }}
              </span>
              <wi-spinner
                v-else
              />
            </button>
          </div>
        </form>
        <CustomDialog
          v-model="showDialog"
          @close="closeDialog"
          @discard-changes="discardChanges"
          @save-changes="saveChanges"
        />
      </div>
    </div>
  </div>
</template>

<script>
  import { mapGetters } from 'vuex'
  import EquipmentSelect from '@/components/NewOffer/EquipmentSelect'
  import AdjectifSelect from '@/components/NewOffer/AdjectifSelect'
  import CustomDialog from '@/components/CustomDialog'

  export default {
    name: 'EditHousing',
    middleware: 'auth',
    components: {
      EquipmentSelect, AdjectifSelect, CustomDialog
    },
    data () {
      return {
        to: null,
        showDialog: false,
        data2: {},
        data: {
          equipmentsIndex: {},
          equipments: [],
          adjectifsIndex: {},
          adjectifs: [],
          settlements: []
        }
      }
    },
    fetch ({ app, route, store }) {
      return app.$axios.get(`/offers/${route.params.id}`)
        .then(res => {
          if (res.status === 200) {
            store.commit('SET_CURRENT_OFFER', res.data)
          }
        })
    },
    beforeRouteLeave (to, from, next) {
      if (this.to) {
        next()
      } else {
        this.to = to
        this.showDialog = true
      }
    },
    computed: {
      ...mapGetters([
        'getCurrentOffer'
      ])
    },
    mounted () {
      this.data2 = this.getCurrentOffer
      if (typeof (this.getCurrentOffer.equipment) === 'undefined') {
        this.getCurrentOffer.equipment = {}
      }
      if (typeof (this.getCurrentOffer.adjectif) === 'undefined') {
        this.getCurrentOffer.adjectif = {}
      }

      this.data.equipmentsIndex = this.getCurrentOffer.equipment
      this.data.adjectifsIndex = this.getCurrentOffer.adjectif

      var self = this
      for (var prop in this.data.equipmentsIndex) {
        if (this.data.equipmentsIndex[prop] === true) {
          self.data.equipments.push(prop)
          self.$children[1].selection.push(prop)
        }
      }
      for (prop in this.data.adjectifsIndex) {
        if (this.data.adjectifsIndex[prop] === true) {
          self.data.adjectifs.push(prop)
          self.$children[0].selection.push(prop)
        }
      }
    },
    methods: {
      closeDialog () {
        this.showDialog = false
        this.to = null
      },
      saveChanges () {
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
                'freezer',
                'deep_freezer',
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
                .catch((err) => {
                  console.error('err', err)
                })
                .finally(() => {
                  this.$wait.end('updating housing')
                  this.showDialog = false
                  this.$router.push(this.to)
                })
            }
          })
      },
      discardChanges () {
        this.showDialog = false
        this.$router.push(this.to)
      },
      next () {
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
                'freezer',
                'deep_freezer',
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
                .catch((err) => {
                  console.error('err', err)
                })
                .finally(() => {
                  this.$wait.end('updating housing')
                  this.$router.push({
                    name: 'EditOfferRules'
                  })
                  this.showDialog = false
                  this.$router.push(this.to)
                })
            }
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
                'freezer',
                'deep_freezer',
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
                .catch((err) => {
                  console.error('err', err)
                })
                .finally(() => {
                  this.$wait.end('updating housing')
                  this.$router.push({
                    name: 'DashboardOffers'
                  })
                  this.showDialog = false
                  this.$router.push(this.to)
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
    width: 90%;
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
