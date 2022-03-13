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
import HoteHero from '@/components/OriginalesEnFrance/Hero'
import Sejour from '@/components/OriginalesEnFrance/Sejour'
import Activity from '@/components/OriginalesEnFrance/Activity'
import Infos from '@/components/OriginalesEnFrance/Infos'
import Reserver from '@/components/OriginalesEnFrance/Reserver'
import Banner from '@/components/OriginalesEnFrance/Banner'
import FAQ from '@/components/OriginalesEnFrance/FAQ'
import footerGreen from '@/components/TinyConcept/FooterGreen'
export default {
  name: 'OriginalesEnFrance',
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
      title: 'Un moment inoubliable en famille ou entre amis',
      titleTemplate: '%s - AgriVillage'
    }
  }
}
</script>

<style lang="scss" scoped>
@import "@/assets/scss/_variables.scss";
</style>
