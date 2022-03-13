<template>
  <nuxt-link
    :to="{
      name: 'Offer',
      params: {
        id: offer.id,
        slug: offer.slug,
        domaine: residenceTypeUrl
      }
    }"
    class="offer-card"
    target="_blank"
  >

    <div
      class="offer-card-image"
    >

      <div
        v-if="hasPromotion"
        class="promotion-box">

        <img
          alt="promotion"
          src="@/assets/img/offer/chicken.svg"
          width="35"
          height="35">

        <div class="promotion-text">
          <p><span class="promotion-amount">-{{ getPromotion.amount }}%</span> {{ $t("offer.titles.from") }} {{ getStartDate }} {{ $t("offer.titles.at") }} {{ getEndDate }}</p>
        </div>

      </div>

      <img
        v-if="isBbc"
        alt="bleu-blanc-coeur"
        src="@/assets/img/logo/bleublanccoeur.png"
        class="badge-bbc"
        width="84"
        height="84">

      <img
        v-if="isAdb"
        alt="agriculteurs-de-bretagne"
        src="@/assets/img/offer/adb-badge.png"
        class="badge-adb"
        width="160"
        height="50">

      <img
        v-if="isFairefrance"
        alt="faire-france"
        src="@/assets/img/logo/faire-france.png"
        class="badge-bbc"
        width="84"
        height="84">

      <cloudinary
        v-if="offer.pictures.length"
        :public-id="offer.pictures[0].public_id"
        :itemkey="offer.id.toString()"
        :transformations="{
          w: 214,
          h: 260,
          c: 'fill',
          f: 'jpg',
          fl: 'progressive'
        }"
        :alt="offer.name"
      />
      <div
        v-else
        class="offer-card-image__empty"
      >
        <span>
          {{ $t('offer.titles.no_images') }}
        </span>
      </div>

    </div>

    <div class="offer-card-informations">

      <div class="infos-secondary">
        {{ residenceType }}, {{ $tc('search.card.people', people, { number: people }) }}

      </div>

      <div class="infos-title">
        {{ offer.address.city }}
      </div>

      <div
        v-if="isCertified"
        class="infos-third">
        <img
          alt="certificated"
          src="@/assets/img/offer/certifie.png"
          class="badge-certificated"
          width="33"
          height="42">
        <p>
          {{ $t('search.card.from') }} <span class="price">{{ getBasePrice | currency }} {{ $t('search.card.per_night') }}</span>
        </p>

      </div>

      <div class="infos-price">
        <p>
          {{ $t('search.card.from') }} <span class="price">{{ getBasePrice | currency }} {{ $t('search.card.per_night') }}</span>
        </p>
      </div>

    </div>

  </nuxt-link>
</template>

<script>
  import moment from 'moment'
  import Cloudinary from '@/components/Cloudinary'

  export default {
    name: 'OfferCard',
    components: {
      Cloudinary
    },
    props: {
      offer: {
        type: Object,
        default: null
      }
    },
    computed: {
      residenceType () {
        // NOTE: Type de logement
        switch (this.offer.residence_type) {
        case 'entire_house':
          return 'Logement entier'
        case 'private_room':
          return 'Chambre privée'
        case 'guest_room':
          return 'Chambre d\'hote'
        case 'unusual_room':
          return 'Logement insolite'
        case 'tiny_house':
          return 'Tiny House'
        case 'immersive_house':
          return 'Logement en immersion'
        }
      },
      residenceTypeUrl () {
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
      },
      people () {
        // NOTE: Nombre de personnes de l'offre
        return this.offer.sleeps_count
      },
      farmType () {
        return [...(this.offer.farm_types || []).slice(0, 2)]
          .filter(v => v.length > 1)
          .map((v) => {
            return this.$t(`offer.farmTypes.${v}`)
          })
          .join(' - ')
      },
      hasPromotion () {
        // NOTE: L'offre a une promotion spéciale
        var l = this.offer.promotions.length - 1
        if (l === -1) {
          return false
        } else {
          return true
        }
      },
      isAmbassador () {
        // NOTE: L'Agriculteur est un ambassadeur
        if (this.offer.farmer.user.ambassador === true) {
          return true
        } else {
          return false
        }
      },
      isBbc () {
        // NOTE: L'Agriculteur est un membre de Bleu Blanc Coeur
        if (!!this.offer.farmer.organisation && this.offer.farmer.organisation.bbc === true) {
          return true
        } else {
          return false
        }
      },
      isFairefrance () {
        // NOTE: L'Agriculteur est un membre de Bleu Blanc Coeur
        if (!!this.offer.farmer.organisation && this.offer.farmer.organisation.fairefrance === true) {
          return true
        } else {
          return false
        }
      },
      isAdb () {
        // NOTE: L'Agriculteur est un membre de Bleu Blanc Coeur
        if (!!this.offer.farmer.organisation && this.offer.farmer.organisation.adb === true) {
          return true
        } else {
          return false
        }
      },
      isCertified () {
        // NOTE: L'Offre est certifier
        if (this.offer.certificated === true) {
          return true
        } else {
          return false
        }
      },
      getBasePrice () {
        // NOTE: Prix de base de la nuit
        return this.offer.price_per_person
      },
      getPromotion () {
        // NOTE: Promotion spéciale de l'offre
        return this.offer.promotions[0]
      },
      getStartDate () {
        // NOTE: Date de départ de la promotion
        return moment(this.offer.promotions[0].start_date).format('DD/MM')
      },
      getEndDate () {
        // NOTE: Date de fin de la promotion
        return moment(this.offer.promotions[0].end_date).format('DD/MM')
      }
    }
  }
</script>

<style lang="scss" scoped>
  @import "@/assets/scss/_variables.scss";

  .promotion-box {
    position: absolute;

    background-color: #EFCE4A;
    padding: 0px 10px;
    box-shadow: 0px 0px 10px black;

    display: grid;
    grid-template-columns: auto auto;
    justify-content: space-around;

    border-radius: 10px;
    margin-left: 10vh;
    margin-top: 2vh;
  }

  .promotion-text {
    color: black;
    text-transform: uppercase;
    font-weight: bold;
    font-size: 11px;
  }

  .promotion-amount {
    color: #466458;
  }

  .badge-ambassador {
    position: absolute;
  }

  .badge-bbc {
    position: absolute;
    margin-left: 16%;
  }

  .badge-adb {
    position: absolute;
    margin-left: 11%;
  }

  .price {
    text-transform: uppercase;
    font-size: 11px;
    font-family: 'Avenir', -apple-system, BlinkMacSystemFont, 'Segoe UI', Oxygen, Ubuntu, Cantarell, 'Open Sans', 'Helvetica Neue', sans-serif;
    font-weight: 800;
  }

  .offer-card{
    display: flex;
    flex-direction: column;
    text-decoration: none;
    width: 214px;
    height: 352px;
    box-shadow: 0 8px 6px -6px black;
    width: 100%;

    &-image{
      display: flex;
      background-color: lighten(#D1D1D1, 10%);
      height: 100%;
      width: 100%;
      border-top-left-radius: 6px;
      border-top-right-radius: 6px;
      // margin-bottom: 6px;
      width: 100%;

      .cloudinary{
        display: flex;
        width: 100%;
        height: 100%;
        object-fit: cover;
        border-top-left-radius: 6px;
        border-top-right-radius: 6px;
        overflow: hidden;

        background-color: #D1D1D1;
      }

      &__empty{
        display: flex;
        flex-direction: column;
        color: rgba(black, 0.5);
        margin: auto;
      }
    }

    &-informations{
      background-color: #476458;
      width: 100%;
      height: 103px;

      border-bottom-left-radius: 6px;
      border-bottom-right-radius: 6px;

      .infos{
        &-secondary{
          font-size: 12px;
          font-family: 'Avenir', -apple-system, BlinkMacSystemFont, 'Segoe UI', Oxygen, Ubuntu, Cantarell, 'Open Sans', 'Helvetica Neue', sans-serif;
          color: white;
          margin-top: 12px;
          text-align: center;
        }

        &-title{
          font-size: 14px;
          font-weight: 800;
          font-family: 'Avenir', -apple-system, BlinkMacSystemFont, 'Segoe UI', Oxygen, Ubuntu, Cantarell, 'Open Sans', 'Helvetica Neue', sans-serif;
          text-transform: uppercase;
          color: white;
          margin-top: 12px;
          text-align: center;
        }

        &-third{
          color: white;
          font-size: 8px;
          font-family: 'Avenir', -apple-system, BlinkMacSystemFont, 'Segoe UI', Oxygen, Ubuntu, Cantarell, 'Open Sans', 'Helvetica Neue', sans-serif;
          font-weight: 800;
          text-align: center;

          display: grid;
          grid-template-columns: 25% 58%;
        }

        &-price {
          color: white;
          font-size: 8px;
          margin-top: 12px;
          font-family: 'Avenir', -apple-system, BlinkMacSystemFont, 'Segoe UI', Oxygen, Ubuntu, Cantarell, 'Open Sans', 'Helvetica Neue', sans-serif;
          font-weight: 800;
          text-align: center;
        }

      }

    }
  }
</style>
