function getDate (element) {
  var date
  try {
    date = $.datepicker.parseDate(Format, element.value)
  } catch (error) {
    date = null
  }

  return date
}
var from, to
var Format = 'dd/mm/yy'
from = $('#date1').datepicker({
  dateFormat: Format
}).on('change', function () {
  to.datepicker('option', 'minDate', getDate(this))
})
to = $('#date2').datepicker({
  dateFormat: 'dd/mm/yy'
}).on('change', function () {
  from.datepicker('option', 'maxDate', getDate(this))
})
