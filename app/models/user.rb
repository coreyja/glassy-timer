# frozen_string_literal: true
class User < ActiveRecord::Base
  include Clearance::User

  has_many :nails
  has_many :dabs

  has_many :pendants
  has_many :pendant_records

  has_many :photos

  has_many :push_notification_subscriptions, dependent: :destroy
  has_many :authentications, dependent: :destroy

  scope :needs_reminder, -> { where.not(id: joins(:pendant_records).merge(PendantRecord.worn_on(Time.zone.today))) }

  def self.create_from_omniauth!(auth_hash)
    create!(
      name: auth_hash[:info][:nickname],
      email: auth_hash[:info][:email],
    )
  end

  def password_optional?
    true
  end

  def email_optional?
    true
  end

  def display_name
    name || email
  end
end
