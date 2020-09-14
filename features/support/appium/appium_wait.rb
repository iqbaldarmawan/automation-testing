def wait
  sleep(2)
end

def wait_dissappear(type, name, timeout: DEFAULT_TIMEOUT)
  element_selector = $mapper.to_element_selector(name)
  wait = Selenium::WebDriver::Wait.new(timeout: timeout)
  wait.until { find_elements(type,element_selector).size==0 }
end

def wait_appear(type, name, timeout: DEFAULT_TIMEOUT)
  sleep(5)
  element_selector = $mapper.to_element_selector(name)
  wait = Selenium::WebDriver::Wait.new(timeout: timeout)
  wait.until { find_elements(type,element_selector).size>=1 }
end

def wait_true(timeout = DEFAULT_TIMEOUT , &block)
  wait_true(default_wait_opts(timeout), &block)
end

def wait_xpath(xpath, timeout = DEFAULT_TIMEOUT)
  begin
    wait(timeout) { xpath(xpath) }
  rescue
    shake
    xpath(xpath)
  end
end

def wait_find(element_name, timeout = DEFAULT_TIMEOUT)
  begin
    wait(timeout) { find(element_name) }
  rescue
    find(element_name)
  end
end

def wait_enabled(element_name)
  wait_true(30) { find(element_name).enabled? }
end

def wait_button(button_name, timeout = DEFAULT_TIMEOUT)
  wait(timeout) { button(button_name) }
end

def wait_gone(element_name, timeout = DEFAULT_TIMEOUT)
  wait_true(timeout) { not_exists?(element_name) }
end

def wait_displayed(element_name, timeout = DEFAULT_TIMEOUT, multidriver=false)
  wait_true(timeout) { exists?(element_name,multidriver) }
end

def default_wait_opts(timeout)
  {
      :timeout => timeout,
      :interval => 0.2
  }
end

def with_retries(interval = 0.5, max_retry = 5)
  max_retry.times do |count|
    begin
      return yield
    rescue StandardError => e
      raise e if count == max_retry - 1
      sleep(interval)
    end
  end

end

def do_until(func, verify_func, opts = {})
  max_retry = opts[:max_retry] || 10
  interval = opts[:interval] || 0.5
  last_error = ''

  max_retry.times do |count|
    func.call rescue nil
    puts "Retries ==> #{count}"

    sleep(interval)

    begin
      verify_func_result = verify_func.call
      return verify_func_result if verify_func_result
    rescue StandardError => e
      last_error = e
    end
  end

  error_message = opts[:error_message] || last_error || "do_until failed after retrying #{max_retry} times.  You can customise this error message by passing error_message => xxx when calling this method"
  raise error_message
end
