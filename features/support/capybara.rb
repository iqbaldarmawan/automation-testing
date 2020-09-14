require 'capybara'
require 'capybara/rspec'
require 'capybara/dsl'

Capybara.run_server = false
Capybara.default_max_wait_time = 50

if ENV['HOST']=='web' && ENV['BROWSER']=='chrome' && ENV['PLATFORM_NAME']=='browser'
  Capybara.default_driver = :selenium_chrome
elsif ENV['HOST']=='web' && ENV['BROWSER']=='firefox' && ENV['PLATFORM_NAME']=='browser'
  Capybara.default_driver = :selenium_firefox
end

Capybara.register_driver :selenium_chrome do |app|
  capabilities = Selenium::WebDriver::Remote::Capabilities.chrome(
      chromeOptions: {
          w3c: false
      }
  )
  args = ["--disable-notifications"]
  Capybara::Selenium::Driver.new(app, browser: :chrome, desired_capabilities: capabilities,:args => args)
end

Capybara.register_driver :selenium_firefox do |app|
  Capybara::Selenium::Driver.new(app, browser: :firefox, desired_capabilities: Selenium::WebDriver::Remote::Capabilities.firefox)
end