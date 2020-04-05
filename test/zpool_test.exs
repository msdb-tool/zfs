defmodule Msdb.ZpoolTest do
  use ExUnit.Case

  test "Parse zpool list string" do
    raw_string = "ztest\t80M\t110K\t79.9M\t-\t-\t3%\t0%\t1.00x\tONLINE\t-\n"

    sanitized_string = [
      "ztest\t80M\t110K\t79.9M\t-\t-\t3%\t0%\t1.00x\tONLINE\t-"
    ]

    assert Msdb.Zpool.sanitize_raw_string(raw_string) == sanitized_string
  end

  test "Parse correctly zpool list output" do
    list_unparsed = [
      "ztest\t80M\t110K\t79.9M\t-\t-\t3%\t0%\t1.00x\tONLINE\t-"
    ]

    list_parsed = [
      [
        name: "ztest",
        size: "80M",
        allocated: "110K",
        free: "79.9M",
        checkpoint: "-",
        expandsize: "-",
        fragmentation: "3%",
        capacity: "0%",
        dedupratio: "1.00x",
        health: "ONLINE",
        altroot: "-"
      ]
    ]

    assert Msdb.Zpool.parse_list(list_unparsed) == list_parsed
  end
end
