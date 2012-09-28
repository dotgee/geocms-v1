class User < ActiveRecord::Base
  authenticates_with_sorcery!

  belongs_to :account

  attr_accessible :email, :password, :password_confirmation, :username, :account

  validates_confirmation_of :password
  validates_presence_of :password, :on => :create

  validates_presence_of :username
  validates_uniqueness_of :username
  validates_presence_of :email
  validates_uniqueness_of :email
end
