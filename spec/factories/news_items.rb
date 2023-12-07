# frozen_string_literal: true

FactoryBot.define do
  factory :news_item do
    title { 'Sample News Title' }
    description { 'Sample Description' }
    link { 'http://example.com' }
    representative
  end
end
