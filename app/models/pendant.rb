# frozen_string_literal: true
class Pendant < ActiveRecord::Base
  belongs_to :user
  belongs_to :artist

  has_many :pendant_records
  has_many :pendant_searches

  scope :search, ->(term) { joins(:pendant_searches).merge(PendantSearch.for(term)).distinct }

  def to_s
    name
  end
end
