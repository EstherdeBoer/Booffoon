module Booffoon
module Errors
  def errors(field_name)
    if (messages = error_messages_for(field_name)).present?
      content_tag(:span, " " + messages.join(" "), "class": "error help-block")
    end
  end

  def has_error_on?(field_name)
    error_messages_for(field_name).present?
  end

  def error_messages_for(field_name)
    object.errors.messages[field_name.to_sym]
  end
end
end
