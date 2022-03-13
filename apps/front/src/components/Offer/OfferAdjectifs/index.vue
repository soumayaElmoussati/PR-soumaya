<template>
  <div class="offer-equipments">

    <div class="offer-equipments-list">
      <div
        v-for="(adjectif, k) in adjectifsList"
        :key="k"
        class="equipment-item"
      >
        <span class="equipment-item-name">
          #{{ adjectif.name }}
        </span>
      </div>
    </div>
  </div>
</template>

<script>
  import { mapGetters } from 'vuex'

  export default {
    name: 'OfferAdjectifs',
    data () {
      return {
        adjectifs: [
          {
            key: 'rustic',
            name: this.$t('offer.adjectifs.rustic'),
            className: 'adjectif'
          },
          {
            key: 'luxurious',
            name: this.$t('offer.adjectifs.luxurious'),
            className: 'adjectif'
          },
          {
            key: 'confortable',
            name: this.$t('offer.adjectifs.confortable'),
            className: 'adjectif'
          },
          {
            key: 'clean',
            name: this.$t('offer.adjectifs.clean'),
            className: 'adjectif'
          },
          {
            key: 'friendly',
            name: this.$t('offer.adjectifs.friendly'),
            className: 'adjectif'
          },
          {
            key: 'calm',
            name: this.$t('offer.adjectifs.calm'),
            className: 'adjectif'
          },
          {
            key: 'exotic',
            name: this.$t('offer.adjectifs.exotic'),
            className: 'adjectif'
          },
          {
            key: 'romantic',
            name: this.$t('offer.adjectifs.romantic'),
            className: 'adjectif'
          },
          {
            key: 'cheap',
            name: this.$t('offer.adjectifs.cheap'),
            className: 'adjectif'
          },
          {
            key: 'insolit',
            name: this.$t('offer.adjectifs.insolit'),
            className: 'adjectif'
          },
          {
            key: 'simple',
            name: this.$t('offer.adjectifs.simple'),
            className: 'adjectif'
          },
          {
            key: 'luminous',
            name: this.$t('offer.adjectifs.luminous'),
            className: 'adjectif'
          }
        ]
      }
    },
    computed: {
      ...mapGetters([
        'getOffer'
      ]),
      adjectifsList () {
        return this.adjectifs.filter((v) => {
          const adjectifObj = this.getOffer.adjectif
          return adjectifObj[v.key]
        })
      }
    }
  }
</script>

<style lang="scss" scoped>
  @import "@/assets/scss/_variables.scss";

  .offer-equipments{

    h2{
      font-size: 20px;
      font-weight: 400;
      color: $primary-text;
    }

    &-title {
      width: 100%;
      text-transform: uppercase;
      margin-bottom: 5px;
    }

    &-list{
      display: flex;
      flex-wrap: wrap;

      .equipment-item{
        display: flex;
        flex-direction: row;
        align-items: center;

        margin-right: 10px;
        margin-bottom: 10px;

        border-right: 1px solid #79BC53;
        border-radius: 50px;

        background-color: #79BC53;

        padding: 5px 10px;

        &:last-child{
          margin-right: 0;
        }

        &-name{
          color: white;
          font-size: 12px;
          text-align: left;
          width: 100%;
          font-family: 'Avenir', -apple-system, BlinkMacSystemFont, 'Segoe UI', Oxygen, Ubuntu, Cantarell, 'Open Sans', 'Helvetica Neue', sans-serif;
        }
      }
    }
  }
</style>
