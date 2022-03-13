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
import HoteHero from '@/components/Hote/Hero'
import Sejour from '@/components/Hote/Sejour'
import Activity from '@/components/Hote/Activity'
import Infos from '@/components/Hote/Infos'
import Reserver from '@/components/Hote/Reserver'
import Banner from '@/components/Hote/Banner2'
import FAQ from '@/components/Hote/FAQ'
import footerGreen from '@/components/TinyConcept/FooterGreen'
export default {
  name: 'ChambreHote',
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
      title: 'Loin de la ville et au plus près de la nature',
      titleTemplate: '%s - AgriVillage'
    }
  }
}
</script>

<style lang="scss" scoped>
@import "@/assets/scss/_variables.scss";
</style>
