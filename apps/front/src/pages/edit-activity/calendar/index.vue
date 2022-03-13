<template>
  <div>

    <Calendar
      :events="bookingsForCalendar"
      @on-dates-selection="handleDateSelection"
      @on-event-click="handleEventClick"
    />

    <div class="legend">
      <div class="legend-member">
        <span class="rectangle agrivillage" />
        <label>{{ $t("activity.titles.siteName") }}</label>
      </div>

      <div class="legend-member">
        <span class="rectangle manual" />
        <label>{{ $t("activity.titles.unavailable") }}</label>
      </div>
    </div>

    <modal
      :scrollable="true"
      :adaptive="true"
      height="auto"
      width="400px"
      name="add-new-unavailable-event"
    >
      <div class="modal-calendar">
        <h3>{{ $t("activity.titles.dateUnavailable") }}</h3>
        <hr >

        <div class="unavailable-event-modal-dates-container">
          <div class="left-column">
            <span>{{ $t("activity.titles.selectDate") }}</span>
          </div>
          <div class="right-column">
            <datepicker
              v-model="unavailableEvent.start"
              :disabled="!!unavailableEvent.id"
              class="first-date-picker"
            />
            <datepicker
              v-model="unavailableEvent.end"
              :disabled="!!unavailableEvent.id"
              :disabled-dates="{to: unavailableEvent.start}"
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
            label="Note (optional)"
            word-count
          />
        </div>

        <br>

        <div class="unavailable-event-buttons-container">
          <button
            v-if="!!unavailableEvent.id"
            type="submit"
            class="btn btn-agri-yellow"
            @click="deleteUnavailableEvent"
          >
            <span v-if="!$wait.is('deleting_unavailable_event')">{{ $t("activity.buttons.delete") }}</span>
            <wi-spinner v-else />
          </button>
          <button
            v-if="!unavailableEvent.id"
            type="submit"
            class="btn btn-agri-yellow"
            @click="saveUnavailableEvent"
          >
            <span v-if="!$wait.is('creating_unavailable_event')">{{ $t("activity.buttons.save") }}</span>
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
        @click="submitted"
      >
        {{ $t("activity.buttons.save") }}
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
      unavailableEvent: {}
    }
  },
  computed: {
    ...mapGetters(['getCurrentActivityBookings', 'getCurrentActivity']),
    bookingsForCalendar: function () {
      return this.getCurrentActivityBookings.map(activityBooking => {
        let color = 'red'
        let title = ''

        switch (activityBooking.provider) {
          case 'agrivillage':
            color = 'green'
            break
          case 'manual':
            color = 'grey'
            title = activityBooking.notes || ''
            break
        }

        return {
          ...activityBooking,
          // rendering: 'background',
          allDay: true,
          classNames: ['agrivillage-calendar-event'],
          backgroundColor: color,
          id: activityBooking.id,
          title: title
        }
      })
    }
  },
  fetch ({ app, route, store }) {
    return app.$axios.get(`/activities/${route.params.id}/activity_bookings`).then(res => {
      if (res.status === 200) {
        store.commit('SET_CURRENT_ACTIVITY_BOOKINGS', res.data)
      }
    })
  },
  methods: {
    submitted () {
      this.$router.push({
        name: 'DashboardActivities'
      })
    },
    deleteUnavailableEvent () {
      this.$wait.start('deleting_unavailable_event')

      this.$axios
        .delete(
          `/activities/${this.$route.params.id}/external_activity_bookings/${this.unavailableEvent.id}`
        )
        .then(res => {
          if (res.status === 200) {
            this.$store.commit('SET_CURRENT_ACTIVITY_BOOKINGS', res.data)
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
        .post(`/activities/${this.$route.params.id}/external_activity_bookings`, {
          external_activity_booking: this.unavailableEvent
        })
        .then(res => {
          if (res.status === 200) {
            this.$store.commit('SET_CURRENT_ACTIVITY_BOOKINGS', res.data)
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
    refreshBookings: function () {
      this.$wait.start('refreshing_bookings')
      this.$axios
        .post(`/activities/${this.$route.params.id}/activity_bookings/refresh`)
        .then(res => {
          if (res.status === 200) {
            this.$store.commit('SET_CURRENT_ACTIVITY_BOOKINGS', res.data)
          }
        })
        .finally(() => {
          this.$wait.end('refreshing_bookings')
        })
    }
  }
}
</script>

<style lang='scss'>
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
