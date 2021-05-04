module ApiStandardizer::Response
  MAPPING_KEYS = {
    id: :_id
  }.freeze

  ALIAS_KEYS = {
    key: :id
  }.freeze

  extend ActiveSupport::Concern

  def render_success(data, status: :ok)
    render(
      status: status_to_code(status),
      json: {
        success: true,
        statusCode: status_to_code(status),
        data: render_data(data)
      }
    )
  end

  def render_error(message, status: :unprocessable_entity)
    render(
      status: status_to_code(status),
      json: {
        success: false,
        statusCode: status_to_code(status),
        message: message,
        error: message
      }
    )
  end

  def status_to_code(status)
    Rack::Utils::SYMBOL_TO_STATUS_CODE[status]
  end

  def render_data(data)
    json = ActiveModelSerializers::SerializableResource.new(data).as_json
    return standardize_response_keys(json) if json.kind_of?(Hash)

    { items: json.map { |h| standardize_response_keys(h) } }
  end

  def standardize_response_keys(hash)
    hash.deep_transform_keys { |key| MAPPING_KEYS[key.to_sym] || key.to_s.camelize(:lower) }
      .merge(ALIAS_KEYS.transform_values { |new_key| hash[new_key] || hash[new_key.to_s] })
  end
end
