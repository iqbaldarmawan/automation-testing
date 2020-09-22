Before do
  if $environment.on_android?
  @driver.start_driver
  end
end

After do |scenario|

  if scenario.failed?
    screenshot_file = "output/screenshots/#{sanitize_filename(scenario.name)}.jpg"
     if $environment.on_web?
         $browser.save_screenshot(screenshot_file)
     else
         screenshot(screenshot_file)
     end
     base64_img = Base64.encode64(File.open(screenshot_file, 'r:UTF-8', &:read))
     embed(base64_img, 'image/png;base64')
     puts "Screenshot saved to #{screenshot_file}"
    if $environment.on_android?
      @driver.driver_quit
    end
  end
end


  def sanitize_filename(filename)
    filename.gsub!(/^.*(\\|\/)/, '')
    filename.gsub!(/[^0-9A-Za-z.\-]/, '_')
    filename.gsub!(' ', '_')
    filename[0..200]
  end