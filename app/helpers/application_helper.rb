module ApplicationHelper
  def instance_or_new(instance, klass)
    return instance if instance.is_a?(klass)
    return klass.new
  end

  def share_link(iframe = false)
    (iframe ? "<iframe src='" : "") + "#{request.protocol}#{request.host_with_port}"
  end
end
