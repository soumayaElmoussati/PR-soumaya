<template>

  <div class="home-hero">
    <client-only>

      <div
        class="home-hero__image h_small">

        <img
          alt="agriculteurs de Bretagne"
          src="@/assets/img/logo/adb-logo.png"
          class="adb-logo"
          width="380"
          height="270">

        <div class="wrap">
          <h1
            class="title title-all"
            style="display: inline">
            <b>{{ $t("home.titles.visit") }}</b> <br> {{ $t("home.titles.farmSeason") }} <br> {{ $t("home.titles.activitiesAgri") }}
          </h1>
          <form
            class="form-inline-full shadow"
            @submit.prevent="$parent.submitted"
          >
            <div class="search-bar">
              <home-hero-location
                v-model="$parent.data.address"
                :distance.sync="$parent.data.distance"
                :placeholder="$t('home.placeholder.goTo')"
              />

              <div class="cust searchbar-field-location cust-fullsearch searchbar-activity">
                <i
                  class="agri-others2 icon-gardening-boots-home"
                  aria-hidden="true"
                />
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
                  :show-no-results="false"
                  :limit="1"
                  :limit-text="count => `plus ${count}`"
                  :placeholder="$t('home.placeholder.farmActivities')"
                  tag-placeholder="Ajouter ce tag"
                  label="name"
                  track-by="code"
                />
              </div>

              <div class="inputWithIcon searchbar-field-location searchbar-date1">
                <datepicker
                  ref="datepicker1"
                  :disabled-dates="CatchEnd"
                  :format="'jj-MM-aaaa'"
                  :language="fr"
                  v-model="$parent.data.date1"
                  :input-class="'hide-input'"
                  :editable="false"
                  class="datepicker-arrival"/>
                <input
                  id="date1"
                  v-model="Formatter1"
                  :placeholder="$t('home.placeholder.arrived')"
                  type="text"
                  class="input datepick1"
                  autocomplete="off"
                  readonly
                  @click="openDatepicker(1)"
                  @blur="closeDatepicker(1)"
                >
                <i
                  class="icon-calendar calendar"
                  aria-hidden="true"
                />
              </div>
              <div class="inputWithIcon searchbar-field-location searchbar-date2">
                <datepicker
                  ref="datepicker2"
                  :disabled-dates="CatchStart"
                  :format="'jj-MM-aaaa'"
                  :language="fr"
                  v-model="$parent.data.date2"
                  :input-class="'hide-input'"
                  class="datepicker-departure"/>
                <input
                  id="date2"
                  v-model="Formatter2"
                  :placeholder="$t('home.placeholder.start')"
                  type="text"
                  class="input datepick2"
                  autocomplete="off"
                  readonly
                  @click="openDatepicker(2)"
                  @blur="closeDatepicker(2)"
                >
                <i
                  class="icon-calendar calendar"
                  aria-hidden="true"
                />
              </div>

              <div class="inputWithIcon searchbar-field-location number-people-field searchbar-count">
                <input
                  v-model="$parent.data.people_count"
                  type="number"
                  min="1"
                  class="input"
                  @change="setPCount"
                >
                <i
                  class="icon-family agri-others"
                  aria-hidden="true"
                />
              </div>
              <div class="buttons searchbar-go">
                <button
                  :disabled="$wait.is('searching')"
                  type="submit"
                  class="btn btn-discover btn-full-search"
                >
                  <span
                    v-if="!$wait.is('searching')"
                  >
                    {{ $t("home.buttons.find") }}
                  </span>
                  <wi-spinner
                    v-else
                  />
                </button>
              </div>
            </div>
          </form>
        </div>
      </div>

    </client-only>
  </div>

</template>

<script>
  import 'jquery'
  import dateFns from 'date-fns'

  import Datepicker from 'vuejs-datepicker'
  import HomeHeroLocation from '@/components/Home/HomeHero/HomeHeroLocation'

  export default {
    name: 'HomeHeroBretagne',
    components: {
      Datepicker,
      HomeHeroLocation
    },
    data () {
      return {
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
          days: [
            'Dim',
            'Lun',
            'Mar',
            'Mer',
            'Jeu',
            'Ven',
            'Sam'
          ],
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
          return dateFns.format(date, 'YYYY-MM-DD')
        }
      },
      Formatter2 () {
        var date = this.$parent.data.date2
        if (date === null) {
          return null
        } else {
          return dateFns.format(date, 'YYYY-MM-DD')
        }
      }
    },
    mounted () {
      // this.mobile = window.innerWidth < 768
    },
    methods: {
      setPCount (value) {
        this.$store.commit('SET_BOOKING_PEOPLE_COUNT', this.$parent.data.people_count)
      },
      addTag (newTag) {
        const tag = {
          name: newTag,
          code: newTag.substring(0, 2) + Math.floor((Math.random() * 10000000))
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
          this.$refs.datepicker1.$children[0].$emit('showCalendar')
          this.$refs.datepicker2.$children[0].$emit('closeCalendar')
          break
        case 2:
          this.$refs.datepicker1.$children[0].$emit('closeCalendar')
          this.$refs.datepicker2.$children[0].$emit('showCalendar')
          break
        default:
        }
      },

      closeDatepicker (id) {
        switch (id) {
        case 1:
          this.$refs.datepicker1.$children[0].$emit('closeCalendar')
          break
        case 2:
          this.$refs.datepicker2.$children[0].$emit('closeCalendar')
          break
        default:
        }
      }
    }
  }
</script>

<style src="vue-multiselect/dist/vue-multiselect.min.css"></style>

<style lang="scss" scoped>
  @import "@/assets/scss/_variables.scss";

  .input-address {
    background-color: $agri-green;
    color: $agri-white;
    border: none;
    border-radius: 50px;
    width: 200px;
    outline: none;
  }

  .adb-logo {
    position: absolute;
    bottom: 0;
    right: 40%;
    @media only screen and (max-width: $breakpoint-tablet) {
      right: 0%;
      bottom: -10px;
    }
  }

  .multiselect__strong {
    color: white !important;
  }

  ::placeholder { /* Chrome, Firefox, Opera, Safari 10.1+ */
    color: #cacec7;
    opacity: 1; /* Firefox */
  }

  .multiselect {
    color: $agri-yellow;
  }

  .multiselect__option--group {
    background: $agri-green !important;
    color:$agri-white;
  }

  .multiselect__option--group--highlight {
    background: $agri-green !important;
    color:$agri-white;
  }

  .number-people-field {
    width: 80px !important;
    @media only screen and (max-width: $breakpoint-tablet) {
      width: 100% !important;
    }
  }

  .searchbar-field-location {
    background-color: $agri-green !important;
    border: 1px solid white;
    border-radius: 50px;
    width: 100%;

    display: grid;
    grid-template-columns: auto auto;
  }

  .btn-discover {
    background-color: $agri-yellow !important;
    border-radius: 50px;
    color: black;
    margin-left: 40px;
    padding: 5px 25px;
    font-family: 'Avenir', -apple-system, BlinkMacSystemFont, 'Segoe UI', Oxygen, Ubuntu, Cantarell, 'Open Sans', 'Helvetica Neue', sans-serif;
    box-shadow: 0px 0px 10px black;
    @media only screen and (max-width: $breakpoint-tablet) {
      margin-left: 0px;
      width: 100%;
    }
  }

  .btn-full-search {
    margin-left: 10px !important;
  }

  .shadow {
    -webkit-box-shadow: 0 8px 6px -6px black;
      -moz-box-shadow: 0 8px 6px -6px black;
           box-shadow: 0 8px 6px -6px black;
  }

  .title-all {
    font-size: 40px !important;
    font-weight: 400;
    text-shadow: 0 0 7px rgba(0, 0, 0, 0.25);
  }

  .datepicker-arrival {
    position: absolute;
    bottom: 0px;
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
    background-image: url('~assets/img/home/home-background.png');
  }
  #s2 {
    background-image: url('~assets/img/home/home-background.png');
  }
  #s3 {
    background-image: url('~assets/img/home/home-background.png');
  }

  .slideshow{
    overflow: hidden;
    display: -webkit-box;
    position: relative;
    width: 100%;
    min-height: 850px;
    background-color: whitesmoke;
    .empty-container{
      height: 850px;
    }
    .hero-image{
      opacity: 0;
      position: absolute;
      width: 100%;
    }
    .h-first{
      opacity: 1
    }
  }
  .hero-content{
    position: absolute;
    margin-left: auto;
    margin-right: auto;
    left: 0;
    right: 0;
    margin-top: 150px;
  }

  .hero-wrap{
    margin-left: auto;
    margin-right: auto;
    .title{
      display: flex;
      justify-content: flex-end;
      flex-direction: row;
      margin-right: 80px;
      margin-bottom: 20px;
      text-shadow: 0 0 7px rgba(0, 0, 0, 0.25);
    }
  }

  @media only screen and (max-width: $breakpoint-tablet) {
    .home-hero-titles {
      margin-right: 10px !important;
      margin-left: 10px !important;
    }
  }
  @media only screen and (max-width: 500px) {
    .home-hero-titles {
      display: flex !important;
      flex-direction: column !important;
    }
  }
  .home-hero__image{
    display: flex;
    flex-direction: column;
    box-shadow: inset 0px -100px 140px 0px #0000008c;
  }

  .home-hero-titles{
    display: grid;
    grid-template-columns: repeat(3,1fr);
    grid-column-gap: 30px;
    margin-right: 100px;
    margin-left: 100px;
    margin-bottom: 20px;
    .hh-sub{
      text-align: center;
      h2{
        margin: 0px;
        font-size: 20px;
        font-weight: 500;
        margin: 12px 0;
        color: white;
      }
      h3{
        margin: 0px;
        font-size: 15px;
        font-weight: 400;
        margin: 12px 0;
        color: white;
      }
    }
  }

  .home-hero{
    display: flex;
    flex-direction: column;
    display: -webkit-box;
    h1,h2,h3{
      user-select: none;
    }

    & > .wrap{
      display: flex;
      height: 100%;
      flex: 1;

      @media only screen and (max-width: $breakpoint-tablet) {
        padding: 0 16px;
      }
    }

    h1{
      display: flex;
      flex-direction: column;
      color: white;
      margin: auto 0;
    }

    &__image{
      display: flex;
      min-height: 550px;
      width: 100%;
      background-color: $agri-grey;
      background-image: url('~assets/img/home/bretagne-background.jpg');
      background-size: cover;
      background-position: center;

      @media only screen and (max-width: $breakpoint-mobile-l) {
        padding: 0 16px;
      }

      .wrap{
        height: 100%;
        margin: auto;
        margin-top: 150px;

        .title{
          font-size: 36px;
          position: absolute;
          margin-top: 7em;
        }
      }

    }

    &__content{
      background-color: $primary;
      color: white;
      padding: 32px 0;

      @media only screen and (max-width: $breakpoint-mobile-l) {
        padding: 32px 16px;
      }

      .wrap{
        display: grid;
        grid-template-columns: repeat(3, 1fr);
        grid-gap: 16px;

        @media only screen and (max-width: $breakpoint-tablet) {
          grid-template-columns: 1fr;
        }

        .body-1{
          color: rgba(white, 0.7);
        }

        .headline{
          color: white;
        }
      }
    }
  }
  @media only screen and (max-width: $breakpoint-mobile-l) {
    .wrap {
      width: 90%;
    }
    .buttons{
      display: flex;
      justify-content: center;
    }
    .title{
      margin-right: 0px !important;
      justify-content: start !important;
    }
  }
  @media only screen and (max-width: $breakpoint-tablet) {
    .image-container{
      background-position-x: -200px !important;
    }
  }

  .search-bar{

    border-radius: 5px;
    padding-left: 8px;
    padding-right: 8px;
    display: grid;
    grid-template-columns: auto auto auto auto auto auto;
    grid-gap: 10px;
    .inputWithIcon{
      position: relative;
      margin-top: auto;
      margin-bottom: auto;
      input {
        width: 100%;
        border-radius: 25px;
        margin: 8px 0;
        outline: none;
        padding: 8px;
        box-sizing: border-box;
        transition: 0.3s;
        background-color: #466458;
        color: white;
        border: none;
      }

      input {
        padding-left: 40px;
      }

      i {
        font-size: 1.4rem;
        position: absolute;
        left: 0;
        top: 12px;
        padding: 9px 8px;
        color: white !important;
        transition: 0.3s;
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

      .buttons{
        margin-top: 0px;
        margin-bottom: 10px !important;
        grid-column-start: 1;
        grid-column-end: 4;
      }
      width: 100%;

      grid-template-columns: auto auto auto;

      .searchbar-location {
        grid-column-start: 1;
        grid-column-end: 4;
      }

      .searchbar-activity {
        grid-column-start: 1;
        grid-column-end: 4;
      }

      .searchbar-date1 {
        grid-column-start: 1;
        grid-column-end: 2;
      }

      .searchbar-date2 {
        grid-column-start: 2;
        grid-column-end: 3;
      }

      .searchbar-count {
        grid-column-start: 3;
        grid-column-end: 4;
      }

    }

  }

  .h_small{
    min-height: 850px !important;
  }

  .cust::v-deep .multiselect{

    min-width: 250px;
    margin-top: 8px;
    margin-bottom: 8px;

    .multiselect__tags{
      min-height: 50px;
      background-color: $agri-green !important;
      border: none;
      border-radius: 50px;
    }
    .multiselect__select{
      top: calc( 50% - 20px );
    }
    .multiselect__placeholder{
      font-size: 13px;
      margin-top: 10px;
      color: $agri-white;
      font-style: italic;
    }
    .multiselect__input{
      padding-top: 7px !important;
      padding-left: 0px !important;
    }
  }

  .cust {
    position: relative;
    i {
        z-index: 100;
        line-height: 0px;
        font-size: 1.4rem;
        color: white;
        transition: 0.3s;
        margin-top: 4vh;
        @media only screen and (max-width: $breakpoint-tablet) {
          margin-top: 2vh;
          margin-left: 1vh;
        }
    }
  }

  @media only screen and (max-width: $breakpoint-tablet) {
    .h_small{
      min-height: 735px !important;
    }
  }

  .form-inline-full {
    display: flex;
    flex-flow: row wrap;
    align-items: center;
    background-color: $agri-green;
    border-radius: 50px;
    padding: 15px 25px;
    position: absolute;
    top: 45em;
    left: 8em;
    @media only screen and (max-width: $breakpoint-tablet) {
      left: 0em;
      width: 100%;
      top: 40em;
      border-radius: 0px 0px 50px 50px;
      padding: 10px 0px;
    }
  }

</style>
