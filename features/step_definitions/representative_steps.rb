# frozen_string_literal: true

When /^I navigate to the (.* County) in (.*)$/ do |county, state|
  state = State.find_by(name: state)
  address = "#{county} #{state}"
  visit search_representatives_path(address: address)
end

Given('I create the following representative:') do |table|
  table.hashes.each do |representative_data|
    Representative.create!(representative_data)
  end
end

Then("I should see the representative's photo with src {string}") do |expected_src|
  expect(page).to have_selector("img[src='#{expected_src}']")
end
