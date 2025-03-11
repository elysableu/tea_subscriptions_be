class TeaApiSerialzer
  include JSONAPI::Serializer

  attributes  :id,
              :title,
              :description,
              :temperature,
              :brew_time
end