<template>
  <div class="offer-card">
    <div class="card-farm">
      <img
        :src="heart"
        class="coup-de-coeur"
        alt="coupdecoeur" >
      <div class="img-details">
        <!-- <img
        src="https://hips.hearstapps.com/hmg-prod.s3.amazonaws.com/images/bedroom-ideas-rds-work-queens-road-08-1593114639.jpg"
        alt=""
      > -->
        <!-- <cloudinary
          v-if="offer.pictures.length"
          :public-id="offer.pictures[0].public_id"
          :itemkey="offer.id.toString()"
          :transformations="{
            w: 430,
            h: 270,
            c: 'fill',
            f: 'jpg',
            fl: 'progressive'
          }"
          :alt="offer.name"
        /> -->
        <img
          :src="cardPhoto"
          alt="" >
        <!-- <div v-else class="offer-card-image__empty">
          <span>
            {{ $t("offer.titles.no_images") }}
          </span>
        </div> -->
        <div class="name-equipment">
          <div class="farm-name">
            <div class="name">
              <!-- {{ offer.name }} -->
              {{ $t("conceptTiny.titles.test") }}
            </div>
            <div class="farm-equipment">
              <i class="fas fa-wifi" />
            </div>
            <!-- Traduction des exploitations -->
            <div class="farm-type-mobile">
              <div class="exploitation-type">
                {{ $t("conceptTiny.exploitationTypes.agroforestry") }}
              </div>
              <!-- <div
                v-if="farmType(offer.farm_types)[0] == 'agroforestry'"
                class="exploitation-type"
              >
                Agroforesterie
              </div>
              <div
                v-if="farmType(offer.farm_types)[0] == 'arborist'"
                class="exploitation-type"
              >
                Arboriste
              </div>
              <div
                v-if="farmType(offer.farm_types)[0] == 'beekeeper'"
                class="exploitation-type"
              >
                Apiculteur
              </div>
              <div
                v-if="farmType(offer.farm_types)[0] == 'breeder'"
                class="exploitation-type"
              >
                Eleveur
              </div>
              <div
                v-if="farmType(offer.farm_types)[0] == 'brewer'"
                class="exploitation-type"
              >
                Brasseur
              </div>
              <div
                v-if="farmType(offer.farm_types)[0] == 'cereal'"
                class="exploitation-type"
              >
                Céréalier
              </div>
              <div
                v-if="farmType(offer.farm_types)[0] == 'cheese_production'"
                class="exploitation-type"
              >
                Production de fromage
              </div>
              <div
                v-if="farmType(offer.farm_types)[0] == 'cider_maker'"
                class="exploitation-type"
              >
                Cidriculteur
              </div>
              <div
                v-if="farmType(offer.farm_types)[0] == 'horticulturist'"
                class="exploitation-type"
              >
                Horticulteur
              </div>
              <div
                v-if="farmType(offer.farm_types)[0] == 'market_gardener'"
                class="exploitation-type"
              >
                Maraicher
              </div>
              <div
                v-if="farmType(offer.farm_types)[0] == 'mushroom_grower'"
                class="exploitation-type"
              >
                Myciculture
              </div>
              <div
                v-if="farmType(offer.farm_types)[0] == 'oyster_farmer'"
                class="exploitation-type"
              >
                Ostréiculteur
              </div>
              <div
                v-if="farmType(offer.farm_types)[0] == 'riding_stable'"
                class="exploitation-type"
              >
                Centre Equestre
              </div>
              <div
                v-if="farmType(offer.farm_types)[0] == 'winegrower'"
                class="exploitation-type"
              >
                Viticulteur
              </div> -->
            </div>
            <!-- END -->
          </div>
          <div class="price">
            <div class="total">
              <p>
                {{ $t("search.card.from") }}
                <!-- <span>{{ offer.price_per_person | currency }}</span -->
                150 €{{ $t("search.card.per_night") }}
              </p>
            </div>
          </div>
        </div>
      </div>
      <div class="details-activity">
        <div class="title">
          <!-- {{ residenceType }} -->
          {{ $t("conceptTiny.titles.tiny") }}
        </div>
        <div class="location">
          <img
            :src="mark"
            alt="location" >
          <!-- {{ offer.address.city }} -->
          {{ $t("conceptTiny.cities.lyon") }}
        </div>
        <div class="number-pers">
          <img
            :src="persons"
            alt="persons" >
          <!-- {{
            $tc("search.card.people", offer.people_count, {
              number: offer.people_count
            })
          }} -->
          5
        </div>
        <div class="number-rooms">
          <img
            :src="bed"
            alt="bed" >
          <!-- {{
            $tc("search.card.rooms", offer.sleeps_count, {
              number: offer.sleeps_count
            })
          }} -->
          2
        </div>
        <div class="number-bathrooms">
          <img
            :src="bathtub"
            alt="" >

          <!-- {{
            $tc("search.card.bathrooms", offer.bathrooms_count, {
              number: offer.bathrooms_count
            })
          }} -->
          1
        </div>
        <div class="line-separate" />
        <!-- Traduction des exploitations -->
        <div class="farm-type">
          <div class="exploitation-type">
            {{ $t("conceptTiny.exploitationTypes.arborist") }}
          </div>
          <!-- <div
            v-if="farmType(offer.farm_types)[0] == 'agroforestry'"
            class="exploitation-type"
          >
            Agroforesterie
          </div>
          <div
            v-if="farmType(offer.farm_types)[0] == 'arborist'"
            class="exploitation-type"
          >
            Arboriste
          </div>
          <div
            v-if="farmType(offer.farm_types)[0] == 'beekeeper'"
            class="exploitation-type"
          >
            Apiculteur
          </div>
          <div
            v-if="farmType(offer.farm_types)[0] == 'breeder'"
            class="exploitation-type"
          >
            Eleveur
          </div>
          <div
            v-if="farmType(offer.farm_types)[0] == 'brewer'"
            class="exploitation-type"
          >
            Brasseur
          </div>
          <div
            v-if="farmType(offer.farm_types)[0] == 'cereal'"
            class="exploitation-type"
          >
            Céréalier
          </div>
          <div
            v-if="farmType(offer.farm_types)[0] == 'cheese_production'"
            class="exploitation-type"
          >
            Production de fromage
          </div>
          <div
            v-if="farmType(offer.farm_types)[0] == 'cider_maker'"
            class="exploitation-type"
          >
            Cidriculteur
          </div>
          <div
            v-if="farmType(offer.farm_types)[0] == 'horticulturist'"
            class="exploitation-type"
          >
            Horticulteur
          </div>
          <div
            v-if="farmType(offer.farm_types)[0] == 'market_gardener'"
            class="exploitation-type"
          >
            Maraicher
          </div>
          <div
            v-if="farmType(offer.farm_types)[0] == 'mushroom_grower'"
            class="exploitation-type"
          >
            Myciculture
          </div>
          <div
            v-if="farmType(offer.farm_types)[0] == 'oyster_farmer'"
            class="exploitation-type"
          >
            Ostréiculteur
          </div>
          <div
            v-if="farmType(offer.farm_types)[0] == 'riding_stable'"
            class="exploitation-type"
          >
            Centre Equestre
          </div>
          <div
            v-if="farmType(offer.farm_types)[0] == 'winegrower'"
            class="exploitation-type"
          >
            Viticulteur
          </div> -->
        </div>
        <!-- END -->
        <!-- Traduction des agricultures -->
        <div class="agri-type">
          <div class="agriculture-type">
            {{ $t("conceptTiny.agricultureType.bio") }}
          </div>
          <!-- <div
            v-if="agriType(offer.agriculture_types)[0] == 'agroecological'"
            class="agriculture-type"
          >
            Agroécologie
          </div>
          <div
            v-if="agriType(offer.agriculture_types)[0] == 'agroecology'"
            class="agriculture-type"
          >
            Agroécologie
          </div>
          <div
            v-if="agriType(offer.agriculture_types)[0] == 'biological'"
            class="agriculture-type"
          >
            Bio
          </div>
          <div
            v-if="agriType(offer.agriculture_types)[0] == 'conventional'"
            class="agriculture-type"
          >
            Conventionnel
          </div>
          <div
            v-if="agriType(offer.agriculture_types)[0] == 'durable'"
            class="agriculture-type"
          >
            Durable
          </div>
          <div
            v-if="agriType(offer.agriculture_types)[0] == 'hydroponics'"
            class="agriculture-type"
          >
            Hydroponie
          </div>
          <div
            v-if="agriType(offer.agriculture_types)[0] == 'permaculture'"
            class="agriculture-type"
          >
            Permaculture
          </div>
          <div
            v-if="agriType(offer.agriculture_types)[0] == 'reliability'"
            class="agriculture-type"
          >
            Conventionnel
          </div>
          <div
            v-if="agriType(offer.agriculture_types)[0] == 'ringing'"
            class="agriculture-type"
          >
            Raisonné
          </div> -->
          <!-- END -->
        </div>

        <div class="img">
          <div class="activities">
            <!-- <i class="fas fa-shoe-prints" />
              <i class="fas fa-skiing-nordic" /> -->
            <!-- <div v-for="icon in thirdIcon" :key="icon" class="show-activities"> -->
            <div class="show-activities">
              <i class="agri-others2 icon-cow-milking" />
              <i class="agri-others2 icon-bird-in-broken-egg" />
            </div>
            <!-- <i
                :class="'agri-others2' + ' ' + icon"
                aria-hidden="true"
                style="font-size: 20px"
              /> -->
          </div>
          <!-- <i
              v-if="!showIcons && lastIcons.length !== 0"
              class="fas fa-ellipsis-h"
              style="z-index: 1000; position: relative"
            /> -->
          <!-- <div v-for="icon in lastIcons" :key="icon">
              <i
                v-if="showIcons"
                :class="'agri-others2' + ' ' + icon"
                aria-hidden="true"
                style="font-size: 20px"
                class="hidden-activities"
              />
            </div> -->
        </div>
        <div class="animals">
          <!-- <div
              v-for="animal in thirdAnimals"
              :key="animal"
              class="show-animals"
            > -->
          <div class="show-animals">
            <i class="agri-animals icon-cow" />
            <i class="agri-animals icon-goat" />
            <!-- <i :class="animal" /> -->
          </div>
          <!-- <i
              v-if="!showIconsAnimals && lastAnimals.length !== 0"
              class="fas fa-ellipsis-h"
              style="z-index: 1000; position: relative"
            /> -->
          <!-- <div v-for="icon in lastAnimals" :key="icon">
              <i v-if="showIconsAnimals" :class="icon" aria-hidden="true" />
            </div> -->
        </div>
        <div class="price-mobile">
          <div class="total">
            <p>
              <!-- {{ $t("search.card.from") }}
                <span>{{ offer.price_per_person | currency }}</span
                >{{ $t("search.card.per_night") }} -->
              150
            </p>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import cardPhoto from '@/assets/img/homeTiny/photoCard.png'
import heart from '@/assets/img/homeTiny/heart.png'
import persons from '@/assets/img/resultsCards/persons.png'
import bed from '@/assets/img/resultsCards/bed.png'
import bathtub from '@/assets/img/resultsCards/bathtub.png'
import mark from '@/assets/img/resultsCards/location.png'
export default {
  name: 'TinyCards',
  data () {
    return {
      persons,
      bed,
      bathtub,
      cardPhoto,
      mark,
      heart
    }
  }
}
</script>

<style lang="scss" scoped>
@import "@/assets/scss/_variables.scss";
a {
  text-decoration: none;
  margin: 0;
  padding: 0;
}
.offer-card {
  z-index: 1;
  position: relative;
}
.cloudinary {
  width: 430px;
  height: 271px;
  @media only screen and (max-width: $breakpoint-tablet) {
    width: 236px;
    height: 140px;
  }
}
.card-farm {
  display: flex;
  background-color: #476458;
  box-shadow: 1px 1px 5px black;
  width: 625px;
  height: 346px;
  margin: 0 auto;
  font-family: "Avenir", -apple-system, BlinkMacSystemFont, "Segoe UI", Oxygen,
    Ubuntu, Cantarell, "Open Sans", "Helvetica Neue", sans-serif;
  z-index: 1;
  margin-top: 7px;
  @media only screen and (max-width: $breakpoint-tablet) {
    width: 200px;
    height: 35%;
  }
  .coup-de-coeur {
    width: 39px;
    height: 39px;
    position: absolute;
    margin-left: 400px;
  }
  .img-details {
    img {
      width: 439px;
      height: 271px;
      @media only screen and (max-width: $breakpoint-tablet) {
        flex-direction: column;
      }
    }
    .offer-card-image__empty {
      background-color: lighten(#d1d1d1, 10%);
      width: 430px;
      height: 270px;
      display: flex;
      justify-content: center;
      align-items: center;
      color: rgba(black, 0.5);
      margin: auto;
      @media only screen and (max-width: $breakpoint-tablet) {
        width: 236px;
        height: 140px;
      }
    }
    .name-equipment {
      display: flex;
      justify-content: space-between;
      color: $agri-white;
      margin-top: 25px;
      padding: 5px 0;
      .farm-name {
        .name {
          font-weight: 900;
          font-size: 18px;
          padding: 0 5px;
          font-family: "Avenir", -apple-system, BlinkMacSystemFont, "Segoe UI",
            Oxygen, Ubuntu, Cantarell, "Open Sans", "Helvetica Neue", sans-serif;
          @media only screen and (max-width: $breakpoint-tablet) {
            font-size: 12px;
            padding: 5px 5px;
          }
        }
        .farm-equipment {
          padding: 0 0 0 5px;
          img {
            width: 20px;
            height: 20px;
          }
          @media only screen and (max-width: $breakpoint-tablet) {
            display: none;
            padding: 0 0 0 5px;
          }
        }
        .services-icons {
          display: flex;
          align-items: flex-start;
          font-size: 16px;
          padding: 0 0 3px 5px;
          i {
            margin-right: 12px;
          }
          @media only screen and (max-width: $breakpoint-tablet) {
            display: block;
          }
        }
        .farm-type-mobile {
          display: none;
          @media only screen and (max-width: $breakpoint-tablet) {
            display: block;
            font-size: 14px;
            font-weight: 500;
            padding: 0 5px;
          }
        }
      }
      .price {
        border: 1px solid $agri-white;
        width: 160px;
        border-radius: 23px;
        display: flex;
        justify-content: center;
        .total {
          text-align: center;
          padding-top: 5px;
          @media only screen and (max-width: $breakpoint-tablet) {
            font-size: 14px;
            padding-top: 0;
          }
          span {
            font-weight: 900;
          }
          p {
            margin: auto auto;
            padding: 0;
          }
        }
        @media only screen and (max-width: $breakpoint-tablet) {
          display: none;
        }
      }
      @media only screen and (max-width: $breakpoint-tablet) {
        padding: 0;
        justify-content: start;
        margin-left: 10px;
      }
      @media only screen and (max-width: $breakpoint-laptop-l) {
        padding: 2px 0 5px 0;
        margin: 0;
      }
    }
  }
  .details-activity {
    @media only screen and (max-width: $breakpoint-tablet) {
      /* width: 120px !important; */
    }
    .location,
    .number-rooms,
    .number-bathrooms,
    .line-separate,
    .farm-type,
    .exploitation-type,
    .agri-type {
      @media only screen and (max-width: $breakpoint-tablet) {
        display: none !important;
      }
    }
    color: $agri-white;
    padding: 10px;
    font-weight: 500;
    font-size: 14px;
    line-height: 19px;
    margin: auto auto;
    .title {
      color: $agri-white;
      font-size: 14px;
      font-weight: 900;
      text-align: center;
      padding: 12px;
    }
    .location {
      padding-top: 12px;
      color: $agri-white;
    }
    .number-pers {
      padding-top: 12px;
      color: $agri-white;
      @media only screen and (max-width: $breakpoint-tablet) {
        text-align: center;
      }
      img {
        @media only screen and (max-width: $breakpoint-tablet) {
          display: none;
        }
      }
    }
    .number-rooms {
      padding-top: 12px;
      color: $agri-white;
    }
    .number-bathrooms {
      color: $agri-white;
      padding-top: 12px;
    }
    .line-separate {
      border-bottom: 1px solid $agri-white;
      padding: 3px 0;
      margin: 0 auto;
      width: 108px;
    }
    .farm-type {
      color: $agri-white;
      .exploitation-type {
        padding-top: 12px;
      }
    }
    .agri-type {
      color: $agri-white;
      .agriculture-type {
        padding-top: 12px;
      }
    }
    .img {
      position: relative;
      .activities {
        padding-top: 12px;
        display: flex;
        color: $agri-white !important;
        position: relative;
        .agri-others2::before {
          color: $agri-white !important;
        }
        i {
          width: 23px;
          height: 23px;
          margin-right: 6px;
          font-size: 20px !important;
          @media only screen and (max-width: $breakpoint-tablet) {
            margin: 0;
            font-size: 16px !important;
            margin-right: 3px;
          }
        }
        @media only screen and (max-width: $breakpoint-tablet) {
          padding: 0;
          margin-left: 2px;
        }
      }
      @media only screen and (max-width: $breakpoint-tablet) {
        padding-top: 8px;
        margin-bottom: 2px;
      }
    }
    .animals {
      display: flex;
      font-size: 22px !important;
      i {
        width: 35px;
        height: 35px;
        margin-right: 7px;
        font-size: 20px !important;
        @media only screen and (max-width: $breakpoint-tablet) {
          margin: 0;
          font-size: 16px !important;
          margin-right: 1px;
          padding-left: 3px;
        }
      }
    }
    img {
      margin-right: 10px;
      width: 20px;
      height: 20px;
      color: $agri-white;
    }
    .price-mobile {
      display: none;
      .total {
        text-align: center;
        font-size: 11px;
        p {
          padding: 0 3px 0 3px !important;
        }
      }
      @media only screen and (max-width: $breakpoint-tablet) {
        display: block;
        border: 1px solid $agri-white;
        width: 90px;
        border-radius: 23px;
        margin-top: 10px;
        display: flex;
        justify-content: center;
      }
    }
    @media only screen and (max-width: $breakpoint-tablet) {
      padding: 0;
    }
    @media only screen and (max-width: $breakpoint-laptop-l) {
      margin: 0 auto;
    }
  }
  /* .hidden-activities {
    visibility: hidden;
  } */
  .show-activities {
    visibility: visible;
  }
  @media only screen and (max-width: $breakpoint-laptop-l) {
    width: 625px;
    height: 346px;
  }
  @media only screen and (max-width: $breakpoint-tablet) {
    width: 337px;
    height: 224px;
  }
}
</style>
