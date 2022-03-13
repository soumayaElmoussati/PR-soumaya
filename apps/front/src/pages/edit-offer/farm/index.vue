<template>
  <div class="edit-farm side">
    <h1 class="title-side">
      {{ $t("offer.titles.operation") }}
    </h1>

    <p class="subtitle">
      {{ $t("offer.paragraphs.operation") }}
    </p>

    <form
      @submit.prevent="submitted"
    >
      <h2 class="headline">
        {{ $t("offer.titles.operationType") }}
      </h2>
      <p class="subtitle">
        {{ $t("offer.paragraphs.selectOperation") }}
      </p>
      <farm-type-select
        v-validate="'required'"
        v-model="data.farmTypes"
        :error="errors.first('farm-types')"
        data-vv-as="type d'exploitation"
        name="farm-types"
      />

      <p class="subtitle">
        {{ $t("offer.paragraphs.selectAgri") }}
      </p>
      <agriculture-type-select
        v-validate="'required'"
        v-model="data.agricultureTypes"
        :error="errors.first('agriculture-types')"
        data-vv-as="type d'agriculture"
        name="agriculture-types"
      />

      <p class="subtitle">
        {{ $t("offer.paragraphs.selectAnimals") }}
      </p>
      <animal-select
        v-model="data.animals"
        :error="errors.first('animals')"
        data-vv-as="animaux"
        name="animals"
      />

      <h2 class="headline">
        {{ $t("offer.titles.description") }}
      </h2>

      <wi-textarea
        v-validate="'required|max:1500'"
        id="description"
        v-model="data.farmDescription"
        :error="errors.first('description')"
        :placeholder="$t('activity.paragraphs.describeLine')[1]"
        data-vv-as="description"
        name="description"
        rows="5"
        word-count
        required
      />

      <h2 class="headline">
        {{ $t("offer.titles.activitiesTravel") }}
      </h2>
      <p class="subtitle">
        {{ $t("offer.paragraphs.staySlot") }}
      </p>
      <p class="subtitle">
        <strong>{{ $t("offer.paragraphs.activitiesConnection") }}</strong>
      </p>
      <p
        class="subtitle"
        style="text-decoration: underline;">
        {{ $t("offer.paragraphs.happen") }}
      </p>
      <ul class="body-1">
        <li>
          {{ $t("offer.lists.beforeVisitor") }}
        </li>
        <br>
        <li>
          {{ $t("offer.lists.notifiedVisitor") }}
        </li>
      </ul>
      <p class="subtitle">
        <strong>{{ $t("offer.paragraphs.warning") }}</strong>  {{ $t("offer.paragraphs.warningChange") }}
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
              class="offer-label"
            >
              {{ $t('offer.activities.' + activitie) }}
            </label>
          </div>
        </div>
      </div>

      <wi-textarea
        v-validate="'required|max:1500'"
        id="farmDescription"
        v-model="data.description"
        :error="errors.first('farmDescription')"
        :placeholder="$t('activity.placeholder.describe')"
        data-vv-as="description"
        name="farmDescription"
        required
        rows="5"
        word-count
      />

      <h2 class="headline">
        {{ $t("offer.titles.adjective") }}
      </h2>

      <p class="subtitle">
        {{ $t("offer.paragraphs.adjectiveSignificant") }}
      </p>

      <p class="subtitle">
        {{ $t("offer.paragraphs.adjectiveIdea") }}
      </p>

      <tag-select
        v-model="data.tags"
      />

      <div class="buttons">
        <button
          type="submit"
          class="btn btn-agri-yellow"
          @click.stop.prevent="next"
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
          :disabled="$wait.is('updating farm')"
          type="submit"
          class="btn btn-agri-yellow"
        >
          <span
            v-if="!$wait.is('updating farm')"
          >
            {{ $t("offer.buttons.save") }}
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
</template>

<script>
  import { mapGetters } from 'vuex'

  import WiTextarea from '@/components/WiUI/Textarea'
  import FarmTypeSelect from '@/components/NewOffer/FarmTypeSelect'
  import AgricultureTypeSelect from '@/components/NewOffer/AgricultureTypeSelect'
  import AnimalSelect from '@/components/NewOffer/AnimalSelect'
  import TagSelect from '@/components/NewOffer/TagSelect'
  import CustomDialog from '@/components/CustomDialog'

  export default {
    name: 'EditFarm',
    middleware: 'auth',
    components: {
      WiTextarea,
      FarmTypeSelect,
      AgricultureTypeSelect,
      AnimalSelect,
      TagSelect,
      CustomDialog
    },
    data () {
      return {
        to: null,
        showDialog: false,
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
        data2: {},
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
      ])
    },
    mounted () {
      const {
        description
      } = this.getCurrentOffer

      this.data = {
        description: description.activities,
        farmTypesIndex: this.getCurrentOffer.farm_type,
        agricultureTypesIndex: this.getCurrentOffer.agriculture_type,
        animalsIndex: this.getCurrentOffer.animal,
        animals: [],
        tags: [],
        tagsIndex: {},
        farmTypes: [],
        agricultureTypes: [],
        activities: [],
        farmDescription: description.farm
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

      this.data.tagsIndex = this.getCurrentOffer.tag

      if (typeof (this.getCurrentOffer.tag) === 'undefined') {
        this.getCurrentOffer.tag = {}
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
        if (this.data.tagsIndex[prop] === true) {
          self.data.tags.push(prop)
          self.$children[5].selection.push(prop)
        }
      }

      for (prop in this.data.activitiesIndex) {
        if (this.data.activitiesIndex[prop] === true) {
          self.data.activities.push(prop)
        }
      }
    },
    methods: {
      closeDialog () {
        this.showDialog = false
        this.to = null
      },
      saveChanges () {
        if (this.$wait.is('updating farm')) return

        this.$validator.validateAll()
          .then(valid => {
            if (!valid) return

            const baseAnimals = [
              'cow', 'chicken', 'sheep', 'rabbit', 'goose', 'goat', 'duck', 'turkey', 'pig', 'milk_cow', 'donkey', 'snail', 'horse', 'bee', 'lama'
            ]
            const animals = {}
            baseAnimals.forEach((animal) => {
              animals[animal] = this.data.animals.includes(animal)
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
              'breeder', 'horticulturist', 'cereal', 'winegrower', 'mushroom_grower', 'market_gardener', 'oyster_farmer', 'beekeeper', 'cheese_production', 'cider_maker', 'riding_stable', 'arborist', 'brewer', 'agroforestry'
            ]

            const baseAgricultureTypes = [
              'biological', 'permaculture', 'agroecology', 'agroecological', 'conventional', 'ringing', 'durable', 'reliability', 'hydroponics'
            ]
            const types = {}
            baseTypes.forEach((type) => {
              types[type] = this.data.farmTypes.includes(type)
            })
            const agricultures = {}
            baseAgricultureTypes.forEach((agriculture) => {
              agricultures[agriculture] = this.data.agricultureTypes.includes(agriculture)
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
            this.$wait.start('updating farm')
            this.$axios.put(`/offers/${this.$route.params.id}`, {
              offer: {
                offer_farm_type: types,
                offer_agriculture_type: agricultures,
                offer_animal: animals,
                offer_tag: tags,
                offer_description: {
                  farm: this.data.farmDescription,
                  activities: this.data.description,
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
                console.log('response', res)
              })
              .catch((err) => {
                console.error('err', err)
              })
              .finally(() => {
                this.$wait.end('updating farm')
                this.showDialog = false
                this.$router.push(this.to)
              })
          })
      },
      discardChanges () {
        this.showDialog = false
        this.$router.push(this.to)
      },
      next () {
        if (this.$wait.is('updating farm')) return

        this.$validator.validateAll()
          .then(valid => {
            if (!valid) return

            const baseAnimals = [
              'cow', 'chicken', 'sheep', 'rabbit', 'goose', 'goat', 'duck', 'turkey', 'pig', 'milk_cow', 'donkey', 'snail', 'horse', 'bee', 'lama'
            ]
            const baseTypes = [
              'breeder', 'horticulturist', 'cereal', 'winegrower', 'mushroom_grower', 'market_gardener', 'oyster_farmer', 'beekeeper', 'cheese_production', 'cider_maker', 'riding_stable', 'arborist', 'brewer', 'agroforestry'
            ]
            const baseAgricultureTypes = [
              'biological', 'permaculture', 'agroecology', 'agroecological', 'conventional', 'ringing', 'durable', 'reliability', 'hydroponics'
            ]
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
            const types = {}
            baseTypes.forEach((type) => {
              types[type] = this.data.farmTypes.includes(type)
            })
            const agricultures = {}
            baseAgricultureTypes.forEach((agriculture) => {
              agricultures[agriculture] = this.data.agricultureTypes.includes(agriculture)
            })
            const animals = {}
            baseAnimals.forEach((animal) => {
              animals[animal] = this.data.animals.includes(animal)
            })
            const tags = {}
            baseTags.forEach((tag) => {
              tags[tag] = this.data.tags.includes(tag)
            })
            this.$wait.start('updating farm')
            this.$axios.put(`/offers/${this.$route.params.id}`, {
              offer: {
                offer_farm_type: types,
                offer_agriculture_type: agricultures,
                offer_animal: animals,
                offer_tag: tags,
                offer_description: {
                  farm: this.data.farmDescription,
                  activities: this.data.description
                }
              }
            })
              .then((res) => {
                console.log('response', res)
              })
              .catch((err) => {
                console.error('err', err)
              })
              .finally(() => {
                this.$wait.end('updating farm')
                this.$router.push({
                  name: 'EditOfferService'
                })
                this.showDialog = false
                this.$router.push(this.to)
              })
          })
      },
      submitted () {
        if (this.$wait.is('updating farm')) return

        this.$validator.validateAll()
          .then(valid => {
            if (!valid) return

            const baseAnimals = [
              'cow', 'chicken', 'sheep', 'rabbit', 'goose', 'goat', 'duck', 'turkey', 'pig', 'milk_cow', 'donkey', 'snail', 'horse', 'bee', 'lama'
            ]
            const animals = {}
            baseAnimals.forEach((animal) => {
              animals[animal] = this.data.animals.includes(animal)
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
              'breeder', 'horticulturist', 'cereal', 'winegrower', 'mushroom_grower', 'market_gardener', 'oyster_farmer', 'beekeeper', 'cheese_production', 'cider_maker', 'riding_stable', 'arborist', 'brewer', 'agroforestry'
            ]

            const baseAgricultureTypes = [
              'biological', 'permaculture', 'agroecology', 'agroecological', 'conventional', 'ringing', 'durable', 'reliability', 'hydroponics'
            ]
            const types = {}
            baseTypes.forEach((type) => {
              types[type] = this.data.farmTypes.includes(type)
            })
            const agricultures = {}
            baseAgricultureTypes.forEach((agriculture) => {
              agricultures[agriculture] = this.data.agricultureTypes.includes(agriculture)
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
            this.$wait.start('updating farm')
            this.$axios.put(`/offers/${this.$route.params.id}`, {
              offer: {
                offer_farm_type: types,
                offer_agriculture_type: agricultures,
                offer_animal: animals,
                offer_tag: tags,
                offer_description: {
                  farm: this.data.farmDescription,
                  activities: this.data.description,
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
                console.log('response', res)
              })
              .catch((err) => {
                console.error('err', err)
              })
              .finally(() => {
                this.$wait.end('updating farm')
                this.$router.push({
                  name: 'DashboardOffers'
                })
                this.showDialog = false
                this.$router.push(this.to)
              })
          })
      }
    }
  }
</script>

<style lang="scss" scoped>
@import "@/assets/scss/_variables.scss";

.offer-label {
  font-size: 14px;
  color: #476458;
  line-height: 2.5;
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
  padding-top: 20px;
  text-transform: uppercase;
  font-size: 18px;
  font-family: 'Avenir', -apple-system, BlinkMacSystemFont, 'Segoe UI', Oxygen, Ubuntu, Cantarell, 'Open Sans', 'Helvetica Neue', sans-serif;
}

.subtitle {
  margin-top: 20px;
  margin-bottom: 20px;
  font-size: 12px;
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
    width: 60%;
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
.activitie__fields__item{
  label {
    user-select: none;
  }
}
.activities__fields{
  margin-bottom: 25px;
}

@media screen and (max-width: 600px) {
  .side {
    width:100%
  }
}
</style>
