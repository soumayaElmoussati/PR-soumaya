<template>
  <div class="new-offer">
    <div class="wrap">
      <div class="side">
        <h1 class="title">
          {{ $t("activity.titles.yourResidence") }}
        </h1>
        <p class="body-1">
          <em>{{ $t("activity.paragraphs.deposit") }} <br>{{ $t("activity.paragraphs.steps") }}</em>
        </p>
      </div>

      <form
        @submit.prevent="submitted"
      >

        <div class="offer-location side">
          <div class="offer-location__infos">
            <fieldset>
              <legend class="headline">
                {{ $t("activity.legend.ad") }}
              </legend>
              <div class="offer-location__infos__fields">
                <wi-input
                  v-validate="'required|max:255'"
                  id="name"
                  v-model="data.name"
                  :error="errors.first('name')"
                  data-vv-as="nom"
                  type="text"
                  label="Nom de l'annonce"
                  name="name"
                  caption="(ex : Chez Jeannine et Jacques / Ferme de Bileau)"
                  required
                />
                <wi-input
                  v-validate="'required'"
                  id="address"
                  v-model="data.address.street_name"
                  :error="errors.first('address')"
                  data-vv-as="addresse"
                  type="text"
                  name="address"
                  label="Adresse de l'exploitation"
                  required
                />
                <wi-input
                  v-validate="'required'"
                  id="city"
                  v-model="data.address.city"
                  :error="errors.first('city')"
                  data-vv-as="ville"
                  type="text"
                  name="city"
                  label="Ville"
                  required
                />
                <wi-input
                  v-validate="'required|numeric'"
                  id="postal_code"
                  v-model="data.address.postalCode"
                  :error="errors.first('postal_code')"
                  data-vv-as="code postal"
                  type="tel"
                  name="postal_code"
                  label="Code postal"
                  required
                />
              </div>
            </fieldset>
          </div>
        </div>

        <div class="side">

          <div class="buttons">
            <button
              :disabled="$wait.is('creating offer')"
              type="submit"
              class="btn btn-agri-yellow"
            >
              <span
                v-if="!$wait.is('creating offer')"
              >
                {{ $t("activity.buttons.continue") }}
              </span>
              <wi-spinner
                v-else
              />
            </button>
          </div>
        </div>
      </form>
    </div>
  </div>
</template>

<script>
  import { mapActions, mapGetters } from 'vuex'

  import WiInput from '@/components/WiUI/Input'
  import WiTextarea from '@/components/WiUI/Textarea'
  import FarmTypeSelect from '@/components/NewActivity/FarmTypeSelect'
  import AnimalSelect from '@/components/NewActivity/AnimalSelect'
  import WiSpinner from '@/components/WiUI/Spinner'

  export default {
    name: 'ActivityIndex',
    middleware: 'auth',
    components: {
      WiInput,
      WiSpinner,
      WiTextarea,
      FarmTypeSelect,
      AnimalSelect
    },
    head () {
      return {
        title: 'Déposer une activité'
      }
    },
    data () {
      return {
        mapsLoaded: false,
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
        position: {
          lat: 0,
          lng: 0
        },
        zoom: 5,
        selection: []
      }
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
      submitted () {
        this.$validator.validateAll()
          .then((valid) => {
            if (valid) {
              if (this.$wait.is('creating offer')) return

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
              this.$wait.start('creating offer')
              this.$axios.put(`/activities/${this.getCurrentActivity.id}`, {
                activity: {
                  farmer_id: this.$auth.user.farmer.id,
                  name: this.data.name,
                  address
                }
              })
                .then((response) => {
                  // this.setCurrentOffer(response.data)
                  this.$router.push({
                    name: 'ActivityRules'
                  })
                })
                .catch((err) => {
                  console.error('Error from the request', err)
                })
                .finally(() => this.$wait.end('creating offer'))
            }
          })
      }
    }
  }
</script>

<style lang="scss" scoped>
  @import "@/assets/scss/_variables.scss";

  .side {
    background-color:white;
    margin:0 auto;
    padding:30px;
    width:75%
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

  .new-offer{
    padding-top: 32px;

    .side{
      width: 60%;
    }

    .offer-location{
      display: grid;
      grid-template-columns: 100%;

      &__infos{

        &__fields{
          display: grid;
          grid-template-columns: repeat(2, 1fr);
          grid-gap: 16px;

          .wi-input{
            &:nth-child(1),
            &:nth-child(2) {
              grid-column: span 2;
            }
          }
        }
      }
    }

    .housing-types {
      display: grid;
      grid-template-columns: repeat(4, 1fr);
      grid-gap: 16px;
    }

    fieldset{
      border: none;
      margin: 0;
      padding-left: 0;
      padding-right: 0;
    }

    .buttons{
      display: flex;
      justify-content: flex-end;

      .btn:first-child{
        margin-right: 16px;
      }
    }

    .complement{
      &__fields{
        display: grid;
        grid-template-columns: repeat(2, calc(50% - 8px));
        grid-gap: 16px;

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
