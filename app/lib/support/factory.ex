defmodule Sense.Factory do
  use ExMachina.Ecto, repo: Sense.Repo
  Faker.start
  alias Sense.{ Device, User, Metric }

  def user_factory do
    %User{
      email: sequence(:email, &"#{&1}mail@example.local"),
      first_name: "John",
      last_name: "Doe",
      username: "johndoe",
      encrypted_password: Comeonin.Bcrypt.hashpwsalt("ValidPassword1")
    }
  end

  def device_factory do
    %Device{
      name: "Example",
      description: "Description",
      user: build(:user)
    }
  end

  def metric_factory do
    %Metric{
      name: "Example",
      description: "Description",
      device: build(:device)
    }
  end
end
