defmodule SlackRtm do
  use Slack

  def w_middlename(name) do
    [first, last] = String.split(name)
    table = %{
      "Caroline" => ["Thunder Lungs"],
      "Patrick" => ["Bossman"],
      "Mike" => ["Loan Ranger"],
      "Tyler" => ["Lockdown"],
      "Jenn" => ["Coffee is for closers"]
    }
    case table[first] do
      [middle] -> "#{first} #{middle} #{last}"
      nil -> name
    end
  end

  def to_full_state(acr) do
    table = %{
      "MA" => "Massachusetts",
      "FL" => "Florida",
      "CT" => "Conneticut",
      "NH" => "New Hampshire",
      "ME" => "Maine",
      "VT" => "Vermont",
    }
    case table[acr] do
      state -> state
      nil -> acr
    end
  end
  
  def parse_message(str) do
    case Regex.run(~r/CG07944SC : Another_one by ([\w ]+) for ([\d\$,]+) in (\w+)/, str) do
      [_, name, amount, state] ->
        Translate.translate("#{w_middlename(name)} with another one in #{to_full_state(state)} for #{amount}")
      nil -> nil
    end
  end
  
  def handle_connect(slack, state) do
    IO.puts "Connected as #{slack.me.name}"
    {:ok, state}
  end

  # Good:  "Message from CG07944SC : Another_one by Caroline McCarthy for $410,000 in CT"
  def handle_event(message = %{type: "message"}, slack, state) do
    parse_message("#{message.channel} : #{message.text}")
    # send_message("I got a message!", message.channel, slack)
    {:ok, state}
  end
  
  def handle_event(_, _, state), do: {:ok, state}

  def handle_info({:message, text, channel}, slack, state) do
    IO.puts "Sending your message, captain!"

    # send_message(text, channel, slack)
    
    {:ok, state}
  end
  def handle_info(_, _, state), do: {:ok, state}
end
