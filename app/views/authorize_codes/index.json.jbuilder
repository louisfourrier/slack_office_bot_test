json.array!(@authorize_codes) do |authorize_code|
  json.extract! authorize_code, :id, :code
  json.url authorize_code_url(authorize_code, format: :json)
end
