Given (/^I should see the results of "(.+)"$/) do |search|
  steps %Q{
    When I press enter on "Searchbar"
    When I should have "Search Result Title" included "#{search}"
  }
end

When (/^I'm on the catagory page$/) do
  steps %Q{
    When I should see "Total Item In The Category"
    Then I should see "PLP Product Name"
    And I should see "PLP Product Price After Discount"
    When I should see "PLP Prodcut Price Before Dicsount"
    Then I should see "PLP Discount Percentage"
    And I should see "PLP Product Location"
  }
end

When (/^I sorting item from the cheapest$/) do
  steps %Q{
    When I click "Sorting Dropdown"
    Then I click "Termurah" text
  }
end

Then(/^the first product price should be "([^"]*)" than the second product$/) do |sort|
  sleep(3)
  item_price_compare(sort)
end

def item_price_compare(sort)
  product1itempricetemp = $browser.find(:xpath, '//*[@id="product-explorer-container"]/div/div/div[2]/div/div[2]/div[2]/div[1]/div/div/div[2]/div[2]/p').text
  product2itempricetemp = $browser.find(:xpath, '//*[@id="product-explorer-container"]/div/div/div[2]/div/div[2]/div[2]/div[2]/div/div/div[2]/div[2]/p').text

  # remove Rp and separator from string and convert to integer
  product1itemprice = product1itempricetemp.tr('Rp,', '').to_i
  product2itemprice = product2itempricetemp.tr('Rp,', '').to_i

  compareitemprice = product1itemprice <=> product2itemprice

  if compareitemprice != 0
    if sort.eql?('lower') && compareitemprice != -1
      raise 'The first product price is not lower than the second product'
    elsif sort.eql?('higher') && compareitemprice != 1
      raise 'The first product price is not higher than the second product'
    end
  end
end