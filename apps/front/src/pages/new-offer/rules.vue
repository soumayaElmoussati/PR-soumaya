<template>
  <div class="housing">
    <div class="edit-wrap">
      <div class="side">
        <h1 class="title-side">
          {{ $t("offer.titles.rules") }}
        </h1>

        <form
          @submit.prevent="submitted"
        >

          <fieldset class="rules">
            <legend class="headline">
              {{ $t("offer.infos.visitor") }}
            </legend>
            <p class="body-1">
              <em>{{ $t("offer.paragraphs.visitorAccepted") }}</em>
            </p>
            <div class="rules__fields">
              <div
                v-for="(rule, k) in rules"
                :key="k"
                class="rules__fields__item"
              >
                <input
                  :id="rule"
                  v-model="data.settlements"
                  :value="rule"
                  name="settlements"
                  type="checkbox"
                >
                <label
                  :for="rule"
                  class="body-1"
                >
                  {{ $t('offer.settlements.' + rule) }}
                </label>
              </div>
            </div>
          </fieldset>

          <br>

          <hr style="border: 1px solid #476458">

          <h2 class="headline">
            {{ $t("offer.titles.conditions") }}
          </h2>
          <p class="body-1">
            <em>{{ $t("offer.paragraphs.politicCanceled") }}</em>
          </p>
          <ul class="body-1 rules-list">
            <li>
              {{ $t("offer.lists.canceled") }}
            </li>
            <li>
              {{ $t("offer.lists.halfCanceled") }}
            </li>
            <li>
              {{ $t("offer.lists.fullCanceled") }}
            </li>
          </ul>

          <hr style="border: 1px solid #476458">

          <fieldset class="rooms">
            <legend class="headline">
              {{ $t("offer.infos.home") }}
            </legend>

            <p class="body-1">
              <em>{{ $t("offer.paragraphs.time") }}</em>
            </p>

            <div class="time-label__fields">

              <p class="body-1">

                <i
                  id="icon-plane-ar"
                  class="icon-plane-ar"
                  aria-hidden="true"
                />
                <br>
                <em>{{ $t("offer.paragraphs.arriveTime") }}</em>
              </p>

              <p class="body-1">

                <i
                  id="icon-plane-dep"
                  class="icon-plane-dep"
                  aria-hidden="true"
                />
                <br>
                <em>{{ $t("offer.paragraphs.startTime") }}</em>
              </p>

              <div class="arrival-fields">

                <wi-input
                  v-validate="'required|numeric|max_value:23'"
                  id="arrivingTime"
                  v-model="data.arrivingTime"
                  :error="errors.first('arrivingTime')"
                  data-vv-as="heure d'arrivée"
                  type="number"
                  name="arrivingTime"
                  label=""
                  required
                />

                <h5 class="time-separator">H</h5>

                <wi-input
                  v-validate="'required|numeric|max_value:59'"
                  id="arrivingMinTime"
                  v-model="data.arrivingMinTime"
                  :error="errors.first('arrivingMinTime')"
                  data-vv-as="heure d'arrivée"
                  type="number"
                  name="arrivingMinTime"
                  label=""
                  required
                />

              </div>

              <div class="departure-fields">

                <wi-input
                  v-validate="'required|numeric|max_value:23'"
                  id="departureTime"
                  v-model="data.departureTime"
                  :error="errors.first('departureTime')"
                  data-vv-as="heure de départ"
                  type="number"
                  name="departureTime"
                  label=""
                  required
                />

                <h5 class="time-separator">H</h5>

                <wi-input
                  v-validate="'required|numeric|max_value:59'"
                  id="departureMinTime"
                  v-model="data.departureMinTime"
                  :error="errors.first('departureMinTime')"
                  data-vv-as="heure de départ"
                  type="number"
                  name="departureMinTime"
                  label=""
                  class="min-separator"
                  required
                />

              </div>

            </div>

            <legend class="headline">
              {{ $t("offer.fields.annexe") }}
            </legend>

            <p class="body-1">
              <em>{{ $t("offer.paragraphs.annexe") }}</em>
            </p>

            <wi-textarea
              id="message"
              v-model="data.annexeInformation"
              :error="errors.first('message')"
              name="message"
              rows="7"
            />

          </fieldset>

          <br>

          <div class="buttons">
            <button
              class="btn btn-agri-previous"
              @click.stop.prevent="previous"
            >
              <span
                v-if="!$wait.is('creating offer')"
              >
                {{ $t("offer.buttons.previous") }}
              </span>
              <wi-spinner
                v-else
              />
            </button>
            <button
              :disabled="$wait.is('updating housing')"
              type="submit"
              class="btn btn-agri-yellow"
            >
              <span
                v-if="!$wait.is('updating housing')"
              >
                {{ $t("offer.buttons.continue") }}
              </span>
              <wi-spinner
                v-else
              />
            </button>
          </div>

        </form>
        <CustomDialog
          v-model="showDialog"
          @close="closeDialog"
          @discard-changes="discardChanges"
          @save-changes="saveChanges"
        />
      </div>
    </div>
  </div>
</template>

<script>
  import { mapGetters } from 'vuex'
  import CustomDialog from '@/components/CustomDialog'

  export default {
    name: 'Rules',
    middleware: 'auth',
    components: {
     CustomDialog
    },
    data () {
      return {
        to: null,
        rules: [
          'baby_suitable',
          'child_suitable',
          'smooking_allowed',
          'parties_allowed',
          'animals_welcome',
          'accessible'
        ],
        data2: {},
        data: {
          departureTime: null,
          departureMinTime: null,
          arrivingTime: null,
          arrivingMinTime: null,
          settlements: []
        }
      }
    },
    fetch ({ app, route, store }) {
      return app.$axios.get(`/offers/${store.state.currentOffer.id}`)
        .then(res => {
          if (res.status === 200) {
            store.commit('SET_CURRENT_OFFER', res.data)
          }
        })
    },
    computed: {
      ...mapGetters([
        'getCurrentOffer'
      ])
    },
    mounted () {
      this.data2 = this.getCurrentOffer

      this.data.departureTime = this.getCurrentOffer.departure_time
      this.data.departureMinTime = this.getCurrentOffer.departure_min_time
      this.data.arrivingTime = this.getCurrentOffer.arriving_time
      this.data.arrivingMinTime = this.getCurrentOffer.arriving_min_time
      this.data.annexeInformation = this.getCurrentOffer.annexe_information

      var self = this

      for (var prop in this.getCurrentOffer.settlement) {
        if (this.getCurrentOffer.settlement[prop] === true) {
          self.data.settlements.push(prop)
        }
      }
    },
    methods: {
      previous () {
        this.$router.push({
          name: 'Housing'
        })
      },
      submitted () {
        this.$validator.validateAll()
          .then((valid) => {
            if (valid) {
              const offer = this.getCurrentOffer

              const baseSettlements = [
                'baby_suitable',
                'child_suitable',
                'smooking_allowed',
                'parties_allowed',
                'animals_welcome',
                'accessible'
              ]
              const settlements = {}
              baseSettlements.forEach((settlement) => {
                settlements[settlement] = this.data.settlements.includes(settlement)
              })

              this.$wait.start('updating housing')
              this.$axios.put(`/offers/${offer.id}`, {
                offer: {
                  departure_time: this.data.departureTime,
                  departure_min_time: this.data.departureMinTime,
                  arriving_time: this.data.arrivingTime,
                  arriving_min_time: this.data.arrivingMinTime,
                  annexe_information: this.data.annexeInformation,
                  offer_settlement: settlements
                }
              })
                .catch((err) => {
                  console.error('err', err)
                })
                .finally(() => {
                  this.$wait.end('updating housing')
                  this.$router.push({
                    name: 'Farm'
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
@import "@/assets/scss/_mixins.scss";

.rules-list {
  color: #476458;
  font-size: 16px;
  font-weight: bold;
  font-family: 'Avenir', -apple-system, BlinkMacSystemFont, 'Segoe UI', Oxygen, Ubuntu, Cantarell, 'Open Sans', 'Helvetica Neue', sans-serif;
}

.title-side {
  color: black;
  font-size: 26px;
  font-weight: bold;
  text-transform: uppercase;
  font-family: 'Avenir', -apple-system, BlinkMacSystemFont, 'Segoe UI', Oxygen, Ubuntu, Cantarell, 'Open Sans', 'Helvetica Neue', sans-serif;
}

.subtitle {
  font-size: 20px;
  color: black;
  font-family: 'Avenir', -apple-system, BlinkMacSystemFont, 'Segoe UI', Oxygen, Ubuntu, Cantarell, 'Open Sans', 'Helvetica Neue', sans-serif;
  font-weight: bold;
  text-transform: uppercase;
}

.side {
  background-color:white;
  margin:0 auto;
  padding:30px;
  width:90%
}

.body-1 em {
  font-size: 12px;
  font-family: 'Avenir', -apple-system, BlinkMacSystemFont, 'Segoe UI', Oxygen, Ubuntu, Cantarell, 'Open Sans', 'Helvetica Neue', sans-serif;
  color: #476458;
}

.spacer-parts {
  margin-top: 45px;
}

.housing-types__item label{
  font-size:13px;
}

span.wi-textarea__label__wordcount {
  font-size:12px;
}

.headline{
  padding-top:20px;
  text-transform: uppercase;
  font-size: 18px;
  font-family: 'Avenir', -apple-system, BlinkMacSystemFont, 'Segoe UI', Oxygen, Ubuntu, Cantarell, 'Open Sans', 'Helvetica Neue', sans-serif;
}

.wi-input__caption{
  font-size:14px!important;
}

.done{
  padding-top:40px
}

.housing{
  padding-top: 0px;

  .side{
    width: 60%;
  }

  fieldset{
    border: none;
    margin: 0;
    padding: 0;
  }

  .buttons{
    display: flex;
    justify-content: space-between;

    .btn:first-child{
      margin-right: 16px;
    }
  }
}

.time-label{
  &__fields{
    display: grid;
    grid-template-columns: repeat(2, calc(25%));
    grid-gap: 5px;
    text-align: center;

    @media only screen and (max-width: 768px) {
      grid-template-columns: repeat(2, calc(50%));
    }
  }
}

.time-field{
  &__fields{
    display: grid;
    grid-template-columns: repeat(2, calc(25%));
    grid-gap: 5px;
    margin-left: 5vh;

    @media only screen and (max-width: 768px) {
      grid-template-columns: repeat(2, calc(50%));
      margin-left: 1vh;
    }

    @media only screen and (max-width: 1024px) {
      margin-left: 1vh;
    }
  }
}

.time-separator {
  margin: auto;
}

.arrival-fields {
  display: grid;
  grid-template-columns: 65px 10px 65px;
  align-self: center;
  justify-self: center;
  color: #476458;
}

.departure-fields {
  display: grid;
  grid-template-columns: 65px 10px 65px;
  align-self: center;
  justify-self: center;
  color: #476458;

  @media (min-width: 768px) and (max-width: 1024px) {
    margin-left: 5vh;
  }
}

@media screen and (max-width: 600px) {
  .side {
    width: 100%;
    margin:0;
    padding:0px;
  }

  .housing{

    .side{
      width: 100%;
    }
  }
}
</style>
