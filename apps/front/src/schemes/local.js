import { Token, RequestHandler } from '@nuxtjs/auth-next/dist/runtime'

const DEFAULTS = {
  name: 'local',
  endpoints: {
    login: {
      url: '/auth/sign_in',
      method: 'post'
    },
    logout: {
      url: '/auth/sign_out',
      method: 'delete'
    },
    user: {
      url: '/auth/validate_token',
      method: 'get'
    }
  },
  token: {
    property: 'token',
    type: '',
    name: 'Access-Token',
    maxAge: 1800,
    global: true,
    required: true,
    prefix: '_token.',
    expirationPrefix: '_token_expiration.'
  },
  user: {
    property: 'user',
    autoFetch: true
  },
  cookie: {},
  clientId: false,
  grantType: false,
  scope: false
}

/**
 * This class is based on the @nuxtjs/auth-next class with some
 * changes to implement the behaviour of devise token auth.
 * @class LocalScheme
 */
export default class LocalScheme {
  constructor ($auth, options) {
    this.$auth = $auth
    this.options = {
      ...DEFAULTS,
      ...options
    }

    this.requestHandler = new RequestHandler(this, this.$auth.ctx.$axios)
    this.token = new Token(this, this.$auth.$storage)

    this.client = null
    this.uid = null
    this.expiry = null
  }

  get name () {
    return this.options.name
  }

  check (checkStatus = false) {
    const response = {
      valid: false,
      tokenExpired: false
    }

    const token = this.token.sync()
    this.client = this.$auth.$storage.getUniversal('client')
    this.uid = this.$auth.$storage.getUniversal('uid')
    this.expiry = this.$auth.$storage.getUniversal('expiry')

    this.updateInterceptor()

    if (!token) {
      return response
    }
    if (!checkStatus) {
      response.valid = true
      return response
    }

    const isExpired = (this.expiry * 1000) <= new Date().getTime()

    if (isExpired) {
      response.tokenExpired = true
      return response
    }
    response.valid = true
    return response
  }

  mounted ({
    tokenCallback = () => this.$auth.reset(),
    refreshTokenCallback = void 0
  } = {}) {
    const { tokenExpired, refreshTokenExpired } = this.check(true)
    if (refreshTokenExpired && typeof refreshTokenCallback === 'function') {
      refreshTokenCallback()
    } else if (tokenExpired && typeof tokenCallback === 'function') {
      tokenCallback()
    }
    this.initializeRequestInterceptor()
    return this.$auth.fetchUserOnce()
  }

  async login (endpoint, { reset = true } = {}) {
    if (!this.options.endpoints.login) {
      return
    }
    if (reset) {
      this.$auth.reset({ resetInterceptor: false })
    }
    if (this.options.clientId) {
      endpoint.data.client_id = this.options.clientId
    }
    if (this.options.grantType) {
      endpoint.data.grant_type = this.options.grantType
    }
    if (this.options.scope) {
      endpoint.data.scope = this.options.scope
    }
    const response = await this.$auth.request(endpoint, this.options.endpoints.login)
    this.updateTokens(response)

    if (!this.requestHandler.interceptor) {
      this.initializeRequestInterceptor()
    }

    if (this.options.user.autoFetch) {
      await this.fetchUser()
    }
    return response
  }

  setUserToken (token) {
    this.token.set(token)
    this.updateStorage()
    return this.fetchUser()
  }

  fetchUser (endpoint) {
    if (!this.check().valid) {
      return Promise.resolve()
    }
    if (!this.options.endpoints.user) {
      this.$auth.setUser({})
      return Promise.resolve()
    }
    return this.$auth.requestWith(this.name, endpoint, this.options.endpoints.user)
      .then((response) => {
        this.$auth.setUser(response.data)
        return response
      })
      .catch((error, some) => {
        this.$auth.callOnError(error, { method: 'fetchUser' })
        return Promise.reject(error)
      })
  }

  async logout (endpoint = {}) {
    if (this.options.endpoints.logout) {
      await this.$auth.requestWith(this.name, endpoint, this.options.endpoints.logout).catch(() => {
      })
    }
    return this.$auth.reset()
  }

  reset ({ resetInterceptor = true } = {}) {
    this.$auth.setUser(false)
    this.token.reset()
    this.client = null
    this.uid = null
    this.expiry = null

    this.$auth.$storage.removeUniversal('client')
    this.$auth.$storage.removeUniversal('uid')
    this.$auth.$storage.removeUniversal('expiry')

    if (resetInterceptor) {
      this.requestHandler.reset()
    }
  }

  updateStorage () {
    this.$auth.$storage.setUniversal('client', this.client)
    this.$auth.$storage.setUniversal('uid', this.uid)
    this.$auth.$storage.setUniversal('expiry', this.expiry)
  }

  updateInterceptor () {
    this.$auth.ctx.$axios.setHeader('Client', this.client)
    this.$auth.ctx.$axios.setHeader('Uid', this.uid)
    this.$auth.ctx.$axios.setHeader('Expiry', this.expiry)
    this.$auth.ctx.$axios.setHeader('Token-Type', 'Bearer')
  }

  updateTokens (response) {
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
  }

  initializeRequestInterceptor () {
    this.requestHandler.initializeRequestInterceptor()
  }
}
