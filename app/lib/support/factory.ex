defmodule Sense.Factory do
  use ExMachina.Ecto, repo: Sense.Repo
  Faker.start
  
  def user_factory do
    %Sense.User{
      email: sequence(:email, &"#{&1}mail@example.local"),
      first_name: "John",
      last_name: "Doe",
      username: "johndoe",
      encrypted_password: Comeonin.Bcrypt.hashpwsalt("password")
    }
  end

  def device_factory do
    %Sense.Device{
      name: "Example",
      description: "Description",
      user: build(:user)
    }
  end
end
