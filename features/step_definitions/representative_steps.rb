# frozen_string_literal: true

When /^I navigate to the (.* County) in (.*)$/ do |county, state|
  state = State.find_by(name: state)
  address = "#{county} #{state}"
  visit search_representatives_path(address: address)
end
