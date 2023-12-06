# frozen_string_literal: true

require 'securerandom'

FactoryBot.define do
  factory :user do
    uid        { SecureRandom.uuid }
    provider   { User.providers['github'] }
    email      { 'sample@berkeley.com' }
    first_name { 'John' }
    last_name  { 'Reese' }
  end

  trait :github_user do
    provider   { User.providers['github'] }
  end

  trait :google_user do
    provider   { User.providers['google_oauth2'] }
  end
end
