require 'nokogiri'

module Gedcom
  module Parser
    extend self

    def parse(data)
      doc = Nokogiri::XML::Document.new
      root = Nokogiri::XML::Node.new('gedcom', doc)
      doc << root

      node_stack = [root]
      data.readlines.each do |line|
        next unless parts = line.match(/^(\d+)(?:\s+(@[^@]+@))?\s+(\S+)(?:\s+(.+))?$/)

        depth = parts[1].to_i
        if parts[3] == 'CONC'
          node_stack[depth].content += parts[4] || ''
        elsif parts[3] == 'CONT'
          node_stack[depth].content += "\n" + parts[4] || ''
        else
          node = Nokogiri::XML::Node.new(parts[3].downcase, doc)
          node['id'] = parts[2] if parts[2]
          node.content = parts[4] if parts[4]

          node_stack[depth] << node
          node_stack[depth + 1] = node
        end
      end

      doc.to_xml(:indent => 2)
    end
  end
end
