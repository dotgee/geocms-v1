class Account < ActiveRecord::Base
  has_many :users
  has_many :categories, :dependent => :destroy
  has_many :layers, :through => :categories

  attr_accessible :name, :subdomain
end
