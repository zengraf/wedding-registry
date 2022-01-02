module HallsHelper
  def hall_display_attributes(hall)
    {
      name: hall.name,
      created_at: hall.created_at,
      updated_at: hall.updated_at
    }
  end
end
