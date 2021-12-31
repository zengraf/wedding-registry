import 'flatpickr/dist/flatpickr.min.css'

import 'flatpickr'

$(() => {
  const orderDatePicker = $('#order_date').flatpickr({
    disable: halls[orderHallId],
    defaultDate: orderDate
  })

  $('#order_hall_id').on('change', function() {
    const newHallId = $(this).val()

    orderDatePicker.set('disable', halls[newHallId])
  })
})