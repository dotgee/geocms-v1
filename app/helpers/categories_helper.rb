module CategoriesHelper
  def nested_categories(categories)
    categories.map do |message, sub_categories|
      render(message) + content_tag(:div, nested_categories(sub_categories), :class => "nested_categories")
    end.join.html_safe
  end
end
