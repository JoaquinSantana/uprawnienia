json.array!(@roles) do |role|
  json.extract! role, :id, :nr_roli, :nazwa, :opis
  json.url role_url(role, format: :json)
end
