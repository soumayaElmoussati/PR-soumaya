<template>
  <div>
    <Header />
    <Mission />
    <Services />
    <Reserve />
    <Seminar />
    <!-- <Partner /> -->
  </div>
</template>
<script>
import Header from '@/components/CompanySeminar/Header'
import Mission from '@/components/CompanySeminar/Mission'
import Services from '@/components/CompanySeminar/Services'
import Reserve from '@/components/CompanySeminar/Reserve'
import Seminar from '@/components/CompanySeminar/Seminar'
import Partner from '@/components/CompanySeminar/Partner'
export default {
  name: 'CompanySeminar',
  head () {
    return {
      title: 'Séminaires en entreprise'
    }
  },
  components: {
    Header,
    Mission,
    Services,
    Reserve,
    Seminar,
    Partner
  }
}
</script>
<style lang="scss" scoped>
@import '@/assets/scss/_variables.scss';

</style>
