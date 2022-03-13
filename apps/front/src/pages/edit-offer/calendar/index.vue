<template>
  <div>
    <div class="buttons-container">
      <button
        v-if="!getCurrentOffer.manager"
        class="btn btn-agri-yellow inline"
        @click="openModal">
        {{ $t("offer.buttons.sync") }}
      </button>
      <button
        v-if="!getCurrentOffer.manager"
        :disabled="$wait.is('refreshing_bookings')"
        class="btn btn-agri-yellow inline"
        @click="refreshBookings"
      >
        <span v-if="!$wait.is('refreshing_bookings')">{{ $t("offer.buttons.update") }}</span>
        <wi-spinner v-else />
      </button>
      <button
        v-if="!getCurrentOffer.manager"
        :disabled="$wait.is('creating_ical_file')"
        class="btn btn-agri-yellow inline"
        @click="saveIcal"
      >
        Exporter mon calendrier
      </button>
    </div>
    <div class="clear-fix" />
    <div v-if="getCurrentOffer.icalendar_urls.length > 0">
      <div>{{ $t("offer.infos.sync") }}</div>
      <ul>
        <li
          v-for="(icalendarUrl, index) in getCurrentOffer.icalendar_urls"
          :key="index"
        >
          {{ icalendarUrl }}
          <button
            class="btn btn-agri-yellow"
            @click="deleteIcalUrl(index)">
            {{ $t("offer.buttons.delete") }}
          </button>
        </li>
      </ul>
    </div>

    <div
      v-if="getCurrentOffer.manager">
      <Calendar
        :events="bookingsForCalendar"
      />
    </div>
    <div v-else>
      <Calendar
        :events="bookingsForCalendar"
        @on-dates-selection="handleDateSelection"
        @on-event-click="handleEventClick"
      />
    </div>

    <div class="legend">
      <div class="legend-member">
        <span class="rectangle agrivillage" />
        <label>{{ $t("offer.titles.siteName") }}</label>
      </div>

      <div class="legend-member">
        <span class="rectangle manual" />
        <label>{{ $t("offer.titles.unavailable") }}</label>
      </div>

      <div class="legend-member">
        <span class="rectangle external" />
        <label>{{ $t("offer.titles.import") }}</label>
      </div>
    </div>

    <modal
      :scrollable="true"
      :adaptive="true"
      width="400px"
      height="auto"
      name="synchronize-new-calendar"
    >
      <div class="modal">
        <h3>{{ $t("offer.titles.syncCalendar") }}</h3>

        <p>
          {{ $t("offer.paragraphs.syncCalendar") }}
        </p>
        <p>
          {{ $t("offer.paragraphs.unavailable") }}
        </p>
        <p>{{ $t("offer.paragraphs.connection") }}</p>

        <div class="input-container">
          <h4>{{ $t("offer.titles.stuck") }}</h4>
          <wi-input
            v-validate="'required'"
            id="icalendarUrl"
            v-model="icalendarUrl"
            :error="errors.first('icalendarUrl')"
            data-vv-as="url icalendar"
            name="icalendarUrl"
            placeholder="https://www.example/com/agenda.ics"
            label
          />
        </div>

        <div class="button-container">
          <button
            :disabled="$wait.is('adding icalendar url')"
            class="btn btn-agri-yellow"
            @click="addIcalendarUrl"
          >
            <span
              v-if="!$wait.is('adding icalendar url')"
            >{{ $t("offer.buttons.syncCalendar") }}</span
            >
            <wi-spinner v-else />
          </button>
        </div>
      </div>
    </modal>
    <modal
      :scrollable="true"
      :adaptive="true"
      height="auto"
      width="400px"
      name="add-new-unavailable-event"
    >
      <div class="modal-calendar">
        <h3>{{ $t("offer.titles.date") }}</h3>
        <hr >

        <div class="unavailable-event-modal-dates-container">
          <div class="left-column">
            <span>{{ $t("offer.infos.selectDate") }}</span>
          </div>
          <div class="right-column">
            <datepicker
              :language="fr"
              :format="DatePickerFormat"
              v-model="unavailableEvent.start"
              :disabled="!!unavailableEvent.id"
              class="first-date-picker"
            />
            <datepicker
              :language="fr"
              :format="DatePickerFormat"
              v-model="unavailableEvent.end"
              :disabled="!!unavailableEvent.id"
              :disabled-dates="{ to: unavailableEvent.start }"
            />
          </div>
        </div>

        <div class="unavailable-event-note-container">
          <wi-textarea
            id="unavailable-event-note"
            v-model="unavailableEvent.notes"
            :disabled="!!unavailableEvent.id"
            data-vv-as="note"
            name="note"
            rows="5"
            label="Note (optionnel)"
            word-count
          />
        </div>

        <br >

        <div class="unavailable-event-buttons-container">
          <button
            v-if="!!unavailableEvent.id"
            type="submit"
            class="btn btn-agri-yellow"
            @click="deleteUnavailableEvent"
          >
            <span
              v-if="!$wait.is('deleting_unavailable_event')"
            >{{ $t("offer.buttons.delete") }}</span
            >
            <wi-spinner v-else />
          </button>
          <button
            v-if="!unavailableEvent.id"
            type="submit"
            class="btn btn-agri-yellow"
            @click="saveUnavailableEvent"
          >
            <span
              v-if="!$wait.is('creating_unavailable_event')"
            >{{ $t("offer.buttons.save") }}</span
            >
            <wi-spinner v-else />
          </button>
        </div>
        <div class="clear-both" />
      </div>
    </modal>

    <div class="buttons">
      <button
        type="submit"
        class="btn btn-agri-yellow"
        @click="submitted">
        {{ $t("offer.buttons.save") }}
      </button>
    </div>
  </div>
</template>
<script>
import { mapGetters } from 'vuex'
import WiInput from '@/components/WiUI/Input'
import Datepicker from 'vuejs-datepicker'

let components = {
  WiInput,
  Datepicker
}
if (process.browser) {
  const Calendar = require('~/components/Calendar').default
  components = {
    Calendar,
    Datepicker
  }
}
export default {
  middleware: 'auth',
  components,
  data () {
    return {
      icalendarUrl: null,
      unavailableEvent: {},
      DatePickerFormat: 'dd/MM/yyyy',
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
      }
    }
  },
  computed: {
    ...mapGetters(['getCurrentOfferBookings', 'getCurrentOffer']),
    bookingsForCalendar: function () {
      return this.getCurrentOfferBookings.map(booking => {
        let color = 'red'
        let title = ''

        switch (booking.provider) {
          case 'agrivillage':
            color = 'green'
            break
          case 'manual':
            color = 'grey'
            title = booking.notes || ''
            break
        }

        return {
          ...booking,
          // rendering: 'background',
          allDay: true,
          classNames: ['agrivillage-calendar-event'],
          backgroundColor: color,
          id: booking.id,
          title: title
        }
      })
    }
  },
  fetch ({ app, route, store }) {
    return app.$axios.get(`/offers/${route.params.id}/bookings`).then(res => {
      if (res.status === 200) {
        store.commit('SET_CURRENT_OFFER_BOOKINGS', res.data)
      }
    })
  },
  methods: {
    saveIcal () {
      this.$wait.start('creating_ical_file')
      this.$axios
        .get(`/offers/${this.$route.params.id}/bookings/ical`)
        .then(response => {
          var FileSaver = require('file-saver')
          var file = new Blob([response.data], { type: 'text/plain;charset=utf-8' })

          FileSaver.saveAs(file, 'iCalendar.ics')

          this.$toast.success({
            title: 'Fichier Ical créé',
            message: 'Votre calendrier a été copié dans votre presse-papier',
            position: 'bottom center',
            timeOut: 8000
          })
        })
        .finally(() => {
          this.$wait.end('creating_ical_file')
        })
    },
    deleteUnavailableEvent () {
      this.$wait.start('deleting_unavailable_event')

      this.$axios
        .delete(
          `/offers/${this.$route.params.id}/external_bookings/${this.unavailableEvent.id}`
        )
        .then(res => {
          if (res.status === 200) {
            this.$store.commit('SET_CURRENT_OFFER_BOOKINGS', res.data)
            this.$toast.success({
              title: 'Evenement Supprimé',
              message: "Votre événement d'indisponibilité a été supprimé",
              position: 'bottom center',
              timeOut: 8000
            })
            this.$modal.hide('add-new-unavailable-event')
          }
        })
        .finally(() => {
          this.$wait.end('deleting_unavailable_event')
        })
    },
    saveUnavailableEvent () {
      this.$wait.start('creating_unavailable_event')

      this.$axios
        .post(`/offers/${this.$route.params.id}/external_bookings`, {
          external_booking: this.unavailableEvent
        })
        .then(res => {
          if (res.status === 200) {
            this.$store.commit('SET_CURRENT_OFFER_BOOKINGS', res.data)
            this.$toast.success({
              title: 'Evenement créé',
              message: "Votre événement d'indisponibilité a été créé",
              position: 'bottom center',
              timeOut: 8000
            })
            this.$modal.hide('add-new-unavailable-event')
          }
        })
        .finally(() => {
          this.$wait.end('creating_unavailable_event')
        })
    },
    handleEventClick (eventClickInfo) {
      this.unavailableEvent = {
        start: eventClickInfo.event.start,
        end: eventClickInfo.event.end,
        id: eventClickInfo.event.id,
        notes: eventClickInfo.event.extendedProps.notes
      }

      this.$modal.show('add-new-unavailable-event')
    },
    handleDateSelection (selectionInfo) {
      this.unavailableEvent = {
        start: new Date(selectionInfo.startStr),
        end: new Date(selectionInfo.endStr)
      }

      this.$modal.show('add-new-unavailable-event')
    },
    deleteIcalUrl: function (index) {
      let updatedUrls = this.getCurrentOffer.icalendar_urls.slice(0)
      updatedUrls.splice(index, 1)

      this.$axios
        .put(`/offers/${this.$route.params.id}`, {
          offer: {
            icalendar_urls: updatedUrls
          }
        })
        .then(res => {
          this.$toast.success({
            title: 'Calendrier supprimé',
            message: 'Le calendrier a bien été supprimé',
            position: 'bottom center',
            timeOut: 8000
          })
          this.$store.commit(
            'SET_CURRENT_OFFER_ICALENDAR_URLS',
            res.data.icalendar_urls
          )
        })
    },
    refreshBookings: function () {
      this.$wait.start('refreshing_bookings')
      this.$axios
        .post(`/offers/${this.$route.params.id}/bookings/refresh`)
        .then(res => {
          if (res.status === 200) {
            this.$store.commit('SET_CURRENT_OFFER_BOOKINGS', res.data)
          }
        })
        .finally(() => {
          this.$wait.end('refreshing_bookings')
        })
    },
    openModal: function () {
      this.icalendarUrl = null
      this.$modal.show('synchronize-new-calendar')
    },
    addIcalendarUrl: function () {
      this.$validator.validateAll().then(valid => {
        if (valid) {
          this.$wait.start('adding icalendar url')

          this.$axios
            .put(`/offers/${this.$route.params.id}`, {
              offer: {
                icalendar_url: this.icalendarUrl
              }
            })
            .then(res => {
              this.$modal.hide('synchronize-new-calendar')
              this.$toast.success({
                title: 'Calendrier rajouté',
                message:
                  'Le calendrier que vous venez de rajouter sera synchronisé prochainement',
                position: 'bottom center',
                timeOut: 8000
              })
              this.$store.commit(
                'SET_CURRENT_OFFER_ICALENDAR_URLS',
                res.data.icalendar_urls
              )
            })
            .catch(err => {
              this.$toast.error({
                title: 'Trop de calendriers synchronisés',
                message:
                  'Vous ne pouvez synchroniser que 3 calendriers simultanement.',
                position: 'bottom center',
                timeOut: 8000
              })
              console.error('err', err)
            })
            .finally(() => {
              this.$wait.end('adding icalendar url')
            })
        }
      })
    },
    submitted () {
      this.$router.push({
        name: 'DashboardOffers'
      })
    }
  }
}
</script>

<style lang="scss">
@import "@fullcalendar/core/main.css";
@import "@fullcalendar/daygrid/main.css";
@import "@fullcalendar/timegrid/main.css";
@import "@/assets/scss/_variables.scss";

.inline {
  display: inline-block !important;
}

.buttons-container {
  float: right;
  margin-bottom: 20px;
}

.delete-calendar-btn {
  line-height: 35px !important;
}

.clear-fix {
  clear: both;
}

.legend {
  text-align: center;
  margin-top: 15px;

  .legend-member {
    display: inline-block;
    margin-right: 10px;
  }
}

.rectangle {
  display: inline-block;
  width: 30px;
  height: 30px;
}

.agrivillage {
  background-color: green;
}

.external {
  background-color: red;
}

.manual {
  background-color: grey;
}

.modal {
  margin-top: 0vh !important;

  h3 {
    text-align: center;
  }

  .input-container {
    text-align: center;
    margin-bottom: 30px;
  }

  .button-container {
    text-align: center;

    button {
      display: inline-block;
    }
  }

  .unavailable-event-modal-dates-container {
    display: flex;
    margin-bottom: 40px;

    .left-column {
      flex: 2;
      span {
        font-weight: bold;
      }
    }

    .right-column {
      display: flex;
      .first-date-picker {
        margin-right: 10px;
      }
    }
  }

  .unavailable-event-note-container {
    margin-bottom: 20px;
  }

  .unavailable-event-buttons-container {
    float: right;
    display: flex;

    .delete-btn {
      background-color: red;
      margin-right: 5px;
    }
  }

  .clear-both {
    clear: both;
  }
}
</style>
