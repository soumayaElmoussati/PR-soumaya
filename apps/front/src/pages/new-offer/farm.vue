<template>
  <div class="farm">
    <div class="wrap">
      <div class="side">
        <h1 class="title-side">
          {{ $t("offer.titles.operation") }}
        </h1>
        <p class="body-1">
          <em>{{ $t("offer.paragraphs.describeOperation") }}</em>
        </p>

        <form @submit.prevent="submitted">
          <h2 class="headline">
            {{ $t("offer.titles.operationType") }}
          </h2>
          <p class="body-1">
            <em>{{ $t("offer.paragraphs.selectOperation") }}</em>
          </p>
          <farm-type-select
            v-validate="'required'"
            v-model="data.farmTypes"
            :error="errors.first('farm-types')"
            data-vv-as="type d'exploitation"
            name="farm-types"
          />

          <p class="body-1">
            <em>{{ $t("offer.paragraphs.agriType") }}</em>
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
            {{ $t("offer.titles.operation") }}
          </h2>
          <p class="body-1">
            <em>{{ $t("offer.paragraphs.animalPresent") }}</em>
          </p>
          <animal-select
            v-model="data.animals"
            :error="errors.first('animals')"
            data-vv-as="animaux"
            name="animals"
          />
          <br>
          <h2 class="headline">
            {{ $t("offer.titles.description") }}
          </h2>
          <p class="body-1">
            <em>{{ $t("offer.paragraphs.operationSpecial")[0] }}<br>
              {{ $t("offer.paragraphs.operationSpecial")[1] }}</em>
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
            {{ $t("offer.titles.activitiesTravel") }}
          </h2>
          <p class="subtitle">
            {{ $t("offer.paragraphs.slotStay") }}
          </p>
          <p class="subtitle">
            <strong>{{ $t("offer.paragraphs.momentShare")[0] }}</strong>
            {{ $t("offer.paragraphs.momentShare")[1] }}
          </p>
          <p
            class="subtitle"
            style="text-decoration: underline;">
            {{ $t("offer.paragraphs.happen") }}
          </p>
          <ul class="body-1">
            <li>
              {{ $t("offer.lists.mailReceved") }}
            </li>
            <li>
              {{ $t("offer.lists.safetyRule") }}
            </li>
          </ul>
          <p class="body-1">
            <strong>{{ $t("offer.paragraphs.warning") }}</strong> {{ $t("offer.paragraphs.warningChange") }}
          </p>

          <div class="activities">
            <p class="headline">
              {{ $t("offer.paragraphs.activitiesProposed") }}
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
            {{ $t("offer.titles.adjective") }}
          </h2>

          <p class="subtitle">
            <em>{{ $t("offer.paragraphs.adjectiveSignificant") }}</em>
          </p>

          <p class="subtitle">
            <em>{{ $t("offer.paragraphs.adjectiveIdea") }}</em>
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
                {{ $t("offer.buttons.previous") }}
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
                {{ $t("offer.buttons.continue") }}
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
  import FarmTypeSelect from '@/components/NewOffer/FarmTypeSelect'
  import AgricultureTypeSelect from '@/components/NewOffer/AgricultureTypeSelect'
  import AnimalSelect from '@/components/NewOffer/AnimalSelect'
  import TagSelect from '@/components/NewOffer/TagSelect'

  export default {
    name: 'Farm',
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
      const {
        description
      } = this.getCurrentOffer

      this.data = {
        description: description.farm,
        farmTypesIndex: this.getCurrentOffer.farm_type,
        farmTypes: [],
        animalsIndex: this.getCurrentOffer.animal,
        animals: [],
        tagsIndex: this.getCurrentOffer.tag,
        tags: [],
        agricultureTypesIndex: this.getCurrentOffer.agriculture_type,
        agricultureTypes: [],
        activities: [],
        farmDescription: description.activities
      }
      this.data.activitiesIndex = {
        discovery: this.getCurrentOffer.description.discovery,
        meeting_animals: this.getCurrentOffer.description.meeting_animals,
        milking_animals: this.getCurrentOffer.description.milking_animals,
        tasting: this.getCurrentOffer.description.tasting,
        birth_animal: this.getCurrentOffer.description.birth_animal,
        stroll: this.getCurrentOffer.description.stroll,
        harvest: this.getCurrentOffer.description.harvest,
        craft: this.getCurrentOffer.description.craft
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
      for (prop in this.data.animalsIndex) {
        if (this.data.animalsIndex[prop] && prop !== 'id') {
          self.data.animals.push(prop)
          self.$children[2].selection.push(prop)
        }
      }
      for (prop in this.data.tagsIndex) {
        if (this.data.tagsIndex[prop] && prop !== 'id') {
          self.data.tags.push(prop)
          self.$children[3].selection.push(prop)
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
          name: 'Rules'
        })
      },
      submitted () {
        this.$validator.validateAll()
          .then((valid) => {
            if (valid) {
              if (this.$wait.is('updating farm')) return

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

              this.$wait.start('updating farm')
              this.$axios.put(`/offers/${this.getCurrentOffer.id}`, {
                offer: {
                  offer_farm_type: types,
                  offer_agriculture_type: agritypes,
                  offer_animal: animals,
                  offer_tag: tags,
                  offer_description: {
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
                    name: 'Service'

                  })
                })
                .catch((err) => {
                  console.error('err', err)
                })
                .finally(() => {
                  this.$wait.end('updating farm')
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
    color: $agri-green;
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
      display: grid;
      grid-template-columns: 150px 150px;
      grid-column-gap: 15em;
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
