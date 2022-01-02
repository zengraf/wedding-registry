module OrdersHelper
  def order_display_attributes(order)
    {
      name: order.name,
      surname: order.surname,
      phone_number: TelephoneNumber.parse(order.phone_number, :pl).national_number(formatted: true),
      date: I18n.l(order.date, format: :long),
      hall: link_to(order.hall.name, order.hall),
      deposit: order.deposit,
      confirmed: order.confirmed ? '✓' : '–',
      added_by: link_to(order.added_by.display_name, order.added_by),
      created_at: order.created_at,
      updated_at: order.updated_at
    }
  end
end
