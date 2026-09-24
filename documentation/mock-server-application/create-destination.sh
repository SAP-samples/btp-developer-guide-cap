#!/bin/bash
echo "Creating destination '$1' with the instance '$2'..."


ROUTE_TO_MOCKSERVER=$(cf app mock-srv | grep 'routes:' | cut -d ':' -f 2 | xargs) 
if [ "$ROUTE_TO_MOCKSERVER" == "" ];
then
    echo "[ERROR]: No app found"
    exit 1
else 
    ROUTE_TO_MOCKSERVER="http://${ROUTE_TO_MOCKSERVER}/op-api-business-partner-srv"
    echo "[SUCCESS]: Route to app: ${ROUTE_TO_MOCKSERVER}"
fi

NEW_DESTINATION_PARAMS="{\"HTML5Runtime_enabled\": \"true\", \"init_data\": {\"subaccount\": {\"existing_destinations_policy\": \"update\", \"destinations\": [{\"Name\": \"${1}\", \"Type\": \"HTTP\", \"URL\": \"${ROUTE_TO_MOCKSERVER}\", \"Authentication\": \"NoAuthentication\", \"ProxyType\": \"Internet\", \"Description\": \"Mock Server\"}]}}}"
cf update-service "$2" -c "$NEW_DESTINATION_PARAMS"
