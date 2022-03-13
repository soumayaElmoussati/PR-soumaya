<template>
  <div class="pictures">
    <div class="wrap">
      <div class="side">
        <h2 class="title-side">
          {{ $t("activity.titles.activitiesPicture") }}
        </h2>

        <div class="info-box">

          <p class="subtitle">
            {{ $t("activity.paragraphs.know") }}
          </p>
          <p class="subtitle-low">
            {{ $t("activity.paragraphs.pictureReservation")[0] }}<br>
            {{ $t("activity.paragraphs.pictureReservation")[1] }}
          </p>
          <p class="subtitle-low">
            {{ $t("activity.paragraphs.picture") }}
          </p>
          <ol class="subtitle-low">
            <li>
              {{ $t("activity.lists.clean") }}
            </li>
            <li>
              {{ $t("activity.lists.light") }}
            </li>
            <li>
              {{ $t("activity.lists.size") }}
            </li>
            <li>
              {{ $t("activity.lists.warm") }}
            </li>
          </ol>

          <p class="subtitle-low">
            {{ $t("activity.paragraphs.upload") }}
          </p>

        </div>

        <div class="pictures__upload">
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

        <div class="buttons">
          <button
            type="submit"
            class="btn btn-agri-previous"
            @click.stop.prevent="previous"
          >
            <span
              v-if="!$wait.is('creating offer')"
            >
              {{ $t("activity.buttons.previous") }}
            </span>
            <wi-spinner
              v-else
            />
          </button>
          <button
            type="submit"
            class="btn btn-agri-yellow"
            @click="submitted"
          >
            {{ $t("activity.buttons.continue") }}
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
    name: 'ActivityPictures',
    middleware: 'auth',
    components: {
      Cloudinary
    },
    data () {
      return {
        data: {
          files: [],
          uploadedFiles: []
        },
        dropzoneOptions: {
          url: 'https://api.cloudinary.com/v1_1/agrivillage/image/upload',
          method: 'post',
          maxFilesize: 5, // MB
          parallelUploads: 1,
          addRemoveLinks: true,
          dictDefaultMessage: 'Cliquez ici pour ajouter',
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
      return app.$axios.get(`/activities/${store.state.currentActivity.id}`)
        .then(res => {
          if (res.status === 200) {
            store.commit('SET_CURRENT_ACTIVITY', res.data)
          }
        })
    },
    computed: {
      ...mapGetters([
        'getCurrentActivity'
      ]),
      images () {
        return this.data.files.filter(file => file.success)
      }
    },
    methods: {
      previous () {
        this.$router.push({
          name: 'ActivityPrice'
        })
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
        this.$router.push({
          name: 'ActivityDone'
        })
        this.$wait.start('adding pictures')
        this.$axios.post(`/activities/${this.getCurrentActivity.id}/replace_pictures`, {
          pictures: this.data.uploadedFiles
        })
          .then((res) => {
            this.$router.push({
              name: 'ActivityDone'
            })
          })
          .catch(err => console.error('err', err))
          .finally(() => this.$wait.end('adding pictures'))
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
    font-size: 12px;
    text-transform: uppercase;
  }

  .subtitle-low {
    margin-top: 20px;
    margin-bottom: 20px;
    font-size: 12px;
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
