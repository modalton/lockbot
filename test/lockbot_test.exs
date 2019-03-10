defmodule LockbotTest do
  use ExUnit.Case
  doctest Lockbot

  test "greets the world" do
    assert Lockbot.hello() == :world
  end
end
