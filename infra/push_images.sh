gcloud auth configure-docker --quiet

export PROJECT_ID="$(gcloud config get-value project -q)"

# APP: Elixir/Phoenix Backend server
docker build ../app -t sense_app:latest

docker tag sense_app:latest eu.gcr.io/${PROJECT_ID}/sense_app:$(git rev-parse HEAD)
docker tag sense_app:latest eu.gcr.io/${PROJECT_ID}/sense_app:latest

docker push eu.gcr.io/${PROJECT_ID}/sense_app:$(git rev-parse HEAD)
docker push eu.gcr.io/${PROJECT_ID}/sense_app:latest

# APP: Angular Frontend app
docker build ../web -t sense_web:latest

docker tag sense_web:latest eu.gcr.io/${PROJECT_ID}/sense_web:$(git rev-parse HEAD)
docker tag sense_web:latest eu.gcr.io/${PROJECT_ID}/sense_web:latest

docker push eu.gcr.io/${PROJECT_ID}/sense_web:$(git rev-parse HEAD)
docker push eu.gcr.io/${PROJECT_ID}/sense_web:latest

# DB: Mosquitto custom with auth schema
docker build ./mqtt -t sense_mqtt:latest

docker tag sense_mqtt:latest eu.gcr.io/${PROJECT_ID}/sense_mqtt:$(git rev-parse HEAD)
docker tag sense_mqtt:latest eu.gcr.io/${PROJECT_ID}/sense_mqtt:latest

docker push eu.gcr.io/${PROJECT_ID}/sense_mqtt:$(git rev-parse HEAD)
docker push eu.gcr.io/${PROJECT_ID}/sense_mqtt:latest
