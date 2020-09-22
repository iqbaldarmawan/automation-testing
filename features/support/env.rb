require 'cucumber'
require 'touch_action'
require 'touch_action/capybara_rspec_helper'
require 'rake/file_utils'
require 'yaml'
require 'securerandom'
require 'date'
require 'cucumber-api'
require 'appium_lib'
require_relative 'appium/appium_wait'
require_relative 'appium/appium_scroll'
require_relative 'appium/appium_patches'
require_relative 'appium/appium_search'
require_relative 'appium/appium_touch'
require_relative 'environment'
require_relative 'capybara'
require_relative 'mappings/mapper'
# require_relative '../../libs/cucumber-api/lib/cucumber-api'
require_relative '../../libs/report_builder/lib/report_builder'


class AppiumWorld
end

class Browser
  include Capybara::DSL
end

DEFAULT_TIMEOUT = 30
$environment = Environment.new
$mapper = Mapper.new($environment)

if $environment.on_android?

  capabilities = {
      caps:{
          "platformName": "Android",
          "paltformVersion": "7.0",
          "deviceName": "Android",
          "app": "assets/login.apk",
          "unicodeKeyboard": "false",
          "resetKeyboard": "false"
      },
      appium_lib:{
          server_url: "http://0.0.0.0:4723/wd/hub",
          wait: 10
      }
  }

  @driver = Appium::Driver.new(capabilities, true)
  Appium.promote_appium_methods Object

elsif $environment.on_web?
  $browser = Browser.new
  Selenium::WebDriver.logger.level = :error
end

at_exit do
  platform_name = $environment.platform_name
  input_path = 'output'
  reportTime = Time.now.strftime("%d/%m/%Y %H:%M")
  options = {
       input_path: input_path,
       html_report_path: 'output/report/automation-report-' + platform_name,
       report_types: ['JSON', 'HTML'],
       report_title: ' ['+reportTime+'] Automation Report ' + platform_name,
       additional_info: {'Platform' => platform_name},
       color: 'indigo'
     }

  ReportBuilder.build_report options
end
