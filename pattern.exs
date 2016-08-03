defmodule MyList1 do

  defp parse_tuple({"href", _}), do: true
  defp parse_tuple({_, _}), do: false

end


cond do
  full url ->
    'leave url complete'
  partial url ->
    'url amend'
end

Enum.map(list, &check_urls)

partition
reduce
scan
