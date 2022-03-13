const axios = require('axios')

const apiUrls = {
  baseUrl: {
    staging: 'https://api.staging.agrivillage.fr/api',
    production: 'https://api.agrivillage.fr/api',
    development: 'http://back:3000/api'
  },
  browserBaseURL: {
    staging: 'https://api.staging.agrivillage.fr/api',
    production: 'https://api.agrivillage.fr/api',
    development: `${process.env.BACK_DOMAIN}/api`
  }
}

module.exports = {
  srcDir: 'src',
  mode: 'universal',

  serverMiddleware: [
    '~/serverMiddleware/redirects'
  ],

  /*
  ** Headers of the page
  */
  head: {
    titleTemplate: '%s - AgriVillage',
    htmlAttrs: {
      dir: 'ltr'
    },
    meta: [
      { charset: 'utf-8' },
      { name: 'viewport', content: 'width=device-width, initial-scale=1, maximum-scale=1' },
      { name: 'google-site-verification', content: '1tzzoisahvXnQLV3cwU_Gfx29J-zOoEonSbq2BcI4jo' },
      { name: 'facebook-domain-verification', content: 'o1fbe0mhw3por2pupadt55irzlp532' }
    ],
    link: [
      { rel: 'icon', type: 'image/x-icon', href: '/favicon.ico' },
      { rel: 'stylesheet', href: 'https://fonts.googleapis.com/css?family=Roboto:300,400,500' },
      { rel: 'stylesheet', href: 'https://fonts.googleapis.com/icon?family=Material+Icons' },
      { rel: 'stylesheet', href: 'https://use.fontawesome.com/releases/v5.7.2/css/all.css' }
    ],
    script: [
      { src: 'https://cdnjs.cloudflare.com/ajax/libs/jquery/3.1.1/jquery.min.js', ssr: false },
      { src: 'https://bat.bing.com/actionp/0?ti=56175913&Ver=2&mid=e8a98fe6-4ef8-4675-bd9f-5067cb28f9f5&sid=3ff7c380282711ebb7546d114d7ae62d&vid=3ff7ff10282711eba9b9dbdc337f6a7b&vids=0&evt=pageHide' }
    ]
  },

  /*
  ** Customize the progress-bar color
  */
  loading: '~/components/Loading.vue',

  loadingIndicator: {
    name: 'circle',
    color: '#3B8070',
    background: 'white',
  },

  /*
  ** Global CSS
  */
  css: [
    '@/assets/fonts/icons/style.css'
  ],

  /*
  ** Plugins to load before mounting the App
  */
  plugins: [
    {
      src: '~plugins/vue-slider.js',
      ssr: false
    },
    {
      src: '~plugins/v-click-outside.js',
      ssr: false
    },
    {
      src: '~plugins/vue-leaflet.js',
      ssr: false
    },
    {
      src: '~/plugins/full-calendar.js',
      ssr: false
    },
    {
      src: '~plugins/vue-infinite-scroll.js',
      ssr: false
    },
    {
      src: '~plugins/vue-upload-component.js',
      ssr: false
    },
    {
      src: '~plugins/vue-toast.js',
      ssr: false
    },
    {
      src: '~plugins/vue-dropzone.js',
      ssr: false
    },
    {
      src: '~plugins/vue-gallery.js',
      ssr: false
    },
    {
      src: '~plugins/vuejs-paginate.js',
      ssr: false
    },
    {
      src: '~plugins/vue-scrollto.js',
      ssr: false
    },
    {
      src: '~plugins/vue-multiselect.js',
      ssr: false
    },
    {
      src: '~plugins/vue-draggable.js',
      ssr: false
    },
    {
      src: '~plugins/vue-modal.js',
      ssr: false
    },
    {
      src: '~plugins/vue-tawk.js',
      ssr: false
    },
    {
      src: '~plugins/vue-read-more.js',
      ssr: false
    },
    {
      src: '~plugins/vue-sticky.js',
      ssr: false
    },
    {
      src: '~plugins/vue-datepicker.js',
      ssr: false
    },
    { src: '~/plugins/v-calendar', ssr: false },
    { src: '~/plugins/vue-stripe-checkout.js',
      ssr: false
    },
    {
      src: '~plugins/epic-spinners.js',
      ssr: false
    },
    {
      src: '~/plugins/vue-google-oauth',
      ssr: false
    },
    {
      src: '~/plugins/facebook',
      ssr: false
    },
    {
      src: '~plugins/rgpd.js',
      ssr: false
    },
    {
      src: '~plugins/vue-html-pdf',
      ssr: false
    },
    {
      src: '~/plugins/star-rating.js',
      ssr: false
    },
    '~plugins/vee-validate.js',
    '~plugins/wiui.js',
    '~plugins/vue-lazyload.js',
    '~plugins/vue-i18n.js',
    '~/plugins/mq.js',
    '~/plugins/gtm',
    '~/plugins/jsonld.js',
    '~plugins/filters.js'
  ],
  meta: {
    name: 'AgriVillage',
    description: 'AgriVillage est une plateforme dédiée à l’agritourisme. Séjournez à la ferme et participez à une activité typique de votre destination.',
    lang: 'fr'
  },
  env: {
    FRONT_DOMAIN: process.env.FRONT_DOMAIN || 'http://localhost:8080',
    BACK_DOMAIN: process.env.BACK_DOMAIN || 'http://localhost:3000',
    GOOGLE_CLIENT_ID: '984686106941-ncsl2vtim04akamceo5iovp8fnm4b838.apps.googleusercontent.com',
    FACEBOOK_APP_ID: '2429484557339299',
    STRIPE_KEY_TEST: 'pk_test_yBPk5dAsU6RPX5pkTzYwmmn4',
    STRIPE_KEY_LIVE: 'pk_live_lKm6FpJvveSb60fUOeX1Z9Iy',
    MAPBOX_URL: 'https://api.mapbox.com/styles/v1/mapbox/streets-v11/tiles/256/{z}/{x}/{y}?access_token=pk.eyJ1IjoiYW50b2luZXdha28iLCJhIjoiY2s3NjBnMXQzMDdjZTNscm9mdDllcTZsbyJ9.YXRP3K28ZzQf_pXjWG_wIA'
  },
  /*
  ** Nuxt.js modules
  */
  modules: [
    '@nuxtjs/robots',
    '@nuxtjs/router',
    '@nuxtjs/auth-next',
    '@nuxtjs/axios',
    '@nuxtjs/sitemap',
    '@nuxtjs/pwa',
    '@nuxtjs/gtm',
    'nuxt-user-agent',
    ['vue-wait/nuxt', { useVuex: true }],
    ['nuxt-google-maps-module', {
      key: 'AIzaSyD3rPfvCVTuK9cxChkHo-qOtTYwUOFHmz0'
    }],
    ['@nuxtjs/google-analytics', {
      id: 'UA-131312886-1',
      dev: false
    }],
    ['@yabhq/nuxt-hotjar', {
      hjid: 1274722, // required
      hjsv: 6, // optional
      defer: false, // optional
      async: false, // optional
      dev: false // optional
    }],
    ['nuxt-facebook-pixel-module', {
      /* module options */
      track: 'PageView',
      pixelId: '596829757488140',
      autoPageView: true,
      disabled: false
    }]
  ],
  facebook: {
    pixelId: 'DEFAULT_PIXEL_ID',
    pixels: [
      {
        pixelId: 'DEFAULT_PIXEL_ID',
        track: 'AddToCart',
        routes: [
          '/offer/:id/:slug/booking/done'
        ]
      }
    ]
  },
  /*
  ** Axios module configuration
  */
  axios: {
    baseURL: apiUrls.baseUrl[process.env.NODE_ENV || 'production'],
    browserBaseURL: apiUrls.browserBaseURL[process.env.NODE_ENV || 'production']
  },
  auth: {
    redirect: {
      login: '/auth/sign-in',
      logout: '/',
      home: false
    },
    strategies: {
      local: {
        scheme: '~/schemes/local.js',
        name: 'local',
        provider: 'local',
        default: true
      },
      googleOAuth: {
        scheme: '~/schemes/google.js',
        name: 'googleOAuth',
        provider: null
      },
      facebookOAuth: {
        scheme: '~/schemes/facebook.js',
        name: 'facebookOAuth',
        provider: null
      }
    }
  },

  /**
   * Sitemap
   */
  sitemap: {
    path: '/sitemap.xml',
    hostname: 'https://www.agrivillage.fr',
    cacheTime: 1000 * 60 * 15,
    gzip: true,
    generate: false,
    exclude: [
      '/auth/**'
    ],
    routes (callback) {
      const routesToBeMerged = [
        '/',
        '/conditions',
        '/devenir-hote-agrivillage',
        '/sejour-agritourisme',
        '/mentions-legales',
        '/tiny-house',
        '/nos-offres',
        '/devenir-client',
        '/devenir-hote-agrivillage',
        '/sejour-en-tiny-house',
        '/sejour-en-gite',
        '/sejour-en-chambre-d-hote',
        '/sejour-insolite',
        '/sejour-en-normandie',
        '/sejour-en-nouvelle-aquitaine',
        '/sejour-en-bretagne',
        '/chambre-hote',
        '/vacances-en-famille-a-la-ferme',
        '/week-end-a-la-ferme',
        '/insolite-en-bretagne',
        '/hebergement-a-la-ferme',
        '/tiny-house-concept',
        '/tiny-house-materiaux'
      ]

      /**
       * Fetch all the offers and create a sitemap from it.
       */
      axios.get(`${apiUrls.baseUrl[process.env.NODE_ENV || 'production']}/offers/sitemap`, {
      })
        .then((res) => {
          const mapObj = {
            entire_house: 'LogementEntier',
            private_room: 'ChambrePrivee',
            guest_room: 'ChambreDHote',
            unusual_room: 'LogementInsolite',
            tiny_house: 'TinyHouse',
            immersive_house: 'LogementEnImmersion'
          }
          callback(null, [
            ...routesToBeMerged,
            ...res.data.offers.map(offer => `/offer/${offer.id}/${offer.slug}/${offer.residence_type.replace(/\b(?:entire_house|private_room|guest_room|unusual_room|tiny_house|immersive_house)\b/gi, matched => mapObj[matched])}`)
          ])
        })
        .catch(callback)
    }
  },
  robots: {
    Disallow: [
      '/auth'
    ],
    Sitemap: `https://www.agrivillage.fr/sitemap.xml`
  },
  watchers: {
    webpack: {
      ignored: /node_modules/,
      aggregateTimeout: 300,
      poll: 1000
    }
  },
  /*
  ** Build configuration
  */
  build: {
    /*
    ** You can extend webpack config here
    */
    vendor: ['gsap'],
    extend (config, ctx) {
      if (ctx.isDev && ctx.isClient) {
        config.module.rules.push({
          enforce: 'pre',
          test: /\.(js|vue)$/,
          loader: 'eslint-loader',
          exclude: /(node_modules)/,
          options: {
            fix: true
          }
        })
      }
    }
  }
}
