<template>
  <div class="container">
    <div class="first-block">
      <div class="details">
        <h3>Qu’est ce que le glamping à la ferme ?</h3>
        <img
          id="mobile"
          :src="photo1"
          class="photo-mobil-1"
          alt="" >
        <p style="margin-bottom: 30px">
          Le glamping, c’est la contraction des mots glamour et camping.
          <br >
          <br >
          Chez AgriVillage, nous avons pensé un hébergement insolite, se composant d’une lodge aménagée et fonctionnelle, accompagnée de sa « Mini Tiny House »
          <br >
          <br >
          Au milieu d'exploitations agricoles, vous découvrirez la vie à la ferme dans des tentes confortables et chaleureuses.
          <br >
          <br >
          Une expérience unique, à partager entre amis ou en famille
        </p>

        <div class="btn">
          <a
            class="typeform-share button"
            href="https://agrivillage.typeform.com/to/VLYM39"
            data-mode="popup"
            data-size="100"
            target="_blank"
          >En savoir plus
          </a>
          <script type="application/javascript">(function() {var qs,js,q,s,d = document,gi = d.getElementById,ce = d.createElement,gt = d.getElementsByTagName,id = "typef_orm_share",b = "https://embed.typeform.com/";if (!gi.call(d, id)) {js = ce.call(d, "script");js.id = id;js.src = b + "embed.js";q = gt.call(d, "script")[0];q.parentNode.insertBefore(js, q);}})();
          </script>
        </div>

      </div>
      <img
        id="desktop"
        :src="photo1"
        class="photo-1"
        alt="" >
    </div>
    <div class="second-block">
      <img
        id="desktop"
        :src="photo3"
        class="photo-2"
        alt="" >
      <div class="details">
        <h3>Comment un hébergement glamping s’organise-t-il ? </h3>
        <img
          id="mobile"
          :src="photo3"
          class="photo-mobil-2"
          alt="" >
        <p style="margin-bottom: 30px">
          Ces logements ont été conçus dans le but de respecter l’environnement qu’ils occupent. Ainsi, tous les matériaux qui constituent nos lodges aménagées et leurs blocs sanitaires sont des matériaux de qualité et responsables. Vous y trouverez :
          <br >
          <br >
          Une lodge aménagée de 20m2 entièrement aménagée + son Poêle à bois
          <br >
          <br >
          Un intérieur confortable et cocooning pour 4/5 personnes
          <br >
          <br >
          Une « Mini Tiny House » en bois avec : kitchenette / douche / toilettes sèches
          <br >
          <br >
          Un espace extérieur folklorique, avec brasero et équipements
        </p>
        <div class="btn">
          <a
            class="typeform-share button"
            href="https://agrivillage.typeform.com/to/VLYM39"
            data-mode="popup"
            data-size="100"
            target="_blank"
          >En savoir plus
          </a>
          <script type="application/javascript">(function() {var qs,js,q,s,d = document,gi = d.getElementById,ce = d.createElement,gt = d.getElementsByTagName,id = "typef_orm_share",b = "https://embed.typeform.com/";if (!gi.call(d, id)) {js = ce.call(d, "script");js.id = id;js.src = b + "embed.js";q = gt.call(d, "script")[0];q.parentNode.insertBefore(js, q);}})();
          </script>
        </div>
      </div>
    </div>
    <br>
    <h3 class="text-color ">4 raisons qui vont vous pousser à proposer du Glamping dans votre ferme : </h3>
    <div class="why-box text-color">
      <div class="manage">
        <img
          id="manage-pic"
          :src="managePic"
          class="why-pic"
          alt="" >
        <div class="manage-box">
          <div class="mobil-pic">
            <div>
              <img
                id="manage-pic"
                :src="managePic"
                class="why-pic-mobil"
                alt="" >
            </div>
            <div>
              <p><b>Gestion simplifiée</b></p>
            </div>
          </div>
          <ul>
            <li>Aucune gestion des réservations (Agrivillage s’en occupe )</li>
            <li>Aucune gestion administrative</li>
            <li>Kit de Glamping complet et fonctionnel </li>
          </ul>
        </div>
      </div>
      <div class="income">
        <img
          id="income-pic"
          :src="incomePic"
          class="why-pic"
          alt="" >
        <div class="income-box">
          <div class="mobil-pic">
            <div>
              <img
                id="income-pic"
                :src="incomePic"
                class="why-pic-mobil"
                alt="" >
            </div>
            <div>
              <p><b>Revenus complémentaires (AgriVillage s’en occupe)</b></p>
            </div>
          </div>
          <ul>
            <li>Aucun coût pour l’agriculteur (0€)</li>
            <li>Rémunération fixe et garantie</li>
            <li>Jusqu’à 10 000 € / saison</li>
          </ul>
        </div>
      </div>
      <div class="activity">
        <img
          id="activity-pic"
          :src="activityPic"
          class="why-pic"
          alt="" >
        <div class="activity-box">
          <div class="mobil-pic">
            <div>
              <img
                id="activity-pic"
                :src="activityPic"
                class="why-pic-mobil"
                alt="" >
            </div>
            <div>
              <p><b>Activité saisonnière</b></p>
            </div>
          </div>
          <ul>
            <li>Louées seulement 90 jours / an </li>
            <li>Saison estivale</li>
          </ul>
        </div>
      </div>
      <div class="ecology">
        <img
          id="ecology-pic"
          :src="ecologyPic"
          class="why-pic"
          alt="" >
        <div class="ecology-box">
          <div class="mobil-pic">
            <div>
              <img
                id="ecology-pic"
                :src="ecologyPic"
                class="why-pic-mobil"
                alt="" >
            </div>
            <div>
              <p><b>Tourisme écoresponsable</b></p>
            </div>
          </div>
          <ul>
            <li>Logement respectueux de l’environnement</li>
            <li>Hausse du tourisme vert </li>
            <li>Forte demande de logement insolite</li>
          </ul>
        </div>
      </div>
    </div>

    <div class="btn cta-want-glamping">
      <a
        class="typeform-share button"
        href="https://agrivillage.typeform.com/to/CruG8J"
        data-mode="popup"
        data-size="100"
        target="_blank"
      >
        Je veux proposer du GLAMPING AgriVillage dans ma ferme
      </a>
      <script type="application/javascript">(function() {var qs,js,q,s,d = document,gi = d.getElementById,ce = d.createElement,gt = d.getElementsByTagName,id = "typef_orm_share",b = "https://embed.typeform.com/";if (!gi.call(d, id)) {js = ce.call(d, "script");js.id = id;js.src = b + "embed.js";q = gt.call(d, "script")[0];q.parentNode.insertBefore(js, q);}})();
      </script>
    </div>

  </div>
</template>

<script>
import photo1 from '@/assets/img/glamping/explain1.jpeg'
import photo2 from '@/assets/img/glamping/explain2.jpeg'
import photo3 from '@/assets/img/glamping/explain3.png'
import managePic from '@/assets/img/glamping/manage-pic.svg'
import incomePic from '@/assets/img/glamping/income-pic.png'
import activityPic from '@/assets/img/glamping/activity-pic.svg'
import ecologyPic from '@/assets/img/glamping/ecology-pic.svg'

export default {
  name: 'GlampingExplain',
  data () {
    return {
      photo1,
      photo2,
      photo3,
      managePic,
      incomePic,
      activityPic,
      ecologyPic
    }
  }
}
</script>

<style lang="scss" scoped>
@import "@/assets/scss/_variables.scss";

.manage {
  display: grid;
  grid-template-columns: 100px auto;
  @media only screen and (max-width: $breakpoint-tablet) {
    grid-template-columns: auto;
  }
}

.why-pic {
  @media only screen and (max-width: $breakpoint-tablet) {
    display: none;
  }
}

.why-pic-mobil {
  display: none;
  @media only screen and (max-width: $breakpoint-tablet) {
    display: block;
    width: 46px;
    height: auto;
  }
}

.mobil-pic {
  display: flex;
  align-items: center;
}

.income {
  display: grid;
  grid-template-columns: 100px auto;
  @media only screen and (max-width: $breakpoint-tablet) {
    grid-template-columns: auto;
  }
}

.activity {
  display: grid;
  grid-template-columns: 100px auto;
  @media only screen and (max-width: $breakpoint-tablet) {
    grid-template-columns: auto;
  }
}

.ecology {
  display: grid;
  grid-template-columns: 100px auto;
  @media only screen and (max-width: $breakpoint-tablet) {
    grid-template-columns: auto;
  }
}

.why-pic {
  width: 100px;
  height: 100px;
  margin: auto;
}

.cta-want-glamping {
  background-color: #FFF9E6;
  border-radius: 20px;
  width: 650px;
  margin: auto;
  @media only screen and (max-width: $breakpoint-tablet) {
    width: 100%;
  }
}

.why-box {
  display: grid;
  grid-template-columns: auto auto;
  @media only screen and (max-width: $breakpoint-tablet) {
      grid-template-columns: auto;
  }
}

.photo-1 {
  height: auto;
  width: 359px;
  object-fit: cover;
}

.photo-2 {
  height: auto;
  width: 359px;
  object-fit: cover;
}

.photo-mobil-1 {
  width: auto;
  height: 50vw;
}

.photo-mobil-2 {
  width: auto;
  height: 50vw;
}

* {
  font-family: "Avenir", -apple-system, BlinkMacSystemFont, "Segoe UI", Oxygen,
    Ubuntu, Cantarell, "Open Sans", "Helvetica Neue", sans-serif;
}
a {
  text-decoration: none;
}
.text-color {
  color: #476458;
}
.container {
  height: auto;
  margin-bottom: 10%;
  margin-left: 5%;
  margin-right: 5%;
  .first-block {
    background-color: rgba(71, 100, 88, 0.05);
    max-width: 1280px;
    display: flex;
    justify-content: space-between;
    margin: 0 auto;
    margin-top: 70px;
    @media only screen and (max-width: $breakpoint-tablet) {
      display: flex;
      flex-direction: column;
      background-color: white !important;
    }
    .details {
      display: grid;
      width: 900px;
      text-align: center;
      border: $agri-green 5px solid;
      @media only screen and (max-width: $breakpoint-tablet) {
        display: flex;
        flex-direction: column;
        width: 100% !important;
        border: none;
      }
      h3 {
        font-size: 22px;
        font-weight: 900;
        color: $agri-green;
        padding-top: 34px;
        @media only screen and (max-width: $breakpoint-tablet) {
          width: 80% !important;
          margin: 0 auto;
          margin-bottom: 20px;
        }
      }
      p {
        font-size: 14px;
        color: $agri-green;
        font-weight: 500;
        padding: 0 5px;
        text-align: left;
      }
      a {
        @media only screen and (max-width: $breakpoint-tablet) {
          margin: 0 auto;
          margin-bottom: 25px;
        }
      }
    }
    #desktop {
      display: block;
      @media only screen and (max-width: $breakpoint-tablet) {
        display: none;
      }
    }
    #mobile {
      display: none;
      @media only screen and (max-width: $breakpoint-tablet) {
        display: block;
        margin: 0 auto;
        width: 100%;
      }
    }
  }
  .second-block {
    background-color: rgba(71, 100, 88, 0.05);
    max-width: 1280px;
    display: flex;
    justify-content: space-between;
    margin: 0 auto;
    margin-top: 70px;
    @media only screen and (max-width: $breakpoint-tablet) {
      display: flex;
      flex-direction: column;
      background-color: white !important;
    }
    .details {
      display: grid;
      width: 900px;
      text-align: center;
      border: $agri-green 5px solid;
      padding-bottom: 30px;
      @media only screen and (max-width: $breakpoint-tablet) {
        display: flex;
        flex-direction: column;
        width: 100% !important;
        border: none;
      }
      h3 {
        font-size: 22px;
        font-weight: 900;
        color: $agri-green;
        padding-top: 34px;
        @media only screen and (max-width: $breakpoint-tablet) {
          width: 80% !important;
          margin: 0 auto;
          padding: 0;
          margin-bottom: 20px;
        }
      }
      p {
        font-size: 14px;
        color: $agri-green;
        font-weight: 500;
        padding: 0 5px;
        text-align: left;
      }
      a {
        @media only screen and (max-width: $breakpoint-tablet) {
          margin: 0 auto;
        }
      }
    }
    #desktop {
      display: block;
      @media only screen and (max-width: $breakpoint-tablet) {
        display: none;
      }
    }
    #mobile {
      display: none;
      @media only screen and (max-width: $breakpoint-tablet) {
        display: block;
        margin: 0 auto;
        width: 100%;
      }
    }
  }
}
.btn-home-tiny {
  margin: auto;
  margin-bottom: 4%;
  width: 272px;
  background-color: $tiny-beige;
  border: 1px solid $agri-green;
  cursor: pointer;
  color: $agri-green;
  font-weight: 900;
  font-size: 20px;
  padding: 14px 34px;
  border-radius: 99.5px;
}
</style>
