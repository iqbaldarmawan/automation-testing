# frozen_string_literal: true

When(/^I click "(.+)"$/) do |element_name|
  if $environment.on_web? || $environment.on_android?
    # wait_until { element_find(element_name).click }
    element_find(element_name).click
    sleep 3
  end
end

When(/^I click "(.+)" text$/) do |element_name|
  # wait_until { element_text(element_name).click }
  element_text(element_name).click
end

When(/^I type "(.+)" on "(.+)"$/) do |text, element_name|
  if $environment.on_web?
      element_find(element_name).native.clear
      sleep(2)
      element_find(element_name).set text.to_s
  elsif $environment.on_android?
      search = element_find(element_name)
      search.send_keys(text)
 end
end

When(/^I press enter on "(.+)"$/) do |element_name|
  element_find(element_name).send_keys(:return)
end

When(/^I scroll down "(.+)" times$/) do |count|
  if $environment.on_web?
    count.to_i.times do
      $browser.execute_script 'window.scrollBy(0,200)'
      puts "scroll_down"
      sleep(1)
    end
  elsif $environment.on_android?
    count.to_i.times do
      scroll_down
      puts "scroll_down"
      sleep(1)
    end
  end
end


When (/^I open url (.+)$/) do |url|
  $browser.current_window.maximize
  $browser.visit(url)
  sleep(2)
end


When(/^I fill in the form with following details$/) do |table|
  table.hashes.each do |field|
    field_name = field['name']
    field_value = field['input']
    puts field_name

    steps %Q{
      When I type "#{field_value}" on "#{field_name}"
    }
  end
end

