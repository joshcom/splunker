module Splunker
  module Errors
    class ConfigurationError < RuntimeError; end

    class ClientError < RuntimeError; end

    # HTTP Status Errors
    class AuthenticationFailureError < ClientError; end
    class FeatureDisabledError < ClientError; end
    class PermissionDeniedError < ClientError; end
    class ObjectDoesNotExistError < ClientError; end
    class MethodNotAllowedError < ClientError; end
    class InvalidOperationError < ClientError; end
    class InternalServerError < ClientError; end

    STATUS_CODE_TO_ERROR_MAP = {
      401 => AuthenticationFailureError,
      402 => FeatureDisabledError,
      403 => PermissionDeniedError,
      404 => ObjectDoesNotExistError,
      405 => MethodNotAllowedError,
      409 => InvalidOperationError,
      500 => InternalServerError 
    } 

    def self.raise_error_for_status!(http_status, body)
      return nil if (200..299).include?(http_status)

      if STATUS_CODE_TO_ERROR_MAP[http_status]
        raise STATUS_CODE_TO_ERROR_MAP[http_status], body
      else
        raise ClientError, body
      end

      nil
    end

  end
end
