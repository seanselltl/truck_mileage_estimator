json.(
  @estimate,
  :origin_latitude,
  :origin_longitude,
  :destination_latitude,
  :destination_longitude,
  :miles
)

json.errors @estimate.errors.messages.reject { |k,v| k == :miles } do |field_messages|
  json.set! field_messages[0], field_messages[1].join(", ")
end