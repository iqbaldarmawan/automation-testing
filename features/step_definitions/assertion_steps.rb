# frozen_string_literal: true

Then(/^I should see "(.+)"$/) do |element_name|
  if  $environment.on_web?
    element_find(element_name)
  if  $environment.on_android?
    element_text_mobile(element_name).displayed?
  end
 end
end

Then(/^I should see (.+) text$/) do |element_name|
  if  $environment.on_web?
  assertion_text(element_name)
  end
end

Then(/^I should have "(.+)" showing up "(.+)"$/) do |element_name, expected_text|
  element_find(element_name).text.downcase.should == expected_text.downcase
end

Then(/^I should have "(.+)" included "(.+)"$/) do |element_name, expected_text|
  element_find(element_name).text.downcase.should include(expected_text.downcase)
end
