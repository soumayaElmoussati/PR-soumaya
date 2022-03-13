import Vue from 'vue'
import VueI18n from 'vue-i18n'

import frLocale from '~/locales/fr'

Vue.use(VueI18n)

export default ({ app, store }) => {
  app.i18n = new VueI18n({
    locale: 'fr',
    fallbackLocale: 'fr',
    messages: {
      fr: frLocale
    }
  })
}
