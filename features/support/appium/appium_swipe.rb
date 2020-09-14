def swipe_on_order
 	$environment.on_android{
 		swipe_screen(500,500,-400,0)
 	}

 	$environment.on_ios{
 		#swipe_screen(500,500,-400,0)
 	}

end

def swipe_on_cart
  swipe_screen(500,500,-600,0)
end

def swipe_on_cart_page
  swipe_screen(100,350,-600,200)
end

def swipe_on_delivery_checker
  if $environment.on_android?
    swipe_screen(167,476,16,550)
  else
    drag_from_to_for_duration(:from_x => 167, :from_y => 476, :to_x => 16, :to_y => 550, :duration => 0.5)
  end
end

def swipe_hide_delivery_checker
  if $environment.on_android?
    back
  else
    drag_from_to_for_duration(:from_x => 167, :from_y => 176, :to_x => 200, :to_y => 1300, :duration => 0.5)
  end
end



def swipe_screen(start_x,start_y,offset_x,offset_y)
  if $environment.on_android?
    with_misclick_handling {
      swipe(:start_x => start_x, :start_y => start_y, :offset_x => offset_x, :offset_y => offset_y, :duration => 500)
    }
  else
    drag_from_to_for_duration(:from_x => start_x, :from_y => start_y, :to_x => offset_x, :to_y => offset_y, :duration => 0.5)
  end
end

def swipe_right_delivery_checker
  if $environment.on_android?
    swipe_screen(38,754,-600,0)
  else
    drag_from_to_for_duration(:from_x => 38, :from_y => 754, :to_x => -600, :to_y => 0, :duration => 0.5)
  end
end
