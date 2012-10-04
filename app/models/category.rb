class Category < ActiveRecord::Base
  has_many :layers, dependent: :destroy
  acts_as_tenant(:account)

  has_ancestry
  acts_as_list scope: [:account_id, :ancestry]

  attr_accessible :name, :position, :parent_id

  before_save :cache_ancestry
  def cache_ancestry
    self.names_depth_cache = path.map(&:name).join('/')
  end
end
