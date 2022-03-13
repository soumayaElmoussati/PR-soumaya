<template lang="html">

  <client-only>

    <stripe-checkout
      ref="sessionRef"
      :pk="pk"
      :session-id="sessionId"
    >
      <template slot="checkout-button">
        <button
          class="btn btn-agri-contact"
          @click="checkout">{{ $t("offer.buttons.payed") }}</button>
      </template>
    </stripe-checkout>

  </client-only>

</template>

<script>
export default {
  name: 'BookingCheckout',
  props: {
        booking: {
            type: Object,
            default: () => {}
        }
  },
  data () {
    this.pk = process.env.STRIPE_KEY_LIVE
    this.sessionId = this.booking.stripe_token

    return {
      items: [{
        name: 'Kavholm rental',
        amount: 1000,
        currency: 'eur',
        quantity: 1
      }],
      mode: 'payment',
      successUrl: 'http://localhost:8080/dashboard/client-bookings',
      cancelUrl: 'http://localhost:8080/dashboard/client-bookings'
    }
  },
  methods: {
    checkout () {
      this.$refs.sessionRef.redirectToCheckout()
    },
    close () {
      this.$emit('close')
    }
  }
}
</script>

<style lang="scss" scoped>
  @import "@/assets/scss/_variables.scss";
</style>
