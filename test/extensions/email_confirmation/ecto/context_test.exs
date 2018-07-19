defmodule AuthexEmailConfirmation.Ecto.ContextTest do
  use Authex.Test.Ecto.TestCase
  doctest AuthexEmailConfirmation.Ecto.Context

  alias AuthexEmailConfirmation.Ecto.Context
  alias AuthexEmailConfirmation.Test.{RepoMock, Users.User}

  @config [repo: RepoMock, user: User]

  describe "confirm_email/2" do
    test "doesn't confirm when already confirmed" do
      user = %User{}
      assert {:ok, user} = Context.confirm_email(@config, user)
      assert user.email_confirmed_at

      previously_confirmed_at = DateTime.from_iso8601("2018-01-01 00:00:00")
      user = %User{email_confirmed_at: previously_confirmed_at}

      assert {:ok, user} = Context.confirm_email(@config, user)
      assert user.email_confirmed_at == previously_confirmed_at
    end
  end
end
