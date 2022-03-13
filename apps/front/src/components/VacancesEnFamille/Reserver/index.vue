<template>
  <div class="contentReserver">
    <div class="title">
      <h3>{{ $t("vacancesEnFamille.reserver.title") }}</h3>
      <hr>
      <h4> {{ $t("chambreHote.paragraphs.guestHouse") }} </h4>
    </div>
    <vueper-slides
      v-if="getOffers.length"
      :visible-slides="1"
      :gap="10"
      :slide-ratio="1 / 4"
      :dragging-distance="200"
      :breakpoints="{ 800: { visibleSlides: 1, slideMultiple: 1 } }"
      :bullets="true"
      class="no-shadow"
      bullets-outside
      arrows-inside
      fixed-height="75vh"
      transition-speed="250"
      slide-multiple
    >
      <template v-slot:arrow-left>
        <img src="@/assets/img/chambrehote/arrowLeft.png" >
      </template>

      <template v-slot:arrow-right>
        <img src="@/assets/img/chambrehote/arrowRight.png" >
      </template>
      <vueper-slide
        v-for="(offer, i) in getOffers"
        :key="i"
        :title="offer.title"
      >
        <template v-slot:content>
          <div class="vueperslide__content-wrapper">
            <div
              class="carousel"
              style="display: flex; background-color: #E2DFDF; width:75%"
            >
              <div>
                <nuxt-link
                  :to="{
                    name: 'Offer',
                    params: {
                      id: offer.id,
                      slug: offer.slug,
                      domaine: offer.residence_type
                    }
                  }"
                  target="_blank"
                >
                  <div v-if="offer.pictures.length">
                    <img
                      v-for="picture in offer.pictures.slice(0, 1)"
                      :key="picture.public_id"
                      :src="address + picture.public_id"
                      alt=""
                      style="width: 100% ; height:100% "
                    >
                  </div>
                  <div v-else>
                    <img
                      src="https://images.unsplash.com/photo-1565971988144-c8a2adc6eb1d?ixid=MnwxMjA3fDB8MHxzZWFyY2h8MXx8Z3Vlc3QlMjBob3VzZXxlbnwwfHwwfHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60"
                      alt=""
                      style="width: 100%; height:100%"
                    >
                  </div>
                </nuxt-link>
              </div>
              <div>
                <nuxt-link
                  :to="{
                    name: 'Offer',
                    params: {
                      id: offer.id,
                      slug: offer.slug,
                      domaine: offer.residence_type
                    }
                  }"
                  target="_blank"
                >
                  <div
                    class=""
                    style="text-align: left;width: 100%; align-items: center; margin: auto; color:grey;"
                  >
                    <h3 style="margin-bottom: 5%">
                      {{ offer.address.city }}
                    </h3>
                    <p>
                      {{ offer.description.residence.substring(0, 160) + "..." }}
                    </p>
                  </div>
                </nuxt-link>
              </div>
            </div>
          </div>
        </template>
      </vueper-slide>
    </vueper-slides>
    <div
      v-else
      style="text-align: center; margin-bottom: 10%">
      <img
        src="~assets/img/home/empty-results.svg"
        alt="empty"
        class="e_icon"
      >
      <h3 class="e-text body-1">{{ $t("insoliteBretagne.empty") }} <br ></h3>
    </div>
  </div>
</template>

<script>
import 'vueperslides/dist/vueperslides.css'
import { VueperSlides, VueperSlide } from 'vueperslides'
import { mapGetters } from 'vuex'
export default {
  name: 'Reserver',
  components: {
    VueperSlides,
    VueperSlide
  },
  data () {
    return {
      address:
        'https://res.cloudinary.com/agrivillage/image/upload/w_430,h_270,c_fill,f_jpg,fl_progressive/'
    }
  },
  async fetch () {
    await this.$axios
      .get('/offers/familly')
      .then(res => {
        this.$store.dispatch('setOffers', res.data.all_offers)
      })
      .catch(err => {
        console.log('error', err)
      })
  },
  computed: {
    ...mapGetters(['getOffers'])
  }
}
</script>

<style lang="scss" scoped>
@import "@/assets/scss/_variables.scss";
h2,
h3,
h4,
p {
  margin: 0;
  padding: 0;
}
* {
  font-family: "Avenir", -apple-system, BlinkMacSystemFont, "Segoe UI", Oxygen,
    Ubuntu, Cantarell, "Open Sans", "Helvetica Neue", sans-serif;
}
.contentReserver {
  height: auto;
  .title {
    margin: 5% 0;
    text-align: center;
    h3 {
      color: black;
      text-align: center;
      font-size: 27px;
      font-weight: 500;
      margin-top: 4%;
      margin-bottom: 2%;
      display: block;
    }
    hr {
      margin: auto;
      margin-bottom: 4%;
      width: 10%;
      border-bottom: $agri-green 4px solid;
    }
    h4 {
      font-size: 18px;
      margin: auto;
      width: 70%;
    }
  }
  .e_icon {
    width: 25%;
    height: auto;
  }
}
.carousel {
  a {
    text-decoration: none;
    margin: 0;
    padding: 0;
  }
  @media only screen and (max-width: $breakpoint-laptop-m) {
    flex-direction: column;
  }
  img {
    @media only screen and (max-width: $breakpoint-laptop-l) {
      width: 636px !important;
      height: 385px !important;
    }
    @media only screen and (max-width: $breakpoint-laptop-m) {
      width: 100% !important;
      height: 100% !important;
    }
  }
}
</style>
