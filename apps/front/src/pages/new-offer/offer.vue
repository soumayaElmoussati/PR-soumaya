<template>
  <div class="new-offer">
    <div class="wrap">
      <div class="side">
        <h1 class="title">
          {{ $t("offer.titles.yourResidence") }}
        </h1>
        <p class="body-1">
          <em>{{ $t("offer.paragraphs.depositOffer")[0] }}<br>
            {{ $t("offer.paragraphs.depositOffer")[1] }}</em>
        </p>
      </div>

      <form
        @submit.prevent="submitted"
      >

        <div class="offer-location side">
          <div class="offer-location__infos">
            <fieldset>
              <legend class="headline">
                {{ $t("offer.infos.ad") }}
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
          <fieldset>
            <legend class="headline">
              {{ $t("offer.infos.residenceType") }}
            </legend>
            <p class="body-1">
              {{ $t("offer.paragraphs.residenceType") }}
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
          <fieldset class="rooms">
            <legend class="headline">
              {{ $t("offer.infos.yourResidence") }}
            </legend>

            <p class="body-1">
              <em>{{ $t("offer.paragraphs.describeRoom") }}</em>
            </p>

            <wi-input
              v-validate="'required|numeric|max_value:10'"
              id="roomsCount"
              v-model="data.roomsCount"
              :error="errors.first('roomsCount')"
              data-vv-as="nombre de chambres"
              type="number"
              name="roomsCount"
              label="Combien de chambre(s) y-a-t-il?"
              required
            />
          </fieldset>

          <fieldset class="complement pt-2">
            <div class="complement__fields">
              <wi-input
                v-validate="'required|numeric'"
                id="bathrooms"
                v-model="data.complement.bathrooms"
                :error="errors.first('bathrooms')"
                name="bathrooms"
                label="Salle(s) de bain"
                data-vv-as="salle de bain"
                type="number"
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
                required
              />
            </div>
          </fieldset>

          <fieldset class="description">
            <p class="body-1">
              <em>{{ $t("offer.paragraphs.describeVisitorPlus")[0] }}<br>
                {{ $t("offer.paragraphs.describeVisitorPlus")[1] }}</em>
            </p>
            <wi-textarea
              v-validate="'required|max:5000'"
              id="description"
              v-model="data.description"
              :error="errors.first('description')"
              name="description"
              word-count
              rows="3"
            />
          </fieldset>

          <br>

          <div class="buttons">
            <button
              :disabled="$wait.is('creating offer')"
              type="submit"
              class="btn btn-primary"
            >
              <span
                v-if="!$wait.is('creating offer')"
              >
                {{ $t("offer.buttons.continue") }}
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
  import FarmTypeSelect from '@/components/NewOffer/FarmTypeSelect'
  import AnimalSelect from '@/components/NewOffer/AnimalSelect'
  import WiSpinner from '@/components/WiUI/Spinner'

  export default {
    name: 'NewOffer',
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
        title: 'Déposer une offre'
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
              this.$axios.put(`/offers/${this.getCurrentOffer.id}`, {
                offer: {
                  farmer_id: this.$auth.user.farmer.id,
                  name: this.data.name,
                  bathrooms_count: this.data.complement.bathrooms,
                  toilets_count: this.data.complement.toilets,
                  sleeps_count: this.data.complement.sleeping,
                  rooms_count: this.data.roomsCount,
                  address,
                  residence_type: this.data.housingType,
                  offer_description: {
                    residence: this.data.description
                  }
                }
              })
                .then((response) => {
                  // this.setCurrentOffer(response.data)
                  this.$router.push({
                    name: 'Housing'
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
      grid-template-columns: 60% 40%;
      grid-gap: 16px;

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
