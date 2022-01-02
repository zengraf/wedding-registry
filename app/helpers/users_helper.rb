module UsersHelper
  def user_list_attributes(user)
    {
      name: user.name,
      surname: user.surname,
      email: mail_to(user.email),
      phone_number: TelephoneNumber.parse(user.phone_number, :pl).national_number(formatted: true),
      role: User.human_attribute_name("role.#{user.role}")
    }
  end

  def user_display_attributes(user)
    {
      name: user.name,
      surname: user.surname,
      email: mail_to(user.email),
      phone_number: TelephoneNumber.parse(user.phone_number, :pl).national_number(formatted: true),
      role: User.human_attribute_name("role.#{user.role}"),
      created_at: user.created_at,
      updated_at: user.updated_at
    }
  end
end
