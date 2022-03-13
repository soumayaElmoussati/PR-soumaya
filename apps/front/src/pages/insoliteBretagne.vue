<template>
  <div>
    <HoteHero />
    <Sejour />
    <Activity />
    <Infos />
    <Reserver />
    <Banner />
    <FAQ />
    <footerGreen />
  </div>
</template>

<script>
import HoteHero from '@/components/InsoliteBretagne/Hero'
import Sejour from '@/components/InsoliteBretagne/Sejour'
import Activity from '@/components/InsoliteBretagne/Activity'
import Infos from '@/components/InsoliteBretagne/Infos'
import Reserver from '@/components/InsoliteBretagne/Reserver'
import Banner from '@/components/InsoliteBretagne/Banner2'
import FAQ from '@/components/InsoliteBretagne/FAQ'
import footerGreen from '@/components/TinyConcept/FooterGreen'
export default {
  name: 'InsoliteBretagne',
  components: {
    HoteHero,
    Sejour,
    Activity,
    Infos,
    Reserver,
    Banner,
    FAQ,
    footerGreen
  },
  head () {
    return {
      title: 'La Bretagne comme vous ne l’avez jamais vue',
      titleTemplate: '%s - AgriVillage'
    }
  }
}
</script>

<style lang="scss" scoped>
@import "@/assets/scss/_variables.scss";
</style>
