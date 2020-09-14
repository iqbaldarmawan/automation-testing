def with_misclick_handling(&block)
  # Handling misclick to product detail/category screen.
  activity_before = current_activity

  return_value = yield

  while current_activity != activity_before
    puts "Unexpected Activity Change Detected from #{activity_before} to #{current_activity}."
    back
    sleep(0.2)
  end

  return_value
end

