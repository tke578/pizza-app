ENV["RAILS_ENV"] ||= "test"
require_relative "../config/environment"
require "rails/test_help"
require "minitest/rails"
require 'database_cleaner/active_record'

# DatabaseCleaner.strategy = :truncation

module ActiveSupport
  class TestCase
    # Run tests in parallel with specified workers
    parallelize(workers: :number_of_processors)

    # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
    fixtures :all
    include FactoryBot::Syntax::Methods
    include Devise::Test::IntegrationHelpers
    include Warden::Test::Helpers

    def sign_in(user)
      post(
        user_session_url,
        params: {
          "user[email]" => user.email,
          "user[password]" => "password1!"
        }
      )
    end

    class << self
      alias context describe
    end
  end
end

module Minitest
  class Spec
    # Add more helper methods to be used by all tests here...
    class << self
      alias context describe
    end
    before :each do
      DatabaseCleaner.start
    end

    after :each do
      DatabaseCleaner.clean
    end
  end
end
