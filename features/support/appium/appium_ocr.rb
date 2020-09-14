require 'rtesseract'
require 'mini_magick'
require 'RMagick'

def toast_message(expected_text)
  screenshot_path = 'output/screenshots/ocr'
  number_of_screenshots = 5

  take_multiple_screens(number_of_screenshots, screenshot_path)
  scan_screens(number_of_screenshots, expected_text, screenshot_path)
end

private

def take_multiple_screens(circles, path)
  circles.times do |index|
    puts "Taking screenshot # #{index + 1}"
    screenshot("#{path}/ocr_#{index}.png")
  end
end

def cropping_image(path)
  image = MiniMagick::Image.open(path)
  crop_params = ($environment.on_android? ? "700x70+80+1100" : "1536x140+0+0")
  image.crop(crop_params)
  image.write(path)
end

def zoom_and_sharping(path)
  img = Magick::Image::read(path)[0]
  new_img = img.resize_to_fit(1536, 150).sharpen(2.0)
  new_img.write(path)
end

def scan_screens(count, text, path)
  recorded_texts = []

  count.times do |index|
    puts "Checking: #{path}/ocr_#{index}.png"
    new_text = text.gsub(/\s+/, '')

    cropping_image("#{path}/ocr_#{index}.png")
    zoom_and_sharping("#{path}/ocr_#{index}.png")
    rec_text = RTesseract.new("#{path}/ocr_#{index}.png").to_s.gsub(/\s+/, '')
    recorded_texts << rec_text if rec_text != ''

    return true if rec_text.include? new_text
  end

  raise "unable to find #{text} toast message.  Found messages were #{recorded_texts}"
end


