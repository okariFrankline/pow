defmodule Authex.Extension.Phoenix.ControllerCallbacks.Base do
  @moduledoc """
  Used for the Phoenix Controller Callbacks module in extensions.

  ## Usage

      defmodule MyAuthexExtension.Phoenix.ControllerCallbacks do
        use Authex.Extension.Phoenix.ControllerCallbacks.Base

        def callback(Authex.Phoenix.RegistrationController, :create, {:ok, user, conn}, _config) do
          {:ok, user, conn}
        end
      end
  """
  alias Authex.Config

  @callback callback(atom(), atom(), any(), Config.t()) :: any()

  defmacro __using__(_opts) do
    quote do
      @behaviour unquote(__MODULE__)

      @before_compile unquote(__MODULE__)
    end
  end

  defmacro __before_compile__(_opts) do
    quote do
      def callback(_controller, _action, res, _config), do: res
    end
  end
end
