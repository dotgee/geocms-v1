class Account < ActiveRecord::Base
  has_many :users, dependent: :destroy
  has_many :categories, dependent: :destroy
  has_many :layers, through: :categories
  has_many :contexts, through: :users_contexts, dependent: :destroy

  attr_accessible :name, :subdomain
end
