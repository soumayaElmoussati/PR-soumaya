<template>
  <client-only>
    <FullCalendar
      :plugins="calendarPlugins"
      :event-color="'grey'"
      :header="{
        left: 'prev,next today',
        center: 'title',
        right: 'dayGridMonth,timeGridWeek,timeGridDay,listWeek'
      }"
      :events="events"
      :selectable="true"
      :select-overlap="false"
      :first-day="1"
      locale="fr"
      default-view="dayGridMonth"
      @eventClick="handleEventClick"
      @select="handleDateSelection"
    />
  </client-only>
</template>

<script>
import FullCalendar from '@fullcalendar/vue'
import dayGridPlugin from '@fullcalendar/daygrid'
import timeGridPlugin from '@fullcalendar/timegrid'
import interactionPlugin from '@fullcalendar/interaction'

import frLocale from '@fullcalendar/core/locales/fr'

export default {
  components: {
    FullCalendar,
    frLocale,
    timeGridPlugin,
    interactionPlugin
  },
  props: {
    events: {
      type: Array,
      default: function () {
        return []
      }
    }
  },
  data () {
    return {
      calendarPlugins: [dayGridPlugin, timeGridPlugin, interactionPlugin]
    }
  },
  computed: {
    selectionContraints () {
      return this.events.map(event => {
        return {
          startTime: event.start,
          endTime: event.end
        }
      })
    }
  },
  methods: {
    handleDateSelection (selectionInfo) {
      this.$emit('on-dates-selection', selectionInfo)
    },
    handleEventClick (eventClickInfo) {
      this.$emit('on-event-click', eventClickInfo)
    }
  }
}
</script>
