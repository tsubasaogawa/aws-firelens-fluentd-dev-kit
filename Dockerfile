# Your fluentd container image
FROM tsubasaogawa/sample-fluentd:v0.1

LABEL maintainer="tsubasaogawa" \
    description="Simple development kit for aws firelens fluentd container"

ARG FLUENT_USER="fluent"
USER $FLUENT_USER

# Rewrite configuration file name if you need
RUN unset FLUENTD_CONF
ENV FLUENTD_CONF "fluent-custom.conf"

# Add source section
RUN sed \
    -e '1i<source>' \
    -e '1i  @type forward' \
    -e '1i  port 24224' \
    -e '1i  bind 0.0.0.0' \
    -e '1i</source>' \
    -i "/fluentd/etc/$FLUENTD_CONF"
