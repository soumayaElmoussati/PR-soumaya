<template>
  <transition name="modal-fade">
    <div
      id="PaymentModal"
      class="modal-backdrop payment-modal">
      <div
        class="modal"
        role="dialog"
        aria-labelledby="modalTitle"
        aria-describedby="modalDescription">
        <header
          id="modalTitle"
          class="modal-header">
          <slot name="header">

            <img
              src="@/assets/img/logo/logo-footer.png"
              class="modal-banner"
              alt="auth">

            <button
              type="button"
              class="btn-close"
              aria-label="Close modal"
              @click="close"
            >
              x
            </button>

          </slot>
        </header>
        <section
          id="modalDescription"
          class="modal-body">
          <slot name="body">
            <client-only>
              <h4 style="text-align: center; margin-top: 1px;">{{ $t("activity.titles.total") }} <span style="color: green;"> {{ offer.sub_total/100 }}€</span></h4>
              <!-- <stripe-checkout
                ref="checkoutRef"
                :pk="publishableKey"
                :amount="offer.sub_total/100"
                :success-url="successUrl"
                :cancel-url="cancelUrl">

                <template slot="checkout-button">
                  <button
                    class="btn btn-primary become-btn"
                    @click="checkout">Payer la reservation</button>
                </template>
              </stripe-checkout> -->
              <stripe-elements
                ref="elementsRef"
                :pk="publishableKey"
                :amount="offer.sub_total/100"
                @token="tokenCreated"
                @loading="loading = $event"
              />
              <!-- public_key:
                    pk_test_yBPk5dAsU6RPX5pkTzYwmmn4

                    secret_key:
                    sk_test_Rn5msomXPxHV2Y5ynnVopH3t -->
            </client-only>

            <br>
            <button
              class="btn btn-primary become-btn"
              style="display: inline-flex;"
              @click="$refs.elementsRef.submit()">
              <div
                v-if="loading"
                style="width: 30px;">
                <client-only>
                  <orbit-spinner
                    :animation-duration="1000"
                    :size="30"
                    :color="'#fffffe'"
                    style="margin-top: 10px;"
                  />
                </client-only>
              </div>

              <span style="margin-left: 10px;">{{ $t("activity.buttons.payed") }} {{ offer.sub_total/100 }}€</span>
            </button>

          </slot>
        </section>
        <!-- <div v-if="dialog">
          <div>
            <h1>Charge</h1>
            <pre>{{ charge }}</pre>
            <br>
            <h1>Token</h1>
            <p>{{ token.id }}</p>
            <br>
          </div>
        </div> -->
      </div>
    </div>
  </transition>
</template>

<script>
export default {
    name: 'ModalPayment',
    props: {
        offer: {
            type: Object,
            default: () => {}
        }
    },
    data () {
      return {
        token: null,
        charge: null,
        loading: false,
        dialog: false,
        publishableKey: 'pk_test_yBPk5dAsU6RPX5pkTzYwmmn4',
        items: [
        {
            sku: 'sku_FdQKocNoVzznpJ',
            quantity: 1
        }
        ],
        successUrl: 'http://localhost:8080/dashboard/client-bookings',
        cancelUrl: 'http://localhost:8080/dashboard/client-bookings'
      }
    },
    methods: {
        close () {
            this.$emit('close')
        },
        checkout () {
            this.$refs.checkoutRef.redirectToCheckout()
        },
        tokenCreated (token) {
            console.warn(token)
            this.token = token
            this.charge = {
                source: token.card,
                amount: this.offer.sub_total
            }
            console.warn(this.charge)
            this.sendTokenToServer(this.charge)
        },
        sendTokenToServer (charge) {
            // Send to server
            this.dialog = true
        }
    }
  }
</script>

<style scoped>
.payment-modal .banner-title {
    color: #476458;
    font-size: 20px;
    font-family: 'Avenir', -apple-system, BlinkMacSystemFont, 'Segoe UI', Oxygen, Ubuntu, Cantarell, 'Open Sans', 'Helvetica Neue', sans-serif;
    text-transform: uppercase;
    font-weight: bold;
}

.payment-modal .modal-banner {
    width: auto;
    height: 80%;
    margin-top: 8px;
}

.payment-modal .modal-fade-enter,
.payment-modal .modal-fade-leave-active {
    opacity: 0;
}

.payment-modal .modal-fade-enter-active,
.payment-modal .modal-fade-leave-active {
    transition: opacity .5s ease
}

.payment-modal .modal-backdrop {
    position: fixed;
    top: 0;
    bottom: 0;
    left: 0;
    right: 0;
    background-color: rgba(0, 0, 0, 0.3);
    display: flex;
    justify-content: center;
    align-items: center;
}

.payment-modal .modal {
    background: #FFFFFF;
    box-shadow: 2px 2px 20px 1px;
    overflow-x: auto;
    display: flex;
    flex-direction: column;
    padding: none !important;
    border-radius: 10px;
    max-width: 450px;
}

.payment-modal .modal-calendar {
    background: #FFFFFF;
    box-shadow: 2px 2px 20px 1px;
    overflow-x: auto;
    display: flex;
    flex-direction: column;
    padding: none !important;
    border-radius: 10px;
    max-width: 400px;
    padding: 25px;
}

.payment-modal .modal-header,
.payment-modal .modal-footer {
    display: flex;
}

.payment-modal .modal-header {
    justify-content: center;
    background-color: #515d45;
    height: 120px;
    width: 450px;
}

.payment-modal .modal-body {
    position: relative;
    padding: 20px 10px;
}

.payment-modal .btn-close {
    border: none;
    font-size: 25px;
    cursor: pointer;
    font-weight: bold;
    color: white;
    background: transparent;
    position: absolute;
    left: 60%;
}

#card-element {
    border: 1px solid lightgray;
}

</style>
