module ApiStandardizer::Request
  MAPPING_KEYS = {
    '_id' => 'id'
  }.freeze
  SKIPPING_KEYS = %w(format controller action).freeze
  RANSACK_SUFFIX = '_eq'.freeze

  extend ActiveSupport::Concern

  def standardized_params
    @standardize_request ||= standardize_request(params)
  end

  def standardize_request(request_params, ransack: false)
    new_params = standardize_keys(request_params, ransack: ransack)
    return new_params if ransack

    ActionController::Parameters.new(new_params)
  end

  def standardize_keys(request_params, ransack: false)
    filter_request_params(request_params).deep_transform_keys do |key|
      key = key.to_s
      mapping_key = MAPPING_KEYS[key]
      next mapping_key if mapping_key

      new_key = key.underscore
      next new_key if !ransack || new_key.end_with?(RANSACK_SUFFIX)

      new_key + RANSACK_SUFFIX
    end
  end

  def filter_request_params(request_params)
    request_params.as_json.reject { |k, _v| SKIPPING_KEYS.include?(k) }
  end
end
