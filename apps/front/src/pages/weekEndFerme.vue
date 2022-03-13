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
import HoteHero from '@/components/WeekEndFerme/Hero'
import Sejour from '@/components/WeekEndFerme/Sejour'
import Activity from '@/components/WeekEndFerme/Activity'
import Infos from '@/components/WeekEndFerme/Infos'
import Reserver from '@/components/WeekEndFerme/Reserver'
import Banner from '@/components/WeekEndFerme/Banner2'
import FAQ from '@/components/WeekEndFerme/FAQ'
import footerGreen from '@/components/TinyConcept/FooterGreen'
export default {
  name: 'WeekEndFerme',
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
      title: 'Où partir en weekend en amoureux ?',
      titleTemplate: '%s - AgriVillage',
      meta: [
        {
          hid: 'description',
          name: 'description',
          content: 'Pour vivre une expérience inoubliable, rien de tel qu’un séjour à deux dans un endroit où intimité, inspiration, confort et environnement s’unissent pour offrir des vacances de rêve.'
        }
      ]
    }
  }
}
</script>

<style lang="scss" scoped>
@import "@/assets/scss/_variables.scss";
</style>
