def long_press_cart_item
	touch(60,850,2000)
end

def long_press_cart_item_middle
	touch(60,960,2000)
end


def press_last_tab_cart
	Appium::TouchAction.new.tap(:x => 315, :y => 64).release.perform
end

def touch(x,y,duration)
  Appium::TouchAction.new.long_press(x: x, y: y, duration: duration).perform
end
