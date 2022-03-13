<template>
  <div class="content">
    <div class="title">
      <h3>Nouvelle dépense</h3>
    </div>
    <div class="form-content">
      <form
        accept-charset="UTF-8"
        method="POST"
        @submit.prevent="onSubmit()"
      >
        <div>

          <div class="row">
            <div class="col-25">
              <label>Date de dépense :</label>
            </div>
            <div class="col-75">
              <div>
                <datepicker
                  v-model="data.date"
                  :format="'dd-MM-yy'"
                  :language="fr"
                />
              </div>
            </div>
          </div>

          <div class="row">
            <div class="col-75">
              <wi-input
                v-validate="'required|decimal:2'"
                id="totalHt"
                v-model="data.totalHt"
                :error="errors.first('totalHt')"
                data-vv-as="prix ht"
                type="tel"
                name="totalHt"
                label="Total HT"
                required
              />
            </div>
          </div>

          <div class="row">
            <div class="col-75">
              <wi-input
                v-validate="'required|decimal:2'"
                id="totalTtc"
                v-model="data.totalTtc"
                :error="errors.first('totalTtc')"
                data-vv-as="prix ttc"
                type="tel"
                name="totalTtc"
                label="Total TTC"
                required
              />
            </div>
          </div>

          <br>

          <p class="body-1">
            <em>
              Décrivez votre dépense
            </em>
          </p>
          <wi-textarea
            v-validate="'required|max:1500'"
            id="comment"
            v-model="data.comment"
            :error="errors.first('comment')"
            name="comment"
            label="Commentaire"
            word-count
            rows="3"
          />

          <br >

          <div class="pictures__upload">
            <h4 class="picture-label">Ajoutez une preuve photo de votre dépense</h4>
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

          <br>

          <div class="buttons">
            <button
              class="btn btn-agri-yellow"
              @click="backFarmerIncome()"
            >
              <span v-if="!$wait.is('creating expense')">
                Retour
              </span>
              <wi-spinner v-else />
            </button>
            <button
              :disabled="$wait.is('creating expense')"
              type="submit"
              class="btn btn-agri-yellow"
            >
              <span v-if="!$wait.is('creating expense')">
                Valider
              </span>
              <wi-spinner v-else />
            </button>
            <div
              v-if="errors.items.length"
              style="margin-left: 1em; color: red">
              {{ $t("offer.infos.check") }}
            </div>
          </div>

        </div>
      </form>
    </div>
  </div>
</template>

<script>
import { mapGetters } from 'vuex'
import WiInput from '@/components/WiUI/Input'
import WiTextarea from '@/components/WiUI/Textarea'
import Datepicker from 'vuejs-datepicker'
import WiSpinner from '@/components/WiUI/Spinner'
import Cloudinary from '@/components/Cloudinary'

export default {
  name: 'NewExpense',
  middleware: 'auth',
  components: {
    Datepicker,
    WiInput,
    WiSpinner,
    WiTextarea,
    Cloudinary
  },
  data () {
    return {
      data: {
        comment: null,
        date: null,
        totalHt: null,
        totalTtc: null,
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
      },
      loading: true,
      isSuccess: false,
      fr: {
        language: 'French',
        months: [
          'Janvier',
          'Février',
          'Mars',
          'Avril',
          'Mai',
          'Juin',
          'Juillet',
          'Août',
          'Septembre',
          'Octobre',
          'Novembre',
          'Décembre'
        ],
        monthsAbbr: [
          'Jan',
          'Fév',
          'Mar',
          'Avr',
          'Mai',
          'Juin',
          'Juil',
          'Août',
          'Sep',
          'Oct',
          'Nov',
          'Déc'
        ],
        days: ['Dim', 'Lun', 'Mar', 'Mer', 'Jeu', 'Ven', 'Sam'],
        rtl: false,
        ymd: false,
        yearSuffix: ''
      }
    }
  },
  computed: {
    ...mapGetters(['getFarmer']),
    images () {
        return this.data.files.filter(file => file.success)
    }
  },
  methods: {
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
    onSubmit () {
      this.$validator.validateAll().then(valid => {
        if (valid) {
          // /**
          //  * The form data is entirely valid
          //  */
        this.$wait.start('creating expense')
          this.$axios
            .post('/expenses', {
              expense: {
                offer_id: this.$route.params.id,
                responsable: 'Agriculteur',
                expense_date: this.data.date,
                total_ttc: (this.data.totalTtc * 100),
                total_ht: (this.data.totalHt * 100),
                comment: this.data.comment
              }
            })
            .then((res) => {
              this.$axios.post(`/expenses/${res.data.id}/replace_pictures`, {
                pictures: this.data.uploadedFiles
              })
              this.$router.push({
                name: 'DashboardOffers'
              })
              this.$toast.success({
                title: 'Dépense ajouter',
                message: 'Vous avez bien ajouté une nouvelle dépense.',
                position: 'bottom center',
                timeOut: 3000
              })
            })
            .catch(err => {
              console.error('Error from the request', err)
            })
            .finally(() => this.$wait.end('creating expense'))
        }
      })
    },
    backFarmerIncome () {
      this.$router.push({
        name: 'DashboardOffers'
      })
    }
  }
}
</script>
<style lang="scss" scoped>
@import "@/assets/scss/_variables.scss";

.buttons{
  display: flex;
  justify-content: space-between;

  .btn:first-child{
    margin-right: 16px;
  }
}

.picture-label {
  color: #476458;
  font-family: 'Avenir', -apple-system, BlinkMacSystemFont, 'Segoe UI', Oxygen, Ubuntu, Cantarell, 'Open Sans', 'Helvetica Neue', sans-serif;
  font-weight: bold;
}

.content {
  margin-bottom: 10%;
}
.title{
  text-align: center;
  padding-top: 25px;
  font-size: 32px;
  h3 {
    margin-bottom: 25px;
    font-family: 'Roboto', -apple-system, BlinkMacSystemFont, 'Segoe UI', Oxygen, Ubuntu, Cantarell, 'Open Sans', 'Helvetica Neue', sans-serif;
    color: $agri-green;
  }
}
.line {
  margin: auto;
  width: 20%;
  margin-bottom: 20px;
  border: 2px solid $agri-green;
}
.form-content {
  margin-left: 20%;
  margin-right: 20%;
}
* {
  box-sizing: border-box;
}

input[type=text], select, textarea {
  width: 100%;
  padding: 7px;
  border: 1px solid #ccc;
  border-radius: 4px;
  resize: vertical;
}

label {
  padding: 12px 12px 12px 0;
  display: inline-block;
}

input[type=submit] {
  background-color: #4CAF50;
  color: white;
  padding: 12px 20px;
  border: none;
  border-radius: 4px;
  cursor: pointer;
  float: right;
}

input[type=submit]:hover {
  background-color: #45a049;
}

.container {
  border-radius: 5px;
  background-color: #f2f2f2;
  padding: 20px;
}

.col-25 {
  float: left;
  width: 25%;
  margin-top: 6px;
}

.col-75 {
  float: left;
  width: 75%;
  margin-top: 6px;
}

/* Clear floats after the columns */
.row:after {
  content: "";
  display: table;
  clear: both;
}

/* Responsive layout - when the screen is less than 600px wide, make the two columns stack on top of each other instead of next to each other */
@media screen and (max-width: 600px) {
  .col-25, .col-75, input[type=submit] {
    width: 100%;
    margin-top: 0;
  }
}
</style>
