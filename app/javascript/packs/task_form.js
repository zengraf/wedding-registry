import 'flatpickr/dist/flatpickr.min.css'
import 'jquery-ui/themes/base/all.css'

import 'flatpickr'
import 'jquery-ui/ui/widgets/autocomplete'

$(() => {
  $('#task_start_time').flatpickr({
    defaultDate: orderDate,
    enableTime: true
  })
  $('#task_end_time').flatpickr({
    enableTime: true
  })

  const templates = [
    {
      name: 'Kwiaty S',
      description: 'Róże: 100, piwonie: 50, hortensje: 25',
      actual_price: 1500,
      price: 3999
    },
    {
      name: 'Kwiaty M',
      description: 'Róże: 250, piwonie: 125, hortensje: 75',
      actual_price: 3000,
      price: 6999
    },
    {
      name: 'Kwiaty L',
      description: 'Róże: 500, piwonie: 250, hortensje: 150',
      actual_price: 6000,
      price: 9999
    },
    {
      name: 'Zespół muzyczny GeminiX',
      actual_price: 7400,
      price: 8499
    },
    {
      name: 'Zespół muzyczny Kapelusze',
      actual_price: 5500,
      price: 6999
    }
  ]

  $('#task_name').autocomplete({
    minLength: 1,
    source: templates.map((t) => t['name']),
    select: function(event, ui) {
      const template = templates.find((t) => t['name'] === ui.item.value)
      if (template != null) {
        $('#task_description').val(template['description'])
        $('#task_actual_price').val(template['actual_price'])
        $('#task_price').val(template['price'])
      }
    }
  })
})
