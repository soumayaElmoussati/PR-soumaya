
var $ = window.jQuery
var self = this
$(document).ready(function () {
  function getDate (element) {
    var date
    try {
      date = $.datepicker.parseDate(
        Format,
        element.value
      )
      console.log(date)
    } catch (error) {
      date = null
    }

    return date
  }
  var from, to
  var Format = 'yy-mm-dd'
  from = $('.datepick1').datepicker({
    dateFormat: Format,
    minDate: '+1D'
  }).on('change', function () {
    to.datepicker('option', 'minDate', getDate(this))
    self.$parent.data.date1 = from[0].value
    // self.$store.booking.from = from[0].value
    self.$store.commit('SET_BOOKING_FROM_DATE', from[0].value)
  })
  to = $('.datepick2').datepicker({
    dateFormat: Format,
    minDate: '+1D'
  }).on('change', function () {
    from.datepicker('option', 'maxDate', getDate(this))
    self.$parent.data.date2 = to[0].value
    // self.$store.booking.to = to[0].value
    self.$store.commit('SET_BOOKING_TO_DATE', to[0].value)
  })
})
