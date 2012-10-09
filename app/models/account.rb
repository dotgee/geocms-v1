class Account < ActiveRecord::Base
  include Preferences

  has_many :users, dependent: :destroy
  has_many :categories, dependent: :destroy
  has_many :layers, through: :categories
  has_many :contexts, through: :users_contexts, dependent: :destroy
  
  preference :longitude , -1.676239
  preference :latitude  , 48.118434
  preference :zoom      , 4
  
  attr_accessible :name, :subdomain
end
