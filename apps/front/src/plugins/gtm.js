export default function ({ $gtm, route }) {
  if (process.env.NODE_ENV === 'production') {
    $gtm.init('GTM-NJVSD4Q')
  }
}
