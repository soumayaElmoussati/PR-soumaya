<template>
  <div class="edit-offer-pictures">
    <div class="">
      <div class="side">
        <h1 class="title">
          {{ $t("farmer.profile.picture") }}
        </h1>

        <br>

        <em>{{ $t("farmer.profile.add") }}</em>

        <client-only>
          <draggable
            ref="drag"
            v-model="list"
            v-bind="dragOptions"
            class="list-group"
            tag="div"
            @start="drag = true"
            @end="setOrders"
          >
            <transition-group
              :name="!drag ? 'flip-list' : null"
              class="drag-wrap"
              type="transition">
              <div
                v-for="(element, idx) in list"
                :key="element.order"
                class="list-group-item"
              >
                <i
                  class="material-icons"
                  @click="removeAt(idx)">close</i>
                <img
                  :src="element.url"
                  alt="">
              </div>
            </transition-group>
          </draggable>
        </client-only>

        <div class="pictures__upload">
          <client-only>
            <vue-dropzone
              id="dropzone"
              ref="drop"
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
            class="btn btn-agri"
            @click="submitted"
          >
            {{ $t("farmer.buttons.save") }}
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
    name: 'EditFarmerPicture',
    middleware: 'auth',
    display: 'Transitions',
    order: 7,
    components: {
      Cloudinary
    },
    data () {
      return {
        ab: [],
        list: null,
        temp: null,
        drag: false,
        data: {
          files: [],
          uploadedFiles: []
        },
        dropzoneOptions: {
          url: 'https://api.cloudinary.com/v1_1/agrivillage/image/upload',
          method: 'post',
          maxFilesize: 5, // NOTE: MB
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
      return app.$axios.get(`/farmers/${route.params.id}`)
        .then(res => {
          if (res.status === 200) {
            store.commit('SET_CURRENT_FARMER', res.data)
          }
        })
    },
    computed: {
      ...mapGetters([
        'getCurrentFarmer'
      ]),
      images () {
        return this.data.files.filter(file => file.success)
      },
      dragOptions () {
        return {
          animation: 200,
          group: 'description',
          disabled: false,
          ghostClass: 'ghost'
        }
      }
    },
    mounted () {
      var temp = this.getCurrentFarmer.pictures
      for (var i = 0; i < this.getCurrentFarmer.pictures.length; i++) {
        temp[i].url = 'https://res.cloudinary.com/agrivillage/image/upload/' + temp[i].public_id
      }

      this.list = temp
    },
    methods: {
      removeAt (idx) {
        this.list.splice(idx, 1)
      },
      setOrders () {
        var l = this.list.length
        this.ab = []
        for (var k = 0; k < l; k++) {
          this.ab[k] = {
            order: k + 1,
            public_id: this.list[k].public_id,
            url: this.list[k].url
          }
        }
        this.$refs.drag.value = this.ab
      },
      sort () {
        this.list = this.list.sort((a, b) => a.order - b.order)
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

        var ord = this.list.length + 1
        if (res.public_id) {
          this.list.push({
            order: ord,
            public_id: res.public_id,
            url: 'https://res.cloudinary.com/agrivillage/image/upload/' + res.public_id
          })
        }
        this.$refs.drop.removeFile(file)
      },
      submitted () {
        this.setOrders()
        this.$wait.start('adding pictures')
        this.$axios.post(`/farmers/${this.getCurrentFarmer.id}/replace_pictures`, {
          pictures: this.$refs.drag.value
        })

          .catch(err => console.error('err', err))
          .finally(() => {
            this.$wait.end('adding pictures')
            this.$router.push({
              name: 'DashboardOffers'
            })
          }
          )
      }
    }
  }
</script>

<style lang="scss" scoped>
  @import "@/assets/scss/_variables.scss";

  .button {
    margin-top: 35px;
  }
  .flip-list-move {
    transition: transform 0.5s;
  }
  .no-move {
    transition: transform 0s;
  }
  .ghost {
    opacity: 0.5;
    background: #c8ebfb;
  }
  .list-group {
    min-height: 20px;
  }
  .list-group-item {
    width: 100%;
    cursor: move;
  }
  .list-group-item i {
    cursor: pointer;
  }

  .drag-wrap{
    display: grid;
    grid-template-columns: repeat(4,1fr);
    grid-gap: 10px;
    @media only screen and (max-width: $breakpoint-tablet) {
      display: flex;
      flex-direction: column;
    }
    div:first-child {
      // border: 1px solid black;
      padding-top: 3px;
      grid-column-start: 1;grid-column-end: 3;
      grid-row-start: 1;grid-row-end: 3;
    }
    div img {
      width: 100%;
    }
    div i {
      position: absolute;
      padding: 5px;
      text-shadow: 0 0 12px white;
      &:hover {
        color: #9a9a9a;
      }
    }
  }

  //
  //
  //
  .edit-offer-pictures{
    // padding-top: 32px;
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

  .pictures{
    padding-top: 0px;
    min-height: 70vh;

    .side{
      width: 90%;
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
  .buttons{
    display: flex;
    justify-content: flex-end;
    margin-top: 32px;

    .btn:first-child{
      margin-right: 16px;
    }
  }

  @media screen and (max-width: $breakpoint-tablet) {
    .side {
      width:100%;
    }
  }
</style>
