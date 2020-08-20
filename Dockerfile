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
ADD source.conf /var/tmp
RUN cat /var/tmp/source.conf $FLUENT_HOME/etc/$FLUENTD_CONF > /var/tmp/$FLUENTD_CONF.in_progress \
    && mv /var/tmp/$FLUENTD_CONF.in_progress $FLUENT_HOME/etc/$FLUENTD_CONF \
    && rm -f /var/tmp/*
