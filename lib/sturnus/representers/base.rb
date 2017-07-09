module Sturnus
  module Representers
    class Base < Representable::Decorator
      include Representable::JSON
      include Representable::Coercion

      property :_links
    end
  end
end
