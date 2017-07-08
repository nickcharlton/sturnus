module Sturnus
  module Representers
    class Account < Base
      property :id
      property :name
      property :number
      property :sort_code, as: :sortCode
      property :currency
      property :iban
      property :bic
      property :created_at, as: :createdAt, type: DateTime
    end
  end
end
