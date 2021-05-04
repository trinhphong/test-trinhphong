API_VERSIONS = [:v1]

defaults format: :json do
  namespace :api do
    API_VERSIONS.each do |version|
      draw :api, version
    end
  end
end
