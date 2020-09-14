def shake
  # Hack to cater for scenario when appium failed to find element even though it actually was there.
  # We shake the screen (i.e. micro_scrolling up, and then back down) to enforce some sort of "refresh" of the screen.
  puts 'Shaking the screen'
  micro_scroll_up(100)
  micro_scroll_down(100)
end

def scroll_up
  sleep(3)
  if $environment.on_android?
    swipe(:start_x => 100, :start_y => 400, :end_x => 0, :end_y =>950, :duration => 500)
  else
    drag_from_to_for_duration(:from_x => 10, :from_y => 200, :to_x => 10, :to_y => 350, :duration => 0.5)
  end
end

def scroll_down
  sleep(3)
  if $environment.on_android?
    swipe(:start_x => 110, :start_y => 450, :end_x => 0, :offsite_y => -450, :duration => 500)
  else
    drag_from_to_for_duration(:from_x => 10, :from_y => 80, :to_x => 10, :to_y => 50, :duration => 0.5)
  end
end

def scroll_up_fast
  sleep(3)
  if $environment.on_android?
    swipe(:start_x => 100, :start_y => 350, :end_x => 0, :end_y =>1050, :duration => 300)
  else
    drag_from_to_for_duration(:from_x => 10, :from_y => 200, :to_x => 10, :to_y => 350, :duration => 0.5)
  end
end

def scroll_down_fast
  sleep(3)
  if $environment.on_android?
    swipe(:start_x => 710, :start_y => 800, :end_x => 0, :offsite_y => -350, :duration => 500)
  else
    drag_from_to_for_duration(:from_x => 10, :from_y => 800, :to_x => 10, :to_y => 30, :duration => 0.1)
  end
end


def scroll_down_lower_screen
  sleep(3)
  if $environment.on_android?
    swipe(:start_x => 710, :start_y => 800, :end_x => 0, :offsite_y => -300, :duration => 500)
  else
    #TODO: Implementation
    #raise 'Method not yet implemented for iOS.'
  end
end

def scroll_down_upper_screen
  sleep(3)
  if $environment.on_android?
    swipe(:start_x => 710, :start_y => 550, :end_x => 0, :offsite_y => -300, :duration => 500)
  else
    #TODO: Implementation
    #raise 'Method not yet implemented for iOS.'
  end
end


def scroll_up_lower_screen
  sleep(2)
  if $environment.on_android?
    swipe(:start_x => 710, :start_y => 800, :end_x => 0, :end_y => 300, :duration => 500)
  else
    #TODO: Implementation
    #raise 'Method not yet implemented for iOS.'
  end
end

def scroll_up_upper_screen
  sleep(3)
  if $environment.on_android?
    swipe(:start_x => 710, :start_y => 250, :end_x => 0, :end_y => 300, :duration => 500)
  else
    #TODO: Implementation
    #raise 'Method not yet implemented for iOS.'
  end
end

def scroll_bottom
  sleep(3)
  previous_screen_texts = []
  subsequent_identical_screen = xScroll = 0
  while subsequent_identical_screen < 1
    #current_screen_texts = texts.collect { |element| element.text }
    if $environment.on_ios?
      current_screen_texts = find_elements(:xpath,'//XCUIElementTypeStaticText') { |element| element.text }
    elsif $environment.on_android?
      #Defined the the latest text on android by using //(Element[countLatest]).text
      current_screen_texts = find_elements(:xpath,'//android.widget.TextView') { |element| element.text }
    end
    subsequent_identical_screen = previous_screen_texts == current_screen_texts ? subsequent_identical_screen + 1 : 0
    previous_screen_texts = current_screen_texts
    scroll_down_fast
    xScroll+=1
    if xScroll > 10
      break
    end
  end
end

def scroll_top
  sleep(3)
  previous_screen_texts = []
  subsequent_identical_screen = xScroll =  0
  while subsequent_identical_screen < 1
    current_screen_texts = wait_true {
      if $environment.on_ios?
        current_screen_texts = find_elements(:xpath,'//XCUIElementTypeStaticText') { |element| element.text }
      elsif $environment.on_android?
        current_screen_texts = find_elements(:xpath,'//android.widget.TextView')[0].text # { |element| element.text }
      end
     }
    subsequent_identical_screen = previous_screen_texts == current_screen_texts ? subsequent_identical_screen + 1 : 0
    previous_screen_texts = current_screen_texts
    scroll_up_fast
    xScroll+=1
    if xScroll > 10
      break
    end
  end
end


def micro_scroll_up(offset)
  sleep(3)
  if $environment.on_android?
      swipe(:start_x => 710, :start_y => 600, :end_x => 0, :end_y => offset, :duration => 500)
  else
    drag_from_to_for_duration(:from_x => 10, :from_y => 350, :to_x => 10, :to_y => 350 + offset, :duration => 0.5)
   end
end

def micro_scroll_down(offset)
  sleep(3)
  if $environment.on_android?
    swipe(:start_x => 710, :start_y => 800, :end_x => 0, :offsite_y => -offset, :duration => 500)
  else
    drag_from_to_for_duration(:from_x => 10, :from_y => 350, :to_x => 10, :to_y => 350 - offset, :duration => 0.5)
    end
end

def fast_scroll_to(text, scroll_down_offset = nil, scroll_up_offset = nil)
  sleep(3)
  begin
    fast_scroll_down_to(text, scroll_down_offset)
  rescue StandardError
    fast_scroll_up_to(text, scroll_up_offset)
  end
end

def fast_scroll_down_to(text, offset = nil)
  sleep(3)
  #scroll_until(
  #    Proc.new { text(text).displayed },
  #    Proc.new { scroll_down },
  #    Proc.new { micro_scroll_down(offset) if offset },
  #    [Proc.new {scroll_down_lower_screen}, Proc.new{ scroll_down_upper_screen} ],
  #    "Unable to scroll down to element with text #{text}"
  #)
  xScroll = 0
  max_scroll = 10
  stopScroll = false

  begin
    xScroll+=1
    if xScroll > max_scroll
      break
    end

    begin
      puts 'Start scroll down find text'

      if text(text).displayed?
        puts "'#{text}' found!"
        stopScroll = true
      else
        puts "'#{text}' text not exists"
        stopScroll = false
      end
    rescue
      puts "rescue '#{text}' error"
      stopScroll = false
    end

    if stopScroll==false
      scroll_down
    end

  end while stopScroll == false
end

def fast_scroll_up_to(text, offset = nil)
  sleep(3)
  #scroll_until(
  #    Proc.new { text(text) },
  #    Proc.new { scroll_up },
  #    Proc.new { micro_scroll_up(offset) if offset },
  #    [Proc.new {scroll_up_lower_screen}, Proc.new{ scroll_up_upper_screen} ],
  #    "Unable to scroll up to element with text #{text}"
  #)
  xScroll = 0
  max_scroll = 10
  stopScroll = false
  begin
    xScroll+=1
    if xScroll > max_scroll
      break
    end

    begin
      puts 'Start'

      if text(text).displayed?
        puts "'#{text}' found!"
        stopScroll = true
      else
        puts "'#{text}' not exists"
        stopScroll = false
      end
    rescue
      puts "rescue '#{text}' error"
      stopScroll = false
    end

    if stopScroll==false
      scroll_up
    end

  end while stopScroll == false
end

def fast_scroll_down_to_element(element_name, offset = nil)
  sleep(3)
  #scroll_until(
  #    Proc.new { find(element_name) },
  #    Proc.new { scroll_down },
  #    Proc.new { micro_scroll_down(offset) if offset },
  #    [Proc.new {scroll_down_lower_screen}, Proc.new{ scroll_down_upper_screen} ],
  #    "Unable to scroll down to element named '#{element_name}'"
  #)
  puts "scroll down to element : '#{element_name}'"
  xScroll = 0
  max_scroll = 10
  stopScroll = false
  begin
    xScroll+=1
    if xScroll > max_scroll
      break
    end
    puts 'Start scroll down : '
    begin
      if find(element_name).displayed?
        puts "'#{element_name}' found!"
        stopScroll = true
      else
        puts "'#{element_name}' element not exists"
        stopScroll = false
      end
    rescue
      puts 'Cant find element'
      stopScroll = false
    end

    if stopScroll==false
      scroll_down
    end

  end while stopScroll == false
  puts "scroll #{xScroll} times"
end

def fast_scroll_up_to_element(element_name, offset = nil)
  sleep(3)
  #scroll_until(
  #    Proc.new { find(element_name) },
  #    Proc.new { scroll_up },
  ##    Proc.new { micro_scroll_up(offset) if offset },
  #    [Proc.new {scroll_up_lower_screen}, Proc.new{ scroll_up_upper_screen} ],
  #    "Unable to scroll up to element named '#{element_name}'"
  #)
  puts "scroll down to element : '#{element_name}'"
  xScroll = 0
  max_scroll = 10
  stopScroll = false
  begin
    xScroll+=1
    if xScroll > max_scroll
      break
    end
    puts 'Start scroll down : '
    begin
      if find(element_name).displayed?
        puts "'#{element_name}' found!"
        stopScroll = true
      else
        puts "'#{element_name}' not exists"
        stopScroll = false
      end
    rescue
      puts 'Cant find element'
      stopScroll = false
    end

    if stopScroll==false
      scroll_up
    end

  end while stopScroll == false
  puts "scroll #{xScroll} times"
end

def scroll_until(find_func, scroll_func, micro_scroll_func, alt_scroll_funcs, error_message)
  sleep(3)
  previous_screen_texts = []
  found_element = nil
  subsequent_identical_screen = 0

  while !found_element && subsequent_identical_screen < 2
    begin
      found_element = find_func.call
      micro_scroll_func.call
      return found_element
    rescue StandardError
      #current_screen_texts = texts.collect { |element| element.text }
      if $environment.on_ios?
        current_screen_texts = find_elements(:xpath,'//XCUIElementTypeStaticText') { |element| element.text }
      elsif $environment.on_android?
        current_screen_texts = find_elements(:xpath,'//android.widget.TextView') { |element| element.text }
      end
      subsequent_identical_screen += (previous_screen_texts == current_screen_texts) ? 1 : 0
      previous_screen_texts = current_screen_texts
      scroll_func.call

      #It is possible that the scroll function is blocked because of an element overlaying the scrollable area
      #Examples: the "Sort by" window in product list screens (blocks upper part of screen), and "Subtotal window" in delivery details form (blocks lower part of screen).
      alt_scroll_funcs.each do |alt_scroll_func|
        alt_scroll_func.call if subsequent_identical_screen == 2
        #current_screen_texts = texts.collect { |element| element.text }
        if $environment.on_ios?
          current_screen_texts = find_elements(:xpath,'//XCUIElementTypeStaticText') { |element| element.text }
        elsif $environment.on_android?
          current_screen_texts = find_elements(:xpath,'//android.widget.TextView') { |element| element.text }
        end
        subsequent_identical_screen -= (previous_screen_texts == current_screen_texts) ? 0 : 1
        previous_screen_texts = current_screen_texts
      end
    end
  end
  raise error_message
end
