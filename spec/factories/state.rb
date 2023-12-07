# frozen_string_literal: true

FactoryBot.define do
  factory :state do
    name         { 'California' }
    symbol       { 'CA' }
    fips_code    { '6' }
    is_territory { 0 }
    lat_min      { '-124.409591' }
    lat_max      { '-114.131211' }
    long_min     { '32.534156' }
    long_max     { '-114.131211' }
  end
end
