<template>
  <div class="reviews">
    <h2
      v-if="getOffer.reviews.length > 0"
      class="content-title">
      ILS RACONTENT LEUR EXPÉRIENCE  EN {{ $t('global.labels.housingType.'+getOffer.residence_type) }}
    </h2>
    <div class="review-desktop">
      <div class="review-grid">
        <div
          v-for="review in getOffer.reviews"
          :key="review.id"
          class="review-card"
        >
          <div class="client-infos">
            <img
              src="~assets/img/user/client-nav.svg"
              class="default-profile"
              title="client-profile"
              alt="client-profile">
            <h3 class="client-name">{{ review.first_name }}</h3>
          </div>
          <div class="review-text">
            <h4>Séjour du {{ moment(review.stay_date).locale('fr').format('L') }}</h4>
            <h4>Score: {{ review.star }}/5</h4>
          </div>
          <p class="review-desc">
            <read-more
              :text="review.comment"
              :max-chars="100"
              class="content-desc"
              more-str="En savoir plus"
              less-str="Voir moins"
              link="#"
            />
          </p>
        </div>
      </div>
    </div>
    <div class="review-mobile">
      <vueper-slides
        :visible-slides="1"
        :gap="0"
        :slide-ratio="1 / 2"
        :dragging-distance="200"
        :breakpoints="{ 800: { visibleSlides: 1, slideMultiple: 1 } }"
        :bullets="true"
        class="no-shadow"
        bullets-outside
        arrows-inside
        transition-speed="250"
        fixed-height="70vh"
        slide-multiple
      >
        <template v-slot:arrow-left>
          <img
            class="arrow"
            src="@/assets/img/chambrehote/arrowLeft.png" >
        </template>
        <template v-slot:arrow-right>
          <img
            class="arrow"
            src="@/assets/img/chambrehote/arrowRight.png" >
        </template>
        <vueper-slide
          v-for="review in getOffer.reviews"
          :key="review.id"
        >
          <template v-slot:content>
            <div class="review-card">
              <div class="review-grid">
                <div class="client-infos">
                  <div>
                    <img
                      src="~assets/img/user/client-nav.svg"
                      class="default-profile"
                      title="client-profile"
                      alt="client-profile">
                  </div>
                  <div>
                    <h3 class="client-name">{{ review.first_name }}</h3>
                  </div>
                </div>
                <div class="review-text">
                  <h4>Séjour du {{ moment(review.stay_date).locale('fr').format('L') }}</h4>
                  <h4>Score: {{ review.star }}/5</h4>
                </div>
                <p class="review-desc">
                  <read-more
                    :text="review.comment"
                    :max-chars="100"
                    class="content-desc"
                    more-str="En savoir plus"
                    less-str="Voir moins"
                    link="#"
                  />
                </p>
              </div>
            </div>
          </template>
        </vueper-slide>
      </vueper-slides>
    </div>
  </div>
</template>

<script>
  import { mapGetters } from 'vuex'
  import moment from 'moment'
  import { VueperSlides, VueperSlide } from 'vueperslides'
  import 'vueperslides/dist/vueperslides.css'

  export default {
    name: 'OfferReviews',
    components: { VueperSlides, VueperSlide },
    data () {
      return {
        moment
      }
    },
    computed: {
      ...mapGetters([
        'getOffer'
      ])
    }
  }
</script>

<style lang="scss" scoped>
  @import "@/assets/scss/_variables.scss";

.reviews {
  margin-top: 3vh;
  margin-bottom: 3vh;
}
.content-title {
  text-transform: uppercase;
  color: $agri-green;
  font-size: 21px;
  font-weight: 900;
  text-align: center;
  @media only screen and (max-width: $breakpoint-mobile-m) {
    margin-top: 2em;
  }
}
.review-desktop {
  .review-grid {
    display: grid;
    grid-template-rows: 1fr;
    grid-template-columns: 25% 25% 25%;
    grid-gap: 8px;
    justify-content: center;
    @media only screen and (max-width: $breakpoint-mobile-large) {
      grid-template-columns: 100%;
    }
    .review-card {
      background-color: $agri-green;
      border-radius: 30px;
      width: 100%;
      color: white;
      padding: 20px;
      justify-content: center;
      .client-infos {
        display: grid;
        grid-template-columns: auto auto;
        grid-gap: 8px;
        justify-content: center;
        .default-profile {
          width: 50px;
          height: 50px;
          border-radius: 100%;
          background-color: white;
        }
      }
      .review-text {
        justify-content: center;
        text-align: center;
      }
      .review-desc {
        color: white;
      }
    }
  }
  @media only screen and (max-width: $breakpoint-tablet) {
    display: none;
  }
}
.review-mobile {
  display: none;
  @media only screen and (max-width: $breakpoint-tablet) {
    display: block;
    .review-card {
      background-color: $agri-green;
      border-radius: 30px;
      width: 90%;
      color: white;
      padding: 20px;
      justify-content: center;
      margin: auto;
      height: -webkit-fill-available;
      .review-grid {
        display: grid;
        grid-template-rows: 1fr;
        grid-template-columns: 25% 25% 25%;
        grid-gap: 8px;
        justify-content: center;
        display: flex;
        flex-direction: column;
        .client-infos {
          display: grid;
          grid-template-columns: auto auto;
          grid-gap: 8px;
          justify-content: center;
          .default-profile {
            width: 50px;
            height: 50px;
            border-radius: 100%;
            background-color: white;
          }
        }
        .review-text {
          justify-content: center;
          text-align: center;
        }
        .review-desc {
          color: white;
        }
      }
    }
  }
}
</style>
