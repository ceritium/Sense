# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Sense.Repo.insert!(%Sense.SomeModel{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.
alias Sense.{ User, Repo, Device }

user_john = User.changeset(%User{}, %{
      email: "john@sense.local",
      first_name: "John",
      last_name: "Doe",
      username: "JohnDoEx",
      password: "foobarfoo"
      
}) |> Repo.insert!

random_user = User.changeset(%User{}, %{
      email: Faker.Internet.email,
      first_name: Faker.Name.first_name,
      last_name: Faker.Name.last_name,
      username: Faker.Internet.user_name,
      password: "mypassword"
}) |> Repo.insert!
      
device_1 = Device.changeset(%Device{}, %{
      name: "Example device 1",
      description: "My first device",
      user_id: user_john.id
}) |> Repo.insert!

device_2 = Device.changeset(%Device{}, %{
      name: "My other device",
      description: "Solar powered device",
      user_id: user_john.id
}) |> Repo.insert!


Sense.Measure.delete_database
Sense.Measure.create_database
