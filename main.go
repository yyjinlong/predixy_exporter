package main

import (
	"flag"
	"log"
	"net/http"

	"github.com/prometheus/client_golang/prometheus"
	"github.com/prometheus/client_golang/prometheus/promhttp"

	"predixy_exporter/exporter"
)

var (
	bind = flag.String("bind", ":9617", "Listen address")
	addr = flag.String("addr", "127.0.0.1:12120", "Predixy service address")
	name = flag.String("name", "none", "Redis service name")
)

func main() {
	flag.Parse()

	exporter, err := exporter.NewExporter(*addr, *name)
	if err != nil {
		log.Fatal(err)
	}
	prometheus.MustRegister(exporter)

	http.Handle("/metrics", promhttp.Handler())
	log.Fatal(http.ListenAndServe(*bind, nil))
}
