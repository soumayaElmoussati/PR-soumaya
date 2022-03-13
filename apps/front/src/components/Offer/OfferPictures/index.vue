<template>
  <div
    :class="[`picture-grid-${getOffer.pictures.length >= 5 ? 5 : getOffer.pictures.length}`]"
    class="offer-pictures"
  >

    <cloudinary
      v-for="(picture, k) in SortedPictures"
      :key="k"
      :public-id="picture.public_id"
      :itemkey="k.toString()"
      :transformations="{
        c: 'fill',
        w: 700,
        h: 430,
        f: 'jpg',
        fl: 'progressive'
      }"
      class="offer-picture"
    />
    <div
      v-if="getOffer.pictures.length === 0"
      class="offer-pictures__empty"
    >
      {{ $t('offer.titles.no_images') }}
    </div>
    <a
      v-if="getOffer.pictures.length !== 0"
      href="#"
      class="pictures-btn btn btn-primary btn-outline"
      @click="index = 0">{{ $t('offer.buttons.residencePicture') }}</a>
    <client-only>
      <gallery
        id="blueimp-gallery"
        :images="images"
        :index="index"
        @close="index = null"
      />
    </client-only>
    <!-- <div
      class="image"
      v-for="image, imageIndex in images"
      @click="index = imageIndex"
      :style="{ backgroundImage: 'url(' + image + ')', width: '300px', height: '200px' }"
    /> -->
  </div>
</template>

<script>
  import { mapGetters } from 'vuex'
  import Cloudinary from '@/components/Cloudinary'

  export default {
    name: 'OfferPictures',
    components: {
      Cloudinary
    },
    data () {
      return {
        images: [],
        index: null,
        SortedPictures: []
      }
    },
    computed: {
      ...mapGetters(['getOffer'])
    },
    mounted () {
      this.SortedPictures = this.getOffer.pictures
      function compare (a, b) {
        if (a.order < b.order) {
          return -1
        }
        if (a.order > b.order) {
          return 1
        }
        return 0
      }
      this.SortedPictures.sort(compare)
      var first
      for (var i = 0; i < this.getOffer.pictures.length; i++) {
        if (this.getOffer.pictures[i].url.slice(-4) === '.png') {
          first = this.getOffer.pictures[i].url.slice(0, -4)
          if (first.slice(0, 5) === 'http:') {
            first = 'https:' + first.slice(5)
            this.images.push(first)
          } else {
            this.images.push(first)
          }
        } else {
          first = this.getOffer.pictures[i].url
          if (first.slice(0, 5) === 'http:') {
            first = 'https:' + first.slice(5)
            this.images.push(first)
          } else {
            this.images.push(first)
          }
        }
      }
    }
  }
</script>

<style lang="scss" scoped>
  @import "@/assets/scss/_variables.scss";

  .pictures-btn{
    position: absolute;
    margin-left: 35px;
    color: white;
    top: 100px;
    border: 1px solid white !important;
    background-color: #11ffee00;
    border-radius: 50px;
    text-transform: uppercase;
    font-size: 12px;
    padding: 0 30px;
    @media only screen and (max-width: $breakpoint-tablet) {
      top: 80px;
    }
    &:hover {
      background-color: #0000003b !important;
    }
    &:focus {
      box-shadow: unset;
    }
    @media only screen and (max-width: $breakpoint-tablet) {
      padding: 7px;
      line-height: normal;
      font-size: 10px;
      margin-left: auto;
    }
    @media only screen and (max-width: $breakpoint-mobile-large) {
      display: none;
    }
  }

  .offer-pictures{
    display: grid;
    grid-template-columns: repeat(4, 25%);
    grid-template-rows: repeat(2, 50%);
    height: 50vh;
    overflow: hidden;

    background-color: lighten(#d1d1d1, 10%);
    @media only screen and (max-width: $breakpoint-tablet) {
      width: 100%;
      height: 25vh;
    }
    &__empty{
      display: flex;
      flex-direction: column;
      color: rgba(black, 0.5);
      margin: auto;
      grid-column: span 4;
      grid-row: span 2;
    }

    .offer-picture{
      cursor: pointer;
      height: 100%;
      width: 100%;
      object-fit: cover;
      object-position: center;
      background-color: #D1D1D1;

      &:first-child{
        grid-column: span 2;
        grid-row: span 2;
      }
    }

    &.picture-grid{
      &-1{
        grid-template-columns: 100%;
      }

      &-2{
        grid-template-columns: repeat(2, 50%);
        grid-template-rows: 100%;
        .offer-picture:first-child{
          grid-column: 1;
        }
      }

      &-3{
        grid-template-columns: 66% 33%;

        .offer-picture:first-child{
          grid-column: 1;
        }
      }
    }
  }
</style>
