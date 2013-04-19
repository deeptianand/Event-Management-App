require 'bcrypt'
class User < ActiveRecord::Base
  include BCrypt
  has_secure_password
  has_many :event_users
  has_many :attended_events, :through => :event_users, :source => :event
  has_many :created_events,
           :class_name => 'Event'
  has_many :events

  validates_confirmation_of :password
  validates :email,:uniqueness => true
  validates_format_of :email, :with=> /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/ ,:on => :create
  validates_presence_of :password, :on => :create
end
