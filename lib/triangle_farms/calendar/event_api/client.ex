defmodule TriangleFarms.Calendar.EventAPI.Client do
  defstruct token: nil

  alias __MODULE__
  alias TriangleFarms.Calendar.Event

  @iss Application.get_env(:triangle_farms, Client)[:email]
  @scope Application.get_env(:triangle_farms, Client)[:scope]
  @aud Application.get_env(:triangle_farms, Client)[:audience]
  @signing_key Application.get_env(:triangle_farms, Client)[:signing_key]
  @calendar Application.get_env(:triangle_farms, Client)[:calendar]

  def authorize do
    with %{body: body} <- HTTPoison.post!(@aud, token_params()) do
      case Poison.decode!(body) do
        %{"access_token" => token} -> {:ok, %Client{token: token}}
        %{"error_description" => msg} -> {:error, msg}
      end
    end
  end

  def list_events(%Client{token: token}, params) do
    HTTPoison.get!(
      "https://www.googleapis.com/calendar/v3/calendars/#{@calendar}/events",
      ["Authorization": "Bearer #{token}"],
      params: params
    ) |> to_events
  end

  defp expiration_timestamp do
    Timex.now
    |> Timex.shift(hours: 1)
    |> Timex.to_unix
  end

  defp signing_key do
    @signing_key
    |> JOSE.JWK.from_pem_file
    |> Joken.rs256
  end

  defp signed_assertion do
    Joken.token
    |> Joken.with_iss(@iss)
    |> Joken.with_aud(@aud)
    |> Joken.with_claim("scope", @scope)
    |> Joken.with_claim_generator("exp", &expiration_timestamp/0)
    |> Joken.sign(signing_key())
    |> Map.get(:token)
  end

  defp token_params do
    {
      :form, [
        grant_type: "urn:ietf:params:oauth:grant-type:jwt-bearer",
        assertion: signed_assertion()
      ]
    }
  end

  defp to_event(event = %{"summary" => summary, "description" => desc, "location" => loc}) do
    start_at = event |> get_in(["start", "dateTime"]) |> Timex.parse!("{RFC3339}")
    end_at = event |> get_in(["end", "dateTime"]) |> Timex.parse!("{RFC3339}")
    %Event{
      name: summary,
      description: desc,
      location: loc,
      start_at: start_at,
      end_at: end_at
    }
  end

  defp to_events(response) do
    response.body
    |> Poison.decode!
    |> Map.get("items")
    |> Enum.map(&to_event/1)
  end
end
