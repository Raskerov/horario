require 'spec_helper'
ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../config/environment', __dir__)
# Prevent database truncation if the environment is production
abort("The Rails environment is running in production mode!") if Rails.env.production?
require 'rspec/rails'
require 'devise'
require 'capybara/rails'
require 'capybara/cuprite'
require 'capybara/rspec'
require 'capybara/email/rspec'

Dir[Rails.root.join('spec', 'support', '**', '*.rb')].each { |f| require f }

Capybara.server = :puma
Capybara.register_driver :chrome do |app|
  args = { window_size: [1440, 700], headless: true, timeout: 30, process_timeout: 30 }

  Capybara::Cuprite::Driver.new(app, args)
end
Capybara.javascript_driver = :chrome
Capybara.server_port = 31337
Capybara.automatic_label_click = true
Capybara.default_max_wait_time = 5

begin
  ActiveRecord::Migration.maintain_test_schema!
rescue ActiveRecord::PendingMigrationError => e
  puts e.to_s.strip
  exit 1
end

RSpec.configure do |config|
  config.include Devise::Test::ControllerHelpers, type: :controller
  config.include Devise::Test::IntegrationHelpers, type: :feature
  config.include FactoryBot::Syntax::Methods
  config.include Support::Auth

  config.use_transactional_examples = false
  config.infer_spec_type_from_file_location!

  before_executed = false
  config.before(:suite) do
    DatabaseCleaner.clean_with(:truncation)
    unless before_executed
      FactoryBot.lint traits: true
      DatabaseCleaner.clean_with(:truncation)
      before_executed = true
    end
  end

  config.around(:each) do |example|
    Rails.cache.clear

    DatabaseCleaner.strategy = if example.metadata[:cleanup_strategy]
                                 example.metadata[:cleanup_strategy]
                               else
                                 example.metadata[:js] ? :truncation : :transaction
                               end

    DatabaseCleaner.cleaning do
      example.run
    end
  end

  config.after(:suite) do
    FileUtils.rm_rf(Rails.root.join('tmp', 'storage'))
  end
end
