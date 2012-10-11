class Layer < ActiveRecord::Base
  belongs_to :category
  belongs_to :data_source
  has_and_belongs_to_many :contexts
  attr_accessible :description, :name, :title, :wms_url, :data_source_id, :category_id, :category
end
