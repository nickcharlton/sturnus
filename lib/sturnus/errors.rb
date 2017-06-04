module Sturnus
  module Errors
    # Generic Error
    class SturnusError < StandardError; end

    # Authentication Error
    class AuthenticationError < SturnusError; end
  end
end
