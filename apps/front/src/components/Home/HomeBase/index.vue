<template>
  <div
    id="wrap-foot"
    class="wrapper_footer">
    <div class="wrapper1">
      <div class="wrap-content1">
        <div class="content1">
          <h2 class="f_subtitle xl-hide" />

          <div v-if="$ua.browser() === 'Safari'">
            <img
              src="@/assets/img/forest/safari.png"
              class="safari-picture"
              title="safari"
              alt="safari"
            >
          </div>
          <div v-else>
            <div class="video-box">
              <video
                width="400"
                class="introducing-video"
                controls>
                <source
                  src="~assets/video/tf1.mp4"
                  type="video/mp4" >
              </video>
            </div>
          </div>
        </div>

        <div class="content2">
          <h2 class="f_subtitle xs-hide">{{ $t("home.base.sub_title") }}</h2>
          <p class="f_text video-text">
            {{ $t("home.base.about_agrivillage")[0] }} <br >
            {{ $t("home.base.about_agrivillage")[1] }} <br >
            {{ $t("home.base.about_agrivillage")[2] }} <br >
            {{ $t("home.base.about_agrivillage")[3] }}

            <a
              href="https://www.agrivillage.fr/sejour-agritourisme"
              target="_blank"
              class="btn btn-blog"
            >
              {{ $t("home.base.about") }}
            </a>
          </p>
        </div>
      </div>
    </div>

    <div class="wrapper-housing">
      <div class="wrap-content2">
        <div class="f_title">
          <div class="housing_content">
            <h2 class="type-title">{{ $t("home.housing.title") }}</h2>
            <p class="category-resume">
              {{ $t("home.housing.sub_title") }} <br >
              {{ $t("home.housing.description")[0] }} <br >
              {{ $t("home.housing.description")[1] }}
            </p>
          </div>
          <img
            :src="corn"
            alt="corn"
            class="icones_png" >
        </div>
        <div class="content">
          <div
            class="type-card4"
            @click="$parent.submittedcard('tinyHouse')">
            <!-- <img
              src="~assets/img/housing/guestroom.png"
              alt="chambre"
              title="chambre"
              class="card-image card-housing"
            > -->

            <p>{{ $t("home.housing.tiny_house") }}</p>
          </div>
          <div
            class="type-card1"
            @click="$parent.submittedcard('entier')">
            <!-- <img
              src="~assets/img/housing/full.png"
              alt="gîte"
              title="gîte"
              class="card-image card-housing"
            > -->
            <p class="title">{{ $t("home.housing.entire_house") }} </p>

            <!-- <p>{{ $t("home.housing.entire_house") }}</p> -->
          </div>

          <div
            class="type-card2"
            @click="$parent.submittedcard('insolite')">
            <!-- <img
              src="~assets/img/housing/insolite.png"
              alt="insolite"
              title="insolite"
              class="card-image card-housing"
            > -->

            <p>{{ $t("home.housing.insolit") }}</p>
          </div>

          <div
            class="type-card3"
            @click="$parent.submittedcard('hote')">
            <!-- <img
              src="~assets/img/housing/guestroom.png"
              alt="chambre"
              title="chambre"
              class="card-image card-housing"
            > -->

            <p>{{ $t("home.housing.host_room") }}</p>
          </div>
        </div>
      </div>

      <!-- <vueper-slides
        :visible-slides="3"
        :gap="3"
        :slide-ratio="1 / 4"
        :dragging-distance="200"
        :breakpoints="{ 800: { visibleSlides: 1, slideMultiple: 1 } }"
        :bullets="false"
        style="margin-bottom: 35px"
        arrows-outside
        fixed-height="360px"
        class="no-shadow"
        slide-multiple
      >
        <template v-slot:arrow-left>
          <i
            class="fas fa-arrow-circle-left"
            style="color: rgb(71, 100, 88); font-size: 45px"
          />
        </template>

        <template v-slot:arrow-right>
          <i
            class="fas fa-arrow-circle-right"
            style="color: rgb(71, 100, 88); font-size: 45px"
          />
        </template>
        <vueper-slide
          v-for="(slide, i) in housings"
          :key="i"
          :title="slide.title"
          @click.native="$parent.submittedcard(slide.link)"
        >
          <template v-slot:content>
            <div
              :style="
                'background-image: url(' +
                  slide.image +
                  '); background-size: cover; border-radius: 31px !important; width: 225px;'
              "
              class="vueperslide__content-wrapper"
            >
              <div
                style="font-size: 20px; line-height: 27px; font-weight: 900; color: white !important; font-size: 22px; position: absolute; bottom: 0; background-color: rgb(71, 100, 88); opacity: 1 !important; width: 225px; border-radius: 0 0 35px 35px; padding: 25px 0; text-transform: uppercase; font-family: 'Avenir', -apple-system, BlinkMacSystemFont, 'Segoe UI', Oxygen, Ubuntu, Cantarell, 'Open Sans', 'Helvetica Neue', sans-serif;"
                class="vueperslide__title"
              >
                {{ slide.title }}
              </div>
            </div>
          </template>
        </vueper-slide>
      </vueper-slides> -->
    </div>

    <div class="wrapper-types">
      <div class="wrap-content2">
        <div class="f_title">
          <div class="farming-type">
            <h2 class="type-title">{{ $t("home.farming_type.title") }}</h2>
            <p class="category-resume">
              {{ $t("home.farming_type.description")[0] }} <br >
              {{ $t("home.farming_type.description")[1] }} <br >
              {{ $t("home.farming_type.sub_description")[0] }} <br >
              <!-- {{ $t("home.farming_type.sub_description")[1] }} <br > -->
            </p>
          </div>
          <img
            :src="bee"
            alt="bee"
            class="icones_png" >
        </div>
        <div class="content agricultures-cards">
          <div
            class="type-card-act1"
            @click="$parent.submittedcard('elevage')">
            <!-- <img
              src="~assets/img/agriculture/eleveur.png"
              alt="élevage"
              title="élevage"
              class="card-image"
            > -->

            <p>{{ $t("home.farming_type.breeding") }}</p>
          </div>

          <div
            class="type-card-act2"
            @click="$parent.submittedcard('viticulture')"
          >
            <!-- <img
              src="~assets/img/agriculture/viticulture.png"
              alt="viticulture"
              title="viticulture"
              class="card-image"
            > -->

            <p>{{ $t("home.farming_type.viticulture") }}</p>
          </div>

          <div
            class="type-card-act3"
            @click="$parent.submittedcard('apiculture')"
          >
            <!-- <img
              src="~assets/img/agriculture/apiculture.png"
              alt="apiculture"
              title="apiculture"
              class="card-image"
            > -->

            <p>{{ $t("home.farming_type.apiculture") }}</p>
          </div>

          <div
            class="type-card-act4"
            @click="$parent.submittedcard('biologique')"
          >
            <!-- <img
              src="~assets/img/agriculture/bio.png"
              alt="biologique"
              title="biologique"
              class="card-image"
            > -->

            <p>{{ $t("home.farming_type.bio") }}</p>
          </div>
        </div>
      </div>

      <!-- <vueper-slides
        :visible-slides="3"
        :gap="3"
        :slide-ratio="1 / 4"
        :dragging-distance="200"
        :breakpoints="{ 800: { visibleSlides: 1, slideMultiple: 1 } }"
        :bullets="false"
        style="margin-bottom: 35px"
        arrows-outside
        fixed-height="360px"
        class="no-shadow"
        slide-multiple
      >
        <template v-slot:arrow-left>
          <i
            class="fas fa-arrow-circle-left"
            style="color: rgb(71, 100, 88); font-size: 45px"
          />
        </template>

        <template v-slot:arrow-right>
          <i
            class="fas fa-arrow-circle-right"
            style="color: rgb(71, 100, 88); font-size: 45px"
          />
        </template>
        <vueper-slide
          v-for="(slide, i) in agricultures"
          :key="i"
          :title="slide.title"
          @click.native="$parent.submittedcard(slide.link)"
        >
          <template v-slot:content>
            <div
              :style="
                'background-image: url(' +
                  slide.image +
                  '); background-size: cover; border-radius: 31px !important; width: 225px;'
              "
              class="vueperslide__content-wrapper"
            >
              <div
                style="font-size: 20px; line-height: 27px; font-weight: 900; color: white !important; font-size: 22px; position: absolute; bottom: 0; background-color: rgb(71, 100, 88); opacity: 1 !important; width: 225px; border-radius: 0 0 35px 35px; padding: 25px 0; text-transform: uppercase; font-family: 'Avenir', -apple-system, BlinkMacSystemFont, 'Segoe UI', Oxygen, Ubuntu, Cantarell, 'Open Sans', 'Helvetica Neue', sans-serif;"
                class="vueperslide__title"
              >
                {{ slide.title }}
              </div>
            </div>
          </template>
        </vueper-slide>
      </vueper-slides> -->
    </div>

    <div
      id="second"
      class="wrapper-types">
      <div class="wrap-content2">
        <div class="f_title">
          <div class="animal_content">
            <h2 class="type-title">{{ $t("home.animals.title") }}</h2>
            <p class="category-resume">
              {{ $t("home.animals.description")[0] }} <br >
              {{ $t("home.animals.description")[1] }} <br >
              {{ $t("home.animals.sub_description")[0] }} <br >
              {{ $t("home.animals.sub_description")[1] }}
            </p>
          </div>
          <img
            :src="cow"
            alt="cow"
            class="icones_png" >
        </div>
        <div class="content animals-cards">
          <div
            class="type-card-animal1"
            @click="$parent.submittedcard('chevre')"
          >
            <!-- <img
              src="~assets/img/animals/chevres.png"
              alt="chèvres"
              title="chèvres"
              class="card-image"
            > -->

            <p>{{ $t("home.animals.goats") }}</p>
          </div>

          <div
            class="type-card-animal2"
            @click="$parent.submittedcard('mouton')"
          >
            <!-- <img
              src="~assets/img/animals/moutons.png"
              alt="moutons"
              title="moutons"
              class="card-image"
            > -->

            <p>{{ $t("home.animals.sheeps") }}</p>
          </div>

          <div
            class="type-card-animal3"
            @click="$parent.submittedcard('vache')"
          >
            <!-- <img
              src="~assets/img/animals/vaches.png"
              alt="vaches"
              title="vaches"
              class="card-image"
            > -->

            <p>{{ $t("home.animals.cows") }}</p>
          </div>

          <div
            class="type-card-animal4"
            @click="$parent.submittedcard('cheval')"
          >
            <!-- <img
              src="~assets/img/animals/chevaux.png"
              alt="chevaux"
              title="chevaux"
              class="card-image"
            > -->

            <p>{{ $t("home.animals.horses") }}</p>
          </div>
        </div>
      </div>

      <!-- <vueper-slides
        :visible-slides="3"
        :gap="3"
        :slide-ratio="1 / 4"
        :dragging-distance="200"
        :breakpoints="{ 800: { visibleSlides: 1, slideMultiple: 1 } }"
        :bullets="false"
        style="margin-bottom: 35px"
        arrows-outside
        fixed-height="360px"
        class="no-shadow"
        slide-multiple
      >
        <template v-slot:arrow-left>
          <i
            class="fas fa-arrow-circle-left"
            style="color: rgb(71, 100, 88); font-size: 45px"
          />
        </template>

        <template v-slot:arrow-right>
          <i
            class="fas fa-arrow-circle-right"
            style="color: rgb(71, 100, 88); font-size: 45px"
          />
        </template>

        <vueper-slide
          v-for="(slide, i) in animals"
          :key="i"
          :title="slide.title"
          @click.native="$parent.submittedcard(slide.link)"
        >
          <template v-slot:content>
            <div
              :style="
                'background-image: url(' +
                  slide.image +
                  '); background-size: cover; border-radius: 31px !important; width: 225px;'
              "
              class="vueperslide__content-wrapper"
            >
              <div
                style="font-size: 20px; line-height: 27px; font-weight: 900; color: white !important; font-size: 22px; position: absolute; bottom: 0; background-color: rgb(71, 100, 88); opacity: 1 !important; width: 225px; border-radius: 0 0 35px 35px; padding: 25px 0; text-transform: uppercase; font-family: 'Avenir', -apple-system, BlinkMacSystemFont, 'Segoe UI', Oxygen, Ubuntu, Cantarell, 'Open Sans', 'Helvetica Neue', sans-serif;"
                class="vueperslide__title"
              >
                {{ slide.title }}
              </div>
            </div>
          </template>
        </vueper-slide>
      </vueper-slides> -->
    </div>

    <div class="wrapper2 testimonial-section">
      <div class="f_title">
        <h3 class="type-title">{{ $t("home.testimonials.title") }}</h3>
        <img
          :src="tractor"
          alt="tractor"
          class="icones_png"
          style="padding-top: 0 !important"
        >
      </div>

      <div class="testimonial-content">
        <div class="content-card">
          <div class="card-images">
            <div class="main">
              <img
                src="~assets/img/testimonial/tourist.png"
                alt="touriste"
                title="touriste"
                class="image"
              >
            </div>
          </div>
          <h4 class="tourist-desc">
            {{ $t("home.testimonials.client.name") }} <br >{{
              $t("home.testimonials.client.title")
            }}
          </h4>
          <p class="f_text testimonial-desc">
            {{ $t("home.testimonials.client.description") }}
            <!-- {{ $t("home.testimonials.client.description")[0] }}<br >
            {{ $t("home.testimonials.client.description")[1] }}<br >
            {{ $t("home.testimonials.client.description")[2] }}
            {{ $t("home.testimonials.client.description")[3] }} -->
          </p>
        </div>
        <div class="content-card">
          <div class="card-images">
            <div class="main">
              <img
                src="~assets/img/testimonial/fermier.png"
                alt="hôte"
                title="hôte"
                class="image"
              >
            </div>
          </div>

          <h4 class="tourist-desc">
            {{ $t("home.testimonials.farmer.name") }} <br >{{
              $t("home.testimonials.farmer.title")
            }}
          </h4>

          <p class="f_text testimonial-desc">
            {{ $t("home.testimonials.farmer.description") }}
            <!-- {{ $t("home.testimonials.farmer.description")[0] }} <br >
            {{ $t("home.testimonials.farmer.description")[1] }} <br >
            {{ $t("home.testimonials.farmer.description")[2] }} -->
          </p>
        </div>
      </div>

      <a
        href="https://www.agrivillage.fr/offer/824/Tiny%20House/TinyHouseCabriole"
        target="_blank"
        class="btn farm-btn"
      >
        {{ $t("home.testimonials.farm_link") }}
      </a>
    </div>
  </div>
</template>

<script>
import { VueperSlides, VueperSlide } from 'vueperslides'
import 'vueperslides/dist/vueperslides.css'
import corn from '../../../assets/img/icones/corn.png'
import bee from '../../../assets/img/icones/bee.png'
import cow from '../../../assets/img/icones/cow.png'
import tractor from '../../../assets/img/icones/tractor.png'
export default {
  name: 'HomeBase',
  components: { VueperSlides, VueperSlide },
  data: () => ({
    corn,
    bee,
    cow,
    tractor,
    housings: [
      {
        title: 'Tiny House',
        link: 'tinyHouse',
        image: require('@/assets/img/housing/tiny.png')
      },
      {
        title: 'Logement entier',
        link: 'entier',
        image: require('@/assets/img/housing/full.png')
      },
      {
        title: 'Logement insolite',
        link: 'insolite',
        image: require('@/assets/img/housing/insolite.png')
      },
      {
        title: "Chambre d'hote",
        link: 'hote',
        image: require('@/assets/img/housing/guestroom.png')
      }
    ],
    agricultures: [
      {
        title: 'Élevage',
        link: 'elevage',
        image: require('@/assets/img/agriculture/eleveur.jpg')
      },
      {
        title: 'Viticulture',
        link: 'viticulture',
        image: require('@/assets/img/agriculture/viticulture.jpg')
      },
      {
        title: 'Apiculture',
        link: 'apiculture',
        image: require('@/assets/img/agriculture/apiculture.jpg')
      },
      {
        title: 'Biologique',
        link: 'biologique',
        image: require('@/assets/img/agriculture/bio.jpg')
      }
    ],
    animals: [
      {
        title: 'Chèvres',
        link: 'chevre',
        image: require('@/assets/img/animals/chevres.png')
      },
      {
        title: 'Moutons',
        link: 'mouton',
        image: require('@/assets/img/animals/moutons.png')
      },
      {
        title: 'Vaches',
        link: 'vache',
        image: require('@/assets/img/animals/vaches.png')
      },
      {
        title: 'Chevaux',
        link: 'cheval',
        image: require('@/assets/img/animals/chevaux.png')
      }
    ]
  })
}
</script>

<style lang="scss" scoped>
@import "@/assets/scss/_variables.scss";

.safari-picture {
  width: 400px;
  height: 225px;
  margin-top: 10vh;

  @media only screen and (max-width: $breakpoint-tablet) {
    max-width: 100%;
    margin-top: 0vh;
  }
}

.vueperslides__arrow {
  color: #466458;
}

.vueperslides--fixed-height {
  height: 360px;
}

.vueperslides__bullet .default {
  background-color: #466458;
}

/* .housing-cards {
  display: grid;
  grid-template-columns: auto auto auto auto;
  margin: auto;
  width: inherit;
  overflow-x: auto;
  padding-left: 5%;
  @media only screen and (max-width: $breakpoint-laptop-m) {
    display: none !important;
  }
}

.agricultures-cards {
  @media only screen and (max-width: $breakpoint-laptop-m) {
    display: none !important;
  }
}

.animals-cards {
  @media only screen and (max-width: $breakpoint-laptop-m) {
    display: none !important;
  }
}
 */
.vueperslides {
  margin: 0 20%;
  display: none;
  @media only screen and (max-width: $breakpoint-laptop-m) {
    display: block;
    height: 360px;
    width: 85%;
    margin: 0;
    padding: 0;
    margin: 0 auto;
  }
  @media only screen and (max-width: $breakpoint-mobile-m) {
    width: 67%;
  }
  @media only screen and (max-width: $breakpoint-mobile-large) {
    width: 60%;
  }
}

.vueperslide {
  @media only screen and (max-width: $breakpoint-tablet) {
    margin-right: 0px;
  }
  &__title {
    font-size: 7em;
    opacity: 0.6;
  }
}

.content {
  a {
    text-decoration: none;
  }
}

.video-box {
  margin-top: 40px;
  @media only screen and (max-width: $breakpoint-tablet-m) {
    margin-top: 0px;
    text-align: center;
  }
  @media only screen and (max-width: $breakpoint-tablet) {
    margin-top: 0px;
  }
}

.forest-video {
  position: absolute;
  width: 290px;
  height: 100px;
  @media only screen and (max-width: $breakpoint-tablet) {
    display: none;
  }
}

.testimonial-content {
  display: grid;
  grid-template-columns: 50% 50%;
  text-align: center;
  @media only screen and (max-width: $breakpoint-tablet) {
    grid-template-columns: auto;
  }
}

.wrapper-housing {
  background-color: $agri-grey-back;
  @media only screen and (max-width: $breakpoint-tablet) {
    background-color: $agri-yellow-back;
  }
  .wrap-content2 {
    width: 100%;
  }
}

#wrap-foot {
  position: relative;
}

.card-title {
  color: white;
  text-transform: uppercase;
  font-family: "Avenir", -apple-system, BlinkMacSystemFont, "Segoe UI", Oxygen,
    Ubuntu, Cantarell, "Open Sans", "Helvetica Neue", sans-serif;
  font-weight: 800;
  font-size: 16px;
}

.video-text {
  text-align: justify;
  @media only screen and (max-width: $breakpoint-tablet) {
    width: 100% !important;
  }
}

.category-resume {
  font-size: 14px;
  font-weight: 500;
  font-family: "Avenir", -apple-system, BlinkMacSystemFont, "Segoe UI", Oxygen,
    Ubuntu, Cantarell, "Open Sans", "Helvetica Neue", sans-serif;
  color: #555f61;
  text-align: left;
  line-height: 19px;
  width: 110%;
  @media only screen and (max-width: $breakpoint-tablet) {
    width: 100%;
  }
}

.introducing-video {
  // margin-top: 100px;
  border: 6px solid $agri-green;
  @media only screen and (max-width: $breakpoint-tablet) {
    margin-top: 0px;
    width: 100% !important;
  }
}

.type-card {
  /* background-color: #476458; */
  /* border-radius: 25px;
  color: white;
  text-transform: uppercase;
  text-align: center;
  font-family: "Avenir", -apple-system, BlinkMacSystemFont, "Segoe UI", Oxygen,
    Ubuntu, Cantarell, "Open Sans", "Helvetica Neue", sans-serif;
  font-weight: 800;
  font-size: 16px; */
  margin-right: 45px;
  /* box-shadow: 0 8px 6px -6px black;
  height: 80%; */
  img {
    border-radius: 45px;
    box-shadow: 0 8px 6px -6px black;
  }
  cursor: pointer;
  p {
    padding-bottom: 15px;
  }
  .title {
    position: absolute;
    background-color: red;
    margin-bottom: 25px;
  }

  @media only screen and (max-width: $breakpoint-tablet) {
    margin-right: 0px;
    margin-bottom: 25px;
  }

  @media only screen and (max-width: $breakpoint-laptop-l) {
    margin-right: 15px !important;
  }
}
.type-card1 {
  cursor: pointer;
  position: relative;
  margin-right: 45px;
  background-image: url("../../../assets/img/housing/full.png");
  background-repeat: no-repeat;
  background-position: center;
  background-size: cover;
  width: 250px;
  height: 350px;
  border-radius: 31px;
  text-align: center;
  display: flex;
  justify-content: center;
  p {
    position: absolute;
    padding: 8px 25px;
    font-weight: 800;
    border-radius: 45px;
    color: $agri-white;
    font-family: "Avenir", -apple-system, BlinkMacSystemFont, "Segoe UI", Oxygen,
      Ubuntu, Cantarell, "Open Sans", "Helvetica Neue", sans-serif;
    font-size: 20px;
    bottom: 2rem;
    background-color: #b6a771;
  }
}
.type-card2 {
  cursor: pointer;
  position: relative;
  margin-right: 45px;
  background-image: url("../../../assets/img/housing/insolite.png");
  background-repeat: no-repeat;
  background-position: center;
  background-size: cover;
  width: 250px;
  height: 350px;
  border-radius: 31px;
  text-align: center;
  display: flex;
  justify-content: center;
  p {
    position: absolute;
    padding: 8px 25px;
    font-weight: 800;
    border-radius: 45px;
    color: $agri-white;
    font-family: "Avenir", -apple-system, BlinkMacSystemFont, "Segoe UI", Oxygen,
      Ubuntu, Cantarell, "Open Sans", "Helvetica Neue", sans-serif;
    font-size: 20px;
    bottom: 1rem;
    background-color: #5c975f;
  }
}
.type-card3 {
  cursor: pointer;
  position: relative;
  margin-right: 45px;
  background-image: url("../../../assets/img/housing/guestroom.png");
  background-repeat: no-repeat;
  background-position: center;
  background-size: cover;
  /* object-fit: contain; */
  width: 250px;
  height: 350px;
  border-radius: 31px;
  text-align: center;
  display: flex;
  justify-content: center;
  p {
    position: absolute;
    padding: 8px 25px;
    font-weight: 800;
    border-radius: 45px;
    color: $agri-white;
    font-family: "Avenir", -apple-system, BlinkMacSystemFont, "Segoe UI", Oxygen,
      Ubuntu, Cantarell, "Open Sans", "Helvetica Neue", sans-serif;
    font-size: 20px;
    bottom: 1rem;
    background-color: #e3b6cc;
  }
}
.type-card4 {
  cursor: pointer;
  position: relative;
  margin-right: 45px;
  background-image: url("../../../assets/img/housing/tiny.png");
  background-repeat: no-repeat;
  background-position: center;
  background-size: cover;
  /* object-fit: contain; */
  width: 250px;
  height: 350px;
  border-radius: 31px;
  text-align: center;
  display: flex;
  justify-content: center;
  p {
    position: absolute;
    padding: 8px 25px;
    font-weight: 800;
    border-radius: 45px;
    color: $agri-white;
    font-family: "Avenir", -apple-system, BlinkMacSystemFont, "Segoe UI", Oxygen,
      Ubuntu, Cantarell, "Open Sans", "Helvetica Neue", sans-serif;
    font-size: 20px;
    bottom: 1rem;
    background-color: #0251CE;
  }
}
.type-card-act1 {
  cursor: pointer;
  position: relative;
  margin-right: 45px;
  background-image: url("../../../assets/img/agriculture/eleveur.jpg");
  background-repeat: no-repeat;
  background-position: center;
  background-size: cover;
  /* object-fit: contain; */
  width: 250px;
  height: 350px;
  border-radius: 31px;
  text-align: center;
  display: flex;
  justify-content: center;
  p {
    position: absolute;
    padding: 8px 25px;
    font-weight: 800;
    border-radius: 45px;
    color: $agri-white;
    font-family: "Avenir", -apple-system, BlinkMacSystemFont, "Segoe UI", Oxygen,
      Ubuntu, Cantarell, "Open Sans", "Helvetica Neue", sans-serif;
    font-size: 20px;
    bottom: 1rem;
    background-color: #808066;
  }
}
.type-card-act2 {
  cursor: pointer;
  position: relative;
  margin-right: 45px;
  background-image: url("../../../assets/img/agriculture/viticulture.jpg");
  background-repeat: no-repeat;
  background-position: center;
  background-size: cover;
  /* object-fit: contain; */
  width: 250px;
  height: 350px;
  border-radius: 31px;
  text-align: center;
  display: flex;
  justify-content: center;
  p {
    position: absolute;
    padding: 8px 25px;
    font-weight: 800;
    border-radius: 45px;
    color: $agri-white;
    font-family: "Avenir", -apple-system, BlinkMacSystemFont, "Segoe UI", Oxygen,
      Ubuntu, Cantarell, "Open Sans", "Helvetica Neue", sans-serif;
    font-size: 20px;
    bottom: 1rem;
    background-color: #8293d0;
  }
}
.type-card-act3 {
  cursor: pointer;
  position: relative;
  margin-right: 45px;
  background-image: url("../../../assets/img/agriculture/apiculture.jpg");
  background-repeat: no-repeat;
  background-position: center;
  background-size: cover;
  /* object-fit: contain; */
  width: 250px;
  height: 350px;
  border-radius: 31px;
  text-align: center;
  display: flex;
  justify-content: center;
  p {
    position: absolute;
    padding: 8px 25px;
    font-weight: 800;
    border-radius: 45px;
    color: $agri-white;
    font-family: "Avenir", -apple-system, BlinkMacSystemFont, "Segoe UI", Oxygen,
      Ubuntu, Cantarell, "Open Sans", "Helvetica Neue", sans-serif;
    font-size: 20px;
    bottom: 1rem;
    background-color: #ab876b;
  }
}
.type-card-act4 {
  cursor: pointer;
  position: relative;
  margin-right: 45px;
  background-image: url("../../../assets/img/agriculture/bio.jpg");
  background-repeat: no-repeat;
  background-position: center;
  background-size: cover;
  /* object-fit: contain; */
  width: 250px;
  height: 350px;
  border-radius: 31px;
  text-align: center;
  display: flex;
  justify-content: center;
  p {
    position: absolute;
    padding: 8px 25px;
    font-weight: 800;
    border-radius: 45px;
    color: $agri-white;
    font-family: "Avenir", -apple-system, BlinkMacSystemFont, "Segoe UI", Oxygen,
      Ubuntu, Cantarell, "Open Sans", "Helvetica Neue", sans-serif;
    font-size: 20px;
    bottom: 1rem;
    background-color: #b4c169;
  }
}
.type-card-animal1 {
  cursor: pointer;
  position: relative;
  margin-right: 45px;
  background-image: url("../../../assets/img/animals/chevres.png");
  background-repeat: no-repeat;
  background-position: center;
  background-size: cover;
  /* object-fit: contain; */
  width: 250px;
  height: 350px;
  border-radius: 31px;
  text-align: center;
  display: flex;
  justify-content: center;
  p {
    position: absolute;
    padding: 8px 25px;
    font-weight: 800;
    border-radius: 45px;
    color: $agri-white;
    font-family: "Avenir", -apple-system, BlinkMacSystemFont, "Segoe UI", Oxygen,
      Ubuntu, Cantarell, "Open Sans", "Helvetica Neue", sans-serif;
    font-size: 20px;
    bottom: 1rem;
    background-color: #ab876b;
  }
}
.type-card-animal2 {
  cursor: pointer;
  position: relative;
  margin-right: 45px;
  background-image: url("../../../assets/img/animals/moutons.png");
  background-repeat: no-repeat;
  background-position: center;
  background-size: cover;
  /* object-fit: contain; */
  width: 250px;
  height: 350px;
  border-radius: 31px;
  text-align: center;
  display: flex;
  justify-content: center;
  p {
    position: absolute;
    padding: 8px 25px;
    font-weight: 800;
    border-radius: 45px;
    color: $agri-white;
    font-family: "Avenir", -apple-system, BlinkMacSystemFont, "Segoe UI", Oxygen,
      Ubuntu, Cantarell, "Open Sans", "Helvetica Neue", sans-serif;
    font-size: 20px;
    bottom: 1rem;
    background-color: #b4c169;
  }
}
.type-card-animal3 {
  cursor: pointer;
  position: relative;
  margin-right: 45px;
  background-image: url("../../../assets/img/animals/vaches.png");
  background-repeat: no-repeat;
  background-position: center;
  background-size: cover;
  /* object-fit: contain; */
  width: 250px;
  height: 350px;
  border-radius: 31px;
  text-align: center;
  display: flex;
  justify-content: center;
  p {
    position: absolute;
    padding: 8px 25px;
    font-weight: 800;
    border-radius: 45px;
    color: $agri-white;
    font-family: "Avenir", -apple-system, BlinkMacSystemFont, "Segoe UI", Oxygen,
      Ubuntu, Cantarell, "Open Sans", "Helvetica Neue", sans-serif;
    font-size: 20px;
    bottom: 1rem;
    background-color: #3a7e7c;
  }
}
.type-card-animal4 {
  cursor: pointer;
  position: relative;
  margin-right: 45px;
  background-image: url("../../../assets/img/animals/chevaux.png");
  background-repeat: no-repeat;
  background-position: center;
  background-size: cover;
  /* object-fit: contain; */
  width: 250px;
  height: 350px;
  border-radius: 31px;
  text-align: center;
  display: flex;
  justify-content: center;
  p {
    position: absolute;
    padding: 8px 25px;
    font-weight: 800;
    border-radius: 45px;
    color: $agri-white;
    font-family: "Avenir", -apple-system, BlinkMacSystemFont, "Segoe UI", Oxygen,
      Ubuntu, Cantarell, "Open Sans", "Helvetica Neue", sans-serif;
    font-size: 20px;
    bottom: 1rem;
    background-color: #bda587;
  }
}
.testimonial-section {
  background-color: white !important;
  padding-top: 65px !important;
  padding-bottom: 65px !important;
  max-width: 1280px;
  width: 75%;
  margin: auto;
  display: flex;
  flex-direction: column;
  align-items: center;

  .f_title {
    display: flex;
    justify-content: space-between;
    width: 90%;
    margin-bottom: 0 !important;
    .icones_png {
      width: 126px;
      height: 132px;
      padding: 12px;
      @media only screen and (max-width: $breakpoint-tablet) {
        display: none;
      }
    }
  }
  @media only screen and (max-width: $breakpoint-tablet) {
    width: 100%;
  }
}

.card-housing {
  width: 250px;
  height: 300px;
  @media only screen and (max-width: $breakpoint-tablet) {
    width: 100%;
  }
}

.testimonial-section {
  background-color: white !important;
  padding-top: 40px !important;
  padding-bottom: 65px !important;
  max-width: 1280px;
  width: 75%;
  margin: auto;
  @media only screen and (max-width: $breakpoint-tablet) {
    width: 100%;
  }
}

.testimonial-title {
  font-family: "Avenir", -apple-system, BlinkMacSystemFont, "Segoe UI", Oxygen,
    Ubuntu, Cantarell, "Open Sans", "Helvetica Neue", sans-serif;
  font-size: 26px !important;
  font-weight: 800 !important;
  text-transform: uppercase;
  color: #476458 !important;
}

.tourist-name {
  font-size: 16px;
  font-weight: 800;
  text-transform: uppercase;
  color: #417267;
  font-family: "Avenir", -apple-system, BlinkMacSystemFont, "Segoe UI", Oxygen,
    Ubuntu, Cantarell, "Open Sans", "Helvetica Neue", sans-serif;
  margin-bottom: 0px;
}

.tourist-desc {
  font-size: 20px;
  font-weight: 900;
  line-height: 40px;
  color: #417267;
  font-family: "Avenir", -apple-system, BlinkMacSystemFont, "Segoe UI", Oxygen,
    Ubuntu, Cantarell, "Open Sans", "Helvetica Neue", sans-serif;
  margin-top: 0px;
}

.testimonial-desc {
  font-size: 14px !important;
  color: #417267 !important;

  font-family: "Avenir", -apple-system, BlinkMacSystemFont, "Segoe UI", Oxygen,
    Ubuntu, Cantarell, "Open Sans", "Helvetica Neue", sans-serif;
}

.farm-btn {
  color: $agri-white;
  font-size: 18px;
  font-family: "Avenir", -apple-system, BlinkMacSystemFont, "Segoe UI", Oxygen,
    Ubuntu, Cantarell, "Open Sans", "Helvetica Neue", sans-serif;
  font-weight: 900;
  background-color: $agri-green-light;
  margin: auto;
  text-transform: uppercase;
  margin-top: 50px;
  width: 350px;
  border-radius: 39.5px;
  border: 1px solid $agri-white;
  box-shadow: 2px 2px 2px rgba(0, 0, 0, 0.4);
  padding: 12px 18px;
  line-height: 20px !important;

  @media only screen and (max-width: $breakpoint-tablet) {
    margin: 0 auto;
    width: 100%;
    max-width: 100%;
    padding: 18px 18px;
    width: 350px !important;
  }
}

.about-icon {
  position: absolute;
  margin: 0 auto;
  width: 400px;
  left: 160px;

  @media only screen and (max-width: $breakpoint-tablet) {
    display: none;
  }

  .farm-btn {
    color: $agri-green;
    font-size: 18px;
    font-family: "Avenir", -apple-system, BlinkMacSystemFont, "Segoe UI", Oxygen,
      Ubuntu, Cantarell, "Open Sans", "Helvetica Neue", sans-serif;
    font-weight: 800;
    background-color: $agri-yellow;
    margin: auto;
    text-transform: uppercase;
    margin-top: 50px;
    max-width: 400px;
    border-radius: 39.5px;
    border: 1px solid $agri-green;
    box-shadow: 2px 2px 2px rgba(0, 0, 0, 0.2);
    padding: 8px 48px;
    line-height: 20px !important;

    @media only screen and (max-width: $breakpoint-tablet) {
      width: 85%;
      border-radius: 45px;
      margin: auto;
      border: none;
      background-color: $agri-green-light;
      color: $agri-white;
      margin-bottom: 12px;
      padding: 25px 18px;
    }
  }
}

/* .space-center {
  display: flex;
  -webkit-box-orient: horizontal;
  -webkit-box-direction: normal;
  flex-direction: row;
  @media only screen and (max-width: $breakpoint-tablet) {
    margin-right: 15px !important;
    margin-left: 15px !important;
  }
} */

.wrap-content2 {
  display: flex;
  flex-direction: column;
  justify-content: center;
  align-items: center;
  padding-top: 65px;
  padding-bottom: 65px;
  max-width: 1380px;
  width: 100%;
  margin: auto;

  @media only screen and (max-width: $breakpoint-tablet) {
    width: 90%;
  }

  .f_title {
    // text-align: center;
    display: flex;
    justify-content: space-between;
    width: 85%;
    .icones_png {
      width: 120px;
      height: 120px;
      padding: 12px;
      @media only screen and (max-width: $breakpoint-tablet) {
        display: none;
      }
    }
  }
  .content {
    display: grid;
    grid-template-columns: auto auto auto auto;
    margin: auto;
    width: inherit;
    //overflow-x: auto;
    padding-left: 35px;
    /* display: flex;
    -webkit-box-orient: horizontal;
    -webkit-box-direction: normal;
    flex-direction: row;

    @media only screen and (max-width: $breakpoint-tablet) {
      width: 90%;
    } */
    .content-card {
      // margin: 50px;
      display: flex;
      flex-direction: column;
      text-align: center;

      .name {
        font-weight: 500;
        font-size: 18px;
        margin-right: 0.5rem;
      }
      .card-images {
        position: relative;
        .main {
          img {
            // border-radius: 500px;
            // border: 5px solid #476458;
            width: 200px;
            height: 200px;
            margin-bottom: 20px;
            @media only screen and (max-width: $breakpoint-tablet) {
              width: 200px;
              height: 200px !important;
            }
          }
        }
        .icon {
          padding: 10px;
          height: 90px;
          width: 90px;
          border-radius: 500px;
          background-color: rgb(108, 140, 76);
          border: 5px solid white;
          position: absolute;
          bottom: 5px;
          left: 60%;
          img {
            height: 100%;
          }
        }
      }
    }
  }
}

.wrapper_footer {
  display: flex;
  flex-direction: column;
  // padding-top: 100px;
  background-color: white;

  .wrapper1 {
    max-width: 1280px;
    width: 75%;
    margin: auto;
    margin-top: 60px !important;
    margin-bottom: 50px !important;
    @media only screen and (max-width: $breakpoint-tablet) {
      /* margin-top: 15em !important; */
      width: 90%;
      margin-top: 5% !important;
    }
    @media only screen and (max-width: $breakpoint-laptop-m) {
      margin-top: 15% !important;
    }
    @media only screen and (max-width: $breakpoint-laptop-l) {
      margin-top: 0% !important;
    }
  }
  .wrapper2 {
    background-color: #f7fcf2;
    // padding-left: 60px;
    // padding-right: 60px;
    background-color: rgb(225, 239, 216);
    padding-top: 10px;
  }
  .wrapper-housing {
    .wrap-content2 {
      .f_title {
        .housing_content {
          width: 70%;
          @media only screen and (max-width: $breakpoint-tablet) {
            text-align: center;
            margin: 0 auto;
            width: 100%;
          }
        }
      }
    }
    // padding-left: 160px;
    // padding-right: 160px;
    // background-color: #F6F5F5;
    @media only screen and (max-width: $breakpoint-tablet) {
      width: 100%;
    }
  }
  .wrapper2 {
    background-color: #f7fcf2;
    // padding-left: 60px;
    // padding-right: 60px;
    background-color: rgb(225, 239, 216);
    padding-top: 10px;
  }

  .wrapper-types {
    // padding-left: 160px;
    // padding-right: 160px;
    background-color: $agri-white;
    // padding-top: 30px;
    .wrap-content2 {
      @media only screen and (max-width: $breakpoint-tablet) {
        width: 100%;
      }
      .f_title {
        .farming-type {
          width: 70%;
          @media only screen and (max-width: $breakpoint-tablet) {
            margin: 0 auto;
            text-align: center;
            width: 100%;
            padding: 0 15px;
          }
        }
        @media only screen and (max-width: $breakpoint-tablet) {
          width: 100%;
        }
      }
    }
    .wrap-content2 {
      .f_title {
        .animal_content {
          width: 70%;
          @media only screen and (max-width: $breakpoint-tablet) {
            margin: 0 auto;
            text-align: center;
            width: 100%;
            padding: 0 15px;
          }
        }
      }
    }

    @media only screen and (max-width: $breakpoint-tablet) {
      padding-left: 0px;
      padding-right: 0px;
    }
  }

  .type-title {
    font-weight: 800;
    font-size: 20px;
    color: #476458;
    text-transform: uppercase;
    font-family: "Avenir", -apple-system, BlinkMacSystemFont, "Segoe UI", Oxygen,
      Ubuntu, Cantarell, "Open Sans", "Helvetica Neue", sans-serif;
    text-align: left;
    margin: 0 0 0 0 !important;
    /* margin-bottom: 35px; */
    @media only screen and (max-width: $breakpoint-tablet) {
      font-size: 16px;
      text-align: center;
    }
  }

  @media only screen and (max-width: $breakpoint-tablet) {
    padding-left: 0px;
    padding-right: 0px;
  }

  /* .type-title {
    font-weight: 800;
    font-size: 20px;
    color: #476458;
    text-transform: uppercase;
    font-family: "Avenir", -apple-system, BlinkMacSystemFont, "Segoe UI", Oxygen,
      Ubuntu, Cantarell, "Open Sans", "Helvetica Neue", sans-serif;
    text-align: left;
    @media only screen and (max-width: $breakpoint-tablet) {
      font-size: 16px;
      text-align: center;
    }
  } */

  .wrap-content1 {
    display: flex;
    flex-direction: row;
    background-color: white;
    padding-bottom: 20px;
    margin-left: 15px;
    // margin-right: 100px;
    // margin-top: 200px;
    @media only screen and (max-width: $breakpoint-tablet-m) {
      margin-left: 0px;
      margin-right: 0px;
      margin-top: 4%;
    }
    @media only screen and (max-width: $breakpoint-mobile-l) {
      /* margin-top: 50%; */
    }
    .content2 {
      padding: 10px 40px 0 40px;
      .f_subtitle {
        margin-bottom: 40px;
      }
      .btn-blog {
        text-align: center !important;
        border: 1px solid $agri-green;
        border-radius: 12px;
        color: $agri-green;
        width: 70%;
        font-size: 16px;
        font-weight: 800;
        margin-top: 15px;
        // @media only screen and (max-width: $breakpoint-laptop-l) {
        //   width: auto;
        // }
        @media only screen and (max-width: $breakpoint-laptop-generic) {
          width: 85%;
        }
        @media only screen and (max-width: $breakpoint-laptop-m) {
          width: auto;
        }
        @media only screen and (max-width: $breakpoint-tablet) {
          margin: 8px auto;
          font-size: 12px;
          width: auto;
          padding: 0;
          margin-top: 18px;
        }
      }
      .btn-blog:first-letter {
        text-transform: uppercase;
      }
    }
  }
  #second {
    background-color: $agri-grey-back;
    @media only screen and (max-width: $breakpoint-tablet) {
      background-color: $agri-yellow-back;
    }
  }
}

.sub-text {
  color: $agri-green;
  font-family: "Avenir", -apple-system, BlinkMacSystemFont, "Segoe UI", Oxygen,
    Ubuntu, Cantarell, "Open Sans", "Helvetica Neue", sans-serif;
}

.f_subtitle {
  margin: 0px;
  font-weight: 800;
  font-size: 20px;
  color: #476458;
  text-transform: uppercase;
  font-family: "Avenir", -apple-system, BlinkMacSystemFont, "Segoe UI", Oxygen,
    Ubuntu, Cantarell, "Open Sans", "Helvetica Neue", sans-serif;
  border-bottom: solid 1px #417267;

  @media only screen and (max-width: $breakpoint-tablet) {
    width: 100%;
    margin-top: 2em;
  }
}
.f_text {
  margin: 0px;
  font-size: 14px;
  font-weight: 400;
  margin: 4px 0;
  color: #4e5547;
  font-family: "Avenir", -apple-system, BlinkMacSystemFont, "Segoe UI", Oxygen,
    Ubuntu, Cantarell, "Open Sans", "Helvetica Neue", sans-serif;
  line-height: 1.6;
}
.f_icon {
  height: 348px;
  width: 411px;
  margin-bottom: 20px;
}
.xl-hide {
  display: none;
  justify-content: center;
  text-align: center;
  margin-bottom: 20px;
}
.f_title,
.f_item1,
.f_item2,
.f_item3,
.f_item4 {
}
.f_title {
  grid-column-start: 1;
  grid-column-end: 5;
  margin-bottom: 20px;
  /* margin-top: 20px; */
  h1 {
    font-size: 30px;
    font-weight: 500;
    margin: 8px 0;
    color: rgba(0, 0, 0, 0.76);
  }
}
@media only screen and (max-width: 1070px) {
  .content {
    flex-direction: column !important;
  }
  .icon {
    left: 54% !important;
  }
}
@media only screen and (max-width: $breakpoint-tablet-m) {
  .wrap-content1 {
    flex-direction: column !important;
    .xs-hide {
      /* display: none; */
    }
    .xl-hide {
      display: flex !important;
    }
    .f_icon {
      width: 100%;
      height: auto;
    }
    .content2 {
      text-align: center;
      padding: 0px !important;
    }
  }
}
@media only screen and (max-width: 500px) {
  .wrapper1 {
    padding-left: 0px !important;
    padding-right: 0px !important;
    width: 100%;
  }
  .wrapper2 {
    padding-left: 10px !important;
    padding-right: 10px !important;
  }
  .content-card {
    margin: 30px !important;
  }
  .image {
    width: 120px;
    height: 120px;
    height: auto !important;
  }
}
</style>
