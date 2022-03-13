<template>
  <div class="offer-rules">
    <h2 class="content-title">
      {{ $t('activity.titles.rules') }}
    </h2>
    <ul class="body-1">
      <li>
        {{ $t('activity.lists.suitableBabe') }} {{ getActivity.settlement.baby_suitable ? 'Oui' : 'Non' }}
      </li>
      <li>
        {{ $t('activity.lists.suitableChild') }} {{ getActivity.settlement.child_suitable ? 'Oui' : 'Non' }}
      </li>
      <li>
        {{ $t('activity.lists.sigar') }} {{ getActivity.settlement.smooking_allowed ? 'Oui' : 'Non' }}
      </li>
      <li>
        {{ $t('activity.lists.celebratory') }} {{ getActivity.settlement.parties_allowed ? 'Oui' : 'Non' }}
      </li>
      <li>
        {{ $t('activity.lists.handicap') }} {{ getActivity.settlement.accessible ? 'Oui' : 'Non' }}
      </li>
      <li>
        {{ $t('activity.lists.welcomAnimals') }} {{ getActivity.settlement.animals_welcome ? 'Oui' : 'Non' }}
      </li>
    </ul>
    <div v-if="getActivity.settlement.additional_rules">
      <h3 class="content-title">
        {{ $t('activity.titles.additionalRules') }}
      </h3>
      <p class="body-1">
        {{ getActivity.settlement.additional_rules }}
      </p>
    </div>

    <!-- <div class="time-label__fields">

      <p class="body-1 arrival-fields">
        <i
          id="icon-plane-ar"
          class="icon-plane-ar"
          aria-hidden="true"
        />
        <br>
        <em class="time-title">Heure d'arrivée</em>
      </p>

      <p class="body-1 arrival-fields">
        <i
          id="icon-plane-dep"
          class="icon-plane-dep"
          aria-hidden="true"
        />
        <br>
        <em class="time-title">Heure de départ</em>
      </p>

    </div>

    <div class="time-field__fields">

      <div>
        <p class="arrival-fields">{{ getActivity.arriving_time }} <span>H</span> {{ formatArrivalMin }} </p>
      </div>

      <div >
        <p class="departure-fields">{{ getActivity.departure_time }} <span>H</span> {{ formatDepartureMin }} </p>
      </div>

    </div> -->

  </div>
</template>

<script>
  import { mapGetters } from 'vuex'

  export default {
    name: 'ActivityRules',
    computed: {
      ...mapGetters([
        'getActivity'
      ]),
      formatArrivalMin () {
        var number = this.getActivity.arriving_min_time
        if (number < 10) {
          var numStr = '0' + number
          return numStr
        }
        if (number >= 10) {
          var numStrclean = number
          return numStrclean
        }
      },
      formatDepartureMin () {
        var number = this.getActivity.departure_min_time
        if (number < 10) {
          var numStr = '0' + number
          return numStr
        }
        if (number >= 10) {
          var numStrclean = number
          return numStrclean
        }
      }
    }
  }
</script>

<style lang="scss" scoped>
  @import "@/assets/scss/_variables.scss";

  .welcome-title {
    font-size: 20px;
  }

  .offer-rules{

    .content-title {
      text-transform: uppercase;
      color: #476458;
      font-size: 21px;
      font-weight: 900;
      margin-top: 20px;
    }

    li {
      font-size: 15px;
      font-weight: bold;
      color: #476458;
      margin-bottom: 5px;
    }

    h3{
      font-size: 20px;
      font-weight: 400;
      color: $primary-text;
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
      grid-gap: 10px;

      @media only screen and (max-width: 768px) {
        grid-template-columns: repeat(2, calc(50%));
      }
    }
  }

  .arrival-fields {
    margin-top: 0px;
    margin-bottom: 0px;
    text-align: center;
    color: #476458;
    font-size: 14px;
    font-weight: bold;
  }

  .departure-fields {
    margin-top: 0px;
    margin-bottom: 0px;
    text-align: center;
    color: #476458;
    font-size: 14px;
    font-weight: bold;
  }

  .time-title {
    color: #476458;
    font-size: 14px;
    font-weight: normal;
  }
</style>
