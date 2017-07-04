module Sturnus
  module Representers
    class Customer < Representable::Decorator
      include Representable::JSON
      include Representable::Coercion

      property :uid, as: :customerUid
      property :first_name, as: :firstName
      property :last_name, as: :lastName
      property :date_of_birth, as: :dateOfBirth, type: Date
      property :email
      property :phone
    end
  end
end
