# content-shell docker image

The purpose of this image is to run browser based Dart unit tests with content-shell.

## Installation:

Simply pull the image from docker hub.

```
docker pull damoti/content-shell
```

## Useage:

`cd` into the root of your Dart project (where `pubspec.yaml` and `test` directory are located).

Because we mount the local project directory into a docker container we need the project to be self-contained without an external global pub cache. To achieve this you need to run `pub get` with `PUB_CACHE` set to the local directory:
```
PUB_CACHE=`pwd`/.pub-cache pub get
```

Now we're ready to run the tests...

Run all of the tests:
```
docker run --rm -v `pwd`:`pwd` --workdir=`pwd` damoti/content-shell
```

Run a specific test:
```
docker run --rm -v `pwd`:`pwd` --workdir=`pwd` damoti/content-shell '-r expanded test/some_test.dart'
```

*NOTES & EXPLANATIONS:*

1. It's really important that you wrap everything after `damoti/content-shell` in one set of single quotes. This is to get around certain limitations in Docker's CMD & ENTRYPOINT commands (see example above on running specific unit tests).

2. The local path to your project and the path inside the container must be identical, this is because `.packages` file uses absolute paths to packages. To achieve this docker is started with ```-v `pwd`:`pwd` --workdir=`pwd` ```
