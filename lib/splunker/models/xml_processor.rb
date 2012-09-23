module Splunker
  module Models
    module XmlProcessor
      # TODO: Process dates as dates.
      # How to handle, in hash, things like action.email = 0 when
      #   action.email also needs to == hash...
      # Process links and other non hash nodes as NOT text.
      def hashify(xml_doc)
        hash = {}
        top_node(xml_doc).children.each do |t_node|
          hash = self.send("process_#{t_node.name}".to_sym, hash, t_node)
        end
        hash
      end

      ###
      # Defined custom processors here.  Hopefully, there ain't many!
      ###
      def process_content(hash, node)
        # So far, looks like content == dict.
        node.xpath("./s:dict/s:key").each do |key|
          hash = place_in_nested_hash(key.attribute("name").value, 
                   key.text, hash)
        end
        hash
      end

      def process_text(hash, node)
        hash
      end

      def place_in_nested_hash(name, text, hash)
        nested_hash(name.split("."), text, hash)
        hash
      end

      def nested_hash(name_array, text, hash)
        e = name_array.shift
        return text if e.nil?
        #hash[e] ||= {} TODO!
        hash[e] = {} unless hash[e].is_a?(Hash)
        hash[e] = nested_hash(name_array, text, hash[e])
        hash
      end

      def top_node(xml_doc)
        # Handle the various types of XML structure
        ["/xmlns:feed/xmlns:entry",
         "/xmlns:entry"].each do |path|
          begin
            if xml_doc.xpath("#{path}/*").size > 0
              return xml_doc.xpath(path)
            end
          rescue Nokogiri::XML::XPath::SyntaxError => e
            # Ignore...
          end
        end

        xml_doc
      end

      def method_missing(method, *args, &block)
        if self.respond_to?(method)
          self.send(method, *args, &block)
        else
          hash = args.first
          node = args[1]
          # TODO: Only text nodes
          hash[node.name] = node.text
          hash
        end
      end

      extend self
    end
  end
end
