<template>
  <div class="edit-offer-offer new-offer">
    <div class="side">
      <h1 class="title-side">
        {{ $t("offer.titles.yourResidence") }}
      </h1>
    </div>

    <form
      @submit.prevent="submitted"
    >

      <div class="offer-location side">
        <div class="offer-location__infos">
          <fieldset>
            <div class="offer-location__infos__fields">
              <wi-input
                v-validate="'required|max:255'"
                id="name"
                v-model="data.name"
                :error="errors.first('name')"
                :placeholder="$t('about.placeholder.email')"
                data-vv-as="nom"
                type="text"
                name="name"
                caption="Exemple : Chez Jeannine et Jacques / Ferme de Bileau"
                required
              />
              <wi-input
                v-validate="'required'"
                id="address"
                v-model="data.address.street_name"
                :error="errors.first('address')"
                :placeholder="$t('activity.placeholder.adress')"
                data-vv-as="addresse"
                type="text"
                name="address"
                required
              />
              <wi-input
                v-validate="'required'"
                id="city"
                v-model="data.address.city"
                :error="errors.first('city')"
                :placeholder="$t('activity.placeholder.city')"
                data-vv-as="ville"
                type="text"
                name="city"
                required
              />
              <wi-input
                v-validate="'required|numeric'"
                id="postal_code"
                v-model="data.address.postalCode"
                :error="errors.first('postal_code')"
                :placeholder="$t('activity.placeholder.postalCode')"
                data-vv-as="code postal"
                type="tel"
                name="postal_code"
                required
              />

            </div>
          </fieldset>
        </div>
      </div>

      <div class="side">
        <fieldset>
          <legend class="headline">
            {{ $t("offer.infos.residenceType") }}
          </legend>
          <p class="body-1">
            <em>{{ $t("offer.paragraphs.residenceType") }}</em>
          </p>
          <div class="housing-types">
            <div
              v-for="(housing, k) in housings"
              :key="k"
              class="housing-types__item">
              <input
                :id="housing"
                :value="housing"
                v-model="data.housingType"
                type="radio"
                name="housingType"
              >
              <label :for="housing">
                {{ $t('global.labels.housingType.' + housing) }}
              </label>
            </div>
          </div>
        </fieldset>

        <br>

        <legend class="headline">
          {{ $t("offer.infos.yourResidence") }}
        </legend>

        <fieldset class="complement pt-2">
          <div class="complement__fields">

            <wi-input
              v-validate="'required|numeric|max_value:10'"
              id="roomsCount"
              v-model="data.roomsCount"
              :error="errors.first('roomsCount')"
              data-vv-as="nombre de chambres"
              type="number"
              name="roomsCount"
              class="housing-field"
              label="Nombre de chambre(s)"
              required
            />

            <wi-input
              v-validate="'required|numeric'"
              id="bathrooms"
              v-model="data.complement.bathrooms"
              :error="errors.first('bathrooms')"
              name="bathrooms"
              label="Nombre de salle(s) de bain"
              data-vv-as="salle de bain"
              type="number"
              class="housing-field"
              required
            />
            <wi-input
              v-validate="'required|numeric'"
              id="sleepings"
              v-model="data.complement.sleeping"
              :error="errors.first('sleepings')"
              name="sleepings"
              data-vv-as="nombre de couchages"
              label="Nombre de couchage(s)"
              type="number"
              class="housing-field"
              required
            />
            <wi-input
              v-validate="'required|numeric|min_value:1'"
              id="toilets"
              v-model="data.complement.toilets"
              :error="errors.first('toilets')"
              name="toilets"
              data-vv-as="toilettes"
              label="Nombre de toilette(s)"
              type="number"
              class="housing-field"
              required
            />
          </div>
        </fieldset>

        <fieldset class="description">

          <wi-textarea
            v-validate="'required|max:1500'"
            id="description"
            v-model="data.description"
            :error="errors.first('description')"
            name="description"
            placeholder="Décrivez à vos potentiels visiteurs votre logement. Maximum 1500 caractères."
            word-count
            rows="3"
          />
        </fieldset>

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
            :disabled="$wait.is('creating offer')"
            type="submit"
            class="btn btn-agri-yellow"
          >
            <span
              v-if="!$wait.is('creating offer')"
            >
              {{ $t("offer.buttons.save") }}
            </span>
            <wi-spinner
              v-else
            />
          </button>
        </div>
      </div>
    </form>
    <CustomDialog
      v-model="showDialog"
      @close="closeDialog"
      @discard-changes="discardChanges"
      @save-changes="saveChanges"
    />
  </div>
</template>

<script>
  import { mapActions, mapGetters } from 'vuex'

  import FarmTypeSelect from '@/components/NewOffer/FarmTypeSelect'
  import AnimalSelect from '@/components/NewOffer/AnimalSelect'
  import CustomDialog from '@/components/CustomDialog'

  export default {
    name: 'EditOfferOffer',
    middleware: 'auth',
    components: {
      FarmTypeSelect,
      AnimalSelect,
      CustomDialog
    },
    data () {
      return {
        mapsLoaded: false,
        to: null,
        showDialog: false,
        data: {
          name: null,
          address: {
            street_name: null,
            city: null,
            postalCode: null
          },
          fiscalNumber: null,
          housingType: null,
          housingClassment: null,
          description: null,
          roomsCount: 1,
          complement: {
            bathrooms: 1,
            toilets: 1,
            sleeping: 0
          }
        },
        housings: [
          'entire_house',
          'private_room',
          'guest_room',
          'unusual_room',
          'tiny_house',
          'immersive_house'
        ],
        housingClassments: [
          'main',
          'secondary',
          'hotel'
        ],
        position: {
          lat: 0,
          lng: 0
        },
        zoom: 5,
        selection: []
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
      return app.$axios.get(`/offers/${route.params.id}`)
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
      const { address } = this.getCurrentOffer

      this.data = {
        name: this.getCurrentOffer.name,
        address: {
          street_name: address.street_name,
          city: address.city,
          postalCode: address.postal_code
        },
        fiscalNumber: null,
        housingType: this.getCurrentOffer.residence_type,
        housingClassment: null,
        description: this.getCurrentOffer.description.residence,
        roomsCount: this.getCurrentOffer.rooms_count,
        complement: {
          bathrooms: this.getCurrentOffer.bathrooms_count,
          toilets: this.getCurrentOffer.toilets_count,
          sleeping: this.getCurrentOffer.sleeps_count
        }
      }
      this.loadMaps()
      if (!this.mapsLOaded) {
        window.addEventListener('maps-module:loaded', () => {
          this.loadMaps()
        })
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
              if (this.$wait.is('updating offer')) return

              const { location } = this.data.address
              const address = {
                street_name: this.data.address.street_name,
                city: this.data.address.city,
                postal_code: this.data.address.postalCode,
                country_code: 'FR',
                lat: location ? location.lat : 0,
                lng: location ? location.lng : 0
              }

              /**
               * The form data is entirely valid
               */
              this.$wait.start('updating offer')
              this.$axios.put(`/offers/${this.getCurrentOffer.id}`, {
                offer: {
                  name: this.data.name,
                  bathrooms_count: this.data.complement.bathrooms,
                  toilets_count: this.data.complement.toilets,
                  sleeps_count: this.data.complement.sleeping,
                  rooms_count: this.data.roomsCount,
                  residence_type: this.data.housingType,
                  offer_description: {
                    residence: this.data.description
                  },
                  address
                }
              })
                .catch((err) => {
                  console.error('Error from the request', err)
                })
                .finally(() => {
                  this.$wait.end('updating offer')
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
      loadMaps () {
        if (this.$google) {
          this.mapsLoaded = true
          const autocomplete = new this.$google.maps.places.Autocomplete(
            document.querySelector('#address'),
            {
              types: ['geocode']
            }
          )

          autocomplete.setComponentRestrictions({
            country: 'FR'
          })
          autocomplete.setFields(['address_components', 'geometry'])
          autocomplete.addListener('place_changed', () => {
            const place = autocomplete.getPlace()
            const {
              address_components: addressComponents,
              geometry
            } = place

            const city = addressComponents.find(comp => comp.types.find(v => v === 'locality' || v === 'administrative_area_level_1'))
            const postalCode = addressComponents.find(comp => comp.types.find(v => v === 'postal_code'))

            this.data.address.street_name = `${addressComponents[0].long_name} ${addressComponents[1].long_name}`
            this.data.address.city = city.long_name
            this.data.address.postalCode = postalCode.long_name
            this.data.address.location = {
              lat: geometry.location.lat(),
              lng: geometry.location.lng()
            }
          })
        }
      },
      ...mapActions([
        'setCurrentOffer'
      ]),
      next () {
        this.$validator.validateAll()
          .then((valid) => {
            if (valid) {
              if (this.$wait.is('updating offer')) return

              const { location } = this.data.address
              const address = {
                street_name: this.data.address.street_name,
                city: this.data.address.city,
                postal_code: this.data.address.postalCode,
                country_code: 'FR',
                lat: location ? location.lat : 0,
                lng: location ? location.lng : 0
              }

              /**
               * The form data is entirely valid
               */
              this.$wait.start('updating offer')
              this.$axios.put(`/offers/${this.getCurrentOffer.id}`, {
                offer: {
                  name: this.data.name,
                  bathrooms_count: this.data.complement.bathrooms,
                  toilets_count: this.data.complement.toilets,
                  sleeps_count: this.data.complement.sleeping,
                  rooms_count: this.data.roomsCount,
                  residence_type: this.data.housingType,
                  offer_description: {
                    residence: this.data.description
                  },
                  address
                }
              })
                .catch((err) => {
                  console.error('Error from the request', err)
                })
                .finally(() => {
                  this.$wait.end('updating offer')
                  this.$router.push({
                    name: 'EditOfferHousing'
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
              if (this.$wait.is('updating offer')) return

              const { location } = this.data.address
              const address = {
                street_name: this.data.address.street_name,
                city: this.data.address.city,
                postal_code: this.data.address.postalCode,
                country_code: 'FR',
                lat: location ? location.lat : 0,
                lng: location ? location.lng : 0
              }

              /**
               * The form data is entirely valid
               */
              this.$wait.start('updating offer')
              this.$axios.put(`/offers/${this.getCurrentOffer.id}`, {
                offer: {
                  name: this.data.name,
                  bathrooms_count: this.data.complement.bathrooms,
                  toilets_count: this.data.complement.toilets,
                  sleeps_count: this.data.complement.sleeping,
                  rooms_count: this.data.roomsCount,
                  residence_type: this.data.housingType,
                  offer_description: {
                    residence: this.data.description
                  },
                  address
                }
              })
                .catch((err) => {
                  console.error('Error from the request', err)
                })
                .finally(() => {
                  this.$wait.end('updating offer')
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

  .headline{
    padding-top:20px;
    text-transform: uppercase;
    font-size: 18px;
    font-family: 'Avenir', -apple-system, BlinkMacSystemFont, 'Segoe UI', Oxygen, Ubuntu, Cantarell, 'Open Sans', 'Helvetica Neue', sans-serif;
  }

  .body-1 em {
    font-size: 12px;
    font-family: 'Avenir', -apple-system, BlinkMacSystemFont, 'Segoe UI', Oxygen, Ubuntu, Cantarell, 'Open Sans', 'Helvetica Neue', sans-serif;
    color: #476458;
  }

  .side {
    background-color:white;
    margin:0 auto;
    padding:30px;
    width:90%
  }

  .housing-types__item label{
    font-size: 14px;
    color: #476458;
    font-family: 'Avenir', -apple-system, BlinkMacSystemFont, 'Segoe UI', Oxygen, Ubuntu, Cantarell, 'Open Sans', 'Helvetica Neue', sans-serif;
    font-weight: bold;
  }

  .housing-field {
    display: grid;
    grid-template-columns: 60% 20%;
  }

  span.wi-textarea__label__wordcount {
    font-size:12px;
  }

  .wi-input__caption{
    font-size:14px!important;
  }

  .done{
    padding-top:40px
  }

  .new-offer{
    padding-top: 0px;

    .side{
      width: 90%;
      @media only screen and (max-width: $breakpoint-tablet) {
        width: 100%;
      }

    }

    .offer-location{

      &__infos{

        &__fields{
          display: grid;
          grid-template-columns: 50% 50%;
          grid-gap: 30px;
          grid-column-gap: 77px;

          @media only screen and (max-width: $breakpoint-tablet) {
            display: block;
            grid-gap: 16px;
          }
        }
      }
    }

    .housing-types {
      display: grid;
      grid-template-columns: repeat(2, 1fr);
      grid-gap: 20px;
    }

    fieldset{
      border: none;
      margin: 0;
      padding-left: 0;
      padding-right: 0;
    }

    .buttons{
      display: flex;
      justify-content: space-between;
    }

    .complement{
      &__fields{
        display: grid;
        grid-template-columns: repeat(2, calc(50% - 8px));
        grid-gap: 20px;
        grid-column-gap: 25px;

        @media only screen and (max-width: $breakpoint-tablet) {
          grid-template-columns: 1fr;
        }
      }
    }

    .time-label{
      &__fields{
        display: grid;
        grid-template-columns: repeat(2, calc(13%));
        grid-gap: 85px;

        @media only screen and (max-width: $breakpoint-tablet) {
          grid-template-columns: 1fr;
        }
      }
    }

    .time-field{
      &__fields{
        display: grid;
        grid-template-columns: repeat(4, calc(10% - 8px));
        grid-gap: 10px;

        @media only screen and (max-width: $breakpoint-tablet) {
          grid-template-columns: 1fr;
        }
      }
    }

    .rooms,
    .description,
    .complement {
      margin-top: 16px;

      > .body-1 {
        margin-top: 0;
      }
    }
  }

</style>
