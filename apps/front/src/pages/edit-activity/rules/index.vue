<template>
  <div class="housing">
    <div class="edit-wrap">
      <div class="side">
        <h1 class="title-side">
          {{ $t("activity.titles.rules") }}
        </h1>

        <form
          @submit.prevent="submitted"
        >

          <fieldset class="rules">
            <legend class="headline">
              {{ $t("activity.legend.visitor") }}
            </legend>
            <p class="body-1">
              <em>{{ $t("activity.paragraphs.ruleTravel") }}</em>
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
                  {{ $t('activity.settlements.' + rule) }}
                </label>
              </div>
            </div>
          </fieldset>

          <h2 class="headline">
            {{ $t("activity.titles.condition") }}
          </h2>
          <p class="body-1">
            <em>{{ $t("activity.paragraphs.politic") }}</em>
          </p>
          <ul class="body-1 rules-list">
            <li>
              {{ $t("activity.lists.cancel") }}
            </li>
            <li>
              {{ $t("activity.lists.halfCancel") }}
            </li>
            <li>
              {{ $t("activity.lists.fullCancel") }}
            </li>
          </ul>

          <fieldset class="rooms">
            <legend class="headline">
              {{ $t("activity.legend.home") }}
            </legend>

            <p class="body-1">
              <em>{{ $t("activity.paragraphs.time") }}</em>
            </p>

            <div class="time-label__fields">

              <p class="body-1">

                <i
                  id="icon-plane-ar"
                  class="icon-plane-ar"
                  aria-hidden="true"
                />
                <br>
                <em>{{ $t("activity.paragraphs.finishTime") }}</em>
              </p>

              <p class="body-1">

                <i
                  id="icon-plane-dep"
                  class="icon-plane-dep"
                  aria-hidden="true"
                />
                <br>
                <em>{{ $t("activity.paragraphs.startTime") }}</em>
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

          </fieldset>

          <br>

          <div class="buttons">
            <button
              type="submit"
              class="btn btn-agri-yellow"
              @click.stop.prevent="next"
            >
              <span
                v-if="!$wait.is('creating activity')"
              >
                {{ $t("activity.buttons.next") }}
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
                {{ $t("activity.buttons.save") }}
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
    name: 'EditActivityRules',
    middleware: 'auth',
    components: {
     CustomDialog
    },
    data () {
      return {
        to: null,
        showDialog: false,
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
      return app.$axios.get(`/activities/${route.params.id}`)
        .then(res => {
          if (res.status === 200) {
            store.commit('SET_CURRENT_ACTIVITY', res.data)
          }
        })
    },
    beforeRouteLeave (to, from, next) {
      if (this.to) {
        next()
      } else {
        this.to = to
        this.showDialog = true
      }
    },
    computed: {
      ...mapGetters([
        'getCurrentActivity'
      ])
    },
    mounted () {
      this.data2 = this.getCurrentActivity

      this.data.departureTime = this.getCurrentActivity.departure_time
      this.data.departureMinTime = this.getCurrentActivity.departure_min_time
      this.data.arrivingTime = this.getCurrentActivity.arriving_time
      this.data.arrivingMinTime = this.getCurrentActivity.arriving_min_time

      var self = this

      for (var prop in this.getCurrentActivity.settlement) {
        if (this.getCurrentActivity.settlement[prop] === true) {
          self.data.settlements.push(prop)
        }
      }
    },
    methods: {
      closeDialog () {
        this.showDialog = false
        this.to = null
      },
      saveChanges () {
        this.$validator.validateAll()
          .then((valid) => {
            if (valid) {
              const activity = this.getCurrentActivity

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

              this.$wait.start('updating activity')
              this.$axios.put(`/activities/${activity.id}`, {
                activity: {
                  departure_time: this.data.departureTime,
                  departure_min_time: this.data.departureMinTime,
                  arriving_time: this.data.arrivingTime,
                  arriving_min_time: this.data.arrivingMinTime,
                  activity_settlement: settlements
                }
              })
                .catch((err) => {
                  console.error('err', err)
                })
                .finally(() => {
                  this.$wait.end('updating activity')
                  this.showDialog = false
                  this.$router.push(this.to)
                })
            }
          })
      },
      discardChanges () {
        this.showDialog = false
        this.$router.push(this.to)
      },
      next () {
        this.$validator.validateAll()
          .then((valid) => {
            if (valid) {
              const activity = this.getCurrentActivity

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
              this.$axios.put(`/activities/${activity.id}`, {
                activity: {
                  departure_time: this.data.departureTime,
                  departure_min_time: this.data.departureMinTime,
                  arriving_time: this.data.arrivingTime,
                  arriving_min_time: this.data.arrivingMinTime,
                  activity_settlement: settlements
                }
              })
                .catch((err) => {
                  console.error('err', err)
                })
                .finally(() => {
                  this.$wait.end('updating housing')
                  this.$router.push({
                    name: 'EditActivityFarm'
                  })
                  this.showDialog = false
                  this.$router.push(this.to)
                })
            }
          })
      },
      submitted () {
        this.$validator.validateAll()
          .then((valid) => {
            if (valid) {
              const activity = this.getCurrentActivity

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

              this.$wait.start('updating activity')
              this.$axios.put(`/activities/${activity.id}`, {
                activity: {
                  departure_time: this.data.departureTime,
                  departure_min_time: this.data.departureMinTime,
                  arriving_time: this.data.arrivingTime,
                  arriving_min_time: this.data.arrivingMinTime,
                  activity_settlement: settlements
                }
              })
                .catch((err) => {
                  console.error('err', err)
                })
                .finally(() => {
                  this.$wait.end('updating activity')
                  this.$router.push({
                    name: 'DashboardActivities'
                  })
                  this.showDialog = false
                  this.$router.push(this.to)
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
    width: 90%;
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
