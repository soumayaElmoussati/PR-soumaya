import Vue from 'vue'
import moment from 'moment'
import VeeValidate, { Validator } from 'vee-validate'
import {
  parsePhoneNumberFromString
} from 'libphonenumber-js'

import fr from 'vee-validate/dist/locale/fr'

Vue.use(VeeValidate)
Validator.localize('fr', fr)

Validator.extend('age_majority', {
  getMessage: () => 'Vous devez avoir au moins 18 ans.',
  validate: (value) => {
    const diff = moment().diff(moment(value), 'years') < 18
    return !diff
  }
})

Validator.extend('phone', {
  getMessage: () => 'Le numéro doit être valide.',
  validate (value, args) {
    const countryCode = args[0]
    if (!countryCode) throw new Error('A country code must be specified (e.g phone:FR).')

    const parsing = value && countryCode
      ? parsePhoneNumberFromString(value, countryCode)
      : null

    return parsing
      ? parsing.isValid()
      : false
  }
})

Validator.extend('verify_password', {
  getMessage: field => 'Le mot de passe doit contenir 6 caractères minimum, 1 lettre majuscule, 1 lettre minuscule, 1 chiffre',
  validate: value => {
    var strongRegex = new RegExp('^(?=.*[a-z])(?=.*[A-Z])(?=.*[0-9])(?=.{6,})')
    return strongRegex.test(value)
  }
})
