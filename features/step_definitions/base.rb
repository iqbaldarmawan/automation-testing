def wait_until
  if  $environment.on_web?
  Timeout.timeout(8) do
    sleep(0.1) until value = yield
  end
 end
end

def element_find(element_name)

  if element_name.start_with?('/')
    element_selector = element_name
  else
    element_selector = $mapper.to_element_selector(element_name)
  end

  if $environment.on_web?
    begin
      if element_selector.start_with?('/')
        $browser.find(:xpath, element_selector)
      else
        $browser.find(:id, element_selector)
      end
    rescue StandardError
      raise "Unable to find web element: #{element_name}. Element selector is: #{element_selector}"
    end

  elsif $environment.on_android?
    begin
      if element_selector.nil?
        @driver.find_element(:xpath,"//*[contains(@label,'#{element_selector}')]")
      else
        if element_selector.start_with?('/')
          @driver.find_element(:xpath,element_selector)
        else
            begin
              @driver.find_element(:xpath,"//*[contains(@resource-id,'#{element_selector}')]")
            rescue
              @driver.find_element(:xpath,"//*[@resource-id='#{element_selector}']")
            end
        end
      end
    rescue StandardError
      raise "Unable to find element: #{element_name}.  Element selector is: #{element_selector}"
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
  elsif $environment.android?
    find_element(:xpath,'//*[contains(@text, "'+text+'")] | //*[contains(@content-desc, "'+text+'")]')
 end
end

def assertion_text(text)
  if  $environment.on_web?
    begin
      # $browser.find("#app").text.should include(text)
      $browser.assert_text(:visible,text)
    rescue
      #wait(wait_time ? wait_time.to_i : DEFAULT_TIMEOUT) { element_text(text).displayed? }
      element_text(text)
    end
  elsif  $environment.on_android?
      begin
        text(text)
      rescue
        element_text(text)
      end
    end
      rescue StandardError
    raise "Unable to find text: #{text}.  Element selector is: #{text}"
end

