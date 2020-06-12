require 'application_system_test_case'

class OrdersTest < ApplicationSystemTestCase
  def setup
    @archived = orders(:archived)
    @upcoming = orders(:upcoming)
    @confirmed = @archived
    @not_confirmed = @upcoming
    @admin = users(:daria)
    @admin.password = 'qwertyasdf1234'
    @non_admin = users(:pawel)
    @non_admin.password = 'bartoszKool1357'
  end

  test 'order info should be displayed correctly' do
    browser_log_in(@non_admin)
    visit orders_url

    assert_selector 'tr.order', id: @upcoming.id.to_s
    assert_selector 'th', text: @upcoming.id.to_s
    assert_selector 'td', text: @upcoming.name
    assert_selector 'td', text: @upcoming.surname
    assert_selector 'td', text: TelephoneNumber.parse(@upcoming.phone_number).international_number(formatted: true)
    assert_selector 'td', text: @upcoming.date
    assert_selector 'td', text: @upcoming.deposit
    assert_selector 'td', text: @upcoming.big? ? 'Duża' : 'Mała'
    assert_selector 'td', text: @upcoming.confirmed? ? 'Potwierdzone' : 'Nie potwierdzone'
  end

  test 'order should not be confirmed by default' do
    browser_log_in(@non_admin)
    visit orders_url
    click_on 'Nowe zamówienie'
    fill_in 'Imię',	with: 'Karolina'
    fill_in 'Nazwisko', with: 'Nowak' 
    fill_in 'Numer komórkowy',	with: '+48264836475'
    fill_in 'Data wesela',	with: Date.today + 2.days
    fill_in 'Płatność wstępna',	with: 2000 
    select 'Duża', from: 'Sala'
    click_on 'Zapisz'

    assert_selector :id, find('div.alert-success').text().split()[1][1..], text: 'Nie potwierdzone'
  end

  test 'upcoming orders should be in index' do
    browser_log_in(@non_admin)
    visit orders_url

    assert_selector '.order', id: @upcoming.id.to_s
  end

  test 'old orders should be in archived' do
    browser_log_in(@non_admin)
    visit archive_url

    assert_selector '.order', id: @archived.id.to_s
  end

  test 'old orders should not be in index' do
    browser_log_in(@non_admin)
    visit orders_url

    refute_selector '.order', id: @archived.id.to_s
  end

  test 'should display warning when non-admin trying to edit confirmed order' do
    browser_log_in(@non_admin)
    visit edit_order_url(@confirmed)

    assert_selector '.alert-warning'
  end

  test 'order should be in filtered by date' do
    browser_log_in(@non_admin)
    visit orders_url

    click_on 'Filtry'
    fill_in 'Od',	with: @upcoming.date - 1.day
    fill_in 'Do',	with: @upcoming.date + 1.day
    click_on 'Szukaj'

    assert_selector '.order', id: @upcoming.id.to_s
  end

  test 'order should not be in filtered by date' do
    browser_log_in(@non_admin)
    visit orders_url

    click_on 'Filtry'
    fill_in 'Od',	with: @upcoming.date - 3.day
    fill_in 'Do',	with: @upcoming.date - 1.day
    click_on 'Szukaj'

    refute_selector '.order', id: @upcoming.id.to_s
  end

  test 'order should be in filtered by status' do
    browser_log_in(@non_admin)
    visit orders_url

    click_on 'Filtry'
    select 'Nie potwierdzone', from: 'Status'
    click_on 'Szukaj'

    assert_selector '.order', id: @upcoming.id.to_s
  end

  test 'order should not be in filtered by status' do
    browser_log_in(@non_admin)
    visit orders_url

    click_on 'Filtry'
    select 'Potwierdzone', from: 'Status'
    click_on 'Szukaj'

    refute_selector '.order', id: @upcoming.id.to_s
  end

  private

  def browser_log_in(user)
    visit login_url

    fill_in 'Email', with: user.email
    fill_in 'Hasło', with: user.password

    click_on 'Zaloguj się'
  end
end
