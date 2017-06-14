defmodule Sense.Measure do
  use Instream.Series

  series do
    database "measurements"
    measurement "measure"

    tag :device_id

    field :value
  end
end
