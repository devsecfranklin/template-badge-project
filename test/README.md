# test

This directory is intended for PlatformIO Unit Testing and project tests.

Unit Testing is a software testing method by which individual units of
source code, sets of one or more MCU program modules together with associated
control data, usage procedures, and operating procedures, are tested to
determine whether they are fit for use. Unit testing finds problems early
in the development cycle.

* [More information about PlatformIO Unit Testing](https://docs.platformio.org/page/plus/unit-testing.html)

## Esp32 build

### OpenBSD

* [platformio-openbsd-tool-esptool](https://github.com/lotherk/platformio-openbsd-tool-esptool)
* [ESP-IDF Visual Studio Code Extension](https://github.com/espressif/vscode-esp-idf-extension)

### Linux

[esptool](https://github.com/espressif/esptool)
[Micropython](https://micropython.org/download/ESP32_GENERIC/)

## PlatformIO

```sh
pio run -v -t upload
```