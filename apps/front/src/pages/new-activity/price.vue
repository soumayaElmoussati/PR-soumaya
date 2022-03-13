<template>
  <div class="price">
    <div class="wrap">
      <div class="side">
        <h1 class="title-side">
          {{ $t("activity.titles.rate") }}
        </h1>

        <form
          @submit.prevent="submitted"
        >

          <div class="price-box">

            <p class="price-label">{{ $t("activity.paragraphs.basePrice") }}</p>

            <div class="price-field">

              <wi-input
                v-validate="'required|decimal:2'"
                id="pricePerPerson"
                v-model="formData.pricePerPerson"
                :error="errors.first('pricePerPerson')"
                data-vv-as="prix de base"
                type="tel"
                name="pricePerPerson"
                placeholder="80"
                required
              />

              <p class="price-night">€</p>

            </div>

          </div>

          <div class="price-box">

            <p class="price-label">{{ $t("activity.paragraphs.person") }}</p>

            <div class="price-field">

              <wi-input
                v-validate="'required|numeric|min_value:1'"
                id="peopleCount"
                v-model="formData.peopleCount"
                :error="errors.first('peopleCount')"
                data-vv-as="nombre de personnes"
                type="tel"
                name="peopleCount"
                required
              />

              <p class="price-night">{{ $t("activity.paragraphs.people") }}</p>

            </div>

          </div>

          <div class="price-box">

            <p class="price-label">{{ $t("activity.paragraphs.travel") }}</p>

            <div class="price-field">

              <wi-input
                v-validate="'required|decimal:2'"
                id="additionalTravelerPrice"
                v-model="formData.additionalTravelerPrice"
                :error="errors.first('additionalTravelerPrice')"
                data-vv-as="prix voyageur supplémentaire"
                name="additionalTravelerPrice"
                required
              />

              <p class="price-night">€</p>

            </div>

          </div>

          <div class="price-box">

            <p class="price-label">{{ $t("activity.paragraphs.moreTravel") }}</p>

            <div class="price-field">

              <wi-input
                v-validate="'required|numeric'"
                id="additionalMaxPeople"
                v-model="formData.additionalMaxPeople"
                :error="errors.first('additionalMaxPeople')"
                data-vv-as="visiteurs supplémentaires"
                type="tel"
                name="additionalMaxPeople"
                required
              />

              <p class="price-night">{{ $t("activity.paragraphs.people") }}</p>

            </div>

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
            >
              {{ $t("activity.buttons.continue") }}
            </button>
          </div>
        </form>
      </div>
      <CustomDialog
        v-model="showDialog"
        @close="closeDialog"
        @discard-changes="discardChanges"
        @save-changes="saveChanges"
      />
    </div>
</div></template>

<script>
  import { mapGetters } from 'vuex'

  import WiInput from '@/components/WiUI/Input'
  import CustomDialog from '@/components/CustomDialog'

  export default {
    name: 'Price',
    middleware: 'auth',
    components: {
      WiInput, CustomDialog
    },
    data () {
      return {
        showDialog: false,
        testValue: null,
        formData: {
          peopleCount: 2,
          pricePerPerson: null,
          minDays: 1,
          additionalMaxPeople: 0,
          additionalTravelerPrice: 0
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
      ])
    },
    mounted () {
      this.formData = {
        ...this.formData,
        peopleCount: this.getCurrentActivity.people_count,
        pricePerPerson: Math.round(this.getCurrentActivity.price_per_person / 100),
        minDays: this.getCurrentActivity.min_days,
        additionalMaxPeople: this.getCurrentActivity.additional_max_people,
        additionalTravelerPrice: Math.round(this.getCurrentActivity.additional_traveler_price / 100)
      }
    },
    methods: {
      closeDialog () {
        this.showDialog = false
        this.to = null
      },
      previous () {
        this.$router.push({
          name: 'ActivityFarm'
        })
      },
      submitted () {
        this.$validator.validateAll()
          .then((valid) => {
            if (valid) {
              if (this.$wait.is('saving price infos')) return

              this.$wait.start('saving price infos')
              const data = {
                people_count: this.formData.peopleCount,
                price_per_person: Math.round(this.formData.pricePerPerson * 100),
                additional_traveler_price: Math.round(this.formData.additionalTravelerPrice * 100),
                additional_max_people: this.formData.additionalMaxPeople,
                min_days: this.formData.minDays
              }

              this.$axios.put(`/activities/${this.getCurrentActivity.id}`, {
                activity: data
              })
                .then((res) => {
                  this.$router.push({
                    name: 'ActivityPictures'
                  })
                })
                .finally(() => this.$wait.end('saving price infos'))
            }
          })
      }
    }
  }
</script>

<style lang="scss" scoped>
@import "@/assets/scss/_variables.scss";

.title-side {
  color: black;
  font-size: 26px;
  font-weight: bold;
  text-transform: uppercase;
  font-family: 'Avenir', -apple-system, BlinkMacSystemFont, 'Segoe UI', Oxygen, Ubuntu, Cantarell, 'Open Sans', 'Helvetica Neue', sans-serif;
}

.subtitle {
  margin-top: 20px;
  margin-bottom: 20px;
  font-size: 12px;
  font-family: 'Avenir', -apple-system, BlinkMacSystemFont, 'Segoe UI', Oxygen, Ubuntu, Cantarell, 'Open Sans', 'Helvetica Neue', sans-serif;
}

.price-box {
  margin-bottom: 55px;
}

.price-field {
  display: grid;
  grid-template-columns: 75px auto;
  grid-column-gap: 5px;
}

.price-field-weekend {
  display: grid;
  grid-template-columns: 75px 90px 300px 120px;
  grid-column-gap: 25px;
}

.price-field-discount {
  display: grid;
  grid-template-columns: 75px 260px 75px;
  grid-column-gap: 25px;
}

.price-label {
  font-size: 20px;
  font-family: 'Avenir', -apple-system, BlinkMacSystemFont, 'Segoe UI', Oxygen, Ubuntu, Cantarell, 'Open Sans', 'Helvetica Neue', sans-serif;
  text-transform: uppercase;
  color: black;
}

.price-night {
  font-size: 20px;
  font-family: 'Avenir', -apple-system, BlinkMacSystemFont, 'Segoe UI', Oxygen, Ubuntu, Cantarell, 'Open Sans', 'Helvetica Neue', sans-serif;
}

.price-align {
  align-self: center;
  justify-self: center;
}

  .price-period {
    position: fixed;
    display: flex;
    left: 0;
    top: 0;
    width: 100vw;
    height: 100vh;
    background-color: rgba(black, 0.5);

    &__content {
      max-width: 400px;
      margin: auto;
      background-color: white;
      padding: 16px;
      border-radius: 4px;

      &__header {
        display: flex;
        justify-content: space-between;
      }
    }
  }

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

  .price{
    padding-top: 32px;

    .side{
      width: 60%;
    }

    .wi-input{
      margin-bottom: 16px;
    }

    .buttons{
      display: flex;
      justify-content: space-between;

      .btn:first-child{
        margin-right: 16px;
      }
    }
  }

  @media screen and (max-width: 768px) {

    .price{
      padding-top: 0px;

      .side{
        width: 100%;
      }
    }
  }
</style>
