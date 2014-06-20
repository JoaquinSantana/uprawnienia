json.array!(@products) do |product|
  json.extract! product, :id, :nr_roli, :nazwa, :opis
  json.url product_url(product, format: :json)
end
