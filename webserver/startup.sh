#!/bin/sh

file="/opt/e-SUS/webserver/config/application.properties"
while IFS='=' read -r key value
do
    key=$(echo "$key" | xargs | tr '.' '_')
    value=$(echo "$value" | xargs)
    if [ ${#key} -le 0 ]; then
      continue
    fi
    export "${key}"="${value}"
done < "$file"

echo "Database URL = " ${spring_datasource_url}
echo "Username = " ${spring_datasource_username}
echo "Password = " ${spring_datasource_password}

java -jar /opt/e-SUS/migrador.jar -url=${spring_datasource_url} -username=${spring_datasource_username} -password=${spring_datasource_password}
sh /opt/e-SUS/webserver/standalone.sh