module Splunker
  module Errors
    class AuthenticationFailureError < RuntimeError; end
    class FeatureDisabledError < RuntimeError; end
    class PermissionDeniedError < RuntimeError; end
    class ObjectDoesNotExistError < RuntimeError; end
    class MethodNotAllowedError < RuntimeError; end
    class InvalidOperationError < RuntimeError; end
    class InternalServerError < RuntimeError; end
  end
end
