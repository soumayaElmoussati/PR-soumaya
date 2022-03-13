<template>
  <div>
    <vueper-slides
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
    </vueper-slides>
  </div>
</template>
<script>
import { VueperSlides, VueperSlide } from 'vueperslides'
import 'vueperslides/dist/vueperslides.css'
import imgCaroussel from '@/assets/img/homeTiny/HeroTiny.jpg'
import heart from '@/assets/img/homeTiny/heart.png'
import persons from '@/assets/img/resultsCards/persons.png'
import bed from '@/assets/img/resultsCards/bed.png'
import bathtub from '@/assets/img/resultsCards/bathtub.png'
import mark from '@/assets/img/resultsCards/location.png'
export default {
  name: 'TinyCardsMobile',
  components: { VueperSlides, VueperSlide },
  data () {
    return {
      imgCaroussel,
      persons,
      bed,
      bathtub,
      mark,
      heart,
      // data list [array]
      someList: [
        {
          html: 'slide1',
          style: {
            background: '#1bbc9b'
          }
        },
        {
          html: 'slide2',
          style: {
            background: '#4bbfc3'
          }
        },
        {
          html: 'slide3',
          style: {
            background: '#7baabe'
          }
        }
      ],
      // Slider configuration [obj]
      options: {
        currentPage: 0
      }
    }
  }
}
</script>

<style lang="scss" scoped>
.vueperslide--visible {
  margin-right: 0 !important;
}
</style>
