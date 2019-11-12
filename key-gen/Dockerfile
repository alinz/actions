FROM alpine

LABEL "maintainer"="maddox <a.najafizadeh@najafizadeh.com>"
LABEL "repository"="https://github.com/alinz/actions"
LABEL "version"="1.0.0"

LABEL "com.github.actions.name"="KEY-GEN"
LABEL "com.github.actions.description"="Generate Key based on intermidate certificates"
LABEL "com.github.actions.icon"="server"
LABEL "com.github.actions.color"="orange"

RUN apk update && \
  apk add --no-cache openssh-client && \
  apk add --no-cache openssl && \
  apk add --no-cache --upgrade bash && \
  rm -rf /var/cache/apk/*


ADD entrypoint.sh /entrypoint.sh


ENTRYPOINT ["/entrypoint.sh"]