<template>
  <div class="edit-offer-pictures">
    <div class="side">

      <h2 class="title-side">
        {{ $t("offer.titles.picture") }}
      </h2>

      <div class="info-box">

        <p class="subtitle">
          {{ $t("offer.paragraphs.know") }}
        </p>
        <p class="subtitle-low">
          {{ $t("offer.paragraphs.pictureReservation")[0] }}<br>
          {{ $t("offer.paragraphs.pictureReservation")[1] }}
        </p>
        <p class="subtitle-low">
          {{ $t("offer.paragraphs.picture") }}
        </p>
        <ol class="subtitle-low">
          <li>
            {{ $t("offer.lists.clean") }}
          </li>
          <li>
            {{ $t("offer.lists.lighted") }}
          </li>
          <li>
            {{ $t("offer.lists.size") }}
          </li>
          <li>
            {{ $t("offer.lists.warm") }}
          </li>
        </ol>

        <p class="subtitle-low">
          {{ $t("offer.paragraphs.upload") }}
        </p>

      </div>

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

      <br>

      <h2 class="title-side">
        {{ $t("offer.titles.pictureOperation") }}
      </h2>
      <p class="subtitle-low">
        {{ $t("offer.paragraphs.put") }}
      </p>
      <ol class="subtitle-low">
        <li>
          {{ $t("offer.lists.animalsPicture") }}
        </li>
        <li>
          {{ $t("offer.lists.activitiesPicture") }}
        </li>
        <li>
          {{ $t("offer.lists.farm") }}
        </li>
      </ol>
      <p class="subtitle-low">
        <em>{{ $t("offer.paragraphs.uploadOperation") }}</em>
      </p>
      <client-only>
        <draggable
          ref="dragFarm"
          v-model="farmlist"
          v-bind="dragOptions"
          class="list-group"
          tag="div"
          @start="dragFarm = true"
          @end="setOrdersFarm"
        >
          <transition-group
            :name="!dragFarm ? 'flip-list' : null"
            class="drag-wrap"
            type="transition">
            <div
              v-for="(elementfarm, id) in farmlist"
              :key="elementfarm.order"
              class="list-group-item"
            >
              <i
                class="material-icons"
                @click="removeAtFarm(id)">close</i>
              <img
                :src="elementfarm.url"
                alt="">
            </div>
          </transition-group>
        </draggable>
      </client-only>

      <div class="pictures__upload">
        <client-only>
          <vue-dropzone
            id="dropzonefarm"
            ref="dropfarm"
            :options="dropzoneOptions"
            @vdropzone-file-added="fileAddedFarm"
            @vdropzone-removed-file="fileRemovedFarm"
            @vdropzone-success="uploadedFarm"
          />
        </client-only>
      </div>

      <div class="buttons">
        <button
          type="submit"
          class="btn btn-agri-yellow"
          @click="next"
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
          type="submit"
          class="btn btn-agri-yellow"
          @click="submitted"
        >
          {{ $t("offer.buttons.save") }}
        </button>
      </div>
    </div>

    <CustomDialog
      v-model="showDialog"
      @close="closeDialog"
      @discard-changes="discardChanges"
      @save-changes="saveChanges"
    />
  </div>
</template>

<script>
  import { mapGetters } from 'vuex'

  import Cloudinary from '@/components/Cloudinary'
  import CustomDialog from '@/components/CustomDialog'

  export default {
    name: 'EditOfferPictures',
    middleware: 'auth',
    display: 'Transitions',
    order: 7,
    components: {
      Cloudinary, CustomDialog
    },
    data () {
      return {
        to: null,
        showDialog: false,
        ab: [],
        abfarm: [],
        list: null,
        farmlist: null,
        temp: null,
        farmtemp: null,
        drag: false,
        dragFarm: false,
        data: {
          files: [],
          uploadedFiles: [],
          farmfiles: [],
          uploadedFarmFiles: []
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
      ]),
      images () {
        return this.data.files.filter(file => file.success)
      },
      farmimages () {
        return this.data.farmfiles.filter(file => file.success)
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
      var temp = this.getCurrentOffer.pictures
      for (var i = 0; i < this.getCurrentOffer.pictures.length; i++) {
        temp[i].url = 'https://res.cloudinary.com/agrivillage/image/upload/' + temp[i].public_id
      }

      var farmtemp = this.getCurrentOffer.picturesoffer
      for (var j = 0; j < this.getCurrentOffer.picturesoffer.length; j++) {
        farmtemp[j].url = 'https://res.cloudinary.com/agrivillage/image/upload/' + farmtemp[j].public_id
      }

      this.list = temp
      this.farmlist = farmtemp
    },
    methods: {
      closeDialog () {
        this.showDialog = false
        this.to = null
      },
      saveChanges () {
        this.setOrders()
        this.setOrdersFarm()
        this.$wait.start('adding pictures')
        this.$axios.post(`/offers/${this.getCurrentOffer.id}/replace_pictures`, {
          pictures: this.$refs.drag.value
        })
        this.$axios.post(`/offers/${this.getCurrentOffer.id}/replace_offer_pictures`, {
          pictures: this.$refs.dragFarm.value
        })
          .catch(err => console.error('err', err))
          .finally(() => {
            this.$wait.end('adding pictures')
            this.$router.push({
              name: 'DashboardOffers'
            })
            this.showDialog = false
            this.$router.push(this.to)
          }
          )
      },
      discardChanges () {
        this.showDialog = false
        this.$router.push(this.to)
      },
      removeAt (idx) {
        this.list.splice(idx, 1)
      },
      removeAtFarm (id) {
        this.farmlist.splice(id, 1)
      },
      setOrders () {
        var l = this.list.length
        this.ab = []
        for (var k = 0; k < l; k++) {
          this.ab[k] = {
            order: k + 1,
            public_id: this.list[k].public_id,
            picture_type: 'offer',
            url: this.list[k].url
          }
        }
        this.$refs.drag.value = this.ab
      },
      setOrdersFarm () {
        var l = this.farmlist.length
        this.abfarm = []
        for (var k = 0; k < l; k++) {
          this.abfarm[k] = {
            order: k + 1,
            public_id: this.farmlist[k].public_id,
            url: this.farmlist[k].url
          }
        }
        this.$refs.dragFarm.value = this.abfarm
      },
      sort () {
        this.list = this.list.sort((a, b) => a.order - b.order)
      },
      sortFarm () {
        this.farmlist = this.farmlist.sort((a, b) => a.order - b.order)
      },
      fileAdded (file) {
        this.data.files.push(file)
      },
      fileAddedFarm (file) {
        this.data.farmfiles.push(file)
      },
      fileRemoved (file) {
        const fileIndex = this.data.files.findIndex(f => f.upload.uuid === file.upload.uuid)
        this.data.files.splice(fileIndex, 1)
      },
      fileRemovedFarm (file) {
        const fileIndexFarm = this.data.farmfiles.findIndex(f => f.upload.uuid === file.upload.uuid)
        this.data.farmfiles.splice(fileIndexFarm, 1)
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
            picture_type: 'offer',
            url: 'https://res.cloudinary.com/agrivillage/image/upload/' + res.public_id
          })
        }
        this.$refs.drop.removeFile(file)
      },
      uploadedFarm (file, res) {
        const fileIndexFarm = this.data.farmfiles.findIndex(f => f.upload.uuid === file.upload.uuid)
        if (fileIndexFarm !== -1) {
          this.$set(this.data.farmfiles, fileIndexFarm, file)
        }

        var farmord = this.farmlist.length + 1
        if (res.public_id) {
          this.farmlist.push({
            order: farmord,
            public_id: res.public_id,
            url: 'https://res.cloudinary.com/agrivillage/image/upload/' + res.public_id
          })
        }
        this.$refs.drop.removeFile(file)
      },
      next () {
        this.setOrders()
        this.setOrdersFarm()
        this.$wait.start('adding pictures')
        // var temp = this.$refs.drag.value
        this.$axios.post(`/offers/${this.getCurrentOffer.id}/replace_pictures`, {
          pictures: this.$refs.drag.value
        })
        this.$axios.post(`/offers/${this.getCurrentOffer.id}/replace_offer_pictures`, {
          pictures: this.$refs.dragFarm.value
        })
          .catch(err => console.error('err', err))
          .finally(() => {
            this.$wait.end('adding pictures')
            this.$router.push({
              name: 'EditOfferAnnexes'
            })
            this.showDialog = false
            this.$router.push(this.to)
          }
          )
      },
      next2 () {
        this.$wait.start('adding pictures')
        this.$axios.post(`/offers/${this.getCurrentOffer.id}/add_pictures`, {
          pictures: this.data.uploadedFiles
        })
        this.$axios.post(`/offers/${this.getCurrentOffer.id}/add_offer_pictures`, {
          pictures: this.data.uploadedFarmFiles
        })
          .catch(err => console.error('err', err))
          .finally(() => {
            this.$wait.end('adding pictures')
            this.$router.push({
              name: 'EditOfferCalendar'
            })
            this.showDialog = false
            this.$router.push(this.to)
          }
          )
      },
      submitted () {
        this.setOrders()
        this.setOrdersFarm()
        this.$wait.start('adding pictures')
        this.$axios.post(`/offers/${this.getCurrentOffer.id}/replace_pictures`, {
          pictures: this.$refs.drag.value
        })
        this.$axios.post(`/offers/${this.getCurrentOffer.id}/replace_offer_pictures`, {
          pictures: this.$refs.dragFarm.value
        })
          .catch(err => console.error('err', err))
          .finally(() => {
            this.$wait.end('adding pictures')
            this.$router.push({
              name: 'DashboardOffers'
            })
            this.showDialog = false
            this.$router.push(this.to)
          }
          )
      }
    }
  }
</script>

<style lang="scss" scoped>
  @import "@/assets/scss/_variables.scss";

  .info-box {
    border-radius: 50px;
    background-color: #E4E6E5;
    padding: 25px;
    width: 65%;
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
      width: 65%;

      .file-uploads{
        margin: auto;
      }
    }
  }
  .buttons{
    display: flex;
    justify-content: space-between;
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
