defmodule Mix.Tasks.Pleroma.Docs do
  use Mix.Task
  import Mix.Pleroma

  @shortdoc "Generates docs from descriptions.exs"
  @moduledoc """
  Generates docs from `descriptions.exs`.

  Supports two formats: `markdown` and `json`.

  ## Generate Markdown docs

  `mix pleroma.docs`

  ## Generate JSON docs

  `mix pleroma.docs json`
  """

  def run(["json"]) do
    do_run(Pleroma.Docs.JSON)
  end

  def run(_) do
    do_run(Pleroma.Docs.Markdown)
  end

  defp do_run(implementation) do
    start_pleroma()
    {descriptions, _paths} = Mix.Config.eval!("config/description.exs")

    {:ok, file_path} =
      Pleroma.Docs.Generator.process(
        implementation,
        descriptions[:pleroma][:config_description]
      )

    Mix.shell().info([:green, "Markdown docs successfully generated to #{file_path}."])
  end
end
