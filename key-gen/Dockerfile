FROM debian:stable-slim

LABEL "maintainer"="maddox <a.najafizadeh@najafizadeh.com>"
LABEL "repository"="https://github.com/alinz/actions"
LABEL "version"="1.0.0"

LABEL "com.github.actions.name"="KEY-GEN"
LABEL "com.github.actions.description"="Generate Key based on intermidate certificates"
LABEL "com.github.actions.icon"="server"
LABEL "com.github.actions.color"="orange"

RUN apt-get update && apt-get install -y \
  openssh-client && \
  openssl && \
  rm -Rf /var/lib/apt/lists/*


ADD entrypoint.sh /entrypoint.sh


ENTRYPOINT ["/entrypoint.sh"]