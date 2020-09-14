# frozen_string_literal: true

Given(/^I open ".+" app$/) do
  wait_gone('Loading Screen Logo', 10)
end

When(/^I click "(.+)"$/) do |element_name|
  if $environment.on_web?
  # wait_until { element_find(element_name).click }
  element_find(element_name).click
  sleep 3
  elsif $environment.on_android?
    element = wait_find(element_name)
    begin
      element.click
    rescue
      puts 'Failed to click found element.  Clicking on its location instead'
      element = wait_find(element_name)
      Appium::TouchAction.new.tap(:x => element.location.x, :y => element.location.y).release.perform
    end
  end
end

When(/^I click "(.+)" text$/) do |element_name|
  # wait_until { element_text(element_name).click }
  element_text(element_name).click
end

When(/^I click element "(.+)" "(.+)" times$/) do |element_name, count|
  if $environment.on_web?
    element_selector = $mapper.to_element_selector(element_name)
    count_number = count.to_i
    (0..count_number).each do |_i|
      begin
        $browser.find_by_id(element_selector).click
        sleep 2
      rescue StandardError
        $browser.find(:xpath, element_selector).click
        sleep 2
      end
    end
  end
end

When(/^I click "(.+)" "(.+)" times$/) do |element_name, count|
  if $environment.on_web? || $environment.on_mweb?
    element_selector = $mapper.to_element_selector(element_name)
    count_number = count.to_i
    (0..count_number).each do |_i|
        $browser.find(:xpath, element_selector).click
        sleep 1
      end
    end
  end

When(/^I click item product "(.+)" "(.+)" times$/) do |element_name, count|
  if $environment.on_mweb?
    id_item = $mapper.to_element_selector(element_name)
    begin
      sleep 4
      element_find("//*[@id='button-add-#{id_item}']").click
    rescue
    end
    count_number = count.to_i
    (1...count_number).each do |_i|
    element_find("//*[@id='button-plus-#{id_item}']").click
    end
    sleep 8
  elsif $environment.on_web?
    steps 'And I wait for "6" seconds'
    element_find("//img[@alt='#{element_name}']").hover
    begin
    sleep 3
    element_find("//h2[text()='#{element_name}']/../div[3]/div[2]/button").click
    rescue StandardError
    end
    count_number = count.to_i
    (1...count_number).each do |_i|
      element_find("//h2[text()='#{element_name}']/../div[3]/div[2]/div/button[2]").click
    end
    sleep 7
  end
end

When(/^I type "(.+)" on "(.+)"$/) do |text, element_name|
  if $environment.on_web?
    element_find(element_name).native.clear
    sleep(2)
    element_find(element_name).set text.to_s
  if $environment.on_android?
    begin
      search = wait_find(element_name)
      search.clear
      wait(DEFAULT_TIMEOUT) { search.text == "iconBack" }
      search.click
      search.send_keys(text)
    rescue
    type_on_old(text, element_name)
    end
  end
 end
end

When(/^I type random number on "(.+)"$/) do |element_name|
  new_phone = rand_phone_number
  user_new_phone = "123123#{new_phone}"
  element_find(element_name).set user_new_phone.to_s
end

When(/^I type random email on "(.+)"$/) do |element_name|
  new_phone = rand_phone_number
  user_new_phone = "test#{new_phone}@gmail.com"
  element_find(element_name).set user_new_phone.to_s
end

When(/^I clear field on "(.+)"$/) do |element_name|
  field = element_find(element_name)
  field.native.clear
  sleep(5)
end

When(/^I press delete "(.+)" times on field "(.+)"$/) do |count, element_name|
  count_number = count.to_i
  (0..count_number).each do |_i|
    field = element_find(element_name)
    field.send_keys [:backspace]
  end
end

When(/^I press enter on "(.+)"$/) do |element_name|
  element_find(element_name).send_keys(:return)
end

When(/^I scroll down "(.+)" times$/) do |count|
  if $environment.on_web? || $environment.on_mweb?
  count.to_i.times do
    $browser.execute_script 'window.scrollBy(0,200)'
    sleep(1)
    end
  end
end


When (/^I open url (.+)$/) do |url|
  $browser.current_window.maximize
  $browser.visit(url)
  sleep(2)
end

def type_on_old(text, element_name)
  search = wait_find(element_name)
  begin
    search.clear
    wait(DEFAULT_TIMEOUT) { search.text == "iconBack" }
    search.click
    search.send_keys(text)
  end
end

When(/^I fill in the form with following details$/) do |table|
  table.hashes.each do |field|
    field_name = field['name']
    field_value = $mapper.replace_random(field['input'])
    puts field_name

    steps %Q{
      When I type "#{field_value}" on "#{field_name}"
    }
  end
end

