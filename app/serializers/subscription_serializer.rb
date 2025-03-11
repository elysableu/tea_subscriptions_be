class SubscriptionSerializer
  include JSONAPI::Serializer

  attributes  :id,
              :title,
              :price,
              :status,
              :frequency

  has_many :teas, serializer: TeaSerializer
  has_many :customers, serializer: CustomerSerializer
end