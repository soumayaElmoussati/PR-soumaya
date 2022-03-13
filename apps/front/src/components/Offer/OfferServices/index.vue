<template>
  <div class="offer-services">
    <h2 class="content-title">
      {{ $t("offer.titles.service") }}
    </h2>
    <div class="divider" />
    <div class="offer-services-list">
      <div
        v-for="(service, k) in servicesList"
        :key="k"
        class="service-item"
      >
        <div class="service-item-block">
          <i
            v-if="service.className!='icon-towel'"
            :class="service.className"
            class="agri-animals"
          />
          <i
            v-if="service.className=='icon-towel'"
            :class="service.className"
            class="agri-others"
          />
        </div>
        <span class="service-item-name">
          {{ service.name }} <br>
          <div v-if="service.key == 'breakfast' && getOffer.service.breakfast_price !== 0">
            <i>{{ getOffer.service.breakfast_price / 100 }}€ / {{ $t("offer.infos.people") }}</i>
          </div>
          <div v-if="service.key == 'breakfast' && getOffer.service.breakfast_price === 0">
            <i>Inclus / {{ $t("offer.infos.people") }}</i>
          </div>
          <div v-if="service.key == 'linens' && getOffer.service.linens_price !== 0">
            <i>{{ getOffer.service.linens_price / 100 }}€ / {{ $t("offer.infos.people") }}</i>
          </div>
          <div v-if="service.key == 'linens' && getOffer.service.linens_price === 0">
            <i>Inclus / {{ $t("offer.infos.people") }}</i>
          </div>
          <div v-if="service.key == 'cleaning' && getOffer.service.cleaning_price !== 0">
            <i>{{ getOffer.service.cleaning_price / 100 }}€ / {{ $t("offer.infos.stay") }}</i>
          </div>
          <div v-if="service.key == 'cleaning' && getOffer.service.cleaning_price === 0">
            <i>Inclus / {{ $t("offer.infos.stay") }}</i>
          </div>
          <div v-if="service.key == 'host_table'">
            <i>{{ $t("offer.infos.see") }}</i>
          </div>

        </span>
      </div>
    </div>
  </div>
</template>

<script>
  import { mapGetters } from 'vuex'

  export default {
    name: 'OfferEquiments',
    data () {
      return {
        services: [
          {
            key: 'breakfast',
            name: this.$t('offer.services.breakfast'),
            className: 'icon-breakfast'
          },
          {
            key: 'linens',
            name: this.$t('offer.services.linens'),
            className: 'icon-towel'
          },
          {
            key: 'cleaning',
            name: this.$t('offer.services.cleaning'),
            className: 'icon-clean'
          },
          {
            key: 'host_table',
            name: this.$t('offer.services.host_table'),
            className: 'icon-dish'
          },
          {
            key: 'esprit_ferme',
            name: this.$t('offer.services.esprit_ferme'),
            className: 'icon-esprit-ferme'
          }
        ]
      }
    },
    computed: {
      ...mapGetters([
        'getOffer'
      ]),
      servicesList () {
        return this.services.filter((v) => {
          const serviceObj = this.getOffer.service
          return serviceObj[v.key]
        })
      }
    }
  }
</script>

<style lang="scss" scoped>
  @import "@/assets/scss/_variables.scss";

  .divider {
    height: 1px;
    background-color: rgba(black, 0.3);
    margin-top: 16px;
  }

  .offer-services{
    .content-title {
      text-transform: uppercase;
      color: $agri-green;
      font-size: 21px;
      font-weight: 900;
    }

    &-list{
      display: flex;
      flex-wrap: wrap;
      // margin-left: 15px;

      .service-item{
        display: flex;
        flex-direction: row;
        align-items: center;

        margin-right: 4px;
        width: 160px;
        // margin-bottom: 16px;

        &:last-child{
          margin-right: 0;
        }

        &-block{
          display: flex;
          border-radius: 6px;
          height: 78px;
          width: 78px;
          margin: 0 auto;

          .agri-animals, .agri-others{
            color: $agri-green-light;
            font-size: 42px;
            margin: auto;
          }
        }

        &-name{
          color: $agri-green;
          font-size: 12px;
          text-align: left;
          width: 100%;
          font-weight: bold;
        }
      }
    }
  }
</style>
