defmodule Lockbot do
  import Slack
  import SlackRtm
  import Translate
  @moduledoc """
  Documentation for Lockbot.
  """

  @doc """
  Hello world.

  ## Examples

      iex> Lockbot.hello
      :world

  """
  def startSlack do
    {:ok, rtm} = Slack.Bot.start_link(SlackRtm, [], Application.get_env(:lockbot, :slack_bot_token))
  end
  
  def say(str) do
    Translate.translate(str)
  end

end
