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
import HoteHero from '@/components/HebergementFerme/Hero'
import Sejour from '@/components/HebergementFerme/Sejour'
import Activity from '@/components/HebergementFerme/Activity'
import Infos from '@/components/HebergementFerme/Infos'
import Reserver from '@/components/HebergementFerme/Reserver'
import Banner from '@/components/HebergementFerme/Banner2'
import FAQ from '@/components/HebergementFerme/FAQ'
import footerGreen from '@/components/TinyConcept/FooterGreen'
export default {
  name: 'HebergementFerme',
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
      title: 'Partez en séjour à la ferme : découvrez la vie à la campagne',
      titleTemplate: '%s - AgriVillage',
      meta: [
        {
          hid: 'description',
          name: 'description',
          content: 'Un séjour à la ferme permet de communiquer avec la nature à travers diverses activités utiles, à découvrir loin de la frénésie de la ville: La nouvelle tendance est à l’agritourisme.'
        }
      ]
    }
  }
}
</script>

<style lang="scss" scoped>
@import "@/assets/scss/_variables.scss";
</style>
