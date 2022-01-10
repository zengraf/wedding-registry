module TasksHelper
  def task_display_attributes(task)
    {
      name: task.name,
      order: link_to(task.order_id, task.order),
      description: task.description,
      start_time: I18n.l(task.start_time, format: :long),
      end_time: task.end_time ? I18n.l(task.end_time, format: :long) : '–',
      actual_price: task.actual_price,
      price: task.price
    }
  end
end
