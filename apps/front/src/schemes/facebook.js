import LocalScheme from './local'

function facebookLogin () {
  return new Promise((resolve, reject) => {
    window.FB.login((response) => {
      if (response.authResponse) {
        resolve(response.authResponse.accessToken)
      } else {
        reject(new Error('User cancelled login or did not fully authorize.'))
      }
    }, {
      scope: 'email'
    })
  })
}

export default class FacebookScheme extends LocalScheme {
  async login ({ params }) {
    const token = await facebookLogin()

    /**
     * Once we got the response, call our own API to get user token and informations.
     */
    return new Promise((resolve, reject) => {
      this.$auth.request({
        method: 'POST',
        url: '/auth/facebook',
        data: {
          access_token: token,
          farmer: params.farmer
        }
      })
        .then(async response => {
          /**
           * Get token informations that we need to authenticate the user later on.
           */
          const { 'access-token': accessToken, client, uid, expiry } = response.headers

          /**
           * Here we can use the nuxt auth token.set to specify the user token.
           * We could have used the this.setUserToken but it triggers an unnecessary fetch user.
           * See: https://github.com/nuxt-community/auth-module/blob/05a2348ddc81a5c4f27d6183c044fe39a773fc78/src/schemes/local.ts#L194
           */
          this.token.set(accessToken)
          this.client = client
          this.uid = uid
          this.expiry = expiry

          this.updateStorage()

          /**
           * Add the two required headers we need to work with device token auth
           */
          this.updateInterceptor()

          /**
           * Set the user informations from the request like in the fetchUser behaviour
           * See: https://github.com/nuxt-community/auth-module/blob/05a2348ddc81a5c4f27d6183c044fe39a773fc78/src/schemes/local.ts#L217
           */
          if (response.data) {
            this.$auth.setUser(response.data)
          }

          if (this.options.user.autoFetch) {
            await this.fetchUser()
          }

          resolve(response)
        })
        .catch(reject)
    })
  }
}
