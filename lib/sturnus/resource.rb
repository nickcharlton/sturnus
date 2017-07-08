module Sturnus
  class Resource
    attr_reader :_links

    def _links=(attr)
      @_links = attr.map do |name, link|
        [name, Hyperlink.new(link["href"], link["templated"])]
      end.to_h
    end
  end
end
