json.array!(@case_sets) do |case_set|
  json.extract! case_set, :id
  json.url case_set_url(case_set, format: :json)
end
