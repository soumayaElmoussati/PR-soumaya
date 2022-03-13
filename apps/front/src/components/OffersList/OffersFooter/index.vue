<template>

  <div class="offers-footer">

    <div class="garanties">
      <h2 class="title">{{ $t('home.guarantees.title') }}</h2>

      <div class="arguments">

        <div class="card">

          <img
            src="@/assets/img/footer/shield.svg"
            class="argument-img"
            alt="sécurité">

          <div class="card-resume">

            <h3 class="catchline">{{ $t('home.guarantees.safety.title') }}</h3>

            <p class="card-text">{{ $t('home.guarantees.safety.description') }}</p>
          </div>

        </div>

        <div class="card">

          <img
            src="@/assets/img/footer/agriculture.svg"
            class="argument-img"
            alt="campagne">

          <div class="card-resume">

            <h3 class="catchline">{{ $t('home.guarantees.moment.title') }}</h3>

            <p class="card-text">{{ $t('home.guarantees.moment.description') }}</p>
          </div>

        </div>

        <div class="card">

          <img
            src="@/assets/img/footer/farmer.svg"
            class="argument-img"
            alt="échange">

          <div class="card-resume">

            <h3 class="catchline">{{ $t('home.guarantees.share.title') }}</h3>

            <p class="card-text">{{ $t('home.guarantees.share.description') }}</p>
          </div>

        </div>

      </div>
    </div>

    <mq-layout mq="md+">

      <!-- <div class="solutions">

        <h3 class="solution-title">Solution de séjours</h3>

        <div class="list-solutions">

          <div class="list-places">

            <ul style="list-style-type:none;">
              <li
                v-for="(region, k) in regions"
                :key="k"
                class="list-elem"
              >
                <a
                  class="list-link"
                  @click="$parent.requestSearch(region.query)"
                  v-text="region.label"
                />
              </li>
            </ul>
          </div>

          <div class="list-types">
            <ul style="list-style-type:none;">
              <li
                v-for="(host, k) in hosts"
                :key="k"
                class="list-elem"
              >
                <a
                  class="list-link"
                  @click="$parent.requestSearch(host.query)"
                  v-text="host.label"
                />
              </li>
            </ul>
          </div>

          <div class="list-gites">
            <ul style="list-style-type:none;">
              <li
                v-for="(stay, k) in stays"
                :key="k"
                class="list-elem"
              >
                <template
                  v-if="stay.target"
                >
                  <nuxt-link
                    :to="stay.target"
                    exact
                    class="list-link"
                    v-text="stay.label"
                  />
                </template>
                <template
                  v-else
                >
                  <a
                    class="list-link"
                    @click="$parent.requestSearch(stay.query)"
                    v-text="stay.label"
                  />
                </template>
              </li>
            </ul>
          </div>
          <div class="list-logements">
            <ul style="list-style-type:none;">
              <li
                v-for="(item, k) in unusual"
                :key="k"
                class="list-elem"
              >
                <a
                  class="list-link"
                  @click="$parent.requestSearch(item.query)"
                  v-text="item.label"
                />
              </li>
            </ul>
          </div>
        </div>
      </div> -->
    </mq-layout>
  </div>
</template>

<script>
  export default {
    name: 'OffersFooter',
    computed: {
      stays () {
        return {
          'offers-lodge': {
            label: 'Séjour en gîte',
            target: { name: 'OffersLodge' }
          },
          'offers-insolit': {
            label: 'Séjour en logement insolite',
            target: { name: 'OffersInsolit' }
          },
          'offers-host': {
            label: 'Séjour en chambre d\'hôte',
            target: { name: 'OffersHost' }
          },
          'offers-bretagne': {
            label: 'Séjour en Bretagne',
            target: { name: 'OffersBretagne' }
          },
          'offers-aquitaine': {
            label: 'Séjour en Aquitaine',
            target: { name: 'OffersAquitaine' }
          },
          'offers-normandie': {
            label: 'Séjour en Normandie',
            target: { name: 'OffersNormandie' }
          },
          l1: {
            label: 'Séjour avec animaux',
            query: {}
          },
          l2: {
            label: 'Séjour avec chevaux',
            query: { animal: 'horse' }
          },
          l3: {
            label: 'Séjour avec vaches',
            query: { animal: 'milk_cow' }
          },
          l4: {
            label: 'Séjour avec poules',
            query: { animal: 'chicken' }
          },
          l5: {
            label: 'Séjour avec chèvres',
            query: { animal: 'goat' }
          },
          l6: {
            label: 'Séjour avec moutons',
            query: { animal: 'sheep' }
          },
          l7: {
            label: 'Séjour en apiculture',
            query: { farm_type: 'beekeeper' }
          },
          l8: {
            label: 'Séjour chez un éleveur',
            query: { farm_type: 'breeder' }
          },
          l9: {
            label: 'Séjour chez un viticulteur',
            query: { farm_type: 'winegrower' }
          },
          l10: {
            label: 'Séjour chez un cidriculteur',
            query: { farm_type: 'cider_maker' }
          },
          l11: {
            label: 'Séjour en centre équestre',
            query: { farm_type: 'riding_stable' }
          },
          l12: {
            label: 'Séjour chez un brasseur',
            query: { farm_type: 'brewer' }
          },
          l13: {
            label: 'Séjour en ferme biologique',
            query: { agriculture_type: 'biological' }
          },
          l14: {
            label: 'Séjour en permaculture',
            query: { agriculture_type: 'permaculture' }
          },
          l15: {
            label: 'Séjour en agroécologie',
            query: { agriculture_type: 'agroecology' }
          },
          l16: {
            label: 'Séjour en agriculture raisonnée',
            query: { agriculture_type: 'ringing' }
          }
        }
      },
      hosts () {
        return {
          l1: {
            label: 'Chambre d\'hôte avec animaux',
            query: {
              residence_type: 'guest_room'
            }
          },
          l2: {
            label: 'Chambre d\'hôte avec chevaux',
            query: {
              residence_type: 'guest_room',
              animal: 'horse'
            }
          },
          l3: {
            label: 'Chambre d\'hôte avec vaches',
            query: {
              residence_type: 'guest_room',
              animal: 'milk_cow'
            }
          },
          l4: {
            label: 'Chambre d\'hôte avec poules',
            query: {
              residence_type: 'guest_room',
              animal: 'chicken'
            }
          },
          l5: {
            label: 'Chambre d\'hôte avec chèvres',
            query: {
              residence_type: 'guest_room',
              animal: 'goat'
            }
          },
          l6: {
            label: 'Chambre d\'hôte avec moutons',
            query: {
              residence_type: 'guest_room',
              animal: 'sheep'
            }
          },
          l7: {
            label: 'Chambre d\'hôte en apiculture',
            query: {
              residence_type: 'guest_room',
              farm_type: 'beekeeper'
            }
          },
          l8: {
            label: 'Chambre d\'hôte chez un éleveur',
            query: {
              residence_type: 'guest_room',
              farm_type: 'breeder'
            }
          },
          l9: {
            label: 'Chambre d\'hôte chez un viticulteur',
            query: {
              residence_type: 'guest_room',
              farm_type: 'winegrower'
            }
          },
          l10: {
            label: 'Chambre d\'hôte chez un cidriculteur',
            query: {
              residence_type: 'guest_room',
              farm_type: 'cider_maker'
            }
          },
          l11: {
            label: 'Chambre d\'hôte en centre équestre',
            query: {
              residence_type: 'guest_room',
              farm_type: 'riding_stable'
            }
          },
          l12: {
            label: 'Chambre d\'hôte chez un brasseur',
            query: {
              residence_type: 'guest_room',
              farm_type: 'brewer'
            }
          },
          l13: {
            label: 'Chambre d\'hôte en ferme biologique',
            query: {
              residence_type: 'guest_room',
              agriculture_type: 'biological'
            }
          },
          l14: {
            label: 'Chambre d\'hôte en permaculture',
            query: {
              residence_type: 'guest_room',
              agriculture_type: 'permaculture'
            }
          },
          l15: {
            label: 'Chambre d\'hôte en agroécologie',
            query: {
              residence_type: 'guest_room',
              agriculture_type: 'agroecology'
            }
          },
          l16: {
            label: 'Chambre d\'hôte en agriculture raisonné',
            query: {
              residence_type: 'guest_room',
              agriculture_type: 'ringing'
            }
          },
          l17: {
            label: 'Chambre d\'hôte en agriculture durable',
            query: {
              residence_type: 'guest_room',
              agriculture_type: 'durable'
            }
          },
          l18: {
            label: 'Chambre d\'hôte en agriculture de préci',
            query: {
              residence_type: 'guest_room',
              agriculture_type: 'reliability'
            }
          },
          l19: {
            label: 'Chambre d\'hôte en agriculture conventi',
            query: {
              residence_type: 'guest_room',
              agriculture_type: 'conventional'
            }
          },
          l20: {
            label: 'Chambre d\'hôte en horticulture',
            query: {
              residence_type: 'guest_room',
              farm_type: 'horticulturist'
            }
          },
          l21: {
            label: 'Chambre d\'hôte chez un maraîcher',
            query: {
              residence_type: 'guest_room',
              farm_type: 'market_gardener'
            }
          },
          l22: {
            label: 'Chambre d\'hôte chez un céréalier',
            query: {
              residence_type: 'guest_room',
              farm_type: 'cereal'
            }
          }
        }
      },
      regions () {
        return {
          l1: {
            label: 'Gîte dans les Alpes-Maritimes',
            query: { area: '06', residence_type: 'entire_house' }
          },
          l2: {
            label: 'Gîte dans les Bouches-du-Rhône',
            query: { residence_type: 'entire_house', area: '13' }
          },
          l3: {
            label: 'Gîte dans le Rhône',
            query: { residence_type: 'entire_house', area: '69' }
          },
          l4: {
            label: 'Gîte dans les Hauts-de-Seine',
            query: { residence_type: 'entire_house', area: '92' }
          },
          l5: {
            label: 'Gîte dans le Val-d’Oise',
            query: { residence_type: 'entire_house', area: '95' }
          },
          l6: {
            label: 'Gîte dans en Gironde',
            query: { residence_type: 'entire_house', area: '33' }
          },
          l7: {
            label: 'Gîte dans le Nord',
            query: { residence_type: 'entire_house', area: '59' }
          },
          l8: {
            label: 'Gîte dans le Bas-Rhin',
            query: { residence_type: 'entire_house', area: '67' }
          },
          l9: {
            label: 'Gîte dans en Haute-Savoie',
            query: { residence_type: 'entire_house', area: '74' }
          },
          l10: {
            label: 'Gîte dans le Val-de-Marne',
            query: { residence_type: 'entire_house', area: '94' }
          },
          l11: {
            label: 'Gîte dans le Calvados',
            query: { residence_type: 'entire_house', area: '14' }
          },
          l12: {
            label: 'Gîte dans l\'Hérault',
            query: { residence_type: 'entire_house', area: '34' }
          },
          l13: {
            label: 'Gîte dans la Côte-d’Or',
            query: { residence_type: 'entire_house', area: '21' }
          },
          l14: {
            label: 'Gîte dans la Haute-Garonne',
            query: { residence_type: 'entire_house', area: '31' }
          },
          l15: {
            label: 'Gîte dans la Loire-Atlantique',
            query: { residence_type: 'entire_house', area: '44' }
          },
          l16: {
            label: 'Gîte dans l\'Ille-et-Vilaine',
            query: { residence_type: 'entire_house', area: '35' }
          },
          l17: {
            label: 'Gîte dans le Var',
            query: { residence_type: 'entire_house', area: '83' }
          },
          l18: {
            label: 'Gîte dans le Haut-Rhin',
            query: { residence_type: 'entire_house', area: '68' }
          },
          l19: {
            label: 'Gîte dans les Yvelines',
            query: { residence_type: 'entire_house', area: '78' }
          },
          l20: {
            label: 'Gîte dans le Pas-de-Calais',
            query: { residence_type: 'entire_house', area: '62' }
          },
          l21: {
            label: 'Gîte dans les Pyrénées-Atlantique',
            query: { residence_type: 'entire_house', area: '64' }
          },
          l22: {
            label: 'Gîte dans la Seine-Maritime',
            query: { residence_type: 'entire_house', area: '76' }
          }
        }
      },
      unusual () {
        return {
          l1: {
            label: 'Logement insolite avec animaux',
            query: { residence_type: 'unusual_room' }
          },
          l2: {
            label: 'Logement insolite avec chevaux',
            query: { residence_type: 'unusual_room', animal: 'horse' }
          },
          l3: {
            label: 'Logement insolite avec vaches',
            query: { residence_type: 'unusual_room', animal: 'milk_cow' }
          },
          l4: {
            label: 'Logement insolite avec poules',
            query: { residence_type: 'unusual_room', animal: 'chicken' }
          },
          l5: {
            label: 'Logement insolite avec chèvres',
            query: { residence_type: 'unusual_room', animal: 'goat' }
          },
          l6: {
            label: 'Logement insolite avec moutons',
            query: { residence_type: 'unusual_room', animal: 'sheep' }
          },
          l7: {
            label: 'Logement insolite en apiculture',
            query: { residence_type: 'unusual_room', farm_type: 'beekeeper' }
          },
          l8: {
            label: 'Logement insolite chez un éleveur',
            query: { residence_type: 'unusual_room', farm_type: 'breeder' }
          },
          l9: {
            label: 'Logement insolite chez un viticulteur',
            query: { residence_type: 'unusual_room', farm_type: 'winegrower' }
          },
          l10: {
            label: 'Logement insolite chez un cidriculteur',
            query: { residence_type: 'unusual_room', farm_type: 'cider_maker' }
          },
          l11: {
            label: 'Logement insolite en centre équestre',
            query: { residence_type: 'unusual_room', farm_type: 'riding_stable' }
          },
          l12: {
            label: 'Logement insolite chez un brasseur',
            query: { residence_type: 'unusual_room', farm_type: 'brewer' }
          },
          l13: {
            label: 'Logement insolite en ferme biologique',
            query: { residence_type: 'unusual_room', agriculture_type: 'biological' }
          },
          l14: {
            label: 'Logement insolite en permaculture',
            query: { residence_type: 'unusual_room', agriculture_type: 'permaculture' }
          },
          l15: {
            label: 'Logement insolite en agroécologie',
            query: { residence_type: 'unusual_room', agriculture_type: 'agroecology' }
          },
          l16: {
            label: 'Logement insolite en agriculture raisonnée',
            query: { residence_type: 'unusual_room', agriculture_type: 'ringing' }
          },
          l17: {
            label: 'Logement insolite en agriculture durable',
            query: { residence_type: 'unusual_room', agriculture_type: 'durable' }
          },
          l18: {
            label: 'Logement insolite en agriculture de précision',
            query: { residence_type: 'unusual_room', agriculture_type: 'reliability' }
          },
          l19: {
            label: 'Logement insolite en agriculture conventionnelle',
            query: { residence_type: 'unusual_room', agriculture_type: 'conventional' }
          },
          l20: {
            label: 'Logement insolite en horticulture',
            query: { residence_type: 'unusual_room', farm_type: 'horticulturist' }
          },
          l21: {
            label: 'Logement insolite chez un maraîcher',
            query: { residence_type: 'unusual_room', farm_type: 'market_gardener' }
          },
          l22: {
            label: 'Logement insolite chez un céréalier',
            query: { residence_type: 'unusual_room', farm_type: 'cereal' }
          }
        }
      }
    }
  }
</script>

<style lang="scss" scoped>
  @import "@/assets/scss/_variables.scss";

  .argument-img {
    width: 95px;
    height: 95px;
    @media only screen and (max-width: $breakpoint-tablet) {
      width: 100%;
    }
  }

  .offers-footer {
    background-color: #F6F6F6;

    .garanties {
      width: 80%;
      margin: 0 auto;

      .title {
        color: $agri-green;
        text-transform: uppercase;
        font-weight: bold;
        font-size: 25px;
        font-family: 'Avenir', -apple-system, BlinkMacSystemFont, 'Segoe UI', Oxygen, Ubuntu, Cantarell, 'Open Sans', 'Helvetica Neue', sans-serif;
        text-align: center;
        padding-top: 100px;
        padding-bottom: 50px;
        @media only screen and (max-width: $breakpoint-tablet-l) {
          padding-top: 2%;
        }
      }

      .arguments {
        display: grid;
        grid-template-columns: repeat(3, 1fr);
        grid-gap: 16px;
        padding-bottom: 100px;

        @media only screen and (max-width: $breakpoint-tablet) {
          grid-template-columns: repeat(1, 1fr);
        }

        .card {
          display: grid;
          grid-template-columns: 96px auto;
          grid-gap: 9px;
          @media only screen and (max-width: $breakpoint-tablet) {
            grid-template-columns: repeat(1, 1fr);
            width: 100%;
            text-align: center;
          }

          .card-resume {
            display: flex;
            flex-direction: column;
            color: $agri-green;
            font-family: 'Avenir', -apple-system, BlinkMacSystemFont, 'Segoe UI', Oxygen, Ubuntu, Cantarell, 'Open Sans', 'Helvetica Neue', sans-serif;

            .catchline {
              text-transform: uppercase;
              font-weight: bold;
              font-size: 13px;
            }

            .card-text {
              font-size: 13px;
            }
          }
        }
      }
    }

    .solutions {
      padding-bottom: 100px;
      margin-left: 75px;
      margin-right: 75px;
      background-image: url(~assets/img/joinus/background.svg);
      background-position: center;
      // background-repeat: no-repeat;
      // background-size: 1200px 970px;

      .list-solutions {
        display: grid;
        grid-template-columns: 25% 25% 25% 25%;
        @media only screen and (max-width: 700px) {
          grid-template-columns: 100%;
        }
      }

      .list-elem {
        margin-bottom: 6px;
      }

      .list-link {
        color: $agri-green;
        text-decoration: none;
        font-size: 13px;
        font-family: 'Avenir', -apple-system, BlinkMacSystemFont, 'Segoe UI', Oxygen, Ubuntu, Cantarell, 'Open Sans', 'Helvetica Neue', sans-serif;

      }

      .solution-title {
        font-size: 26px;
        font-weight: 800;
        color: $agri-green;
        font-family: 'Avenir', -apple-system, BlinkMacSystemFont, 'Segoe UI', Oxygen, Ubuntu, Cantarell, 'Open Sans', 'Helvetica Neue', sans-serif;
        text-transform: uppercase;
        text-align: center;

        margin-bottom: 75px;
        @media only screen and (max-width: 700px) {
          margin-left: 0%;
          width: 100%;
        }
      }

    }

  }

</style>
