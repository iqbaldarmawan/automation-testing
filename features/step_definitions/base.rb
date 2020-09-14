def wait_until
  if  $environment.on_web?
  Timeout.timeout(8) do
    sleep(0.1) until value = yield
  end
 end
end

def element_find(element_name)
  if $environment.on_web?
  element_selector = $mapper.to_element_selector(element_name)
  begin
    if element_selector.start_with?('/')
      $browser.find(:xpath, element_selector)
    else
      $browser.find(:id, element_selector)
    end
  rescue StandardError
    raise "Unable to find web element: #{element_name}. Element selector is: #{element_selector}"
  end
 end
end

def element_text(text)
  if  $environment.on_web?
  begin
  $browser.find(:xpath, "//*[contains(text(), '#{text}')]")
  rescue StandardError
    begin
    $browser.find(:xpath,"//*div[text()='#{text}']")
    rescue
    $browser.find(:xpath,"//*strong[text()='#{text}']")
    raise "Unable to find text: #{text}"
    end
  end
 end
end

def assertion_text(element_name)
  if  $environment.on_web?
    # $browser.find("#app").text.should include(text)
    $browser.assert_text(:visible,element_name)
  else
    #wait(wait_time ? wait_time.to_i : DEFAULT_TIMEOUT) { element_text(text).displayed? }
    element_text(element_name).displayed?
  end
end

