# frozen_string_literal: true

Mobility.configure do
  plugins do
    backend :table
    active_record
    reader
    writer
    backend_reader
    query
    cache
    presence
    fallbacks false
    dirty
    default
  end
end
