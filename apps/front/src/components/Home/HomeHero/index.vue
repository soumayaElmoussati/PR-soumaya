<template>
  <div class="home-hero">
    <div class="desktop">
      <div class="home-hero__image h_small">
        <div
          class="wrap"
          style="width: 100%!important; height: 100% !important"
        >
          <div class="head">
            <div class="search-title">
              <h1
                class="title title-all"
                style="display: inline">
                {{ $t("home.titles.go") }} <strong>{{ $t("home.titles.farmStay") }}</strong> <br >
                {{ $t("home.titles.participe") }} <strong>{{ $t("home.titles.activity") }}</strong>
              </h1>
              <div class="image-bottom" />
            </div>
            <div>
              <form
                v-if="getOffers.length == 0"
                class="form-inline-full-reduce shadow"
                @submit.prevent="$parent.submitted"
              >
                <div class="search-bar">
                  <home-hero-location
                    v-model="$parent.data.address"
                    :distance.sync="$parent.data.distance"
                  />
                  <div
                    class="cust searchbar-field-location cust-fullsearch searchbar-activity"
                  >
                    <i
                      class="agri-others2 icon-gardening-boots-home"
                      aria-hidden="true"
                    />

                    <client-only>
                      <multiselect
                        v-model="$parent.activity"
                        :options="$parent.activityOptions"
                        :multiple="true"
                        :taggable="true"
                        :searchable="false"
                        :deselect-label="''"
                        :select-label="''"
                        :selected-label="'Selectionné'"
                        :open-direction="'below'"
                        :close-on-select="false"
                        :show-no-results="false"
                        :limit="1"
                        :limit-text="count => `+ ${count}`"
                        :placeholder="$t('home.placeholder.farmActivities')"
                        tag-placeholder="Ajouter ce tag"
                        label="name"
                        track-by="code"
                        class="input-activity"
                      />
                    </client-only>
                  </div>
                  <!-- Hide others input with date when no search -->
                  <div
                    v-if="getOffers.length != 0"
                    class="inputWithIcon searchbar-field-location searchbar-date1"
                  >
                    <datepicker
                      ref="datepicker1desktop"
                      :disabled-dates="CatchEnd"
                      :disabled="false"
                      :format="'jj-MM-aaaa'"
                      :language="fr"
                      v-model="$parent.data.date1"
                      :input-class="'hide-input'"
                      :editable="false"
                      class="datepicker-arrival"
                    />
                    <div
                      @click="openDatepicker(1)"
                      @blur="closeDatepicker(1)">
                      <input
                        id="date1"
                        v-model="Formatter1"
                        :placeholder="$t('home.placeholder.arrived')"
                        type="text"
                        class="input datepick1"
                        autocomplete="off"
                        readonly
                      >
                      <i
                        class="icon-calendar calendar"
                        aria-hidden="true" />
                    </div>
                  </div>
                  <div
                    v-if="getOffers.length != 0"
                    class="inputWithIcon searchbar-field-location searchbar-date2"
                  >
                    <datepicker
                      ref="datepicker2desktop"
                      :disabled-dates="CatchStart"
                      :format="'jj-MM-aaaa'"
                      :language="fr"
                      v-model="$parent.data.date2"
                      :input-class="'hide-input'"
                      class="datepicker-departure"
                    />
                    <div
                      @click="openDatepicker(2)"
                      @blur="closeDatepicker(2)">
                      <input
                        id="date2"
                        v-model="Formatter2"
                        :placeholder="$t('home.placeholder.start')"
                        type="text"
                        class="input datepick2"
                        autocomplete="off"
                        readonly
                      >
                      <i
                        class="icon-calendar calendar"
                        aria-hidden="true" />
                    </div>
                  </div>
                  <div
                    v-if="getOffers.length != 0"
                    class="inputWithIcon searchbar-field-location number-people-field searchbar-count"
                  >
                    <input
                      v-model="$parent.data.people_count"
                      type="number"
                      min="1"
                      class="input"
                      @change="setPCount"
                    >
                    <i
                      class="icon-family agri-others"
                      aria-hidden="true" />
                  </div>
                  <div class="buttons searchbar-go">
                    <button
                      v-if="getOffers.length == 0"
                      :disabled="$wait.is('searching')"
                      type="submit"
                      class="btn btn-discover btn-full-search"
                    >
                      <span v-if="!$wait.is('searching')">
                        {{ $t("home.buttons.find") }}
                      </span>
                      <wi-spinner v-else />
                    </button>
                  </div>
                </div>
              </form>
              <form
                v-if="getOffers.length != 0"
                class="form-inline-full shadow"
                @submit.prevent="$parent.submitted"
              >
                <div class="search-bar">
                  <home-hero-location
                    v-model="$parent.data.address"
                    :distance.sync="$parent.data.distance"
                  />
                  <div
                    class="cust searchbar-field-location cust-fullsearch searchbar-activity"
                  >
                    <i
                      class="agri-others2 icon-gardening-boots-home"
                      aria-hidden="true"
                    />

                    <client-only>
                      <multiselect
                        v-model="$parent.activity"
                        :options="$parent.activityOptions"
                        :multiple="true"
                        :taggable="true"
                        :searchable="false"
                        :deselect-label="''"
                        :select-label="''"
                        :close-on-select="false"
                        :selected-label="'Selectionné'"
                        :open-direction="'below'"
                        :show-no-results="false"
                        :limit="1"
                        :limit-text="count => `+ ${count}`"
                        :placeholder="$t('home.placeholder.farmActivities')"
                        tag-placeholder="Ajouter ce tag"
                        label="name"
                        track-by="code"
                        class="input-activity"
                      />
                    </client-only>
                  </div>
                  <!-- Hide others input with date when no search -->
                  <div
                    v-if="getOffers.length != 0"
                    class="inputWithIcon searchbar-field-location searchbar-date1"
                  >
                    <datepicker
                      ref="datepicker1desktop"
                      :disabled-dates="CatchEnd"
                      :format="'jj-MM-aaaa'"
                      :language="fr"
                      v-model="$parent.data.date1"
                      :input-class="'hide-input'"
                      :editable="false"
                      class="datepicker-arrival"
                    />
                    <div
                      @click="openDatepicker(1)"
                      @blur="closeDatepicker(1)">
                      <input
                        id="date1"
                        v-model="Formatter1"
                        :placeholder="$t('home.placeholder.arrived')"
                        type="text"
                        class="input datepick1"
                        autocomplete="off"
                        readonly
                      >
                      <i
                        class="icon-calendar calendar"
                        aria-hidden="true" />
                    </div>
                  </div>
                  <div
                    v-if="getOffers.length != 0"
                    class="inputWithIcon searchbar-field-location searchbar-date2"
                  >
                    <datepicker
                      ref="datepicker2desktop"
                      :disabled-dates="CatchStart"
                      :open-date="CatchStart.to"
                      :format="'jj-MM-aaaa'"
                      :language="fr"
                      v-model="$parent.data.date2"
                      :input-class="'hide-input'"
                      class="datepicker-departure"
                    />
                    <div
                      @click="openDatepicker(2)"
                      @blur="closeDatepicker(2)">
                      <input
                        id="date2"
                        v-model="Formatter2"
                        :placeholder="$t('home.placeholder.start')"
                        type="text"
                        class="input datepick2"
                        autocomplete="off"
                        readonly
                      >
                      <i
                        class="icon-calendar calendar"
                        aria-hidden="true" />
                    </div>
                  </div>
                  <div
                    v-if="getOffers.length != 0"
                    class="inputWithIcon searchbar-field-location number-people-field searchbar-count"
                  >
                    <!-- <input
                  v-model="$parent.data.people_count"
                  type="number"
                  min="1"
                  class="input"
                  @change="setPCount"
                /> -->
                    <i
                      class="icon-family agri-others"
                      aria-hidden="true" />
                    <select
                      id="personns-select"
                      v-model="$parent.data.people_count"
                      style="width: 80px !important; border: none; margin-left: 40px; background-color: transparent; color: #FFFFFF; font-family: 'Avenir', -apple-system, BlinkMacSystemFont, 'Segoe UI', Oxygen, Ubuntu, Cantarell, 'Open Sans', 'Helvetica Neue', sans-serif;"
                      class="input"
                      name="personns"
                      @change="setPCount"
                    >
                      <option value="">{{ $t("home.selects.person") }}</option>
                      <option value="0" />
                      <option value="1">1</option>
                      <option value="2">2</option>
                      <option value="3">3</option>
                      <option value="4">4</option>
                      <option value="5">5</option>
                      <option value="6">6</option>
                      <option value="7">7</option>
                      <option value="8">8</option>
                      <option value="9">9</option>
                      <option value="10">10</option>
                      <option value="11">11</option>
                      <option value="12">12</option>
                      <option value="13">13</option>
                      <option value="14">14</option>
                      <option value="15">15</option>
                      <option value="16">16</option>
                      <option value="17">17</option>
                      <option value="18">18</option>
                      <option value="19">19</option>
                      <option value="20">20</option>
                      <option value="21">21</option>
                      <option value="22">22</option>
                      <option value="23">23</option>
                      <option value="24">24</option>
                      <option value="25">25</option>
                    </select>
                  </div>
                  <div class="buttons searchbar-go-go">
                    <button
                      :disabled="$wait.is('searching')"
                      type="submit"
                      class="btn btn-discover btn-full-search"
                    >
                      <span v-if="!$wait.is('searching')">
                        {{ $t("home.buttons.find") }}
                      </span>
                      <wi-spinner v-else />
                    </button>
                    <button
                      :disabled="$wait.is('searching')"
                      type="submit"
                      class="btn btn-discover btn-full-search-mobile"
                    >
                      <span v-if="!$wait.is('searching')">
                        <img
                          :src="loupe"
                          alt="" >
                      </span>
                    </button>
                  </div>
                  <div class="mobile-btns">
                    <div
                      v-if="getOffers.length != 0"
                      class="inputWithIcon searchbar-field-location number-people-field searchbar-count-mobile"
                    >
                      <i
                        id="familyIcon"
                        class="icon-family agri-others"
                        aria-hidden="true"
                      />
                      <!-- <input
                    v-model="$parent.data.people_count"
                    type="number"
                    min="1"
                    class="input"
                    @change="setPCount"
                  > -->
                      <select
                        id="personns-select"
                        v-model="$parent.data.people_count"
                        style="width: 80px !important; border: none; margin-left: 45px; background-color: transparent; color: #FFFFFF; font-family: 'Avenir', -apple-system, BlinkMacSystemFont, 'Segoe UI', Oxygen, Ubuntu, Cantarell, 'Open Sans', 'Helvetica Neue', sans-serif;"
                        class="input"
                        name="personns"
                        @change="setPCount"
                      >
                        <option value="">{{ $t("home.selects.person") }}</option>
                        <option value="1">1</option>
                        <option value="2">2</option>
                        <option value="3">3</option>
                        <option value="4">4</option>
                        <option value="5">5</option>
                        <option value="6">6</option>
                        <option value="7">7</option>
                        <option value="8">8</option>
                        <option value="9">9</option>
                        <option value="10">10</option>
                        <option value="11">11</option>
                        <option value="12">12</option>
                        <option value="13">13</option>
                        <option value="14">14</option>
                        <option value="15">15</option>
                        <option value="16">16</option>
                        <option value="17">17</option>
                        <option value="18">18</option>
                        <option value="19">19</option>
                        <option value="20">20</option>
                        <option value="21">21</option>
                        <option value="22">22</option>
                        <option value="23">23</option>
                        <option value="24">24</option>
                        <option value="25">25</option>
                      </select>
                    </div>
                    <div class="buttons searchbar-go-mobile">
                      <button
                        :disabled="$wait.is('searching')"
                        type="submit"
                        class="btn btn-discover btn-full-search-mobile"
                      >
                        <span v-if="!$wait.is('searching')">
                          <img
                            :src="loupe"
                            alt="" >
                        </span>
                      </button>
                    </div>
                  </div>
                </div>
              </form>
              <video
                ref="video"
                class="video"
                style="width: 100%; height: 75vh; background-color: white; object-fit: cover; object-position: 50% 50%; transition: 1s; z-index: -1;"
                autoplay
                muted
                loop
              >
                <source
                  src="@/assets/video/Agri Vidéo.mp4"
                  type="video/mp4" >
              </video>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import 'jquery'
import dateFns from 'date-fns'
import { mapGetters } from 'vuex'
import Datepicker from 'vuejs-datepicker'
import loupe from '@/assets/img/button/loupe.png'
import HomeHeroLocation from '@/components/Home/HomeHero/HomeHeroLocation'

import videoAgri from '@/assets/video/Agri Vidéo.mp4'

export default {
  name: 'HomeHeroOfferAll',
  components: {
    Datepicker,
    HomeHeroLocation,
    videoAgri
  },
  data () {
    return {
      loupe,
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
      },
      mobile: false,
      disabledDates: {
        to: new Date()
      }
    }
  },
  computed: {
    CatchEnd () {
      var fDate
      if (this.$parent.data.date2 === null) {
        fDate = null
      } else {
        fDate = dateFns.subDays(this.$parent.data.date2, 1)
      }
      var disabledDates = {
        to: new Date(),
        from: fDate
      }
      return disabledDates
    },
    CatchStart () {
      var sDate
      if (this.$parent.data.date1 === null) {
        sDate = new Date()
      } else {
        sDate = dateFns.addDays(this.$parent.data.date1, 1)
      }
      var disabledDates = {
        to: sDate
      }
      return disabledDates
    },
    Formatter1 () {
      var date = this.$parent.data.date1
      if (date === null) {
        return null
      } else {
        return dateFns.format(date, 'D-MM-YYYY')
      }
    },
    Formatter2 () {
      var date = this.$parent.data.date2
      if (date === null) {
        return null
      } else {
        return dateFns.format(date, 'D-MM-YYYY')
      }
    },
    ...mapGetters(['getOffers'])
  },
  mounted () {
    this.$refs.video.play()
  },
  methods: {
    setPCount (value) {
      this.$store.commit(
        'SET_BOOKING_PEOPLE_COUNT',
        this.$parent.data.people_count
      )
    },
    addTag (newTag) {
      const tag = {
        name: newTag,
        code: newTag.substring(0, 2) + Math.floor(Math.random() * 10000000)
      }
      this.taggingOptions.push(tag)
      this.taggingSelected.push(tag)
    },
    customFormatter (date) {
      return dateFns.format(date, 'YYYY-MM-DD')
    },
    openDatepicker (id) {
      switch (id) {
        case 1:
          this.$refs.datepicker1desktop.$children[0].$emit('showCalendar')
          this.$refs.datepicker2desktop.$children[0].$emit('showCalendar')
          break
        case 2:
          this.$refs.datepicker1desktop.$children[0].$emit('closeCalendar')
          this.$refs.datepicker2desktop.$children[0].$emit('showCalendar')
          break
        case 3:
          this.$refs.datepicker1.$children[0].$emit('showCalendar')
          this.$refs.datepicker2.$children[0].$emit('closeCalendar')
          break
        case 4:
          this.$refs.datepicker1.$children[0].$emit('closeCalendar')
          this.$refs.datepicker2.$children[0].$emit('showCalendar')
          break
        default:
      }
    },
    closeDatepicker (id) {
      switch (id) {
        case 1:
          this.$refs.datepicker1desktop.$children[0].$emit('closeCalendar')
          this.$refs.datepicker2desktop.$children[0].$emit('showCalendar')
          break
        case 2:
          this.$refs.datepicker1desktop.$children[0].$emit('closeCalendar')
          this.$refs.datepicker2desktop.$children[0].$emit('showCalendar')
          break
        case 3:
          this.$refs.datepicker1.$children[0].$emit('closeCalendar')
          this.$refs.datepicker2.$children[0].$emit('showCalendar')
          break
        case 4:
          this.$refs.datepicker2.$children[0].$emit('closeCalendar')
          break
        default:
      }
    }
  }
}
</script>

<style lang="scss" scoped>
@import "@/assets/scss/_variables.scss";

.head {
  top: 0;
  width: 100%;
  height: 100%;
  position: relative;
  @media only screen and (max-width: $breakpoint-laptop-generic) {
    position: initial;
  }
}

.shadow {
  z-index: 10;
  background-color: $agri-green-opacity;
  border: 3px solid;
  border-color: rgba(71, 100, 88, 0.9);
  border-radius: 50px;
  padding: 10px 15px;
  position: absolute;
  bottom: 18%;
  left: 9%;
  -webkit-box-shadow: 0 8px 6px -6px black;
  -moz-box-shadow: 0 8px 6px -6px black;
  box-shadow: 0 8px 6px -6px black;
  @media only screen and (max-width: $breakpoint-laptop-generic) {
    left: 2em;
    margin: auto;
  }
   @media only screen and (max-width: $breakpoint-laptop-m) {
    left: 30%;
    top: 30%;
    height: max-content;
    margin: 0 auto;
  }
  @media only screen and (max-width: $breakpoint-tablet-m) {
    bottom: 50%;
    left: 25%;
  }
  @media only screen and (max-width: $breakpoint-tablet) {
    text-align: center;
    top: 45%;
    left: 15%
  }
  @media only screen and (max-width: $breakpoint-mobile-large) {
    text-align: center;
    top: 30%;
    left: 4%;
    margin-top: 28%;
  }
}

.video {
  display: block;
  @media only screen and (max-width: $breakpoint-laptop-generic) {
    display: none;
  }
}

.image-bottom {
  position: absolute;
  bottom: 0;
  background-image: url("../../../assets/img/home/Barre_navigation.png");
  background-size: cover;
  height: 20%;
  width: 100%;
  margin: 0;
  z-index: 0;
  padding: 0;
  left: 0;
  @media only screen and (max-width: $breakpoint-laptop-generic) {
    display: none;
  }
}

.input-address {
  background-color: rgba(71, 100, 88, 0.2) !important;
  color: $agri-white;
  border: none;
  border-radius: 50px;
  width: 200px;
  outline: none;
  background-color: transparent;
}

.input-activity {
  background-color: transparent;
  color: $agri-white;
  border: none;
  border-radius: 50px;
  width: 300px;
  outline: none;
  text-align: center;
  padding: 0;
  margin: 0;
  @media only screen and (max-width: $breakpoint-tablet) {
    width: 100%;
  }
}

::placeholder {
  /* Chrome, Firefox, Opera, Safari 10.1+ */
  color: $agri-white;
  opacity: 1; /* Firefox */
}

.multiselect__option--group {
  background: $agri-green !important;
  color: $agri-white;
}

.multiselect__option--group--highlight {
  background: $agri-green !important;
  color: $agri-white;
}

.multiselect {
  color: $agri-yellow;
}

.number-people-field {
  width: 80px !important;
  @media only screen and (max-width: $breakpoint-tablet) {
    width: 100% !important;
  }
}
.searchbar-go-go {
  @media only screen and (max-width: $breakpoint-tablet) {
    display: none !important;
  }
}
.searchbar-field-location {
  margin: 0 auto;
  display: flex;
  align-self: center;
  align-items: center;
  padding: 0.6rem auto 0.6rem auto;
  background-color: $agri-green-opacity !important;
  border: 1px solid white;
  border-radius: 50px;
  width: 100%;
  display: grid;
  grid-template-columns: auto auto;
  input {
    font-family: "Avenir", -apple-system, BlinkMacSystemFont, "Segoe UI", Oxygen,
      Ubuntu, Cantarell, "Open Sans", "Helvetica Neue", sans-serif;
    color: $agri-white;
  }
  i {
    padding: 0.6rem;
  }
  @media only screen and (max-width: $breakpoint-tablet) {
    background-color: transparent;
  }
}
input:focus::placeholder {
  color: transparent;
}

.btn-discover {
  background-color: $agri-green-light !important;
  border: solid 1px $agri-white;
  color: $agri-white;
  border-radius: 50px;
  font-size: 20px;
  font-weight: 900;
  line-height: 27px;
  margin: 0 !important;
  padding: 8px 20px;
  font-family: "Avenir", -apple-system, BlinkMacSystemFont, "Segoe UI", Oxygen,
    Ubuntu, Cantarell, "Open Sans", "Helvetica Neue", sans-serif;
  box-shadow: 0px 0px 10px black;
  @media only screen and (max-width: $breakpoint-tablet) {
    margin-left: 0px;
    width: 191px !important;
    background-color: $agri-green-light !important;
    color: $agri-white;
    border: solid 1px $agri-white;
  }
}

.btn-full-search {
  margin: 0 !important;
  @media only screen and (max-width: $breakpoint-tablet) {
  }
}

.btn-full-search-mobile {
  width: 80px !important;
  padding: 8px 8px !important;
  display: none;
  @media only screen and (max-width: $breakpoint-tablet) {
    display: block;
  }
}

.mobile-btns {
  display: none;
  .searchbar-count-mobile {
    display: block;
    grid-column-start: 1;
    grid-column-end: 4;
    width: 250px !important;
    @media only screen and (max-width: $breakpoint-tablet) {
      width: 100px !important;
      padding: 0 !important;
      margin-right: 70px !important;
    }
    @media only screen and (max-width: $breakpoint-mobile-l) {
      width: 150px !important;
      padding: 0 !important;
      margin-right: 10px !important;
      /* margin-right: 70px !important; */
    }
  }
  .searchbar-go-mobile {
    display: block;
  }
  @media only screen and (max-width: $breakpoint-tablet) {
    display: block;
    display: flex;
    margin-left: 35px !important;
  }
  @media only screen and (max-width: $breakpoint-mobile-l) {
    margin-left: 35px !important;
  }
  @media only screen and (max-width: $breakpoint-mobile-m) {
    margin-left: 25px !important;
  }
}

.datepicker-arrival {
  position: absolute;
  bottom: 0px;
  z-index: 105;
}
.datepicker-departure {
  position: absolute;
  bottom: 0px;
  right: 100px;
}
.hide-input {
  z-index: -99999999;
  opacity: 0;
  position: relative;
}
.image-container {
  background-size: cover;
  background-position-x: left;
  background-position-y: center;
  width: 100%;
  position: absolute;
  height: 900px;
  opacity: 0;
}
#s1 {
  background-image: url("~assets/img/home/home-background.png");
}
#s2 {
  background-image: url("~assets/img/home/home-background.png");
}
#s3 {
  background-image: url("~assets/img/home/home-background.png");
}

.slideshow {
  overflow: hidden;
  display: -webkit-box;
  position: relative;
  width: 100%;
  min-height: 850px;
  background-color: whitesmoke;
  .empty-container {
    height: 850px;
  }
  .hero-image {
    opacity: 0;
    position: absolute;
    width: 100%;
  }
  .h-first {
    opacity: 1;
  }
}
.hero-content {
  position: absolute;
  margin-left: auto;
  margin-right: auto;
  left: 0;
  right: 0;
  margin-top: 150px;
}

.hero-wrap {
  margin-left: auto;
  margin-right: auto;
  .title {
    display: flex;
    justify-content: flex-end;
    flex-direction: row;
    margin-right: 80px;
    margin-bottom: 20px;
    text-shadow: 0 0 7px rgba(0, 0, 0, 0.25);
  }
}
.home-hero__image {
  display: flex;
  flex-direction: column;
  box-shadow: inset 0px -100px 140px 0px #0000008c;
}

.home-hero {
  display: flex;
  flex-direction: column;
  display: -webkit-box;
  width: 100%;
  height: auto;
  @media only screen and (max-width: $breakpoint-tablet) {
    height: auto;
  }
  @media only screen and (max-width: $breakpoint-laptop-l) {
    height: auto;
  }
  /* Safari 10.1+ (which is the latest version of Safari at this time) */

  /* Safari 10.1+ (alternate method) */

  @media not all and (min-resolution: 0.001dpcm) {
    @supports (-webkit-appearance: none) {
      .safari_only {
        height: 95vh;
      }
    }
  }
  h1,
  h2,
  h3 {
    user-select: none;
  }

  & > .wrap {
    display: flex;
    height: 100%;
    flex: 1;

    @media only screen and (max-width: $breakpoint-tablet) {
      padding: 0 16px;
    }
  }

  h1 {
    display: flex;
    flex-direction: column;
    color: white;
    margin: auto 0;
  }

  &__image {
    display: flex;
    min-height: 550px;
    width: 100%;
    background-color: $agri-grey;
    background-image: url("~assets/img/home/home-background.png");
    background-size: cover;
    background-position: center;
    @media only screen and (min-width: $breakpoint-laptop-generic) {
      background-image: none;
      background-color: white;
      height: auto !important;
    }

    @media only screen and (max-width: $breakpoint-mobile-l) {
      /* padding: 0 16px; */
      padding: auto;
    }

    .wrap {
      height: 100%;
      margin: auto;
      @media only screen and (max-width: $breakpoint-tablet) {
        position: absolute;
        margin-top: 0px;
      }

      .title {
        margin-top: 15%;
        top: auto;
        bottom: 34%;
        font-size: 36px;
        position: absolute;
        font-family: "Avenir", -apple-system, BlinkMacSystemFont, "Segoe UI",
          Oxygen, Ubuntu, Cantarell, "Open Sans", "Helvetica Neue", sans-serif;
        @media only screen and (max-width: $breakpoint-tablet) {
          font-size: 28px !important;
          font-weight: 500;
          line-height: 38px;
          top: 60%;
        }
        @media only screen and (max-width: $breakpoint-laptop-generic) {
          // margin-top: 15%;
          top: 79px;
          margin: auto;
        }
      }
    }
  }
  // &__content {
  //   background-color: $primary;
  //   color: white;
  //   padding: 32px 0;

  //   @media only screen and (max-width: $breakpoint-mobile-l) {
  //     padding: 32px 16px;
  //   }

  //   .wrap {
  //     display: grid;
  //     grid-template-columns: repeat(3, 1fr);
  //     grid-gap: 16px;

  //     @media only screen and (max-width: $breakpoint-tablet) {
  //       grid-template-columns: 1fr;
  //     }

  //     .body-1 {
  //       color: rgba(white, 0.7);
  //     }

  //     .headline {
  //       color: white;
  //     }
  //   }
  // }
}
@media only screen and (max-width: $breakpoint-mobile-l) {
  .wrap {
    width: 90%;
  }
  .buttons {
    display: flex;
    justify-content: center;
  }
  .title {
    margin-right: 0px !important;
    justify-content: start !important;
  }
}
.search-bar {
  display: grid;
  grid-template-columns: auto auto auto auto auto auto;
  grid-gap: 10px;
  @media only screen and (max-width: $breakpoint-laptop-m) {
    display: flex;
    flex-direction: column;
  }
  .inputWithIcon {
    position: relative;
    margin: auto;
    input {
      width: 100%;
      border-radius: 25px;
      outline: none;
      box-sizing: border-box;
      transition: 0.3s;
      color: white;
      border: none;
      align-self: center;
      margin: auto;
      font-family: "Avenir", -apple-system, BlinkMacSystemFont, "Segoe UI",
        Oxygen, Ubuntu, Cantarell, "Open Sans", "Helvetica Neue", sans-serif;
      color: #ffffff;
      background-color: transparent !important;
      font-size: 13px;
    }

    input {
      padding-left: 40px;
      // @media only screen and (max-width: $breakpoint-mobile-l) {
      //   margin-left: 2px;
      // }
    }

    i {
      font-size: 1.4rem;
      position: absolute;
      left: 0;
      padding: 9px 8px;
      color: white !important;
      transition: 0.3s;
      // @media only screen and (max-width: $breakpoint-mobile-l) {
      //   padding: 9px 12px 9px 12px !important;
      //   margin-right: 12px;
      // }
    }
  }
  .buttons {
    margin-top: auto;
    margin-bottom: auto;
    button {
      width: 100%;
    }
  }
  .wi-spinner {
    width: 127px;
  }

  @media only screen and (max-width: $breakpoint-tablet) {
    margin: 0 auto 0 auto;
    .buttons {
      margin-top: 0px;
      margin-bottom: 10px !important;
      grid-column-start: 1;
      grid-column-end: 4;
      display: flex;
      justify-content: center;
      @media only screen and (max-width: $breakpoint-tablet) {
        margin-bottom: 0px !important;
      }
    }
    width: 100%;

    grid-template-columns: auto auto auto;

    .searchbar-location {
      grid-column-start: 1;
      grid-column-end: 4;
      width: 250px;
      @media only screen and (max-width: $breakpoint-tablet) {
        width: auto;
      }
    }

    .searchbar-activity {
      grid-column-start: 1;
      grid-column-end: 4;
      width: 250px;
    }

    .searchbar-date1 {
      grid-column-start: 1;
      grid-column-end: 4;
      width: 250px;
      text-align: center;
    }

    .searchbar-date2 {
      grid-column-start: 1;
      grid-column-end: 4;
      width: 250px;
    }

    .searchbar-count {
      grid-column-start: 1;
      grid-column-end: 4;
      width: 250px !important;
      @media only screen and (max-width: $breakpoint-tablet) {
        display: none;
      }
    }
  }
  @media only screen and (max-width: $breakpoint-tablet-m) {
    display: flex;
    flex-direction: column;
  }
}

.h_small {
  min-height: 750px !important;
  @media only screen and (min-width: $breakpoint-laptop-generic) {
    min-height: 0 !important;
  }
}

.cust::v-deep .multiselect {
  background-color: transparent !important;

  .multiselect__option--selected {
    background-color: #a4a8ad;
  }

  .multiselect__tags {
    min-height: 50px;
    background-color: transparent !important;
    border: none;
    border-radius: 50px;
    display: flex;
    align-items: center;
    padding: 0;
  }
  .multiselect__select {
    background-color: transparent !important;
    top: calc(50% - 20px);
  }
  .multiselect__placeholder {
    font-size: 13px;
    line-height: 14px;
    color: $agri-white;
    font-family: "Avenir", -apple-system, BlinkMacSystemFont, "Segoe UI", Oxygen,
      Ubuntu, Cantarell, "Open Sans", "Helvetica Neue", sans-serif;
    padding: 0;
    margin: 0;
    text-align: start;
    margin-left: 4px;
  }
  .multiselect__input {
    background-color: transparent !important;
    padding-top: 7px !important;
    padding-left: 0px !important;
  }
  .multiselect__tag {
    @media only screen and (max-width: $breakpoint-tablet) {
      width: 160px;
    }
  }

  .multiselect__content-wrapper {
    background-color: $agri-white !important;
    text-align: start !important;
    @media only screen and (max-width: $breakpoint-tablet) {
      width: 250px !important;
      margin-left: -50px !important;
      margin-top: 10px;
    }
    .multiselect__content {
      background-color: transparent !important;
    }
  }
  @media only screen and (max-width: $breakpoint-tablet) {
    width: 190px;
  }
}

.cust {
  i {
    text-align: center;
    font-size: 1.4rem;
    color: white;
    @media only screen and (max-width: $breakpoint-tablet) {
      margin-left: 1vh;
    }
  }
}

.search-title {
  display: flex;
  align-items: flex-start;
  flex-direction: column;
  padding: 0 10%;
}

.input {
  option {
    color: green;
  }
}
</style>
