const redirects =
[
  { 'from': '/farmer', 'to': '/' },
  { 'from': '/offer', 'to': '/nos-offres' },
  { 'from': '/offers-all', 'to': '/nos-offres' },
  { 'from': '/agriculteurs-de-bretagne', 'to': '/nos-offres' },
  { 'from': '/sejour-insolite', 'to': '/vacances-originales-en-france' },
  { 'from': '/sejour-en-bretagne', 'to': '/insolite-en-bretagne' }
]

module.exports = function (req, res, next) {
  const redirect = redirects.find(r => r.from === req.url)
  if (redirect) {
    console.log(`301 redirect: ${redirect.from} => ${redirect.to}`)
    res.writeHead(301, { Location: redirect.to })
    res.end()
  } else {
    next()
  }
}
