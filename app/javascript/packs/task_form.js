import 'flatpickr/dist/flatpickr.min.css'

import 'flatpickr'

$(() => {
  $('#task_start_time').flatpickr({
    defaultDate: orderDate,
    enableTime: true
  })
  $('#task_end_time').flatpickr({
    defaultDate: orderDate,
    enableTime: true
  })
})