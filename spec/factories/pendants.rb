# frozen_string_literal: true
FactoryGirl.define do
  factory :pendant do
    name 'Pendant'
    user
    artist_group
  end
end
