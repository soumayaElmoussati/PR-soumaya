<template>
  <div class="edit-offer-offer new-offer">
    <div class="side">
      <h1 class="title-side">
        {{ $t("activity.titles.yourResidence") }}
      </h1>
    </div>

    <form
      @submit.prevent="submitted"
    >

      <div class="offer-location side">
        <div class="offer-location__infos">
          <fieldset>
            <legend class="headline">
              {{ $t("activity.titles.ad") }}
            </legend>
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

        <div class="buttons">
          <button
            type="submit"
            class="btn btn-agri-yellow"
            @click.stop.prevent="next"
          >
            <span
              v-if="!$wait.is('creating offer')"
            >
              {{ $t("activity.buttons.next") }}
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
              {{ $t("activity.buttons.save") }}
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

  import FarmTypeSelect from '@/components/NewActivity/FarmTypeSelect'
  import AnimalSelect from '@/components/NewActivity/AnimalSelect'
  import CustomDialog from '@/components/CustomDialog'

  export default {
    name: 'EditActivity',
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
          }
        },
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
      this.data = {
        name: this.getCurrentActivity.name,
        address: {
          street_name: this.getCurrentActivity.activity_address.street_name,
          city: this.getCurrentActivity.activity_address.city,
          postalCode: this.getCurrentActivity.activity_address.postal_code
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
              if (this.$wait.is('updating activity')) return

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
              this.$wait.start('updating activity')
              this.$axios.put(`/activities/${this.getCurrentActivity.id}`, {
                activity: {
                  name: this.data.name,
                  address
                }
              })
                .catch((err) => {
                  console.error('Error from the request', err)
                })
                .finally(() => {
                  this.$wait.end('updating activity')
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
        'setCurrentActivity'
      ]),
      next () {
        this.$validator.validateAll()
          .then((valid) => {
            if (valid) {
              if (this.$wait.is('updating activity')) return

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
              this.$wait.start('updating activity')
              this.$axios.put(`/activities/${this.getCurrentActivity.id}`, {
                activity: {
                  name: this.data.name,
                  address
                }
              })
                .catch((err) => {
                  console.error('Error from the request', err)
                })
                .finally(() => {
                  this.$wait.end('updating activity')
                  this.$router.push({
                    name: 'EditActivityRules'
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
              if (this.$wait.is('updating activity')) return

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
              this.$wait.start('updating activity')
              this.$axios.put(`/activities/${this.getCurrentActivity.id}`, {
                activity: {
                  name: this.data.name,
                  address
                }
              })
                .catch((err) => {
                  console.error('Error from the request', err)
                })
                .finally(() => {
                  this.$wait.end('updating activity')
                  this.$router.push({
                    name: 'DashboardActivities'
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
