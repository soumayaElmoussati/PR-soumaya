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
import HoteHero from '@/components/VacancesEnFamille/Hero'
import Sejour from '@/components/VacancesEnFamille/Sejour'
import Activity from '@/components/VacancesEnFamille/Activity'
import Infos from '@/components/VacancesEnFamille/Infos'
import Reserver from '@/components/VacancesEnFamille/Reserver'
import Banner from '@/components/VacancesEnFamille/Banner2'
import FAQ from '@/components/VacancesEnFamille/FAQ'
import footerGreen from '@/components/TinyConcept/FooterGreen'
export default {
  name: 'VacancesEnFamille',
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
      title: 'Vacances à la ferme en famille',
      titleTemplate: '%s - AgriVillage',
      meta: [
        {
          hid: 'description',
          name: 'description',
          content: 'Les vacances à la ferme sont aussi enrichissantes que relaxantes. Grâce à ce type de séjour, la communion avec la nature se fait dans un confort bien pensé.'
        }
      ]
    }
  }
}
</script>

<style lang="scss" scoped>
@import "@/assets/scss/_variables.scss";
</style>
