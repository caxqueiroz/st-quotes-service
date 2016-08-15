#!/bin/bash
APP_NAME="spring-music"
APP_ROUTE="spring-music-dev"
ROUTE_DOMAIN="cdcidemo.fe.gopivotal.com"
BUILD_ARTIFACT="artifacts/spring-music-${BUILD_VERSION}.war"
DEPLOYED_VERSION_CMD=$(CF_COLOR=false cf apps | grep "$APP_NAME-" | grep -v "Getting apps in org" | cut -d" " -f1)
DEPLOYED_VERSION="$DEPLOYED_VERSION_CMD"
ROUTE_VERSION=$(echo "${BUILD_VERSION}" | cut -d"." -f1-3 | tr '.' '-')
echo "Deployed Version: $DEPLOYED_VERSION"
echo "Route Version: $ROUTE_VERSION"

cf push "$APP_NAME-$BUILD_VERSION" -i 1 -m 512M -n "$APP_ROUTE-$ROUTE_VERSION" -p $BUILD_ARTIFACT --no-manifest
cf map-route "$APP_NAME-${BUILD_VERSION}" $ROUTE_DOMAIN -n $APP_ROUTE
cf scale $APP_NAME-${BUILD_VERSION} -i 1

if [ ! -z "$DEPLOYED_VERSION" -a "$DEPLOYED_VERSION" != " " -a "$DEPLOYED_VERSION" != "$APP_NAME-${BUILD_VERSION}" ]; then
  echo "Performing zero-downtime cutover to $BUILD_VERSION"
  while read line
  do
    if [ ! -z "$line" -a "$line" != " " -a "$line" != "$APP_NAME-${BUILD_VERSION}" ]; then
      echo "Scaling down, unmapping and removing $line"
      cf scale "$line" -i 1
      cf unmap-route "$line" $ROUTE_DOMAIN -n $APP_ROUTE
      cf delete "$line" -f
    else
      echo "Skipping $line"
    fi
  done <<<"$DEPLOYED_VERSION"
fi

