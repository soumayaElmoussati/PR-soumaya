<template>
  <div
    v-if="similars.length"
    class="offer-similar">
    <h2 class="content-title">
      {{ $t("offer.titles.similarAd") }}
    </h2>
    <div class="cards">
      <nuxt-link
        v-for="offer in similars"
        :key="offer.id"
        :to="{
          name: 'Offer',
          params: {
            id: offer.id,
            slug: offer.slug,
            domaine: residenceTypeAdress(offer.residence_type)
          }
        }"
        style="cursor: pointer"
        class="card desktop"
      >
        <div class="photo">
          <div v-if="offer.pictures.length">
            <img
              v-for="picture in offer.pictures.slice(0, 1)"
              :key="picture.public_id"
              :src="address + picture.public_id"
              :alt="offer.name"
            >
          </div>
          <div v-else>
            <img
              :alt="offer.name"
              src="https://images.unsplash.com/photo-1565971988144-c8a2adc6eb1d?ixid=MnwxMjA3fDB8MHxzZWFyY2h8MXx8Z3Vlc3QlMjBob3VzZXxlbnwwfHwwfHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60"
            >
          </div>
        </div>
        <div class="text">
          <p class="desc">
            {{ residenceTypeAdress(offer.residence_type) }},
            {{ offer.people_count }} {{ $t("booking.card.personMin") }}
          </p>
          <p class="city">{{ offer.address.city }}</p>
          <p class="price">
            {{ $t("offer.popup.from") }} {{ offer.price_per_person / 100 }}€ {{ $t("offer.paragraphs.atNight") }}
          </p>
        </div>
        <div class="macaron">
          <img
            :src="certified"
            alt="" >
        </div>
      </nuxt-link>
    </div>
    <div class="mobile">
      <div class="carousel">
        <ul class="slides">
          <input
            id="img-1"
            type="radio"
            name="radio-buttons"
            checked >
          <li
            v-if="similars.length > 0"
            class="slide-container">
            <div class="slide-image">
              <nuxt-link
                :to="{
                  name: 'Offer',
                  params: {
                    id: similars[0].id,
                    slug: similars[0].slug,
                    domaine: residenceTypeAdress(similars[0])
                  }
                }"
                class="photo"
              >
                <div v-if="offer.pictures.length">
                  <img
                    v-for="picture in offer.pictures.slice(0, 1)"
                    :key="picture.public_id"
                    :src="address + picture.public_id"
                    :alt="offer.name"
                  >
                </div>
                <div v-else>
                  <img
                    :alt="offer.name"
                    src="https://images.unsplash.com/photo-1565971988144-c8a2adc6eb1d?ixid=MnwxMjA3fDB8MHxzZWFyY2h8MXx8Z3Vlc3QlMjBob3VzZXxlbnwwfHwwfHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60"
                  >
                </div>
              </nuxt-link>
              <div class="text">
                <p class="desc">
                  {{ residenceTypeAdress(similars[0].residence_type) }},
                  {{ similars[0].people_count }} {{ $t("booking.card.personMin") }}
                </p>
                <p class="city">{{ similars[0].address.city }}</p>
                <p class="price">
                  A partir de {{ similars[0].price_per_person / 100 }}€ {{ $t("offer.paragraphs.atNight") }}
                </p>
              </div>
              <div
                v-if="similars[0].certificated"
                class="macaron">
                <img
                  :src="certified"
                  alt="" >
              </div>
            </div>
            <!-- <div class="carousel-controls">
              <label
                for="img-3"
                class="prev-slide">
                <span>&lsaquo;</span>
              </label>
              <label
                for="img-2"
                class="next-slide">
                <span>&rsaquo;</span>
              </label>
            </div> -->
          </li>
          <input
            id="img-2"
            type="radio"
            name="radio-buttons" >
          <li
            v-if="similars.length > 1"
            class="slide-container">
            <div class="slide-image">
              <nuxt-link
                :to="{
                  name: 'Offer',
                  params: {
                    id: similars[1].id,
                    slug: similars[1].slug,
                    domaine: residenceTypeAdress(similars[1])
                  }
                }"
                class="photo"
              >
                <div v-if="offer.pictures.length">
                  <img
                    v-for="picture in offer.pictures.slice(0, 1)"
                    :key="picture.public_id"
                    :src="address + picture.public_id"
                    :alt="offer.name"
                  >
                </div>
                <div v-else>
                  <img
                    :alt="offer.name"
                    src="https://images.unsplash.com/photo-1565971988144-c8a2adc6eb1d?ixid=MnwxMjA3fDB8MHxzZWFyY2h8MXx8Z3Vlc3QlMjBob3VzZXxlbnwwfHwwfHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60"
                  >
                </div>
              </nuxt-link>
              <div class="text">
                <p class="desc">
                  {{ residenceTypeAdress(similars[1].residence_type) }},
                  {{ similars[1].people_count }} {{ $t("booking.card.personMin") }}
                </p>
                <p class="city">{{ similars[1].address.city }}</p>
                <p class="price">
                  A partir de {{ similars[1].price_per_person / 100 }}€ {{ $t("offer.paragraphs.atNight") }}
                </p>
              </div>
              <div
                v-if="similars[1].certificated"
                class="macaron">
                <img
                  :src="certified"
                  alt="" >
              </div>
            </div>
            <!-- <div class="carousel-controls">
              <label
                for="img-1"
                class="prev-slide">
                <span>&lsaquo;</span>
              </label>
              <label
                for="img-3"
                class="next-slide">
                <span>&rsaquo;</span>
              </label>
            </div> -->
          </li>
          <input
            id="img-3"
            type="radio"
            name="radio-buttons" >
          <li
            v-if="similars.length > 2"
            class="slide-container">
            <div class="slide-image">
              <nuxt-link
                :to="{
                  name: 'Offer',
                  params: {
                    id: similars[2].id,
                    slug: similars[2].slug,
                    domaine: residenceTypeAdress(similars[2])
                  }
                }"
                class="photo"
              >
                <div v-if="offer.pictures.length">
                  <img
                    v-for="picture in offer.pictures.slice(0, 1)"
                    :key="picture.public_id"
                    :src="address + picture.public_id"
                    :alt="offer.name"
                  >
                </div>
                <div v-else>
                  <img
                    :alt="offer.name"
                    src="https://images.unsplash.com/photo-1565971988144-c8a2adc6eb1d?ixid=MnwxMjA3fDB8MHxzZWFyY2h8MXx8Z3Vlc3QlMjBob3VzZXxlbnwwfHwwfHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60"
                  >
                </div>
              </nuxt-link>
              <div class="text">
                <p class="desc">
                  {{ residenceTypeAdress(similars[2].residence_type) }},
                  {{ similars[2].people_count }} {{ $t("booking.card.personMin") }}
                </p>
                <p class="city">{{ similars[2].address.city }}</p>
                <p class="price">
                  A partir de {{ similars[2].price_per_person / 100 }}€ {{ $t("offer.paragraphs.atNight") }}
                </p>
              </div>
              <div
                v-if="similars[2].certificated"
                class="macaron">
                <img
                  :src="certified"
                  alt="" >
              </div>
            </div>
            <!-- <div class="carousel-controls">
              <label
                for="img-2"
                class="prev-slide">
                <span>&lsaquo;</span>
              </label>
              <label
                for="img-1"
                class="next-slide">
                <span>&rsaquo;</span>
              </label>
            </div> -->
          </li>
          <div class="carousel-dots">
            <label
              id="img-dot-1"
              for="img-1"
              class="carousel-dot" />
            <label
              id="img-dot-2"
              for="img-2"
              class="carousel-dot" />
            <label
              id="img-dot-3"
              for="img-3"
              class="carousel-dot" />
          </div>
        </ul>
      </div>
    </div>
  </div>
</template>

<script>
import certified from '@/assets/img/resultsCards/Membre_Certifie.png'
import { mapGetters } from 'vuex'
export default {
  props: {
    offer: {
      type: Object,
      default: null
    }
  },
  data () {
    return {
      certified,
      similars: [],
      address:
        'https://res.cloudinary.com/agrivillage/image/upload/w_430,h_270,c_fill,f_jpg,fl_progressive/'
    }
  },
  async fetch () {
    if (this.offer.residence_type === 'guest_room') {
      await this.$axios
        .get('/offers/host')
        .then(res => {
          this.similars = res.data.offers.splice(0, 3)
        })
        .catch(err => {
          console.log('error', err)
        })
    }
    if (this.offer.residence_type === 'tiny_house') {
      await this.$axios
        .get('/offers/tiny')
        .then(res => {
          this.similars = res.data.offers.splice(0, 3)
        })
        .catch(err => {
          console.log('error', err)
        })
    }
    if (this.offer.residence_type === 'private_room') {
      await this.$axios
        .get('/offers/lodge')
        .then(res => {
          this.similars = res.data.offers.splice(0, 3)
        })
        .catch(err => {
          console.log('error', err)
        })
    }
    if (this.offer.residence_type === 'unusual_room') {
      await this.$axios
        .get('/offers/insolit')
        .then(res => {
          this.similars = res.data.offers.splice(0, 3)
        })
        .catch(err => {
          console.log('error', err)
        })
    }
    if (this.offer.residence_type === 'entire_house') {
      await this.$axios
        .get('/offers/lodge')
        .then(res => {
          this.similars = res.data.offers.splice(0, 3)
        })
        .catch(err => {
          console.log('error', err)
        })
    }
  },
  computed: {
    ...mapGetters(['getHostOffers'])
  },
  methods: {
    residenceTypeAdress (value) {
      // NOTE: Type de logement
      switch (value) {
        case 'entire_house':
          return 'LogementEntier'
        case 'private_room':
          return 'ChambrePrivee'
        case 'guest_room':
          return 'ChambreDHote'
        case 'unusual_room':
          return 'LogementInsolite'
        case 'tiny_house':
          return 'TinyHouse'
        case 'immersive_house':
          return 'LogementEnImmersion'
      }
    }
  }
}
</script>

<style lang="scss" scoped>
@import "@/assets/scss/_variables.scss";
p,
h2,
h3 {
  margin: 0;
  padding: 0;
}
* {
  font-family: "Avenir", -apple-system, BlinkMacSystemFont, "Segoe UI", Oxygen,
    Ubuntu, Cantarell, "Open Sans", "Helvetica Neue", sans-serif;
}
a {
  text-decoration: none;
}
.offer-similar {
  height: auto;
  margin-bottom: 5vw;
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
  h3 {
    color: $agri-green;
    font-size: 14px;
    font-weight: 900;
  }
  .cards {
    display: grid;
    grid-template-rows: 1fr;
    grid-template-columns: 25% 25% 25%;
    grid-gap: 8px;
    justify-content: center;
    @media only screen and (max-width: $breakpoint-laptop-m) {
      display: flex;
      flex-direction: column;
      width: 75%;
      align-items: center;
      justify-content: center;
    }
  }
  .card {
    background-color: $agri-green;
    border-radius: 30px;
    width: 100%;
    position: relative;
    .photo {
      img {
        width: 100%;
        height: 300px;
        border-top-left-radius: 30px;
        border-top-right-radius: 30px;
      }
    }
    .text {
      display: flex;
      flex-direction: column;
      justify-content: center;
      align-items: center;
      color: white;
      p {
        margin: 1%;
      }
      .city {
        font-weight: 900;
      }
    }
    .macaron {
      img {
        position: absolute;
        width: 70px !important;
        height: 63px;
        top: 300px;
        left: -9px;
      }
    }
  }
}
.desktop {
  display: block;
  @media only screen and (max-width: $breakpoint-tablet) {
    display: none;
  }
}
.mobile {
  display: none;
  @media only screen and (max-width: $breakpoint-tablet) {
    display: block;
  }
}

/* Carousel */
.carousel {
  margin-left: 15%;
  margin-right: 15%;
}

ul.slides {
  display: block;
  position: relative;
  height: 450px;
  width: 95%;
  margin: 0 auto;
  padding: 0;
  overflow: hidden;
  list-style: none;
  background-color: $agri-green;
  border-radius: 30px;
  width: 100%;
  position: relative;
  .photo {
    img {
      width: 100%;
      height: 200px;
      border-top-left-radius: 30px;
      border-top-right-radius: 30px;
    }
  }
  .text {
    display: flex;
    flex-direction: column;
    justify-content: center;
    align-items: center;
    color: white;
    p {
      margin: 1%;
    }
    .city {
      font-weight: 900;
    }
  }
  .macaron {
    img {
      position: absolute;
      width: 70px !important;
      height: 63px;
      top: 154px;
      left: -9px;
    }
  }
}

.slides * {
  user-select: none;
  -ms-user-select: none;
  -moz-user-select: none;
  -khtml-user-select: none;
  -webkit-user-select: none;
  -webkit-touch-callout: none;
}

ul.slides input {
  display: none;
}

.slide-container {
  display: block;
}

.slide-image {
  display: block;
  position: absolute;
  width: 100%;
  height: 100%;
  top: 0;
  opacity: 0;
  transition: all 0.7s ease-in-out;
}

.carousel-controls {
  position: absolute;
  top: 0;
  left: 0;
  right: 0;
  z-index: 999;
  font-size: 100px;
  line-height: 600px;
  color: #fff;
}

.carousel-controls label {
  display: block;
  position: absolute;
  padding: 0 20px;
  opacity: 0;
  cursor: pointer;
}

.carousel-controls .prev-slide {
  width: 15%;
  text-align: left;
  left: 0;
}

.carousel-controls .next-slide {
  width: 15%;
  text-align: right;
  right: 0;
}

.carousel-dots {
  position: absolute;
  left: 0;
  right: 0;
  bottom: 20px;
  z-index: 999;
  text-align: center;
}

.carousel-dots .carousel-dot {
  display: inline-block;
  width: 30px;
  height: 30px;
  border-radius: 50%;
  background-color: #fff;
  opacity: 0.5;
  margin: 10px;
}

input:checked + .slide-container .slide-image {
  opacity: 1;
  transform: scale(1);
  transition: opacity 1s ease-in-out;
}

input:checked + .slide-container .carousel-controls label {
  display: block;
}

input#img-1:checked ~ .carousel-dots label#img-dot-1,
input#img-2:checked ~ .carousel-dots label#img-dot-2,
input#img-3:checked ~ .carousel-dots label#img-dot-3,
input#img-4:checked ~ .carousel-dots label#img-dot-4,
input#img-5:checked ~ .carousel-dots label#img-dot-5,
input#img-6:checked ~ .carousel-dots label#img-dot-6 {
  opacity: 1;
}

input:checked + .slide-container .nav label {
  display: block;
}
</style>
