When(/^I wait until "(.*)"(?: button|component) is enabled?$/) do |component_name|
  # wait_until { element_find(component_name).enabled?.should == true }
  element_find(component_name).enabled?.should == true
end

When(/^I wait until "(.*)" is displayed?$/) do |component_name|
  # wait_until { element_find(component_name) }
  element_find(component_name)
end

When(/^I wait until "(.*)" display$/) do |component_name|
  # wait_until { element_find(component_name) }
  sleep(2)
  element_find(component_name)
end

When(/^I wait until "(.*)" is gone?$/) do |component_name|
  # wait_until { element_find(component_name).disabled?.should == true }
  element_find(component_name).disabled?.should == true
end

When(/^I wait for (.*) seconds$/) do |wait_time|
  sleep(wait_time.to_i)
end

When(/^I wait until "(.*)" display quickly$/) do |componet_text|
  element_find(componet_text)
end

When(/^I wait until "(.*)" text display$/) do |componet_text|
  wait_time=10
  sleep(3)
  begin
   # wait_until(wait_time) { $browser.assert_text(:visible,componet_text) }
    $browser.assert_text(:visible,componet_text)
  rescue
    begin
      # wait_until(wait_time) { $browser.find(:xpath,"//*[contains(text(),'#{componet_text}')]")}
      $browser.find(:xpath,"//*[contains(text(),'#{componet_text}')]")
    rescue
      # wait_until(wait_time) { $browser.find(:xpath,"//*[@value='#{componet_text}']")}
      $browser.find(:xpath,"//*[@value='#{componet_text}']")
    end
  end
end
