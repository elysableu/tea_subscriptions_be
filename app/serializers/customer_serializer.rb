class CustomerApiSerialzer
  include JSONAPI::Serializer

  attributes  :id,
              :first_name,
              :last_name,
              :email,
              :address
end