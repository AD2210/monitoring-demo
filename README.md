# monitoring-demo

Demo Symfony application used to validate `ad2210/monitoring-bundle` as a real
client application.

Install dependencies and start the Symfony runtime with the preferred local
web server. The liveness endpoint is:

```text
GET /_monitoring/health/live
X-Monitoring-Token: demo-token
```

Deterministic application scenarios are available at:

```text
/demo/ok
/demo/fail
/demo/slow
```

To simulate a failed readiness dependency, start the application with:

```bash
MONITORING_DEMO_DEPENDENCY_DOWN=1 php -S 127.0.0.1:8091 -t public public/index.php
```

The readiness endpoint then returns HTTP 503 and identifies
`demo_dependency` as failed without exposing internal error details.
