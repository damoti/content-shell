# content-shell docker image

`Ubuntu:15.10` docker image with `dart` and `content-shell` installed.

The purpose of this image is to run Dart unit tests with content-shell.

## Installation:

Simply pull the image from docker hub.

```
docker pull damoti/content-shell
```

## Useage:

`cd` into the root of your Dart project (where `pubspec.yaml` and `test` directory are located).

Run all of the tests:
```
docker run --rm -v `pwd`:`pwd` --workdir=`pwd` content-shell
```

Run a specific test:
```
docker run --rm -v `pwd`:`pwd` --workdir=`pwd` content-shell '-r expanded test/some_test.dart'
```

*NOTE:* It's really important that you wrap everything after `content-shell` in single quotes. This is to get around certain limitations in Docker's CMD & ENTRYPOINT commands.
