<template>
  <div class="price">
    <div class="wrap">
      <div class="side">
        <h1 class="title-side">
          {{ $t("offer.buttons.syncCalendar") }}
        </h1>
        <p class="subtitle">
          {{ $t("offer.paragraphs.syncCalendar") }}
        </p>

        <p>{{ $t("offer.paragraphs.connection") }}</p>

        <p>{{ $t("offer.paragraphs.unavailable") }}</p>

        <form
          @submit.prevent="submitted"
        >

          <wi-input
            id="icalendarUrl"
            v-model="data.icalendarUrl"
            data-vv-as="caution"
            type="tel"
            name="icalendarUrl"
            label="Avez-vous un lien iCalendar ?"
          />

          <p class="subtitle">
            <em>{{ $t("offer.paragraphs.linkSync") }}</em>
          </p>

          <br>

          <div class="buttons">
            <button
              type="submit"
              class="btn btn-agri-previous"
              @click.stop.prevent="previous"
            >
              <span
                v-if="!$wait.is('creating offer')"
              >
                {{ $t("offer.buttons.previous") }}
              </span>
              <wi-spinner
                v-else
              />
            </button>
            <button
              type="submit"
              class="btn btn-agri-yellow"
            >
              {{ $t("offer.buttons.continue") }}
            </button>

          </div>
        </form>
      </div>
    </div>
  </div>
</template>

<script>
  import { mapGetters } from 'vuex'
  import WiInput from '@/components/WiUI/Input'

  export default {
    name: 'Calendar',
    middleware: 'auth',
    components: {
      WiInput
    },
    data () {
      return {
        data: {
          icalendarUrl: null
        }
      }
    },
    fetch ({ app, route, store }) {
      return app.$axios.get(`/offers/${store.state.currentOffer.id}`)
        .then(res => {
          if (res.status === 200) {
            store.commit('SET_CURRENT_OFFER', res.data)
          }
        })
    },
    computed: {
      ...mapGetters([
        'getCurrentOffer'
      ])
    },
    mounted () {
      this.data2 = this.getCurrentOffer
    },
    methods: {
      previous () {
        this.$router.push({
          name: 'Pictures'
        })
      },

      submitted () {
        this.$validator.validateAll()
          .then((valid) => {
            if (valid) {
              if (this.$wait.is('saving calendar infos')) return

              this.$wait.start('saving calendar infos')

              if (this.data.icalendarUrl !== null) {
                this.$axios.put(`/offers/${this.getCurrentOffer.id}`, {
                  offer: {
                    icalendar_url: this.data.icalendarUrl
                  }
                })
                .then((res) => {
                  this.$store.commit(
                    'SET_CURRENT_OFFER_ICALENDAR_URLS',
                    res.data.icalendar_urls
                  )
                  this.$router.push({
                    name: 'Done'
                  })
                })
                .finally(() => this.$wait.end('saving calendar infos'))
              } else {
                this.$router.push({
                  name: 'Done'
                })
                .finally(() => this.$wait.end('saving calendar infos'))
              }
            }
          })
      }
    }
  }
</script>

<style lang="scss" scoped>
@import "@/assets/scss/_variables.scss";

.subtitle {
  color: black;
  font-family: 'Avenir', -apple-system, BlinkMacSystemFont, 'Segoe UI', Oxygen, Ubuntu, Cantarell, 'Open Sans', 'Helvetica Neue', sans-serif;
  font-size: 12px;
  text-transform: uppercase;
}

.title-side {
  color: black;
  font-size: 26px;
  font-weight: bold;
  text-transform: uppercase;
  font-family: 'Avenir', -apple-system, BlinkMacSystemFont, 'Segoe UI', Oxygen, Ubuntu, Cantarell, 'Open Sans', 'Helvetica Neue', sans-serif;
}

  .side {
    background-color:white;
    margin:0 auto;
    padding:30px;
    width:75%
  }

  .body-1 em {
    font-size:14px;
  }

  .housing-types__item label{
    font-size:13px;
  }

  span.wi-textarea__label__wordcount {
    font-size:12px;
  }

  .headline{
    padding-top:20px;
  }

  .wi-input__caption{
    font-size:14px!important;
  }

  .done{
    padding-top:40px
  }

  .price{
    padding-top: 32px;

    .side{
      width: 60%;
    }

    .wi-input{
      margin-bottom: 16px;
    }

    .buttons{
      display: flex;
      justify-content: space-between;

      .btn:first-child{
        margin-right: 16px;
      }
    }
  }

  @media screen and (max-width: 768px) {

    .price{
      padding-top: 0px;

      .side{
        width: 100%;
      }
    }
  }
</style>
