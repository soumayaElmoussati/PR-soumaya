<template>
  <div class="offer-popup">

    <div class="offer-popup-night">
      <i class="agri-others2 icon-sleep-mode"/>
      <br>
      <span class="popup-text">{{ getOffer.min_days }} {{ $t('offer.popup.night') }}</span>
    </div>

    <div class="offer-popup-room">
      <i class="agri-others2 icon-door"/>
      <br>
      <span class="popup-text">{{ getOffer.rooms_count }} {{ $t('offer.popup.room') }}</span>
    </div>

    <div class="offer-popup-room">
      <i class="slumber icon-slumber"/>
      <br>
      <span class="popup-text">{{ getOffer.sleeps_count }} {{ $t("offer.paragraphs.lying") }}</span>
    </div>

    <div class="offer-popup-bath">
      <i class="agri-others2 icon-bathtub"/>
      <br>
      <span class="popup-text">{{ getOffer.bathrooms_count }} {{ $t('offer.popup.bathroom') }}</span>
    </div>

    <div class="offer-popup-pricebox">
      <p class="offer-popup-start-at">{{ $t('offer.popup.from') }}</p>
      <p class="offer-popup-price">{{ getBestPrice | currency }}/ {{ $t('offer.popup.nights') }}</p>
    </div>

  </div>
</template>

<script>
import { mapGetters } from 'vuex'

export default {
  name: 'OfferPopup',
  computed: {
    ...mapGetters(['getOffer']),
    getBestPrice () {
      var allPrices = []
      var p = this.getOffer.price_period.length - 1
      var today = new Date()

      allPrices.push(this.getOffer.price_per_person)

      if (p !== -1) {
        // Si il n'y a pas de period de prix
        this.getOffer.price_period.forEach(period => {
          var periodDate = new Date(period.end_date)
          if (periodDate >= today) {
            allPrices.push(period.price_period)
          }
        })
      }

      var minPrice = Math.min(...allPrices)

      return minPrice
    }
  }
}
</script>

<style lang="scss" scoped>
@import "@/assets/scss/_variables.scss";

.offer-popup {
  border-radius: 20px;
  padding-top: 10px;
  padding-bottom: 10px;
  margin-left: 20vh;
  text-align: center;
  position: relative;
  width: 725px;
  background-color: white;
  bottom: 3vh;
  box-shadow: 1px 1px 12px #555;
  font-family: 'Avenir', -apple-system, BlinkMacSystemFont, 'Segoe UI', Oxygen, Ubuntu, Cantarell, 'Open Sans', 'Helvetica Neue', sans-serif;
   @media only screen and (max-width: $breakpoint-tablet-m) {
    margin-left: auto;
  }
  @media only screen and (max-width: $breakpoint-tablet) {
    bottom: auto;
    margin-left: 0vh;
    width: 100%;
  }

  display: grid;
  grid-template-columns: auto auto auto auto auto;
}

.offer-popup-night {
  border-right: 1px solid grey;
  align-self: center;
  justify-self: center;
  padding-left: 26px;
  padding-right: 26px;
  @media only screen and (max-width: 690px) {
    padding-left: 0px;
    padding-right: 0px;
  }
  @media only screen and (max-width: $breakpoint-mobile-large) {
    padding-left: 0px;
    padding-right: 0px;
    border-right: none;
  }
}

.offer-popup-room {
  border-right: 1px solid grey;
  align-self: center;
  justify-self: center;
  padding-right: 26px;
  padding-left: 26px;
  @media only screen and (max-width: 690px) {
    padding-left: 0px;
    padding-right: 0px;
  }
  @media only screen and (max-width: $breakpoint-mobile-large) {
    padding-left: 0px;
    padding-right: 0px;
    border-right: none;
  }
}

.offer-popup-bath {
  border-right: 1px solid grey;
  align-self: center;
  justify-self: center;
  padding-right: 15px;
  padding-left: 15px;
  @media only screen and (max-width: 690px) {
    padding-left: 0px;
    padding-right: 0px;
  }
  @media only screen and (max-width: $breakpoint-mobile-large) {
    padding-left: 0px;
    padding-right: 0px;
    border-right: none;
  }
}

.offer-popup-toilet {
  border-right: 1px solid grey;
  align-self: center;
  justify-self: center;
  padding-right: 26px;
  padding-left: 26px;
  @media only screen and (max-width: 690px) {
    padding-left: 0px;
    padding-right: 0px;
  }
  @media only screen and (max-width: $breakpoint-mobile-l) {
    padding-left: 0px;
    padding-right: 0px;
    border-right: none;
  }
}

.offer-popup-pricebox {
  text-transform: uppercase;
  color: #3F9536;
  line-height: 5px;

  align-self: center;
  justify-self: center;
  padding-right: 20px;
  padding-left: 20px;
  @media only screen and (max-width: 690px) {
    padding-left: 0px;
    padding-right: 0px;
  }
  @media only screen and (max-width: $breakpoint-mobile-l) {
    padding-left: 0px;
    padding-right: 0px;
  }
}

.offer-popup-start-at {
  font-size: 20px;
  @media only screen and (max-width: $breakpoint-mobile-large) {
    font-size: 10px;
  }
}

.offer-popup-price {
 font-size: 20px;
 font-weight: 900;
  @media only screen and (max-width: 690px) {
    font-size: 13px;
  }
 @media only screen and (max-width: $breakpoint-mobile-l) {
   font-size: 13px;
 }
}

.popup-text {
  font-size: 14px;
  @media only screen and (max-width: $breakpoint-mobile-l) {
    font-size: 9px;
  }
}

.agri-others2 .slumber{
  font-size: 25px;
}
</style>
