ENV['RAILS_ENV'] ||= 'test'
require_relative '../config/environment'
require 'rails/test_help'

class ActiveSupport::TestCase
  # Run tests in parallel with specified workers
  parallelize(workers: :number_of_processors)

  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  # Add more helper methods to be used by all tests here...
end

module LogInHelper
  def log_in(user)
    post login_url(session: {email: user.email, password: user.password})
  end

  def log_out
    get logout_url
  end
end
 
class ActionDispatch::IntegrationTest
  include LogInHelper
end