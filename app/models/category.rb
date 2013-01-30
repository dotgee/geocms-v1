class Category < ActiveRecord::Base
  extend FriendlyId
  friendly_id :name, :use => :scoped, :scope => :account

  has_and_belongs_to_many :layers
  acts_as_tenant(:account)

  has_ancestry :cache_depth => true
  acts_as_list scope: [:account_id, :ancestry]

  scope :receiver, where(:default => true)
  scope :ordered, select([:name, :id, :slug, :ancestry]).ordered_by_ancestry.order("position asc")
  attr_accessible :name, :position, :parent_id
      
  before_save :cache_ancestry

  class << self
    def for_select
      Category.sort_by_ancestry(Category.all)
    end

    def leafs
      all.reject! { |c| c.has_children? }
    end
  end

  def cache_ancestry
    self.names_depth_cache = path.map(&:name).join('/')
  end

  def self.json_tree(nodes)
    nodes.map do |node, sub_nodes|
      { "name" => node.name,
        "id" => node.id,
        "slug" => node.slug,
        "children" => json_tree(sub_nodes).compact
      }
    end
  end

  def depth_name
    ("-" * depth) + name
  end
end
