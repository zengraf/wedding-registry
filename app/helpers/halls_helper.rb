module HallsHelper
  def hall_list_attributes(hall)
    {
      id: link_to(hall.id, hall),
      name: hall.name
    }
  end

  def hall_display_attributes(hall)
    {
      name: hall.name,
      created_at: hall.created_at,
      updated_at: hall.updated_at
    }
  end
end
