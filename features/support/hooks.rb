Before do
end

After do |scenario|
  if scenario.failed?
    begin
      if $environment.on_web?
        screenshot_fileb = "output/screenshots/browser_#{sanitize_filename(scenario.name)}.jpg"
      else
        screenshot_file = "output/screenshots/#{sanitize_filename(scenario.name)}.png"
      end
        if $environment.on_web?
          $browser.save_screenshot(screenshot_fileb)
        else
          begin
            screenshot(screenshot_file)
          rescue
         end
        end

      if $environment.on_web?
        base64_img = Base64.encode64(File.open(screenshot_fileb, 'r:UTF-8', &:read))
        embed(base64_img, 'image/png;base64')
        puts "Screenshot saved to #{screenshot_fileb} and no screenshot for API"
      else
        puts "Screenshot saved to #{screenshot_file} and no screenshot for API"
      end

    ensure
      puts 'Force-quitting driver as scenario failed.'
        if $environment.on_web?
          Capybara.current_session.driver.quit
        end
      end
    end
  end

def sanitize_filename(filename)
  filename.gsub!(/^.*(\\|\/)/, '')
  filename.gsub!(/[^0-9A-Za-z.\-]/, '_')
  filename.gsub!(' ', '_')
  filename[0..200]
end

def driver_session_exists?
  begin
    driver.device_time
    puts "Driver device time ==> #{driver.device_time}"
    true
  rescue StandardError
    false
  end
end