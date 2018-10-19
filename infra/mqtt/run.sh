set -e

chown mosquitto:mosquitto -R /var/lib/mosquitto

if [ "$1" = 'mosquitto' ]; then
    if [ ! -f /etc/mosquitto.d/custom_config.conf ]; then
        echo "auth_plugin /usr/local/lib/auth-plug.so" | tee -a /etc/mosquitto.d/custom_config.conf
        env | grep "MOSQUITTOCONF" | while IFS="=" read -r name value; do
            echo "${name:14} ${value}" | tee -a /etc/mosquitto.d/custom_config.conf
        done
    fi

	  exec /usr/local/sbin/mosquitto -c /etc/mosquitto/mosquitto.conf
fi

exec "$@"
