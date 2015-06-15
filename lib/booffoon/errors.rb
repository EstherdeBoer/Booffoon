module Booffoon
module Errors
  def errors(field_name)
    if (messages = fetch_errors(field_name)).present?
      content_tag(:span, " " + messages.join(" "), "class": "error help-block")
    end
  end

  def has_error_on?(field_name)
    fetch_errors(field_name).present?
  end

  private

  def fetch_errors(field_name)
    ErrorMapper.new(object, field_name).errors
  end
end
end
