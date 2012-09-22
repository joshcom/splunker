module Splunker
  module Models
    require 'cgi'
    require 'splunker/models/finders'
    require 'splunker/models/xml_processing'

    class Resource 

      attr_accessor :attributes

      TOP_ATTRIBUTE_NODES = ["id","title","updated"]

      include Finders
      include XmlProcessing

      def self.service_path(path)
        @service_path = path
      end

      def self.client
        Splunker.client
      end

      def initialize(xml_doc)
        node = top_node(xml_doc)
        self.attributes = {}

        # Grab top level entries, dynimically add methods
        # Create attributes for all top level nodes
        node.children.each do |node|
          next unless TOP_ATTRIBUTE_NODES.include?(node.name)
          write_attribute(node.name, node.text)
        end
      end

      def method_missing(method_symbol, *arguments)
        method_name = method_symbol.to_s
        if method_name =~ /(=|\?)$/
          case $1
          when "=" 
            write_attribute($`, arguments.first)
          when "?" 
            if attributes.include?($`)
              attributes[$`] ? true : false
            else
              raise NoMethodError
            end
          end 
        elsif attributes.include?(method_name)
          return attributes[method_name]
        else
          super
        end
      end
      
      def respond_to?(method_symbol, include_private=false)
        if super
          return true
        else
          method_name = method_symbol.to_s

          if method_name =~ /=$/
            true
          elsif method_name =~ /(\?)$/
            attributes.include?($`)
          else
            attributes.include?(method_name)
          end

        end
      end

      protected

      # Escapes a object ID for use in a URI
      def self.escape_object_id(id_str)
        CGI.escape(id_str)
      end

      def write_attribute(attribute,  value)
        attributes[attribute] = value
      end
    end
  end
end
