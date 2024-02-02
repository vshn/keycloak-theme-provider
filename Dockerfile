FROM docker.io/library/alpine:latest

# renovate: datasource=github-releases depName=sventorben/keycloak-restrict-client-auth
ARG KEYCLOAK_RESTRICT_CLIENT_AUTH_VERSION=v23.0.0

RUN \
  mkdir /providers &&\
  wget -O /providers/keycloak-restrict-client-auth.jar https://github.com/sventorben/keycloak-restrict-client-auth/releases/download/${KEYCLOAK_RESTRICT_CLIENT_AUTH_VERSION}/keycloak-restrict-client-auth.jar

RUN \
  chmod -R ugo+r /providers

COPY themes /themes

RUN \
  chmod -R ugo+r /themes


USER 1001:0
