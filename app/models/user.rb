class User < ActiveRecord::Base
  rolify
  authenticates_with_sorcery!

  acts_as_tenant(:account)
  after_create :define_role

  attr_accessible :email, :password, :password_confirmation, :username, :account

  validates_confirmation_of :password
  validates_presence_of :password, on: :create

  validates_presence_of :username
  validates_uniqueness_of :username
  validates_presence_of :email
  validates_uniqueness_of :email

  private
  def define_role
    if account.users.empty?
      self.add_role :admin, account
    end
  end
end
