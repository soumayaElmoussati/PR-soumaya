<template>
  <nuxt-link
    :to="{
      name: 'Activity',
      params: {
        id: activity.id,
        slug: activity.slug
      }
    }"
    class="offer-card"
    target="_blank"
  >

    <div
      class="offer-card-image"
    >

      <img
        v-if="isMember"
        alt="breton"
        src="@/assets/img/offer/adb-badge.png"
        class="badge-adb"
        width="160"
        height="50">

      <cloudinary
        v-if="activity.pictures.length"
        :public-id="activity.pictures[0].public_id"
        :itemkey="activity.id.toString()"
        :transformations="{
          w: 214,
          h: 260,
          c: 'fill',
          f: 'jpg',
          fl: 'progressive'
        }"
        :alt="activity.name"
      />
      <div
        v-else
        class="offer-card-image__empty"
      >
        <span>
          {{ $t('activity.titles.no_images') }}
        </span>
      </div>

    </div>

    <div class="offer-card-informations">

      <div class="infos-secondary">
        <span class="price">{{ people }}</span> {{ $t('activity.titles.personMax') }}
      </div>

      <div class="infos-title">
        {{ activity.name }}
      </div>

      <div class="infos-price">
        <p>
          {{ $t('activity.paragraphs.from') }} <span class="price">{{ getBasePrice | currency }}</span> {{ $t('activity.titles.for') }} <span class="price">{{ activity.people_count }}</span> {{ $t('activity.titles.personMin') }}
        </p>
      </div>

    </div>

  </nuxt-link>
</template>

<script>
  import Cloudinary from '@/components/Cloudinary'

  export default {
    name: 'ActivityCard',
    components: {
      Cloudinary
    },
    props: {
      activity: {
        type: Object,
        default: null
      }
    },
    computed: {
      getBasePrice () {
        // NOTE: Prix de base de la nuit
        return this.activity.price_per_person
      },
      people () {
        // NOTE: Nombre de personnes de l'offre
        return this.activity.max_people_count
      },
      stateType () {
        switch (this.activity.state) {
        case 'draft':
          return 'Brouillon'
        case 'pending_validation':
          return 'En attente de validation'
        case 'published':
          return 'Publiée'
        }
      },
      isAmbassador () {
        // NOTE: L'Agriculteur est un ambassadeur
        if (this.activity.farmer.user.ambassador === true) {
          return true
        } else {
          return false
        }
      },
      isMember () {
        // NOTE: L'Agriculteur est un membre d'Agriculteur de Bretagne
        if (this.activity.farmer.agriculteur_de_bretagne === true) {
          return true
        } else {
          return false
        }
      }
    }
  }
</script>

<style lang="scss" scoped>
  @import "@/assets/scss/_variables.scss";

  .badge-adb {
    position: absolute;
    margin-left: 14vh;
    margin-top: -3vh;
  }

  .edit-offer {
    background-color: #79BC53;
    width: 30px;
    height: 30px;
    text-align: center;
    border-radius: 100%;
    position: absolute;
  }

  .edit-icon {
    vertical-align: middle;
  }

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
      background-color: $agri-green;
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
