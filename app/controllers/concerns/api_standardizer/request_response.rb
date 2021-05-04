module ApiStandardizer
  module RequestResponse
    extend ActiveSupport::Concern
    include Request
    include Response
  end
end
