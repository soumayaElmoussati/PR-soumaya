<template>
  <div class="edit-offer-price">
    <div class="side">
      <h1 class="title-side">
        {{ $t("offer.titles.rate") }}
      </h1>
      <p class="subtitle">
        <em
        >{{ $t("offer.paragraphs.commission") }}</em
        >
      </p>

      <form @submit.prevent="submitted">
        <div class="price-box">
          <p class="price-label">{{ $t("offer.paragraphs.price") }}</p>
          <p class="subtitle">
            <em
            >{{ $t("offer.paragraphs.nightPrice") }}</em
            >
          </p>

          <div class="price-field">
            <wi-input
              v-validate="'required|decimal:2|min_value:0'"
              id="pricePerPerson"
              v-model="formData.pricePerPerson"
              :error="errors.first('pricePerPerson')"
              data-vv-as="prix de base"
              name="pricePerPerson"
              placeholder="80"
              required
              type="number"
              step="0.01"
            />

            <p class="price-night">€ {{ $t("offer.paragraphs.night") }}</p>
          </div>

          <div class="simulator-box">
            <p class="simulator">
              Vous percevrez
              <b class="simulator-price">{{ getPricePerNight }} €</b> {{ $t("offer.paragraphs.bedNight") }}
            </p>

            <p class="simulator">
              <b class="simulator-price">{{ getPricePerWeek }} €</b> {{ $t("offer.paragraphs.week") }}
            </p>
          </div>
        </div>

        <div class="price-box">
          <p class="price-label">
            {{ $t("offer.paragraphs.ratePerson") }}
          </p>
          <p class="subtitle">
            <em>{{ $t("offer.paragraphs.residencePerson") }}</em>
          </p>

          <div class="price-field">
            <wi-input
              v-validate="'required|numeric|min_value:1'"
              id="peopleCount"
              v-model="formData.peopleCount"
              :error="errors.first('peopleCount')"
              data-vv-as="nombre de personnes"
              name="peopleCount"
              required
            />

            <p class="price-night">{{ $t("offer.paragraphs.person") }}</p>
          </div>
        </div>

        <div class="price-box">
          <p class="price-label">{{ $t("offer.paragraphs.priceTraveler") }}</p>
          <p class="subtitle">
            <em
            >{{ $t("offer.paragraphs.nightPrice") }}</em
            >
          </p>

          <div class="price-field">
            <wi-input
              v-validate="'required|decimal:2'"
              id="additionalTravelerPrice"
              v-model="formData.additionalTravelerPrice"
              :error="errors.first('additionalTravelerPrice')"
              data-vv-as="prix voyageur supplémentaire"
              name="additionalTravelerPrice"
              type="number"
              step="0.01"
              required
            />

            <p class="price-night">€ {{ $t("offer.paragraphs.night") }}</p>
          </div>
        </div>

        <div class="price-box">
          <p class="price-label">
            {{ $t("offer.paragraphs.travelerNumber") }}
          </p>
          <p class="subtitle">
            <em>{{ $t("offer.paragraphs.maximum") }}</em>
          </p>

          <div class="price-field">
            <wi-input
              v-validate="'required|numeric|max_value:6'"
              id="additionalMaxPeople"
              v-model="formData.additionalMaxPeople"
              :error="errors.first('additionalMaxPeople')"
              data-vv-as="visiteurs supplémentaires"
              type="tel"
              name="additionalMaxPeople"
              required
            />

            <p class="price-night">{{ $t("offer.paragraphs.person") }}</p>
          </div>
        </div>

        <div class="price-box">
          <p class="price-label">{{ $t("offer.paragraphs.nightNumber") }}</p>

          <div class="price-field">
            <wi-input
              v-validate="'required|numeric|min_value:1'"
              id="minDays"
              v-model="formData.minDays"
              :error="errors.first('minDays')"
              data-vv-as="nombre de nuits"
              name="minDays"
              label=""
              required
            />

            <p class="price-night">{{ $t("offer.paragraphs.nights") }}</p>
          </div>
        </div>

        <div class="price-box">
          <p class="price-label">{{ $t("offer.paragraphs.tax") }}</p>

          <p class="subtitle">
            <em
            >{{ $t("offer.paragraphs.cityTax") }}</em
            >
          </p>

          <div class="price-field-tax">
            <wi-input
              id="touristTax"
              v-model="formData.touristTax"
              :error="errors.first('touristTax')"
              data-vv-as="taxe de séjour"
              name="touristTax"
              label=""
              required
            />

            <p class="price-night">€</p>

            <div class="tooltip">(<span>&#63;</span>)
              <span class="tooltiptext">Les taxes de séjours seront à régler sur place, Utilisez bien les . pour séparer les décimales</span>
            </div>
          </div>
        </div>

        <div class="price-box">
          <p class="price-label">{{ $t("offer.paragraphs.deposit") }}</p>

          <p class="subtitle">
            <em
            >{{ $t("offer.paragraphs.amountDeposit") }}</em
            >
          </p>

          <div class="caution-field">
            <wi-input
              v-validate="'decimal:2'"
              id="deposit"
              v-model="formData.deposit"
              :error="errors.first('deposit')"
              data-vv-as="caution"
              name="deposit"
            />

            <div class="tooltip">(<span>&#63;</span>)
              <span class="tooltiptext">Le montant de la caution sera indiquée au voyageur lors de sa demande de réservation, mais pas débité sur son compte ! Nous effecturons simplement une empreinte de sa Carte Bancaire afin de poouvoir y recouvrir si nécessaire pour faire valoir vos droits.</span>
            </div>

            <p class="price-night">€ {{ $t("offer.paragraphs.fromDeposit") }}</p>
          </div>
        </div>

        <div class="price-box">
          <p class="price-label">{{ $t("offer.paragraphs.priceWeek") }}</p>

          <p class="subtitle">
            <em>{{ $t("offer.paragraphs.fill") }}</em>
            <em>{{ $t("offer.paragraphs.indicatedPrice") }}</em>
          </p>

          <div class="price-field-weekend">
            <wi-input
              v-validate="'decimal:2|min_value:0'"
              id="weekend_price"
              v-model="formData.weekend.price"
              :error="errors.first('weekend_price')"
              data-vv-as="prix weekend"
              type="number"
              step="0.01"
              name="weekend_price"
              label=""
              caption=""
            />

            <p class="price-night">€ {{ $t("offer.paragraphs.night") }}</p>
          </div>
        </div>

        <p class="price-label">
          {{ $t("offer.paragraphs.reduce") }}
        </p>

        <p class="subtitle">
          {{ $t("offer.paragraphs.proposedReduce") }}
        </p>

        <table
          v-if="
            formData.offerPriceDiscount &&
              formData.offerPriceDiscount.length > 0
          "
        >
          <thead>
            <tr>
              <td>
                {{ $t("offer.tables.percent") }}
              </td>
              <td>
                {{ $t("offer.tables.minimumNight") }}
              </td>
            </tr>
          </thead>
          <tbody>
            <tr
              v-for="discount in formData.offerPriceDiscount"
              :key="discount.id"
            >
              <td>{{ discount.percentage_discount }}%</td>
              <td>
                {{ discount.min_nights }}
              </td>
              <td>
                <button
                  v-if="discount.id"
                  :disabled="
                    $wait.is(`removing price discount with id ${discount.id}`)
                  "
                  type="button"
                  @click="removeDiscount(discount.id)"
                >
                  {{ $t("offer.buttons.delete") }}
                </button>
              </td>
            </tr>
          </tbody>
        </table>

        <br >

        <button
          type="button"
          class="btn btn-agri-yellow"
          @click="addingPriceDiscount = true"
        >
          {{ $t("offer.buttons.addReduce") }}
        </button>

        <p class="price-label">
          {{ $t("offer.paragraphs.seasonPrice") }}
        </p>

        <p class="subtitle">
          {{ $t("offer.paragraphs.seasonBill")[0] }}<br>
          {{ $t("offer.paragraphs.seasonBill")[1] }}
        </p>

        <table
          v-if="
            formData.offerPricePeriod && formData.offerPricePeriod.length > 0
          "
          class="table-season"
        >
          <thead>
            <tr>
              <td class="price-label td-season">
                {{ $t("offer.tables.date") }}
              </td>
              <td class="price-label td-season">
                {{ $t("offer.tables.price") }}
              </td>
              <td class="price-label td-season">
                {{ $t("offer.tables.duration") }}
              </td>
              <td class="price-label td-season">
                {{ $t("offer.tables.politic") }}
              </td>
              <td />
            </tr>
          </thead>
          <tbody>
            <tr
              v-for="period in formData.offerPricePeriod"
              :key="period.id">
              <td>
                Du
                {{
                  moment(period.start_date)
                    .locale("fr")
                    .format("DD/MM")
                }}
                au
                {{
                  moment(period.end_date)
                    .locale("fr")
                    .format("DD/MM")
                }}
              </td>
              <td>
                {{ period.price_period | currency }}
              </td>
              <td>{{ period.min_days }} {{ $t("offer.tables.night") }}</td>
              <td>
                {{ period.use_discount ? "Oui" : "Non" }}
              </td>
              <td>
                <button
                  v-if="period.id"
                  :disabled="
                    $wait.is(`removing price period with id ${period.id}`)
                  "
                  type="button"
                  @click="removePeriod(period.id)"
                >
                  {{ $t("offer.buttons.delete") }}
                </button>
              </td>
            </tr>
          </tbody>
        </table>

        <br >

        <button
          type="button"
          class="btn btn-agri-yellow"
          @click="addingPricePeriod = true"
        >
          {{ $t("offer.buttons.addSeason") }}
        </button>

        <br >

        <div class="buttons">
          <button
            type="submit"
            class="btn btn-agri-yellow"
            @click="next">
            {{ $t("offer.buttons.next") }}
          </button>
          <button
            type="submit"
            class="btn btn-agri-yellow"
            @click="submitted">
            {{ $t("offer.buttons.save") }}
          </button>
        </div>
      </form>

      <!-- Add price period -->
      <template v-if="addingPricePeriod">
        <div class="price-period">
          <form
            class="price-period__content"
            @submit.prevent="addPricePeriod">
            <div class="price-period__content__header">
              <h3>
                {{ $t("offer.titles.addSeason") }}
              </h3>
              <button
                type="button"
                class="btn"
                title="Fermer"
                @click="addingPricePeriod = false"
              >
                {{ $t("offer.buttons.close") }}
              </button>
            </div>

            <label for="startDate">{{ $t("offer.infos.start") }}</label>
            <datepicker
              v-validate="'required'"
              v-model="tmp.offerPricePeriod.start_date"
              :format="DatePickerFormat"
              :disabled-dates="disabledDates"
              :required="true"
              :placeholder="$t('activity.placeholder.date')"
              :language="fr"
              :monday-first="true"
              name="startDate"
            />

            <label for="startDate">{{ $t("offer.infos.end") }}</label>
            <datepicker
              v-validate="'required'"
              v-model="tmp.offerPricePeriod.end_date"
              :format="DatePickerFormat"
              :disabled-dates="disabledDates"
              :required="true"
              :placeholder="$t('activity.placeholder.date')"
              :language="fr"
              :monday-first="true"
              name="endDate"
            />

            <wi-input
              v-validate="'required|decimal:2|min_value:0'"
              id="pricePeriod"
              v-model="tmp.offerPricePeriod.price_period"
              :error="errors.first('price-period.pricePeriod')"
              data-vv-scope="price-period"
              data-vv-as="prix"
              name="pricePeriod"
              label="Prix de la nuit pour la période"
              type="number"
              step="0.01"
            />

            <wi-input
              v-validate="'required|numeric|min_value:0'"
              id="periodMinDays"
              v-model="tmp.offerPricePeriod.min_days"
              :error="errors.first('price-period.periodMinDays')"
              data-vv-as="durée minimum"
              data-vv-scope="price-period"
              name="periodMinDays"
              label="Durée minimum du séjour"
              caption="Indiquez le nombre de jours"
            />

            <label for="use_discount">
              {{ $t("offer.infos.politic") }}
            </label>
            <div>
              <input
                id="use_discount_yes"
                v-model="tmp.offerPricePeriod.use_discount"
                data-vv-scope="price-period"
                type="radio"
                name="use_discount"
                value="yes"
              >
              <label for="use_discount_yes">
                {{ $t("offer.infos.yes") }}
              </label>
              <input
                id="use_discount_no"
                v-model="tmp.offerPricePeriod.use_discount"
                data-vv-scope="price-period"
                type="radio"
                name="use_discount"
                value="no"
              >
              <label for="use_discount_no">
                {{ $t("offer.infos.no") }}
              </label>
            </div>

            <button
              type="button"
              class="btn btn-agri-yellow-secondary"
              @click="addPricePeriod"
            >
              {{ $t("offer.buttons.addPrice") }}
            </button>
          </form>
        </div>
      </template>

      <!-- Add price discount -->
      <template v-if="addingPriceDiscount">
        <div class="price-period">
          <form
            class="price-period__content"
            @submit.prevent="addPriceDiscount"
          >
            <div class="price-period__content__header">
              <h3>
                {{ $t("offer.titles.addReduce") }}
              </h3>
              <button
                type="button"
                class="btn"
                title="Fermer"
                @click="addingPriceDiscount = false"
              >
                {{ $t("offer.buttons.close") }}
              </button>
            </div>

            <wi-input
              v-validate="'numeric|min_value:0|max_value:100'"
              id="percentageDiscount"
              v-model="tmp.offerPriceDiscount.percentage_discount"
              :error="errors.first('percentageDiscount')"
              data-vv-as="Pourcentage remise"
              name="percentageDiscount"
              label="Montant de la remise en % : "
            />

            <wi-input
              v-validate="'numeric|min_value:0'"
              id="minNights"
              v-model="tmp.offerPriceDiscount.min_nights"
              :error="errors.first('minNights')"
              data-vv-as="nombre de nuits pour atteindre la remise"
              name="minNights"
              label="À partir de combien de nuits ?"
            />

            <br >

            <button
              type="button"
              class="btn btn-agri-yellow"
              @click="addPriceDiscount"
            >
              {{ $t("offer.buttons.reduceAdd") }}
            </button>
          </form>
        </div>
      </template>
    </div>
    <CustomDialog
      v-model="showDialog"
      @close="closeDialog"
      @discard-changes="discardChanges"
      @save-changes="saveChanges"
    />
  </div>
</template>

<script>
import { mapGetters } from 'vuex'
import WiInput from '@/components/WiUI/Input'
import moment from 'moment'
import Datepicker from 'vuejs-datepicker'
import CustomDialog from '@/components/CustomDialog'

export default {
  name: 'EditOfferPrice',
  components: {
    WiInput,
    Datepicker,
    CustomDialog
  },
  data () {
    return {
      to: null,
      showDialog: false,
      moment,
      testValue: null,
      DatePickerFormat: 'dd/MM/yyyy',
      disabledDates: {
        to: new Date(Date.now() - 8640000)
      },
      addingPricePeriod: false,
      addingPriceDiscount: false,
      fr: {
        language: 'French',
        months: [
          'Janvier',
          'Février',
          'Mars',
          'Avril',
          'Mai',
          'Juin',
          'Juillet',
          'Août',
          'Septembre',
          'Octobre',
          'Novembre',
          'Décembre'
        ],
        monthsAbbr: [
          'Jan',
          'Fév',
          'Mar',
          'Avr',
          'Mai',
          'Juin',
          'Juil',
          'Août',
          'Sep',
          'Oct',
          'Nov',
          'Déc'
        ],
        days: ['Dim', 'Lun', 'Mar', 'Mer', 'Jeu', 'Ven', 'Sam'],
        rtl: false,
        ymd: false,
        yearSuffix: ''
      },
      tmp: {
        offerPricePeriod: {
          start_date: null,
          end_date: null,
          price_period: 0,
          min_days: 0,
          use_discount: 0
        },
        offerPriceDiscount: {
          percentage_discount: 0,
          min_nights: 0
        }
      },
      formData: {
        peopleCount: 2,
        pricePerPerson: null,
        minDays: 1,
        touristTax: null,
        additionalMaxPeople: 0,
        deposit: null,
        additionalTravelerPrice: 0,
        weekend: {
          price: null,
          bothDays: null
        },
        offerPriceDiscount: [],
        offerPricePeriod: []
      }
    }
  },
  beforeRouteLeave (to, from, next) {
    if (this.to) {
      next()
    } else {
      this.to = to
      this.showDialog = true
    }
  },
  fetch ({ app, route, store }) {
    return app.$axios.get(`/offers/${route.params.id}`).then(res => {
      if (res.status === 200) {
        store.commit('SET_CURRENT_OFFER', res.data)
      }
    })
  },
  computed: {
    ...mapGetters(['getCurrentOffer']),
    getPricePerNight () {
      var final =
        this.formData.pricePerPerson - this.formData.pricePerPerson * 0.05
      return final.toFixed(2)
    },
    getPricePerWeek () {
      var final =
        (this.formData.pricePerPerson - this.formData.pricePerPerson * 0.05) *
        7
      return final.toFixed(2)
    }
  },
  mounted () {
    const {
      price_discount: priceDiscount,
      price_period: pricePeriod
    } = this.getCurrentOffer

    this.formData = {
      ...this.formData,
      peopleCount: this.getCurrentOffer.people_count,
      pricePerPerson: Math.round(this.getCurrentOffer.price_per_person / 100),
      minDays: this.getCurrentOffer.min_days,
      additionalMaxPeople: this.getCurrentOffer.additional_max_people,
      deposit: Math.round(this.getCurrentOffer.deposit / 100),
      touristTax: this.getCurrentOffer.tourist_tax / 100,
      additionalTravelerPrice: Math.round(
        this.getCurrentOffer.additional_traveler_price / 100
      )
    }

    this.formData.weekend = {
      price: null,
      bothDays: null
    }

    /**
     * Handle discount
     */
    if (priceDiscount) {
      this.formData.offerPriceDiscount = [...priceDiscount]
    }

    /**
     * Handle price periods
     */
    if (pricePeriod) {
      this.formData.offerPricePeriod = [...pricePeriod]
    }

    if (this.getCurrentOffer.price_weekend) {
      const { price, both_days: bothDays } = this.getCurrentOffer.price_weekend
      this.formData.weekend = {
        price,
        bothDays: bothDays ? 'yes' : 'no'
      }
    }
  },
  methods: {
    closeDialog () {
      this.showDialog = false
      this.to = null
    },
    saveChanges () {
      this.saveOffer().then(() => {
        this.showDialog = false
        this.$router.push(this.to)
      })
    },
    discardChanges () {
      this.showDialog = false
      this.$router.push(this.to)
    },
    addPriceDiscount () {
      this.$validator.validate('price-discount.*').then(valid => {
        if (!valid) return false
        if (this.$wait.is('adding price discount')) return

        const discount = this.tmp.offerPriceDiscount
        this.$wait.start('adding price discount')
        this.$axios
          .post(`/offers/${this.getCurrentOffer.id}/discounts`, {
            offer_price_discount: Object.assign(
              {},
              {
                percentage_discount: discount.percentage_discount,
                min_nights: discount.min_nights
              }
            )
          })
          .then(res => {
            if (res.status === 201) {
              if (res.data) {
                this.$set(
                  this.formData,
                  'offerPriceDiscount',
                  res.data.price_discount
                )
              }
            }

            this.tmp.offerPriceDiscount = {
              percentage_discount: 0,
              min_nights: 0
            }
            this.addingPriceDiscount = false
          })
          .finally(() => {
            this.$wait.end('adding price discount')
          })
      })
    },
    removeDiscount (id) {
      if (this.$wait.is(`removing price discount with id ${id}`)) return

      this.$wait.start(`removing price discount with id ${id}`)
      this.$axios
        .delete(`/offers/${this.getCurrentOffer.id}/discounts/${id}`)
        .then(res => {
          if (res.status === 200) {
            if (res.data) {
              this.$set(
                this.formData,
                'offerPriceDiscount',
                res.data.price_discount
              )
              this.$forceUpdate()
            }
          }
        })
        .finally(() => {
          this.$wait.end(`removing price discount with id ${id}`)
        })
    },
    removePeriod (id) {
      if (this.$wait.is(`removing price period with id ${id}`)) return

      this.$wait.start(`removing price period with id ${id}`)
      this.$axios
        .delete(`/offers/${this.getCurrentOffer.id}/periods/${id}`)
        .then(res => {
          if (res.status === 200) {
            if (res.data) {
              this.$set(
                this.formData,
                'offerPricePeriod',
                res.data.price_period
              )
              this.$forceUpdate()
            }
          }
        })
        .finally(() => {
          this.$wait.end(`removing price period with id ${id}`)
        })
    },
    addPricePeriod () {
      this.$validator.validate('price-period.*').then(valid => {
        if (!valid) return false
        if (this.$wait.is('adding price period')) return

        const period = this.tmp.offerPricePeriod
        this.$wait.start('adding price period')
        this.$axios
          .post(`/offers/${this.getCurrentOffer.id}/periods`, {
            offer_price_period: Object.assign(
              {},
              {
                start_date: period.start_date,
                end_date: period.end_date,
                min_days: period.min_days,
                use_discount: period.use_discount === 'yes',
                price_period: Math.round(period.price_period * 100)
              }
            )
          })
          .then(res => {
            if (res.status === 201) {
              if (res.data) {
                this.$set(
                  this.formData,
                  'offerPricePeriod',
                  res.data.price_period
                )
              }
            }

            this.tmp.offerPricePeriod = {
              start_date: null,
              end_date: null,
              price_period: 0,
              min_days: 0,
              use_discount: 0
            }
            this.addingPricePeriod = false
          })
          .finally(() => {
            this.$wait.end('adding price period')
          })
      })
    },
    next () {
      this.saveOffer().then(() => {
        this.$router.push({
          name: 'EditOfferPictures'
        })
        this.showDialog = false
        this.$router.push(this.to)
      })
    },
    submitted () {
      this.saveOffer().then(() => {
        this.$router.push({
          name: 'DashboardOffers'
        })
        this.showDialog = false
        this.$router.push(this.to)
      })
    },
    saveOffer () {
      return new Promise(resolve => {
        this.$validator.validateAll().then(valid => {
          if (valid) {
            if (this.$wait.is('saving price infos')) return

            this.$wait.start('saving price infos')

            const data = {
              people_count: this.formData.peopleCount,
              price_per_person: Math.round(this.formData.pricePerPerson * 100),
              additional_traveler_price: Math.round(
                this.formData.additionalTravelerPrice * 100
              ),
              additional_max_people: this.formData.additionalMaxPeople,
              deposit: Math.round(this.formData.deposit * 100),
              tourist_tax: Math.round(this.formData.touristTax * 100),
              min_days: this.formData.minDays
            }

            if (this.formData.weekend.price !== null) {
              const { price, bothDays } = this.formData.weekend
              data.offer_price_weekend = {
                price,
                both_days: bothDays === 'yes'
              }
            }

            this.$axios
              .put(`/offers/${this.getCurrentOffer.id}`, {
                offer: data
              })
              .then(res => {
                resolve(res)
              })
              .catch(err => {
                this.$toast.error({
                  title: 'Sauvegarde tarif',
                  message: 'Impossible de sauvegarder les informations.',
                  position: 'bottom center',
                  timeOut: 8000
                })
                console.error('Error occured', err)
              })
              .finally(() => {
                this.$wait.end('saving price infos')
              })
          }
        })
      })
    }
  }
}
</script>

<style lang="scss" scoped>
@import "@/assets/scss/_variables.scss";

.tooltip {
  position: relative;
  display: inline-block;
  border-bottom: 1px dotted black;
  margin: auto;
}

.tooltip .tooltiptext {
  visibility: hidden;
  width: 300px;
  background-color: #79BC53;
  color: #fff;
  border-radius: 6px;
  padding: 5px 5px;

  /* Position the tooltip */
  position: absolute;
  z-index: 1;

  bottom: 100%;
  left: 50%;
  margin-left: -60px; /* Use half of the width (120/2 = 60), to center the tooltip */

  @media only screen and (max-width: $breakpoint-tablet) {
    width: 200px;
  }
}

.tooltip:hover .tooltiptext {
  visibility: visible;
}

.simulator-box {
  display: grid;
  grid-template-columns: auto auto;
  grid-column-gap: 2ch;
}

.simulator {
  border: 1px solid grey;
  padding: 1ch;
}

.simulator-price {
  color: $agri-green-light;
}

.table-season {
  text-align: center;
}

.td-season {
  border: 1px solid $agri-green-light;
  border-radius: 8px;
  color: $agri-green-light !important;
}

.price-box {
  margin-bottom: 55px;
}

.price-field {
  display: grid;
  grid-template-columns: 75px 150px;
}

.price-field-tax {
  display: grid;
  grid-template-columns: 75px 25px 25px;
  grid-column-gap: 5px;
}

.caution-field {
  display: grid;
  grid-template-columns: 75px 25px 150px;
  grid-column-gap: 5px;
}

.caution-mark {
  width: 15px;
  height: 15px;
  margin: auto;
}

.price-field-weekend {
  display: grid;
  grid-template-columns: 75px 85px 300px 120px;
}

.price-field-discount {
  display: grid;
  grid-template-columns: 75px 240px 75px;
  grid-column-gap: 25px;
}

.price-label {
  font-size: 20px;
  font-family: "Avenir", -apple-system, BlinkMacSystemFont, "Segoe UI", Oxygen,
    Ubuntu, Cantarell, "Open Sans", "Helvetica Neue", sans-serif;
  text-transform: uppercase;
  color: black;
}

.price-night {
  font-size: 20px;
  font-family: "Avenir", -apple-system, BlinkMacSystemFont, "Segoe UI", Oxygen,
    Ubuntu, Cantarell, "Open Sans", "Helvetica Neue", sans-serif;
}

.price-align {
  align-self: center;
  justify-self: center;
}

.title-side {
  color: black;
  font-size: 26px;
  font-weight: bold;
  text-transform: uppercase;
  font-family: "Avenir", -apple-system, BlinkMacSystemFont, "Segoe UI", Oxygen,
    Ubuntu, Cantarell, "Open Sans", "Helvetica Neue", sans-serif;
}

.subtitle {
  margin-top: 20px;
  margin-bottom: 20px;
  font-size: 12px;
  font-family: "Avenir", -apple-system, BlinkMacSystemFont, "Segoe UI", Oxygen,
    Ubuntu, Cantarell, "Open Sans", "Helvetica Neue", sans-serif;
}

.cat-title {
  font-weight: 400;
}
.price-period {
  position: fixed;
  display: flex;
  left: 0;
  top: 0;
  width: 100vw;
  height: 100vh;
  background-color: rgba(black, 0.5);

  &__content {
    max-width: 400px;
    margin: auto;
    background-color: white;
    padding: 16px;
    border-radius: 4px;

    &__header {
      display: flex;
      justify-content: space-between;
    }
  }
}

.side {
  background-color: white;
  margin: 0 auto;
  padding: 30px;
  width: 90%;
}

.body-1 em {
  font-size: 14px;
}

.housing-types__item label {
  font-size: 13px;
}

span.wi-textarea__label__wordcount {
  font-size: 12px;
}

.headline {
  padding-top: 20px;
}

.wi-input__caption {
  font-size: 14px !important;
}

.done {
  padding-top: 40px;
}

.price {
  padding-top: 32px;

  .side {
    width: 90%;
  }

  .wi-input {
    margin-bottom: 16px;
  }
}
.buttons {
  display: flex;
  justify-content: space-between;

  .btn:first-child {
    margin-right: 16px;
  }
}
</style>
