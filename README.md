# aws-firelens-fluentd-dev-kit

This simple development kit runs your custom fluentd adding &lt;source&gt; sections to configuration.

## Problems to develop Firelens fluentd container

### Cannot set &lt;source&gt; section which listens localhost in fluentd conf file

Firelens will define &lt;source&gt; section listening localhost to fluentd configuration. When we define it too for local debug, Fluentd may show error: `unexpected error error_class=Errno::EADDRINUSE error=#<Errno::EADDRINUSE: Address in use - bind(2) for "0.0.0.0" port 24224`.

It is hard to write configuration because fluentd does not listen localhost in local machine.

## Usage

### Build your fluentd container

Sample fluentd container is available in this repository.

```bash
cd sample-fluentd
docker-compose build
```

### Fix Dockerfile of devkit

Open Dockerfile and fix `FROM` to your container image name.

```dockerfile
FROM tsubasaogawa/sample-fluentd:v0.1 -> your/fluentd:tag
```

### Customize &lt;source&gt; sections

Open and edit `source.conf` easy to debug. Dummy plugin is defined in default.

### Build & Run

```bash
docker-compose build
docker-compose up -d
```

### Start debug

```bash
# Set test message json
export JSON='{\"message\": \"hello world\"}'

# Send message
docker-compose exec fluentd_dev_kit ash -c "echo $JSON | fluent-cat foo-firelens-bar"
```

See logs.

```bash
$ docker-compose logs
  :
fluentd-dev-kit    | 2020-08-16 14:19:07.526814774 +0000 foo-firelens-bar: {"message":"hello world","foo":"bar"}
```

## Arguments

You can edit `args` section in docker-compose.yml.

|Argument name|Description|
|-------------|-----------|
|FLUENT_USER  |User name. Try `fluent` if cannot run container|
|FLUENT_CONF  |Custom fluentd configuration file name. (It is defined in `config-file-value` in task definition.)|
|FLUENT_HOME  |Fluentd home directory.|
