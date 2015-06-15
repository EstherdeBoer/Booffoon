module Booffoon
class ErrorMapper
  def initialize(object, attr_name)
    @object, @attr_name = object, attr_name
  end

  def errors
    attribute_errors + association_errors
  end

  def attribute_errors
    @object.errors.messages[@attr_name] || []
  end

  def association_errors
    if association_name
      @object.errors.messages[association_name.to_sym] || []
    else
      []
    end
  end

  def association_name
    return unless @object.class.respond_to?(:reflections)

    association_name = case @attr_name.to_s
    when /(\w+)_id$/
      $1
    when /(\w+)_ids$/
      $1.pluralize
    end

    if association_name && @object.class.reflections[association_name].present?
      association_name
    end
  end
end
end
