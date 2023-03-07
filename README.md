# predixy_exporter
Simple server that scrapes Predixy stats and exports them via HTTP for Prometheus consumption

## Description

Cloned from https://github.com/joyieldInc/predixy_exporter and secondary development of it

## Build

It is as simple as:

    $ make

## Running

    $ ./predixy_exporter

With default options, predixy_exporter will listen at 0.0.0.0:9617 and
scrapes predixy(127.0.0.1:7617).
To change default options, see:

    $ ./predixy_exporter --help
