<template>
  <div class="pictures">
    <div class="wrap">
      <div class="side">
        <h2 class="title-side">
          Un grand merci ! Grâce à votre retour vous avez participez à l’avancement et l’amélioration d’Agrivillage !
        </h2>

        <div class="info-box">

          <p class="subtitle">
            Pour vous remercier nous vous offrons jusqu’à 10 impressions de photos à recevoir chez vous !
          </p>
          <p class="subtitle-low">
            Acceptez-vous que vous  photos soient utilisées à des fins commerciales uniquement par Agrivillage ? <br>
            Les photos seront utilisés avec bienveillance !
          </p>

          <input
            id="oui"
            v-model="accept"
            type="radio"
            value="oui">
          <label for="oui">Oui je veux mes 10 photos</label>
          <br>
          <input
            id="non"
            v-model="accept"
            type="radio"
            value="non">
          <label for="non">Non je ne souhaite garder mes photos en privée, déjà 3 photos c’est géniale !</label>

        </div>

        <div
          v-if="accept === 'non'"
          class="pictures__upload">
          <client-only>
            <vue-dropzone
              id="dropzone"
              :options="dropzoneOptions"
              @vdropzone-file-added="fileAdded"
              @vdropzone-removed-file="fileRemoved"
              @vdropzone-success="uploaded"
            />
          </client-only>
        </div>

        <div v-else>
          <div
            class="pictures__upload">
            <client-only>
              <vue-dropzone
                id="dropzone"
                :options="dropzoneOptionsYes"
                @vdropzone-file-added="fileAdded"
                @vdropzone-removed-file="fileRemoved"
                @vdropzone-success="uploaded"
              />
            </client-only>
          </div>

        </div>

        <br>

        <wi-input
          id="recipient"
          v-model="data.recipient"
          :error="errors.first('recipient')"
          data-vv-as="recipient"
          type="text"
          label="Nom du destinataire"
          name="recipient"
          required
        />
        <wi-input
          id="address"
          v-model="data.address.street_name"
          :error="errors.first('address')"
          data-vv-as="addresse"
          type="text"
          name="address"
          label="Adresse postale"
          required
        />
        <wi-input
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
          id="postal_code"
          v-model="data.address.postalCode"
          :error="errors.first('postal_code')"
          data-vv-as="code postal"
          type="tel"
          name="postal_code"
          label="Code postal"
          required
        />

        <br>

        <div class="buttons">
          <button
            type="submit"
            class="btn btn-agri-yellow"
            @click="refused"
          >
            Merci, je ne suis pas intéressé
          </button>

          <br>

          <button
            type="submit"
            class="btn btn-agri-yellow"
            @click="submitted"
          >
            Recevoir mes photos
          </button>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
  import { mapGetters } from 'vuex'

  import Cloudinary from '@/components/Cloudinary'

  export default {
    name: 'PicturesReview',
    middleware: 'auth',
    components: {
      Cloudinary
    },
    data () {
      return {
        data: {
          files: [],
          uploadedFiles: [],
          recipient: null,
          address: {
            street_name: null,
            city: null,
            postalCode: null
          }
        },
        accept: null,
        dropzoneOptions: {
          url: 'https://api.cloudinary.com/v1_1/agrivillage/image/upload',
          method: 'post',
          maxFilesize: 5, // MB
          maxFiles: 3,
          parallelUploads: 1,
          addRemoveLinks: true,
          dictDefaultMessage: 'Télécharger vos 3 photos',
          dictFileTooBig: 'Fichier trop lourd Max {{maxFilesize}}MB',
          dictCancelUpload: 'Annuler',
          dictCancelUploadConfirmation: 'Êtes-vous sûr de vouloir annuler ce chargement ?',
          dictRemoveFile: 'Supprimer',
          params: {
            upload_preset: 'jqbvlryc'
          }
        },
        dropzoneOptionsYes: {
          url: 'https://api.cloudinary.com/v1_1/agrivillage/image/upload',
          method: 'post',
          maxFilesize: 5, // MB
          maxFiles: 10,
          parallelUploads: 1,
          addRemoveLinks: true,
          dictDefaultMessage: 'Télécharger vos 10 photos',
          dictFileTooBig: 'Fichier trop lourd Max {{maxFilesize}}MB',
          dictCancelUpload: 'Annuler',
          dictCancelUploadConfirmation: 'Êtes-vous sûr de vouloir annuler ce chargement ?',
          dictRemoveFile: 'Supprimer',
          params: {
            upload_preset: 'jqbvlryc'
          }
        }
      }
    },
    fetch ({ app, route, store }) {
      return app.$axios.get(`/reviews/${store.state.currentReview.id}`)
        .then(res => {
          if (res.status === 200) {
            store.commit('SET_CURRENT_REVIEW', res.data)
          }
        })
    },
    computed: {
      ...mapGetters([
        'getCurrentReview'
      ]),
      images () {
        return this.data.files.filter(file => file.success)
      }
    },
    mounted () {
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
            const { address_components: addressComponents, geometry } = place

            const city = addressComponents.find(comp =>
              comp.types.find(
                v => v === 'locality' || v === 'administrative_area_level_1'
              )
            )
            const postalCode = addressComponents.find(comp =>
              comp.types.find(v => v === 'postal_code')
            )

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
      fileAdded (file) {
        this.data.files.push(file)
      },
      fileRemoved (file) {
        const fileIndex = this.data.files.findIndex(f => f.upload.uuid === file.upload.uuid)
        this.data.files.splice(fileIndex, 1)
      },
      uploaded (file, res) {
        const fileIndex = this.data.files.findIndex(f => f.upload.uuid === file.upload.uuid)
        if (fileIndex !== -1) {
          this.$set(this.data.files, fileIndex, file)
        }

        if (res.public_id) {
          this.data.uploadedFiles.push({
            order: this.data.uploadedFiles.length + 1,
            public_id: res.public_id,
            url: 'https://res.cloudinary.com/agrivillage/image/upload/' + res.public_id
          })
        }
      },
      submitted () {
        const { location } = this.data.address
        const address = {
          recipient: this.data.recipient,
          street_name: this.data.address.street_name,
          city: this.data.address.city,
          postal_code: this.data.address.postalCode,
          country_code: 'FR',
          lat: location ? location.lat : 0,
          lng: location ? location.lng : 0
        }
        this.$wait.start('adding pictures')
        this.$axios
          .put(`/reviews/${this.getCurrentReview.id}`, {
            review: address
          })
        this.$axios.post(`/reviews/${this.getCurrentReview.id}/replace_pictures`, {
          pictures: this.data.uploadedFiles
        })
          .then((res) => {
            this.$router.push({
              name: 'DoneReview',
              params: { id: this.getCurrentReview.id }
            })
          })
          .catch(err => console.error('err', err))
          .finally(() => this.$wait.end('adding pictures'))
      },
      refused () {
        this.$router.push({
          name: 'DashboardClientBookings'
        })
      }
    }
  }
</script>

<style lang="scss">
@import "@/assets/scss/_variables.scss";

  .side {
    background-color:white;
    margin: 0 120px 30px 0;
    padding:30px;
    width:75%
  }

  .info-box {
    border-radius: 50px;
    background-color: #E4E6E5;
    padding: 25px;
    margin-bottom: 20px;
  }

  .title-side {
    color: black;
    font-size: 26px;
    font-weight: bold;
    text-transform: uppercase;
    font-family: 'Avenir', -apple-system, BlinkMacSystemFont, 'Segoe UI', Oxygen, Ubuntu, Cantarell, 'Open Sans', 'Helvetica Neue', sans-serif;
  }

  .subtitle {
    color: black;
    font-family: 'Avenir', -apple-system, BlinkMacSystemFont, 'Segoe UI', Oxygen, Ubuntu, Cantarell, 'Open Sans', 'Helvetica Neue', sans-serif;
    font-size: 14px;
    text-transform: uppercase;
  }

  .subtitle-low {
    margin-top: 20px;
    margin-bottom: 20px;
    font-size: 14px;
    font-family: 'Avenir', -apple-system, BlinkMacSystemFont, 'Segoe UI', Oxygen, Ubuntu, Cantarell, 'Open Sans', 'Helvetica Neue', sans-serif;
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

  .pictures{
    padding-top: 32px;
    min-height: 70vh;

    .side{
      width: 60%;
    }

    .buttons{
      display: flex;
      justify-content: space-between;
      margin-top: 32px;

      @media screen and (max-width: 768px) {
        display: grid;
        grid-template-columns: auto;
      }

      .btn:first-child{
        margin-right: 16px;
      }
    }

    .testing{
      display: flex;

      .dz-preview{
        margin-right: 16px;
      }
    }

    &__upload{
      display: flex;
      flex-direction: column;

      .file-uploads{
        margin: auto;
      }
    }
  }

  @media screen and (max-width: 768px) {
    .side {
      width:100%;
      margin:0;
      padding:10px;
    }

    .pictures{
      padding-top: 0px;

      .side{
        width: 100%;
      }
    }
  }
</style>
