FROM python:3.11.0rc2-alpine3.16
LABEL maintainer=jon@kosli.com

COPY server/requirements.txt /tmp/requirements.txt
RUN pip3 install -r /tmp/requirements.txt

ARG XY_APP_DIR \
    XY_PORT \
    XY_USER \
    XY_WORKERS

ENV XY_APP_DIR=${XY_APP_DIR} \
    XY_PORT=${XY_PORT} \
    XY_WORKERS=${XY_WORKERS} \
    PYTHONPATH=${XY_APP_DIR}/server \
    TERM=xterm-256color

WORKDIR ${XY_APP_DIR}
COPY . .
RUN apk --update --upgrade add bash tini && \
    apk --no-cache upgrade musl && \
    apk update && \
    adduser -D -g "" ${XY_USER} && \
    chown -R ${XY_USER} ${XY_APP_DIR}

USER ${XY_USER}
EXPOSE "${XY_PORT}"
ENTRYPOINT [ "/sbin/tini", "-g", "--" ]
CMD ${XY_APP_DIR}/server/gunicorn.sh
