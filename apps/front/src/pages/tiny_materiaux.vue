<template>
  <div class="container">
    <MateriauxHero />
    <PlanCharly />
    <GreenFooter />
    <Photos />
    <FooterBle />
    <LesPlus />
    <footerGreen />
  </div>
</template>

<script>
import MateriauxHero from '@/components/TinyMateriaux/MateriauxHero'
import PlanCharly from '@/components/TinyMateriaux/PlanCharly'
import GreenFooter from '@/components/TinyMateriaux/GreenFooter'
import Photos from '@/components/TinyMateriaux/NosTinyHousePhotos'
import FooterBle from '@/components/TinyMateriaux/FooterBle'
import LesPlus from '@/components/TinyMateriaux/LesPlus'
import footerGreen from '@/components/TinyConcept/FooterGreen'

export default {
  name: 'Materiaux',
  components: {
    MateriauxHero,
    PlanCharly,
    GreenFooter,
    Photos,
    FooterBle,
    LesPlus,
    footerGreen
  },
  head () {
    return {
      title: 'Un hébergement respectueux de l\'environnement',
      titleTemplate: '%s - AgriVillage'
    }
  }
}
</script>

<style lang="scss" scoped>
@import "@/assets/scss/_variables.scss";
// .container {
//   min-height: 550px;
// }
</style>
