export default {
  name: 'currencyFromCents',
  filter: (value, countryCode) => {
    const countries = {
      FR: {
        locale: 'fr-FR',
        currency: 'EUR'
      }
    }

    const { locale, currency } = countries[countryCode || 'FR']
    const nf = new Intl.NumberFormat(
      locale,
      {
        style: 'currency',
        currency
      }
    )

    const formatedValue = (parseInt(value, 10) / 100)
    return nf.format(formatedValue)
  }
}
