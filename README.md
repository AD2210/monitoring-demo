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
