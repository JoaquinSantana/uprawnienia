json.array!(@decisions) do |decision|
  json.extract! decision, :id, :opinia
  json.url decision_url(decision, format: :json)
end
