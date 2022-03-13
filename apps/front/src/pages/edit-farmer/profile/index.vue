<template>
  <div class="farmer">
    <div class="edit-wrap">

      <div class="side">

        <div class="edit-infos">

          <div class="offer-card-image">
            <cloudinary
              v-if="getCurrentFarmer.pictures.length"
              :public-id="getCurrentFarmer.pictures[0].public_id"
              :itemkey="getCurrentFarmer.id.toString()"
              :transformations="{
                w: 80,
                h: 80,
                c: 'fill',
                f: 'jpg',
                fl: 'progressive'
              }"
              :alt="getCurrentFarmer.first_name"
            />

            <div v-else>
              <img
                src="~assets/img/user/farmer.svg"
                class="default-profile"
                title="profile"
                alt="profile">
            </div>
          </div>

          <h1 class="edit-title">
            {{ $t("farmer.profile.edit") }}
          </h1>
          <h2 class="headline">
            {{ $t("farmer.titles.talking") }} {{ getCurrentFarmer.user.first_name }} !
          </h2>
          <p class="body-1">
            {{ $t("farmer.paragraphs.about") }}
          </p>

          <form
            @submit.prevent="submitted"
          >

            <wi-textarea
              v-validate="'required|max:500'"
              id="description"
              v-model="data.description"
              :error="errors.first('description')"
              :placeholder="$t('farmer.placeholder.describe')"
              data-vv-as="description"
              name="description"
              rows="3"
              required
              word-count
            />

            <p class="body-1">
              {{ $t("farmer.paragraphs.language") }}
            </p>

            <equipment-select
              v-model="data.equipments"
            />

            <p class="body-1">
              {{ $t("farmer.paragraphs.member") }}
            </p>

            <organisation-select
              v-model="data.organisations"
            />

            <div v-if="getCurrentFarmer.payments_authorisation === false">

              <p class="body-1">
                {{ $t("farmer.paragraphs.connection") }}
              </p>

              <a
                :href="getCurrentFarmer.stripe_link"
                class="btn btn-agri-yellow"
                style="max-width: 350px;">{{ $t("farmer.buttons.register") }}</a>

            </div>

            <div v-if="getCurrentFarmer.payments_authorisation === true">

              <p class="body-1">
                {{ $t("farmer.paragraphs.stripeOk") }}
                <i
                  class="check material-icons check-icon"
                  aria-hidden="true"
                >check</i>
              </p>

              <a
                :href="getCurrentFarmer.stripe_link"
                class="btn btn-agri-yellow"
                style="max-width: 350px;">{{ $t("farmer.paragraphs.stripeChange") }}</a>

            </div>

            <div class="buttons">
              <button
                type="submit"
                class="btn btn-agri-yellow"
                style="max-width: 350px;"
              >
                {{ $t("farmer.buttons.save") }}
              </button>
            </div>

          </form>

        </div>

      </div>
    </div>
  </div>
</template>

<script>
  import { mapGetters } from 'vuex'
  import WiTextarea from '@/components/WiUI/Textarea'
  import EquipmentSelect from '@/components/Farmer/EquipmentSelect'
  import OrganisationSelect from '@/components/Farmer/OrganisationSelect'
  import Cloudinary from '@/components/Cloudinary'

  export default {
    name: 'EditFarmerProfile',
    middleware: 'auth',
    display: 'Transitions',
    order: 7,
    components: {
      WiTextarea, EquipmentSelect, OrganisationSelect, Cloudinary
    },
    data () {
      return {
        data2: {},
        data: {
          description: null,
          equipments: [],
          equipmentsIndex: {},
          organisations: [],
          organisationsIndex: []
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
      ])
    },
    mounted () {
      this.data.description = this.getCurrentFarmer.description

      if (typeof (this.getCurrentFarmer.equipment) === 'undefined') {
        this.getCurrentFarmer.equipment = {}
      }

      this.data.equipmentsIndex = this.getCurrentFarmer.equipment

      if (typeof (this.getCurrentFarmer.organisation) === 'undefined') {
        this.getCurrentFarmer.organisation = {}
      }

      this.data.organisationsIndex = this.getCurrentFarmer.organisation

      var self = this

      for (var prop in this.data.equipmentsIndex) {
        if (this.data.equipmentsIndex[prop] === true) {
          self.data.equipments.push(prop)
          self.$children[2].selection.push(prop)
        }
      }

      for (prop in this.data.organisationsIndex) {
        if (this.data.organisationsIndex[prop] === true) {
          self.data.organisations.push(prop)
          self.$children[3].selection.push(prop)
        }
      }
    },
    methods: {
      submitted () {
        this.$validator.validateAll()
          .then(valid => {
            if (valid) {
              if (this.$wait.is('updating farmer infos')) return
              const farmer = this.getCurrentFarmer

              const baseEquipments = [
                'english',
                'spanish',
                'german',
                'italian',
                'portuguese',
                'russian',
                'dutch',
                'french'
              ]
              const equipments = {}
              baseEquipments.forEach((equipment) => {
                equipments[equipment] = this.data.equipments.includes(equipment)
              })

              const baseOrganisations = [
                'fairefrance',
                'adb',
                'bbc'
              ]
              const organisations = {}
              baseOrganisations.forEach((organisation) => {
                organisations[organisation] = this.data.organisations.includes(organisation)
              })

              if (this.$wait.is('updating farmer infos')) return

              this.$wait.start('updating farmer infos')

              this.$axios.put(`/farmers/${farmer.id}`, {
                farmer: {
                  description: this.data.description,
                  farmer_equipment: equipments,
                  farmer_organisation: organisations
                }
              })
                .finally(() => {
                  this.$wait.end('updating farmer infos')
                  this.$router.push({
                    name: 'FarmerProfile',
                    slug: `hote-${this.getFarmer.user.first_name}`,
                    id: this.getFarmer.id
                  })
                })
            }
          })
      }
    }
  }
</script>

<style lang="scss" scoped>
@import "@/assets/scss/_variables.scss";

.default-profile {
  width: 80px;
  height: 80px;
  border-radius: 100%;
}

.offer-card{
  display: flex;
  flex-direction: column;
  text-decoration: none;

  &-image{
    display: contents;
    /* display: flex; */
    height: 138px;
    width: 138px;

    position: absolute;
    top: 135px;
    left: 170px;

    .cloudinary{
      display: flex;
      width: 138px;
      height: 138px;
      object-fit: cover;
      border-radius: 100%;
      border: 5px solid $agri-green;
      overflow: hidden;
    }

    &__empty{
      display: flex;
      flex-direction: column;
      color: rgba(black, 0.5);
      margin: auto;
    }
  }
}

.edit-title {
  font-size: 21px;
  font-family: 'Avenir', -apple-system, BlinkMacSystemFont, 'Segoe UI', Oxygen, Ubuntu, Cantarell, 'Open Sans', 'Helvetica Neue', sans-serif;
  color: $agri-green;
  font-weight: bold;
}

.edit-infos {
  padding: 25px;
}

.headline {
  font-size: 21px;
  font-family: 'Avenir', -apple-system, BlinkMacSystemFont, 'Segoe UI', Oxygen, Ubuntu, Cantarell, 'Open Sans', 'Helvetica Neue', sans-serif;
  color: $agri-green;
  padding-top: 0px !important;
}

.body-1 {
  font-size: 12px;
  font-family: 'Avenir', -apple-system, BlinkMacSystemFont, 'Segoe UI', Oxygen, Ubuntu, Cantarell, 'Open Sans', 'Helvetica Neue', sans-serif;
  color: $agri-green;
}

.farmer{
  padding-top: 0px;

  .side{
    width: 740px;
    height: auto;
    margin: auto;
    /* height: 750px; */
    box-shadow: 1px 1px 12px #555;
    border-radius: 25px;
   /*  margin-top: 15vh; */
    @media screen and (max-width: $breakpoint-tablet) {
      width: auto;
    }
  }

  .buttons{
    display: flex;
    justify-content: flex-end;
    margin-top: 30px;
  }
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
    margin-top: 30px;

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

@media screen and (max-width: 600px) {
  .farmer{

    .side{
      width: 100%;
    }
  }
}
</style>
