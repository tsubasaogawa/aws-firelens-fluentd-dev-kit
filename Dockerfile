# Your fluentd container image
FROM tsubasaogawa/sample-fluentd:v0.1

LABEL maintainer="tsubasaogawa" \
    description="Simple development kit for aws firelens fluentd container"

ARG FLUENT_USER="fluent"
USER $FLUENT_USER

# Rewrite configuration file name if you need
ARG FLUENT_CONF="fluent-custom.conf"
RUN unset FLUENTD_CONF
ENV FLUENTD_CONF $FLUENT_CONF

# Add source section
ARG FLUENT_HOME="/fluentd"
RUN sed \
    -e '1i<source>' \
    -e '1i  @type forward' \
    -e '1i  port 24224' \
    -e '1i  bind 0.0.0.0' \
    -e '1i</source>' \
    "$FLUENT_HOME/etc/$FLUENTD_CONF" > /var/tmp/$FLUENTD_CONF.in_progress

ADD in_dummy.conf /var/tmp
RUN cat /var/tmp/in_dummy.conf /var/tmp/$FLUENTD_CONF.in_progress > $FLUENT_HOME/etc/$FLUENTD_CONF
