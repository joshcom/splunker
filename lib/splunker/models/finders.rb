module Splunker::Models
  module Finders
    module ClassMethods
      def where(options={})
        raise NotImplemented, "Not yet implemented!"
        find(:all, options)
      end

      def find(*arguments)
        scope = arguments.slice!(0)
        options = arguments.slice!(0) || {}
        case scope
          when :all
            find_all(options)
          when :first 
            find_all(options).first
          else
            find_by_id(scope, options)
          end
      end

      def find_all(options={})
        raise NotImplemented, "Not yet implemented!"
        self.client.get @service_path, options
      end

      def find_by_id(object_id, options={})
        object_path = "#{@service_path}/#{escape_object_id(object_id)}"
        self.new(self.client.get(object_path, options))
      end
    end

    def self.included(base)
      base.send(:extend, ClassMethods)
    end
  end
end
