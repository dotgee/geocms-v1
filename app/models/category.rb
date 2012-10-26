class Category < ActiveRecord::Base
  extend FriendlyId
  friendly_id :name, :use => :scoped, :scope => :account

  has_many :layers, dependent: :destroy
  acts_as_tenant(:account)

  has_ancestry
  acts_as_list scope: [:account_id, :ancestry]

  scope :receiver, where(:default => true)
  scope :with_layers, select([:name, :id, :ancestry]).includes(:layers).ordered_by_ancestry

  attr_accessible :name, :position, :parent_id, :default

  before_save :cache_ancestry
  def cache_ancestry
    self.names_depth_cache = path.map(&:name).join('/')
  end

  def self.json_tree(nodes)
    nodes.map do |node, sub_nodes|
      { "name" => node.name,
        "id" => node.id,
        "layers" => node.layers.compact,
        "children" => json_tree(sub_nodes).compact 
      } 
    end
  end
end
