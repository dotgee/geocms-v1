module CategoriesHelper
  
  def nested_categories(categories)
    categories.map do |message, sub_categories|
      render(message) + content_tag(:div, nested_categories(sub_categories), :class => "nested_categories")
    end.join.html_safe
  end

  def back_link(category)
    if category.parent
      path = [:backend, category.parent]
    else
      path = [:backend, :categories]
    end
    link_to path, :class => "m-btn blue pull-right" do
      content_tag("div", nil, :class => "clearfix")+
      content_tag("i", nil, :class => "m-icon-swapleft m-icon-white")+
      " Back"
    end
  end

  def up_link(path)
    link_to path, :class => "m-btn mini icn-only disabled" do
      content_tag('i', :class => "icon-arrow-up"){}
    end
  end

  def down_link(path)
    link_to path, :class => "m-btn mini icn-only disabled" do
      content_tag('i', :class => "icon-arrow-down"){}
    end
  end

end
