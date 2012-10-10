module ApplicationHelper
  def instance_or_new(instance, klass)
    return instance if instance.is_a?(klass)  
    return klass.new
  end
end
