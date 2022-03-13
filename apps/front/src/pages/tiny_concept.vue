<template>
  <div class="container">
    <concept-hero />
    <sejourTiny />
    <vacancesTiny />
    <nature />
    <footerGreen/>
    <!--  <OffersFooter/> -->
  </div>
</template>

<script>
import ConceptHero from '@/components/TinyConcept/ConceptHero'
import sejourTiny from '@/components/TinyConcept/SejourTiny'
import vacancesTiny from '@/components/TinyConcept/VacancesTiny'
import nature from '@/components/TinyConcept/Nature'
import footerGreen from '@/components/TinyConcept/FooterGreen'
import OffersFooter from '@/components/OffersList/OffersFooter'
export default {
  name: 'TinyConcept',
  components: {
    ConceptHero,
    sejourTiny,
    vacancesTiny,
    footerGreen,
    nature,
    OffersFooter
  },
  head () {
    return {
      title: 'Un joli petit cocon en bois, pour vivre un instant unique au cœur de la campagne !',
      titleTemplate: '%s - AgriVillage'
    }
  }
}
</script>

<style lang="scss" scoped>
@import "@/assets/scss/_variables.scss";
.container {
  margin-top: 0 !important;
  @media only screen and (max-width: $breakpoint-tablet) {
    max-width: 100% !important;
  }
}
</style>
