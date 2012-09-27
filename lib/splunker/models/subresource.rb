module Splunker::Models
  module Subresource
    module ClassMethods
      def find_as_subresource(service_path, object_id, subresource, options={})
        object_path = "#{service_path}/#{escape_object_id(object_id)}/#{subresource}"
        self.new(self.client.get(object_path, options))
      end

      def where(options={})
        raise NoMethodError, "Finders not available for subresources."
      end

      def find_all(options={})
        raise NoMethodError, "Finders not available for subresources."
      end

      def find_by_id(object_id, options={})
        raise NoMethodError, "Finders not available for subresources."
      end
    end

    def self.included(base)
      base.send(:extend, ClassMethods)
    end
  end
end
