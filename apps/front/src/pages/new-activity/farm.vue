<template>
  <div class="farm">
    <div class="wrap">
      <div class="side">
        <h1 class="title-side">
          {{ $t("activity.titles.yourOperation") }}
        </h1>
        <p class="body-1">
          <em>{{ $t("activity.paragraphs.describeOperation") }}</em>
        </p>

        <form @submit.prevent="submitted">
          <h2 class="headline">
            {{ $t("activity.titles.typeOperation") }}
          </h2>
          <p class="body-1">
            <em>{{ $t("activity.paragraphs.operationType") }}</em>
          </p>
          <farm-type-select
            v-validate="'required'"
            v-model="data.farmTypes"
            :error="errors.first('farm-types')"
            data-vv-as="type d'exploitation"
            name="farm-types"
          />

          <p class="body-1">
            <em>{{ $t("activity.paragraphs.typeAgri") }}</em>
          </p>
          <agriculture-type-select
            v-validate="'required'"
            v-model="data.agricultureTypes"
            :error="errors.first('agriculture-types')"
            data-vv-as="type d'agriculture"
            name="agriculture-types"
          />

          <hr style="border: 1px solid #476458">

          <h2 class="headline">
            {{ $t("activity.titles.yourOperation") }}
          </h2>
          <p class="body-1">
            <em>{{ $t("activity.paragraphs.animalsSelect") }}</em>
          </p>
          <animal-select
            v-model="data.animals"
            :error="errors.first('animals')"
            data-vv-as="animaux"
            name="animals"
          />
          <br>
          <h2 class="headline">
            {{ $t("activity.titles.descriptionOperation") }}
          </h2>
          <p class="body-1">
            <em>{{ $t("activity.paragraphs.describeLine")[0] }}<br>
              {{ $t("activity.paragraphs.describeLine")[0] }}</em>
          </p>

          <wi-textarea
            v-validate="'required|max:1500'"
            id="description"
            v-model="data.description"
            :error="errors.first('description')"
            data-vv-as="description"
            name="description"
            rows="5"
            word-count
            required
          />

          <br>

          <hr style="border: 1px solid #476458">

          <h2 class="headline">
            {{ $t("activity.titles.agritourism") }}
          </h2>
          <p class="subtitle">
            {{ $t("activity.paragraphs.agritourism") }}
          </p>
          <p class="subtitle">
            <strong>{{ $t("activity.paragraphs.activitiesShare") }}</strong> {{ $t("activity.paragraphs.connection") }}
          </p>

          <div class="activities">
            <p class="headline">
              {{ $t("activity.paragraphs.visitorActivity") }}
            </p>
            <div class="activities__fields">
              <div
                v-for="(activitie, k) in activities"
                :key="k"
                class="activitie__fields__item"
              >
                <input
                  :id="activitie"
                  v-model="data.activities"
                  :value="activitie"
                  name="activities"
                  type="checkbox"
                >
                <label
                  :for="activitie"
                  class="body-1"
                >
                  {{ $t('offer.activities.' + activitie) }}
                </label>
              </div>
            </div>
          </div>

          <wi-textarea
            v-validate="'required|max:1500'"
            id="farmDescription"
            v-model="data.farmDescription"
            :error="errors.first('farmDescription')"
            data-vv-as="description"
            name="farmDescription"
            label="Décrivez en quelques lignes les activités que vous proposez à vos visiteurs"
            required
            rows="5"
            word-count
          />

          <br>

          <hr style="border: 1px solid #476458">

          <h2 class="headline">
            {{ $t("activity.titles.adjective") }}
          </h2>

          <p class="subtitle">
            <em>{{ $t("activity.paragraphs.adjective") }}</em>
          </p>

          <p class="subtitle">
            <em>{{ $t("activity.paragraphs.target") }}</em>
          </p>

          <tag-select
            v-model="data.tags"
          />

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
              :disabled="$wait.is('updating farm')"
              type="submit"
              class="btn btn-agri-yellow"
            >
              <span
                v-if="!$wait.is('updating farm')"
              >
                {{ $t("activity.buttons.continue") }}
              </span>
              <wi-spinner
                v-else
              />
            </button>
          </div>
        </form>
      </div>
    </div>
  </div>
</template>

<script>
  import { mapGetters } from 'vuex'
  import WiTextarea from '@/components/WiUI/Textarea'
  import FarmTypeSelect from '@/components/NewActivity/FarmTypeSelect'
  import AgricultureTypeSelect from '@/components/NewActivity/AgricultureTypeSelect'
  import AnimalSelect from '@/components/NewActivity/AnimalSelect'
  import TagSelect from '@/components/NewActivity/TagSelect'

  export default {
    name: 'ActivityFarm',
    middleware: 'auth',
    components: {
      WiTextarea,
      FarmTypeSelect,
      AgricultureTypeSelect,
      AnimalSelect,
      TagSelect
    },
    data () {
      return {
        activities: [
          'discovery',
          'meeting_animals',
          'milking_animals',
          'tasting',
          'birth_animal',
          'stroll',
          'harvest',
          'craft'
        ],
        data: {
          description: null,
          farmDescription: null,
          farmTypesIndex: {},
          farmTypes: [],
          animalsIndex: {},
          animals: [],
          agricultureTypesIndex: {},
          agricultureTypes: [],
          activitiesIndex: {},
          activities: [],
          tagsIndex: {},
          tags: []
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
      this.data = {
        description: this.getCurrentActivity.farm,
        farmTypesIndex: this.getCurrentActivity.farm_type,
        farmTypes: [],
        animalsIndex: this.getCurrentActivity.animal,
        animals: [],
        tagsIndex: this.getCurrentActivity.tag,
        tags: [],
        agricultureTypesIndex: this.getCurrentActivity.agriculture_type,
        agricultureTypes: [],
        activities: [],
        farmDescription: this.getCurrentActivity.activities
      }
      this.data.activitiesIndex = {
        discovery: this.getCurrentActivity.discovery,
        meeting_animals: this.getCurrentActivity.meeting_animals,
        milking_animals: this.getCurrentActivity.milking_animals,
        tasting: this.getCurrentActivity.tasting,
        birth_animal: this.getCurrentActivity.birth_animal,
        stroll: this.getCurrentActivity.stroll,
        harvest: this.getCurrentActivity.harvest,
        craft: this.getCurrentActivity.craft
      }

      var self = this
      for (var prop in this.data.farmTypesIndex) {
        if (this.data.farmTypesIndex[prop] && prop !== 'id') {
          self.data.farmTypes.push(prop)
          self.$children[0].selection.push(prop)
        }
      }
      for (prop in this.data.agricultureTypesIndex) {
        if (this.data.agricultureTypesIndex[prop] && prop !== 'id') {
          self.data.agricultureTypes.push(prop)
          self.$children[1].selection.push(prop)
        }
      }
      for (prop in this.data.tagsIndex) {
        if (this.data.tagsIndex[prop] && prop !== 'id') {
          self.data.tags.push(prop)
          self.$children[2].selection.push(prop)
        }
      }
      for (prop in this.data.activitiesIndex) {
        if (this.data.activitiesIndex[prop] === true) {
          self.data.activities.push(prop)
        }
      }
    },
    methods: {
      previous () {
        this.$router.push({
          name: 'ActivityRules'
        })
      },
      submitted () {
        this.$validator.validateAll()
          .then((valid) => {
            if (valid) {
              if (this.$wait.is('updating activity')) return

              const baseAnimals = [
                'cow', 'chicken', 'sheep', 'rabbit', 'goose', 'goat', 'duck', 'turkey', 'pig', 'milk_cow', 'donkey', 'snail', 'horse', 'bee', 'lama'
              ]
              const animals = {}
              baseAnimals.forEach((animal) => {
                animals[animal] = this.data.animals.includes(animal)
              })

              const baseTags = [
                'playful',
                'pedagogic',
                'unusual',
                'public',
                'gustatory',
                'animal',
                'dirty',
                'rewarding',
                'depth',
                'intensive',
                'quick',
                'physical'
              ]
              const tags = {}
              baseTags.forEach((tag) => {
                tags[tag] = this.data.tags.includes(tag)
              })

              const baseActivities = [
                'discovery',
                'meeting_animals',
                'milking_animals',
                'tasting',
                'birth_animal',
                'stroll',
                'harvest',
                'craft'
              ]
              const activities = {}
              baseActivities.forEach((activitie) => {
                activities[activitie] = this.data.activities.includes(activitie)
              })

              const baseTypes = [
                'breeder', 'cereal', 'horticulturist', 'market_gardener', 'cheese_production', 'winegrower', 'brewer', 'arborist', 'oyster_farmer', 'mushroom_grower', 'beekeeper', 'cider_maker', 'riding_stable', 'agroforestry'
              ]

              const baseAgriTypes = [
                'biological', 'permaculture', 'agroecology', 'agroecological', 'conventional', 'ringing', 'durable', 'reliability', 'hydroponics'
              ]

              const types = {}
              baseTypes.forEach((type) => {
                types[type] = this.data.farmTypes.includes(type)
              })

              const agritypes = {}
              baseAgriTypes.forEach((agritype) => {
                agritypes[agritype] = this.data.agricultureTypes.includes(agritype)
              })

              this.$wait.start('updating activity')
              this.$axios.put(`/activities/${this.getCurrentActivity.id}`, {
                activity: {
                  activity_farm_type: types,
                  activity_agriculture_type: agritypes,
                  activity_animal: animals,
                  activity_tag: tags,
                  activity_description: {
                    farm: this.data.description,
                    activities: this.data.farmDescription,
                    discovery: this.data.activities.includes('discovery'),
                    meeting_animals: this.data.activities.includes('meeting_animals'),
                    milking_animals: this.data.activities.includes('milking_animals'),
                    tasting: this.data.activities.includes('tasting'),
                    birth_animal: this.data.activities.includes('birth_animal'),
                    stroll: this.data.activities.includes('stroll'),
                    harvest: this.data.activities.includes('harvest'),
                    craft: this.data.activities.includes('craft')
                  }
                }
              })
                .then((res) => {
                  this.$router.push({
                    name: 'ActivityPrice'

                  })
                })
                .catch((err) => {
                  console.error('err', err)
                })
                .finally(() => {
                  this.$wait.end('updating activity')
                })
            }
          })
      },
      saveLater () {

      }
    }
  }
</script>

<style lang="scss" scoped>
@import "@/assets/scss/_variables.scss";

.wrap {
  width: 90% !important;
}

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

  .side {
    background-color:white;
    margin:0 auto;
    padding:30px;
    width:75%
  }

  .body-1 em {
    font-size: 12px;
    font-family: 'Avenir', -apple-system, BlinkMacSystemFont, 'Segoe UI', Oxygen, Ubuntu, Cantarell, 'Open Sans', 'Helvetica Neue', sans-serif;
    color: #476458;
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

  .farm{
    padding-top: 32px;

    .side{
      width: 90%;
    }

    .buttons{
      display: flex;
      justify-content: space-between;
      margin-top: 32px;

      .btn:first-child{
        margin-right: 16px;
      }
    }
  }
  .activitie__fields__item{
    label {
      user-select: none;
    }
  }
  .activities__fields{
    margin-bottom: 25px;
  }

  @media screen and (max-width: 768px) {

    .farm{
      padding-top: 0px;

      .side{
        width: 100%;
      }
    }
  }
</style>
