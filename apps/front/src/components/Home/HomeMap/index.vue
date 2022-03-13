<template>
  <div class="map_wrap">
    <h2 class="h_subtitle">
      {{ $t("home.titles.stayProfits") }}
    </h2>

    <div
      class="offers-map">

      <client-only>

        <l-map
          :zoom="zoom"
          :center="center"
          style="height: 100%; width: 100%;z-index: 1;"
        >

          <l-tile-layer :url="url" />

          <l-marker
            v-for="offer in getOffers"
            :key="offer.id"
            :offer="offer"
            :lat-lng="[offer.address.lat, offer.address.lng]" >

            <l-popup
              class="marker-card">

              <nuxt-link
                :to="{
                  name: 'Offer',
                  params: {
                    id: offer.id,
                    slug: offer.slug,
                    domaine: residenceTypeAdress
                  }
                }"
                target="_blank"
                class="marker-text"
              >

                {{ offer.name }}<br>
                <p class="marker-location">
                  À {{ offer.address.city }}
                </p>

              </nuxt-link>

            </l-popup>

          </l-marker>

        </l-map>

      </client-only>

    </div>

    <div class="content">
      <h1 class="title">{{ $t("home.titles.activitiesProposed") }}</h1>
      <p class="text">{{ $t("home.paragraphs.agritourism") }}</p>
      <img
        src="~assets/img/home/liste-activites.png"
        title="AgriVillage - Visite de l'exploitation agricole, Rencontre avec les animaux, Confection de produits artisanaux, Récolte des produits de la ferme, Dégustation des produits de la ferme, Participation à la traite des animaux, Assister à une naissance, Balade en tracteur à dos d'animaux ou en calèche"
        alt="AgriVillage - Visite de l'exploitation agricole, Rencontre avec les animaux, Confection de produits artisanaux, Récolte des produits de la ferme, Dégustation des produits de la ferme, Participation à la traite des animaux, Assister à une naissance, Balade en tracteur à dos d'animaux ou en calèche">

      <a
        href="https://blog.agrivillage.fr/les-activites-proposees-par-agrivillage"
        target="_blank"
        class="btn btn-primary button"
      >
        {{ $t("home.buttons.more") }}
      </a>
    </div>
  </div>
</template>

<script>
  import { mapGetters } from 'vuex'
  export default {
    name: 'Homemap',
    data () {
      return {
        url: process.env.MAPBOX_URL,
        zoom: 5,
        center: [47.266963327000084, 2.307975641902913], // NOTE: Center of France
        seen: true
      }
    },
    computed: {
      ...mapGetters([
        'getOffers'
      ]),
      residenceTypeAdress () {
      // NOTE: Type de logement
      switch (this.offer.residence_type) {
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
  .offers-map {
    width: 900px;
    height: 500px;
    margin-left: 20vw;
    margin-right: 20vw;
    margin-bottom: 70px;
    @media only screen and (max-width: 420px) {
      width: 100% !important;
      padding: 20px;
    }
  }
  .marker-location {
    font-size: 10px;
  }
  .marker-text {
    color: black;
    text-align: center;
    text-decoration: none;
    font-size: 12px;
    font-weight: 800;
    text-transform: uppercase;
    font-family: 'Avenir', -apple-system, BlinkMacSystemFont, 'Segoe UI', Oxygen, Ubuntu, Cantarell, 'Open Sans', 'Helvetica Neue', sans-serif;
  }
  @media only screen and (max-width: 420px) {
    .button{
      margin-left: 10px !important;
      margin-right: 10px !important;
    }
  }
  .button{
    max-width: 400px;
    margin-left: auto;
    margin-right: auto;
  }
  .map_wrap{
    display: flex;
    justify-content:center;
    flex-direction: column;
    align-items: center;
    background-color: rgb(225, 239, 216);
    padding-top: 100px;
    .content {
      background-color: white;
      margin: 0px;
      padding: 100px;
      width: 100%;
      text-align: center;
      img {
        width: 100%;
        max-width: 840px;
        margin-top: 50px;
      }
    }
    .map {
      width: 100%;
      height: 500px;
      max-width: 900px;
      border: none;
      margin-left: 20vw;
      margin-right: 20vw;
      margin-bottom: 70px;
    }
    .h_subtitle{
      font-size: 32px;
      font-weight: 500;
      margin: 8px 0;
      color: rgba(0, 0, 0, 0.76);
      text-align: center;
      margin-top: 50px;
      margin-bottom: 40px;
    }
  }
  @media only screen and (max-width: $breakpoint-tablet) {
    .content{
      padding-left: 0px !important;
      padding-right: 0px !important;
    }
    .title, .text{
      padding-left: 50px !important;
      padding-right: 50px !important;
    }
  }
  .app-header:v-deep {
    box-shadow: 0 0 24px rgba(0, 0, 0, 0.12) !important;
    background-color: white !important;
  }
</style>
