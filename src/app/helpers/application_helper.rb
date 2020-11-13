module ApplicationHelper
  def home_path()
    if staff_signed_in?
      return root_path
    end

    return new_staff_session_path
  end

  def production?
    request.host === Settings.domain.production
  end

  def bg_color
    production? ? 'bg-primary' : 'bg-warning'
  end

  def current_store
    return nil unless staff_signed_in?

    return Store.find current_staff.login_store_id
  end

  def params_debug
    return unless Rails.env.development?
    return debug(params) if ENV['PARAMS_DEBUG_ENABLED'] == 'true'
  end

  def bundle_js_path
    webpack_path = '/assets/javascripts/webpack'
    File.open("#{Rails.public_path}#{webpack_path}/manifest.json") do |json_file|
      json = JSON.parse(json_file.read)
      source_file = json['main.js']

      return content_tag(:script, nil, src: "#{webpack_path}/#{source_file}")
    end
  end

  def get_model_error_message(model, attribute)
    return nil if model.errors.details[attribute].nil?

    error = model.errors.details[attribute].first
    return nil if error.nil?

    model_name = model.class.name.downcase
    attribute_name = I18n.t "activerecord.attributes.#{model_name}.#{attribute.to_s}"
    return "#{attribute_name}#{error[:error]}"
  end
end
