# Welcome to Auditbeat 6.5.4

Audit the activities of users and processes on your system.

## Getting Started

To get started with Auditbeat, you need to set up Elasticsearch on
your localhost first. After that, start Auditbeat with:

     ./auditbeat -c auditbeat.yml -e

This will start Auditbeat and send the data to your Elasticsearch
instance. To load the dashboards for Auditbeat into Kibana, run:

    ./auditbeat setup -e

For further steps visit the
[Getting started](https://www.elastic.co/guide/en/beats/auditbeat/6.5/auditbeat-getting-started.html) guide.

## Documentation

Visit [Elastic.co Docs](https://www.elastic.co/guide/en/beats/auditbeat/6.5/index.html)
for the full Auditbeat documentation.

## Release notes

https://www.elastic.co/guide/en/beats/libbeat/6.5/release-notes-6.5.4.html
