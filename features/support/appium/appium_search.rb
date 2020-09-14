def find(element_name, multidriver=false)
  #some of steps use xpath directly so dont check the mapper
  if element_name.start_with?('/')
    element_selector = element_name
  else
    element_selector = $mapper.to_element_selector(element_name)
  end


  #action on web testcase
  if $environment.on_web? ||
    begin
      if element_selector.start_with?('/')
        $browser.find(:xpath, element_selector)
        #@appium_driver.xpath(element_selector)
      else
        begin
          $browser.find(:id, element_selector)
          #@appium_driver.find_element(:accessibility_id,element_selector)
        rescue
          #@appium_driver.find(element_selector)
          $browser.find(:class, element_selector)
        end
      end
    rescue
      raise "Unable to find web element: #{element_name}.  Element selector is: #{element_selector}"
    end
  #condition if test on web + native app
  elsif multidriver==true
    begin
      if element_selector.nil?
        puts "ByText : #{element_selector}" if $environment.on_debug_mode?
        @appium_driver.find_element(:xpath,"//*[contains(@label,'#{element_selector}')]")
      else
        if element_selector.start_with?('/')
          puts "ByXpath : #{element_selector}" if $environment.on_debug_mode?
          @appium_driver.find_element(:xpath,element_selector)
        else
          puts "ByID : #{element_selector}" if $environment.on_debug_mode?
          if $environment.on_android?
            begin
              @appium_driver.find_element(:xpath,"//*[contains(@resource-id,'#{element_selector}')]")
            rescue
              @appium_driver.find_element(:xpath,"//*[@resource-id='#{element_selector}']")
            end
          elsif
            sleep(2)
            puts "//*[@name='#{element_selector}']"
            #find_element(:accessibility_id,element_selector)
            @appium_driver.find_element(:xpath,"//*[@name='#{element_selector}']")
          end
        end
      end
    rescue StandardError
      raise "[MULTIDRIVER] Unable to find element: #{element_name}.  Element selector is: #{element_selector}"
    end
  #for native app only
  else
    begin
      if element_selector.nil?
        puts "ByText : #{element_selector}" if $environment.on_debug_mode?
        text(element_selector)
      else
        if element_selector.start_with?('/')
          puts "ByXpath : #{element_selector}" if $environment.on_debug_mode?
          find_element(:xpath,element_selector)
        else
          puts "ByID : #{element_selector}" if $environment.on_debug_mode?
          if $environment.on_android?
            find_element(:xpath,"//*[contains(@resource-id,'#{element_selector}')]")
          else
            find_element(:accessibility_id,element_selector)
          end
          #if $environment.on_android?
          #  begin
          #    find_element(:xpath,"//*[contains(@resource-id,'#{element_selector}')]")
          #  rescue
          #    find_element(:xpath,"//*[@resource-id='#{element_selector}']")
          #  end
          #elsif
          #  sleep(2)
          #  puts "#{element_selector}"
          #  find_element(:accessibility_id,element_selector)
          #  #find_element(:xpath,"//*[@name='#{element_selector}']")
          #end
        end
      end
    rescue StandardError
      raise "Unable to find element: #{element_name}.  Element selector is: #{element_selector}"
    end
  end

end

def finds(element_names)
  #some of steps use xpath directly so dont check the mapper
  if element_names.start_with?('/')
    element_selector = element_names
  else
    element_selector = $mapper.to_element_selector(element_names.strip)
  end

  found_elements = nil
  if element_selector.start_with?('/')
    found_elements = find_elements(:xpath,element_selector)
  else
    if $environment.on_android?
      begin
        find_elements(:xpath,"//*[contains(@resource-id,'#{element_selector}')]")
      rescue
        find_elements(:xpath,"//*[@resource-id='#{element_selector}']")
      end
    elsif $environment.on_ios?
      #find_elements(:accessibility_id,element_selector)
      find_element(:xpath,"//*[@name='#{element_selector}']").click
    end
  end
end

def element_text_mobile(text)
      if  $environment.on_android?
        begin
          text(text)
        rescue
          find_element(:xpath,'//*[contains(@text, "'+text+'")] | //*[contains(@content-desc, "'+text+'")]')
        end
      end
    rescue StandardError
      #byebug
      #find_element_by_text(text)
      raise "Unable to find text: #{text}.  Element selector is: #{text}"
end


def find_element_by_text(text)
  page_source = driver.page_source

  current_name = nil
  StringIO.open(page_source) do |stream|
    stream.each(sep=' ') do |word|
      word = word.strip
      next if word.length < 7

      parts = /name=\"(?<content>\S+)\"/.match(word)
      if parts != nil
        current_name = parts['content']
        next
      end

      parts = /label=\"(?<content>\S+)\"/.match(word)
      if parts != nil
        if parts['content'] == text
          break
        end
        next
      end

      parts = /value=\"(?<content>\S+)\"/.match(word)
      if parts != nil
        if parts['content'] == text
          break
        end
        next
      end
    end
  end

  return nil if current_name.length == 0
  return find_element(:accessibility_id,current_name)
end

def xpath(xpath)
  begin
    find_element(:xpath,xpath)
  rescue StandardError
    raise "Unable to find element with xpath: #{xpath}"
  end
end

def xpaths(xpath)
  begin
    find_elements(:xpath,xpath)
  rescue StandardError
    raise "Unable to find elements with xpath: #{xpath}"
  end
end

def button(button_name)
  begin
    button_selector = $mapper.to_element_selector(button_name)
    button(button_selector)
  rescue
    raise "Unable to find button with selector: #{button_selector}"
  end
end

def buttons(button_name)
  begin
    button_selector = $mapper.to_element_selector(button_name)
    buttons(button_selector)
  rescue
    raise "Unable to find buttons with selector: #{button_selector}"
  end
end

def is_displayed?(type,element)
  type = type=='id'? 'accessibility_id' : type
  if find_elements(type,element).size==0
    return false
  else
    return true
  end
end

def exists?(element_name_or_selector, multidriver=false)
  begin
    if multidriver==true
      find(element_name_or_selector,multidriver)
    else
      puts element_name_or_selector
      element_name_or_selector.start_with?('/') ? xpath(element_name_or_selector) : find(element_name_or_selector)
    end
    return true
  rescue
    return false
  end
end

def not_exists?(element_name_or_selector)
  !exists?(element_name_or_selector)
end
