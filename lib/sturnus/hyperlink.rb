module Sturnus
  class Hyperlink
    attr_reader :link, :templated

    def initialize(link, templated)
      @link = link
      @templated = templated
    end

    def get
      model_klass_with(link: link)&.get
    end

    private

    def model_klass_with(link:)
      matching_key = models.keys.detect { |key| link.match(key) }

      models[matching_key]
    end

    def models
      Sturnus.models
    end
  end
end
