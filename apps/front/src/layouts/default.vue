<template
  ref="ok">
  <div>

    <client-only>
      <div v-if="$route.name=='Index' || $route.name=='OffersAll' || $route.name=='HomeTiny'">
        <app-header-home />
      </div>
      <div v-else-if="$route.name=='CompanySeminar'"/>
      <div v-else>
        <app-header />
      </div>
    </client-only>

    <nuxt class="nuxt-content"/>

    <app-footer />

    <noscript>
      This website requires Javascript to work properly. Please enable it or update your browser.
    </noscript>

  </div>
</template>

<script>
  import AppHeader from './../components/Global/AppHeader'
  import AppHeaderHome from './../components/Global/AppHeaderHome'
  import AppFooter from './../components/Global/AppFooter'

  export default {
    components: {
      AppHeader,
      AppHeaderHome,
      AppFooter
    },
    head () {
      return {
        titleTemplate: '%s - AgriVillage',
        htmlAttrs: {
          lang: 'fr'
        },
        meta: [
          { hide: 'twitter:card', name: 'twitter:card', content: 'https://agrivillage.fr/icon.png' },
          { hide: 'twitter:site', name: 'twitter:site', content: 'https://agrivillage.fr' },
          { hid: 'og:type', name: 'og:type', content: 'website' },
          { hid: 'og:url', property: 'og:url', name: 'og:url', content: 'https://agrivillage.fr' },
          { hid: 'og:title', name: 'og:title', content: 'AgriVillage' },
          { hid: 'og:site_name', name: 'og:site_name', content: 'AgriVillage' },
          { hid: 'og:locale', name: 'og:locale', content: 'fr' },
          { hid: 'og:image', property: 'og:image', name: 'og:image', content: 'https://agrivillage.fr/icon.png' }
        ]
      }
    },
    data () {
      return {
        expl: true,
        sDate: null,
        fDate: null,
        prodBaseUrl: 'https://agrivillage.fr'
      }
    },
    jsonld () {
      return {
        '@context': 'https://schema.org',
        '@type': 'WebPage',
        url: 'https://www.agrivillage.fr/',
        name: 'AgriVillage - Découvrez ou redécouvrez vos campagnes françaises !',
        description: this.getOfferMetaDescription
      }
    },
    mounted () {
      this.$nextTick(async () => {
        this.$nuxt.$loading.start()
         /* setTimeout(() => this.$nuxt.$loading.finish(), 1000) */
        this.$nuxt.$loading.finish()
      })
    }
  }

</script>

<style lang="scss">
  @import "@/assets/scss/style.scss";
  @import "@/assets/scss/_variables.scss";

  .nuxt-content{
    margin-top: 70px;
  }
</style>
