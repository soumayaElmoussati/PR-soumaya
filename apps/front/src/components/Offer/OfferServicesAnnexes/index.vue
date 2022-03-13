<template>
  <div class="offer-services">
    <h2 class="content-title">
      {{ $t("offer.titles.proposedService") }}
    </h2>
    <h3 class="service-sub">
      {{ $t("offer.titles.payedService") }}
      <br>
      {{ $t("offer.titles.warningBooking") }}
    </h3>
    <div class="divider" />
    <div class="offer-services-list">
      <div
        v-for="service in getOffer.annexe_service"
        :key="service.name"
        class="service-item"
      >
        <div class="service-item-block">
          <img
            v-if="service.name === 'Panier garnis'"
            :src="paniergarnis" >
          <img
            v-if="service.name === 'Location de vélo'"
            :src="velos" >
          <img
            v-if="service.name === 'Petit déjeuner'"
            :src="ptitdej" >
          <img
            v-if="service.name === 'Panier repas'"
            :src="panierRepas" >
          <img
            v-if="service.name === 'Atelier cuisine'"
            :src="atelier" >
          <img
            v-if="service.name === 'Activité bien-être'"
            :src="bien" >
          <img
            v-if="service.name === 'Accès SPA'"
            :src="spa" >
          <img
            v-if="service.name === 'Location de voiture'"
            :src="locvoiture"
          >
          <img
            v-if="service.name === 'Trajet gare-ferme'"
            :src="gare" >
          <img
            v-if="service.name === 'Espace nuit pour animaux'"
            :src="animaux"
          >
          <img
            v-if="service.name === 'Table d\'hôte'"
            :src="hote" >
          <img
            v-if="service.name === 'Barbecue'"
            :src="bbq" >
          <img
            v-if="service.name === 'Lave-linge / sèche-linge'"
            :src="washing" >
          <img
            v-if="service.name === 'Cours d\'équitation'"
            :src="training" >
          <img
            v-if="service.name === 'Balade à cheval / en âne'"
            :src="balade" >
          <img
            v-if="service.name === 'Stage d\'équitation'"
            :src="stage" >
          <img
            v-if="service.name === 'Initiation à l\'équitation'"
            :src="riding" >
          <img
            v-if="service.name === 'Immersion à la ferme'"
            :src="immersion" >
        </div>
        <div class="line" />
        <div
          v-if="service.name === 'Trajet gare-ferme'"
          class="service-item-name"
        >
          <div style="display: flex; flex-direction: row">
            <div>
              {{ service.name }}
            </div>
          </div>
          <div v-if="service.name === 'Panier garnis'">
            <i>{{ service.price / 100 }}{{ $t("bookingTiny.servicesAnnexes.title")[0].currency }}</i>
          </div>
          <div v-if="service.name === 'Location de vélo'">
            <i>{{ service.price / 100 }}{{ $t("bookingTiny.servicesAnnexes.title")[1].currency }}</i>
          </div>
          <div v-if="service.name === 'Petit déjeuner'">
            <i>{{ service.price / 100 }}{{ $t("bookingTiny.servicesAnnexes.title")[2].currency }}</i>
          </div>
          <div v-if="service.name === 'Panier repas'">
            <i>{{ service.price / 100 }}{{ $t("bookingTiny.servicesAnnexes.title")[3].currency }}</i>
          </div>
          <div v-if="service.name === 'Atelier cuisine'">
            <i>{{ service.price / 100 }}{{ $t("bookingTiny.servicesAnnexes.title")[4].currency }}</i>
          </div>
          <div v-if="service.name === 'Activité bien-être'">
            <i>{{ service.price / 100 }}{{ $t("bookingTiny.servicesAnnexes.title")[5].currency }}</i>
          </div>
          <div v-if="service.name === 'Accès SPA'">
            <i>{{ service.price / 100 }}{{ $t("bookingTiny.servicesAnnexes.title")[6].currency }}</i>
          </div>
          <div v-if="service.name === 'Location de voiture'">
            <i>{{ service.price / 100 }}{{ $t("bookingTiny.servicesAnnexes.title")[7].currency }}</i>
          </div>
          <div v-if="service.name === 'Trajet gare-ferme'">
            <i>{{ service.price / 100 }}{{ $t("bookingTiny.servicesAnnexes.title")[8].currency }}</i>
          </div>
          <div v-if="service.name === 'Espace nuit pour animaux'">
            <i>{{ service.price / 100 }}{{ $t("bookingTiny.servicesAnnexes.title")[9].currency }}</i>
          </div>
          <div v-if="service.name === 'Table d\'hôte'">
            <i>{{ service.price / 100 }}{{ $t("bookingTiny.servicesAnnexes.title")[10].currency }}</i>
          </div>
          <div v-if="service.name === 'Barbecue'">
            <i>{{ service.price / 100 }}{{ $t("bookingTiny.servicesAnnexes.title")[11].currency }}</i>
          </div>
          <div v-if="service.name === 'Lave-linge / sèche-linge'">
            <i>{{ service.price / 100 }}{{ $t("bookingTiny.servicesAnnexes.title")[12].currency }}</i>
          </div>
          <div v-if="service.name === 'Cours d\'équitation'">
            <i>{{ service.price / 100 }}{{ $t("bookingTiny.servicesAnnexes.title")[13].currency }}</i>
          </div>
          <div v-if="service.name === 'Balade à cheval / en âne'">
            <i>{{ service.price / 100 }}{{ $t("bookingTiny.servicesAnnexes.title")[14].currency }}</i>
          </div>
          <div v-if="service.name === 'Stage d\'équitation'">
            <i>{{ service.price / 100 }}{{ $t("bookingTiny.servicesAnnexes.title")[15].currency }}</i>
          </div>
          <div v-if="service.name === 'Initiation à l\'équitation'">
            <i>{{ service.price / 100 }}{{ $t("bookingTiny.servicesAnnexes.title")[16].currency }}</i>
          </div>
          <div v-if="service.name === 'Immersion à la ferme'">
            <i>{{ service.price / 100 }}{{ $t("bookingTiny.servicesAnnexes.title")[17].currency }}</i>
          </div>
          <div>
            <i>{{ service.description }}</i>
          </div>
        </div>
        <div
          v-else
          class="service-item-name"
        >
          <div style="display: flex; flex-direction: row">
            <div>
              {{ service.name }}
            </div>
          </div>
          <div>
            <i>{{ service.price / 100 }}€ / {{ $t("offer.infos.people") }}</i>
          </div>
          <div>
            <i>{{ service.description }}</i>
          </div>
        </div>
      </div>
    </div>

    <nuxt-link
      :to="{
        name: 'TinyBookingPreview',
        params: {
          id: getOffer.id
        }
      }"
      target="_blank"
      class="btn btn-agri-services"
    >{{ $t("booking.services.subtitle") }}</nuxt-link
    >

  </div>
</template>

<script>
import { mapGetters } from 'vuex'
import paniergarnis from '@/assets/img/offer/PanierGarnis.png'
import velos from '@/assets/img/offer/velos.png'
import ptitdej from '@/assets/img/offer/ptitdej.png'
import panierRepas from '@/assets/img/offer/panierRepas.png'
import atelier from '@/assets/img/offer/atelier.png'
import bien from '@/assets/img/offer/bien.png'
import spa from '@/assets/img/offer/spa.png'
import gare from '@/assets/img/offer/gare.png'
import locvoiture from '@/assets/img/offer/locvoiture.png'
import animaux from '@/assets/img/offer/animaux.png'
import hote from '@/assets/img/offer/hote.png'
import training from '@/assets/img/offer/horseshoe.svg'
import balade from '@/assets/img/offer/horse-saddle.svg'
import stage from '@/assets/img/offer/horse-head.svg'
import riding from '@/assets/img/offer/riding.svg'
import bbq from '@/assets/img/offer/grill.svg'
import washing from '@/assets/img/offer/washing-machine.svg'
import immersion from '@/assets/img/offer/initiation.svg'

export default {
  name: 'OffersServicesAnnexes',
  data () {
    return {
      paniergarnis,
      velos,
      ptitdej,
      panierRepas,
      atelier,
      bien,
      spa,
      gare,
      locvoiture,
      animaux,
      hote,
      training,
      balade,
      stage,
      riding,
      bbq,
      washing,
      immersion
    }
  },
  computed: {
    ...mapGetters(['getOffer'])
  },
  methods: {}
}
</script>

<style lang="scss" scoped>
@import "@/assets/scss/_variables.scss";

.service-sub {
  margin-top: 0px;
}

.divider {
  height: 1px;
  background-color: rgba(black, 0.3);
  margin-top: 16px;
}

.offer-services {
  .content-title {
    text-transform: uppercase;
    color: $agri-green;
    font-size: 21px;
    font-weight: 900;
    margin-bottom: 0px;
  }
  h3 {
    color: $agri-green;
    font-size: 14px;
    font-weight: 900;
  }

  &-list {
    display: flex;
    flex-wrap: wrap;

    .service-item {
      display: flex;
      flex-direction: row;
      align-items: flex-start;

      margin-right: 4px;
      width: 100%;

      &:last-child {
        margin-right: 0;
      }

      &-block {
        display: flex;
        border-radius: 6px;
        height: 78px;
        width: 78px;
        margin: 0 auto;

        .agri-animals,
        .agri-others {
          color: $agri-green-light;
          font-size: 42px;
          margin: auto;
        }
      }

      &-name {
        display: flex;
        justify-content: center;
        flex-direction: column;
        margin: auto;
        color: $agri-green;
        font-size: 12px;
        text-align: left;
        width: 100%;
        font-weight: bold;
      }
    }
  }
  .service-item-block {
    align-items: center;
    margin-right: 5%;
    img {
      width: 48px;
      height: 48px;
    }
  }
  .offer-services-list {
    margin-top: 4%;
    display: grid;
    grid-template-columns: 1fr 1fr;
    @media only screen and (max-width: $breakpoint-mobile-large) {
      grid-template-columns: 1fr;
    }
    .line {
      border-left: 1px solid $agri-green-light;
      height: 50%;
      margin: auto 1.5em auto 0;
    }
  }
}
</style>
