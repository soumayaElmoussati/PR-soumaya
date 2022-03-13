<template>
  <div class="heart-container">
    <div class="title">
      <h3>Le succès de nos collaborations avec des agriculteurs</h3>
      <img
        :src="heartIcone"
        alt="coup de coeur" >
    </div>
    <div
      id="cardDeskt1"
      class="cards-heart">
      <div class="card-preview">
        <div class="card-text">
          <p class="text-card-info">
            "Travailler avec AgriVillage m'a permis de développer des revenus complémentaires sans avoir eu à débourser 1€ ! <br>
            La gestion locative est très satisfaisante, je m'occupe du client une fois qu'il est arrivé à la ferme ! <br>
            JE RECOMMANDE"
          </p>
          <div class="info-farmer">
            <div>
              <img
                id="farmer1"
                :src="farmer1"
                class="farmer-picture"
                alt="domaine des Essart">
            </div>
            <div>
              <p class="name-farmer">
                DANA LERNER
              </p>
              <p class="offer-description">
                Gérante du domaine des Essart – Tiny House Coquerelle
              </p>
            </div>
          </div>
        </div>
      </div>
      <div class="card-preview">
        <div class="card-text">
          <p class="text-card-info">
            "Je rêvais d’avoir une « Tiny House » sur mon exploitation depuis quelques années. <br> Grâce à AgriVillage, je dispose aujourd’hui d’un hébergement insolite supplémentaire qui me permet de générer d’avantage de revenues. <br> Tout est géré en amont par les équipes AgriVillage. Un bonheur !"
          </p>
          <div class="info-farmer">
            <div>
              <img
                id="farmer2"
                :src="farmer2"
                class="farmer-picture"
                alt="Ferme des coutures">
            </div>
            <div>
              <p class="name-farmer">
                BRUNO BONIN
              </p>
              <p class="offer-description">
                Ferme des coutures – Tiny House Galinette
              </p>
            </div>
          </div>
        </div>
      </div>
    </div>
    <div class="button">
      <div class="line" />
      <nuxt-link
        :to="{
          name: 'OffersTinyHouse'
        }"
        class="button btn-home-tiny">
        {{ $t("tinyhouse.buttons")[2] }}
      </nuxt-link>
      <div class="line" />
    </div>
  </div>
</template>

<script>
import heartIcone from '@/assets/img/homeTiny/heartIcone.png'
import blur1 from '@/assets/img/homeTiny/blur_filter1.png'
import blur2 from '@/assets/img/homeTiny/blur_filter2.png'
import farmer1 from '@/assets/img/glamping/farmer1.png'
import farmer2 from '@/assets/img/glamping/farmer2.png'

export default {
  name: 'GlampingHeart',
  data () {
    return {
      heartIcone,
      blur1,
      blur2,
      farmer1,
      farmer2
    }
  }
}
</script>

<style lang="scss" scoped>
@import "@/assets/scss/_variables.scss";
* {
  font-family: "Avenir", -apple-system, BlinkMacSystemFont, "Segoe UI", Oxygen,
    Ubuntu, Cantarell, "Open Sans", "Helvetica Neue", sans-serif;
}

.info-farmer {
  display: flex;
  justify-content: space-between;
}

.text-card-info {
  font-size: 16px;
  text-align: left;
}

.name-farmer {
  margin-top: auto;
}

.offer-description {
  font-size: 12px;
}

.card-preview {
  display: grid;
  grid-template-columns: auto auto;
  column-gap: 10px;
  background-color: white;
  border-radius: 50px;
  padding: 20px;
  @media only screen and (max-width: $breakpoint-tablet) {
    grid-template-columns: auto;
  }
}

.farmer-picture {
  height: 100px;
  width: 100px;
  border-radius: 50px;
  margin-right: 23px;
}

.heart-container {
  background-image: linear-gradient(
      to bottom,
      rgba(210, 204, 184, 0.7),
      rgba(210, 204, 184, 0.7)
    ),
    url("~assets/img/homeTiny/fondBois.png");
  /* min-height: 837px; */
  background-repeat: no-repeat;
  background-size: cover;
  padding: 20px 80px;
  @media only screen and (max-width: $breakpoint-tablet) {
    width: 100% !important;
    padding: 0;
    height: auto;
  }
  .title {
    display: flex;
    justify-content: space-between;
    h3 {
      font-size: 24px;
      font-weight: 900;
      color: $agri-green;
      @media only screen and (max-width: $breakpoint-tablet) {
        text-align: center;
        margin-top: 45px;
      }
    }
    img {
      @media only screen and (max-width: $breakpoint-tablet) {
        width: 40px;
        height: 40px;
        position: absolute;
        left: 280px;
        transform: rotate(30deg);
      }
    }
  }
  .cards-heart {
    display: flex !important;
    justify-content: space-around;
    padding: 50px 0px;
    gap: 20px;
    @media only screen and (max-width: $breakpoint-tablet) {
      display: flex;
      flex-direction: column;
      justify-content: center;
      padding: 0 8px !important;
    }
    @media only screen and(max-width: $breakpoint-laptop-generic) {
      padding: 50px 15px;
    }
    #blur2 {
      @media only screen and (max-width: $breakpoint-tablet) {
        margin-top: 25px;
        margin-bottom: 45px;
      }
    }
  }
  .button {
    display: flex;
    justify-content: space-around;
    top: 0;
    @media only screen and (max-width: $breakpoint-tablet) {
      padding-bottom: 25px;
      padding-top: 25px;
    }
    @media only screen and (max-width: $breakpoint-mobile-m) {
      padding-bottom: 25px;
      padding-top: 25px;
    }
    .line {
      border-bottom: 4px solid $agri-green;
      width: 440px;
      margin-bottom: 20px;
      @media only screen and (max-width: $breakpoint-tablet) {
        display: none;
      }
    }
    a {
      text-decoration: none;
      width: 272px;
      background-color: $tiny-beige;
      border: none;
      cursor: pointer;
      color: $agri-green;
      font-weight: 900;
      font-size: 20px;
      padding: 14px 34px;
      border-radius: 99.5px;
    }
  }
  #cardDeskt2 {
    display: block;
    @media only screen and (max-width: $breakpoint-tablet) {
      display: none;
    }
  }
  #cardDeskt1 {
    display: block;
    @media only screen and (max-width: $breakpoint-tablet) {
      display: none;
    }
    #blur1 {
      margin-right: 25px;
      /* @media only screen and(max-width: $breakpoint-laptop-l) {
        margin-right: 15px;
      } */
      @media only screen and (max-width: $breakpoint-tablet) {
        margin: 0;
        height: 300px;
      }
    }
    #blur2 {
      @media only screen and (max-width: $breakpoint-tablet) {
        height: 300px;
      }
    }
  }
  #cardMobile {
    display: none;
    @media only screen and (max-width: $breakpoint-tablet) {
      display: block;
    }
  }
}
</style>
