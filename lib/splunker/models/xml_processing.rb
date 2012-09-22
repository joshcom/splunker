module Splunker
  module Models
    module XmlProcessing
      def top_node(xml_doc)
        begin
          if xml_doc.xpath("/xmlns:feed/*").size > 0
            return xml_doc.xpath("/xmlns:feed")
          end
        rescue Nokogiri::XML::XPath::SyntaxError => e
          # Ignore...
        end

        if xml_doc.xpath("/entry/*").size > 0
          xml_doc.xpath("/entry")
        else
          xml_doc
        end
      end
    end
  end
end
