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
alias Sense.{ User, Repo, Device, Metric, Measure }

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
      name: "Heater sensor",
      description: "This sensor give info about heater status",
      user_id: user_john.id
}) |> Repo.insert!

device_2 = Device.changeset(%Device{}, %{
      name: "Garden sensor",
      description: "Solar powered device that give some info about garden status",
      user_id: user_john.id
}) |> Repo.insert!

device_1_metric_1 = Metric.changeset(%Metric{}, %{
      name: "Temperature",
      description: "Water temperature",
      device_id: device_1.id
}) |> Repo.insert!

device_1_metric_2 = Metric.changeset(%Metric{}, %{
      name: "Consumption",
      description: "Watts consumed",
      device_id: device_1.id
}) |> Repo.insert!

device_2_metric_1 = Metric.changeset(%Metric{}, %{
      name: "Humidity",
      description: "Percentage of humidity",
      device_id: device_2.id
}) |> Repo.insert!

Sense.Measure.delete_database
Sense.Measure.create_database

Measure.write_measure(device_1_metric_1, 1)
Measure.write_measure(device_1_metric_1, 2)
Measure.write_measure(device_1_metric_1, 3)
Measure.write_measure(device_1_metric_1, 5)
Measure.write_measure(device_1_metric_1, 4)
Measure.write_measure(device_1_metric_1, 3)
Measure.write_measure(device_1_metric_1, 1)
Measure.write_measure(device_1_metric_1, 3)
Measure.write_measure(device_1_metric_2, 4)
Measure.write_measure(device_1_metric_2, 5)
Measure.write_measure(device_1_metric_2, 5)
Measure.write_measure(device_1_metric_2, 6)
Measure.write_measure(device_1_metric_2, 4)
Measure.write_measure(device_2_metric_1, 6)
Measure.write_measure(device_2_metric_1, 7)
Measure.write_measure(device_2_metric_1, 8)
Measure.write_measure(device_2_metric_1, 9)
Measure.write_measure(device_2_metric_1, 10)

