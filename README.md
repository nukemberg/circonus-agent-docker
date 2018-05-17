# Circonus agent docker

This repository contains a `Dockerfile` for building a minimal docker image containing a staticly compiled binary of the golang `circonus-agent`.

Please check out the [Circonus agent repository](https://github.com/circonus-labs/circonus-agent) for docs.

## Usage

```
docker build -t circonus-agent:latest .
docker run -d circonus-agent --api-key MY_KEY -r -E -C
```

### Configuration

Circonus agent is configured using command line arguments and/or environment variables. This container image passes through these parameters as is, so configuration is pretty much the same as the original documentation.
There is one notable exception - plugins and state directories, see bellow.

### Volumes, plugins, state

The image is configured with volumes for the plugins and state directories, mounted on `/plugins` and `/state` respectively.
To use plugins installed outside the image, simply mount your plugin directory:

```
docker run -v /path/to/plugins:/plugins circonus-agent:latest --api-key KEY ...
```
