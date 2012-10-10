class Account < ActiveRecord::Base
  include Preferences
  # extend FriendlyId

  # friendly_id :name, use: :slugged
  
  has_many :users, dependent: :destroy
  accepts_nested_attributes_for :users

  has_many :categories, dependent: :destroy
  has_many :layers, through: :categories
  has_many :contexts, dependent: :destroy
  
  preference :longitude , -1.676239
  preference :latitude  , 48.118434
  preference :zoom      , 4

  validates_presence_of :name
  validates_uniqueness_of :name
  validates_presence_of :subdomain
  validates_uniqueness_of :subdomain

  attr_accessible :name, :subdomain, :users_attributes

end
