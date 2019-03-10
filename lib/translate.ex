defmodule Translate do
  import AWS

  # Replace w datetime
  def randStr() do
    Integer.to_string(Enum.random(1..10000))
  end
  
  defp writePlayDelete(raw_mp3) do
    filename = randStr() <> ".mp3"
    case File.write(filename, raw_mp3) do
      :ok -> System.cmd("nvlc",["--play-and-exit", filename])
      {:error, reason} -> IO.puts('err') 
    end
  end
  
  def translate(str) do
    client = %AWS.Client{
      access_key_id: Application.get_env(:lockbot, :aws_access_key_id),
      secret_access_key: Application.get_env(:lockbot, :aws_secret_access_key),
      region: Application.get_env(:lockbot, :aws_region),
      endpoint: "amazonaws.com"}
    case AWS.Polly.synthesize_speech(client,%{"Text"=>str,"OutputFormat"=> "mp3", "VoiceId"=> "Russell"}) do
      {:ok, result, resp} ->  writePlayDelete(result)
      {:error, err} -> IO.inspect(err, label: 'ERR')
    end
  end

end
