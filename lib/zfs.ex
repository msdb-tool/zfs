defmodule Msdb.Zfs do
  @spec list() :: list(list())
  def list() do
    {raw_list, _} = System.cmd("zfs", ["list", "-H", "-o", "name,used,avail,refer,mountpoint"])

    raw_list
    |> sanitize_raw_string()
    |> parse_list()
  end

  @spec sanitize_raw_string(String.t()) :: list(list(String.t()))
  def sanitize_raw_string(raw_list) do
    raw_list |> String.replace_trailing("\n", "") |> String.split("\n")
  end

  @type dataset :: list(tuple)
  @type datasets :: list(dataset)

  @spec parse_list(list(list)) :: datasets
  def parse_list(datasets) do
    Enum.map(datasets, fn dataset ->
      [name, used, available, referenced, mountpoint] = dataset |> String.split()

      [
        name: name,
        used: used,
        available: available,
        referenced: referenced,
        mountpoint: mountpoint
      ]
    end)
  end
end
