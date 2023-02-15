{
  "annotations": {
    "list": [
      {
        "builtIn": 1,
        "datasource": {
          "type": "datasource",
          "uid": "grafana"
        },
        "enable": true,
        "hide": true,
        "iconColor": "rgba(0, 211, 255, 1)",
        "name": "Annotations & Alerts",
        "target": {
          "limit": 100,
          "matchAny": false,
          "tags": [],
          "type": "dashboard"
        },
        "type": "dashboard"
      }
    ]
  },
  "description": "Istio Control Plane Dashboard version 1.13.4",
  "editable": true,
  "fiscalYearStartMonth": 0,
  "gnetId": 7645,
  "graphTooltip": 1,
  "id": 2,
  "iteration": 1652879774772,
  "links": [],
  "liveNow": false,
  "panels": [
    {
      "collapsed": false,
      "datasource": {
        "type": "prometheus",
        "uid": "P46855B3906317654"
      },
      "gridPos": {
        "h": 1,
        "w": 24,
        "x": 0,
        "y": 0
      },
      "id": 60,
      "panels": [],
      "title": "Deployed Versions",
      "type": "row"
    },
    {
      "aliasColors": {},
      "bars": false,
      "dashLength": 10,
      "dashes": false,
      "datasource": {
        "type": "prometheus",
        "uid": "P46855B3906317654"
      },
      "fill": 1,
      "fillGradient": 0,
      "gridPos": {
        "h": 5,
        "w": 24,
        "x": 0,
        "y": 1
      },
      "hiddenSeries": false,
      "id": 56,
      "legend": {
        "avg": false,
        "current": false,
        "max": false,
        "min": false,
        "show": true,
        "total": false,
        "values": false
      },
      "lines": true,
      "linewidth": 1,
      "links": [],
      "nullPointMode": "null",
      "options": {
        "alertThreshold": true
      },
      "percentage": false,
      "pluginVersion": "8.5.2",
      "pointradius": 5,
      "points": false,
      "renderer": "flot",
      "seriesOverrides": [],
      "spaceLength": 10,
      "stack": false,
      "steppedLine": false,
      "targets": [
        {
          "datasource": {
            "type": "prometheus",
            "uid": "P46855B3906317654"
          },
          "expr": "sum(istio_build{component=\"pilot\", cluster_name=\"$cluster\"}) by (tag)",
          "format": "time_series",
          "intervalFactor": 1,
          "legendFormat": "{{ tag }}",
          "refId": "A"
        }
      ],
      "thresholds": [],
      "timeRegions": [],
      "title": "Pilot Versions",
      "tooltip": {
        "shared": true,
        "sort": 0,
        "value_type": "individual"
      },
      "type": "graph",
      "xaxis": {
        "mode": "time",
        "show": true,
        "values": []
      },
      "yaxes": [
        {
          "format": "short",
          "logBase": 1,
          "show": true
        },
        {
          "format": "short",
          "logBase": 1,
          "show": false
        }
      ],
      "yaxis": {
        "align": false
      }
    },
    {
      "collapsed": false,
      "datasource": {
        "type": "prometheus",
        "uid": "P46855B3906317654"
      },
      "gridPos": {
        "h": 1,
        "w": 24,
        "x": 0,
        "y": 6
      },
      "id": 62,
      "panels": [],
      "title": "Resource Usage",
      "type": "row"
    },
    {
      "aliasColors": {},
      "bars": false,
      "dashLength": 10,
      "dashes": false,
      "datasource": {
        "type": "prometheus",
        "uid": "P46855B3906317654"
      },
      "fill": 1,
      "fillGradient": 0,
      "gridPos": {
        "h": 7,
        "w": 6,
        "x": 0,
        "y": 7
      },
      "hiddenSeries": false,
      "id": 5,
      "legend": {
        "avg": false,
        "current": false,
        "max": false,
        "min": false,
        "show": true,
        "total": false,
        "values": false
      },
      "lines": true,
      "linewidth": 1,
      "links": [],
      "nullPointMode": "null",
      "options": {
        "alertThreshold": true
      },
      "percentage": false,
      "pluginVersion": "8.5.2",
      "pointradius": 5,
      "points": false,
      "renderer": "flot",
      "seriesOverrides": [],
      "spaceLength": 10,
      "stack": false,
      "steppedLine": false,
      "targets": [
        {
          "datasource": {
            "type": "prometheus",
            "uid": "P46855B3906317654"
          },
          "expr": "process_virtual_memory_bytes{app=\"istiod\", cluster_name=\"$cluster\"}",
          "format": "time_series",
          "instant": false,
          "intervalFactor": 2,
          "legendFormat": "Virtual Memory",
          "refId": "I",
          "step": 2
        },
        {
          "datasource": {
            "type": "prometheus",
            "uid": "P46855B3906317654"
          },
          "expr": "process_resident_memory_bytes{app=\"istiod\", cluster_name=\"$cluster\"}",
          "format": "time_series",
          "intervalFactor": 2,
          "legendFormat": "Resident Memory",
          "refId": "H",
          "step": 2
        },
        {
          "datasource": {
            "type": "prometheus",
            "uid": "P46855B3906317654"
          },
          "expr": "go_memstats_heap_sys_bytes{app=\"istiod\", cluster_name=\"$cluster\"}",
          "format": "time_series",
          "hide": true,
          "intervalFactor": 2,
          "legendFormat": "heap sys",
          "refId": "A"
        },
        {
          "datasource": {
            "type": "prometheus",
            "uid": "P46855B3906317654"
          },
          "expr": "go_memstats_heap_alloc_bytes{app=\"istiod\", cluster_name=\"$cluster\"}",
          "format": "time_series",
          "hide": true,
          "intervalFactor": 2,
          "legendFormat": "heap alloc",
          "refId": "D"
        },
        {
          "datasource": {
            "type": "prometheus",
            "uid": "P46855B3906317654"
          },
          "expr": "go_memstats_alloc_bytes{app=\"istiod\", cluster_name=\"$cluster\"}",
          "format": "time_series",
          "intervalFactor": 2,
          "legendFormat": "Alloc",
          "refId": "F",
          "step": 2
        },
        {
          "datasource": {
            "type": "prometheus",
            "uid": "P46855B3906317654"
          },
          "expr": "go_memstats_heap_inuse_bytes{app=\"istiod\", cluster_name=\"$cluster\"}",
          "format": "time_series",
          "hide": false,
          "intervalFactor": 2,
          "legendFormat": "Heap in-use",
          "refId": "E",
          "step": 2
        },
        {
          "datasource": {
            "type": "prometheus",
            "uid": "P46855B3906317654"
          },
          "expr": "go_memstats_stack_inuse_bytes{app=\"istiod\", cluster_name=\"$cluster\"}",
          "format": "time_series",
          "intervalFactor": 2,
          "legendFormat": "Stack in-use",
          "refId": "G",
          "step": 2
        },
        {
          "datasource": {
            "type": "prometheus",
            "uid": "P46855B3906317654"
          },
          "expr": "container_memory_working_set_bytes{container=~\"discovery\", pod=~\"istiod-.*|istio-pilot-.*\", cluster_name=\"$cluster\"}",
          "format": "time_series",
          "hide": false,
          "intervalFactor": 2,
          "legendFormat": "Discovery (container)",
          "refId": "B",
          "step": 2
        },
        {
          "datasource": {
            "type": "prometheus",
            "uid": "P46855B3906317654"
          },
          "expr": "container_memory_working_set_bytes{container=~\"istio-proxy\", pod=~\"istiod-.*|istio-pilot-.*\", cluster_name=\"$cluster\"}",
          "format": "time_series",
          "intervalFactor": 1,
          "legendFormat": "Sidecar (container)",
          "refId": "C"
        }
      ],
      "thresholds": [],
      "timeRegions": [],
      "title": "Memory",
      "tooltip": {
        "shared": true,
        "sort": 0,
        "value_type": "individual"
      },
      "type": "graph",
      "xaxis": {
        "mode": "time",
        "show": true,
        "values": []
      },
      "yaxes": [
        {
          "format": "bytes",
          "logBase": 1,
          "show": true
        },
        {
          "format": "short",
          "logBase": 1,
          "show": false
        }
      ],
      "yaxis": {
        "align": false
      }
    },
    {
      "aliasColors": {},
      "bars": false,
      "dashLength": 10,
      "dashes": false,
      "datasource": {
        "type": "prometheus",
        "uid": "P46855B3906317654"
      },
      "fill": 1,
      "fillGradient": 0,
      "gridPos": {
        "h": 7,
        "w": 6,
        "x": 6,
        "y": 7
      },
      "hiddenSeries": false,
      "id": 6,
      "legend": {
        "avg": false,
        "current": false,
        "max": false,
        "min": false,
        "show": true,
        "total": false,
        "values": false
      },
      "lines": true,
      "linewidth": 1,
      "links": [],
      "nullPointMode": "null",
      "options": {
        "alertThreshold": true
      },
      "percentage": false,
      "pluginVersion": "8.5.2",
      "pointradius": 5,
      "points": false,
      "renderer": "flot",
      "seriesOverrides": [],
      "spaceLength": 10,
      "stack": false,
      "steppedLine": false,
      "targets": [
        {
          "datasource": {
            "type": "prometheus",
            "uid": "P46855B3906317654"
          },
          "expr": "sum(irate(container_cpu_usage_seconds_total{container=\"discovery\", pod=~\"istiod-.*|istio-pilot-.*\", cluster_name=\"$cluster\"}[1m]))",
          "format": "time_series",
          "intervalFactor": 1,
          "legendFormat": "Discovery (container)",
          "refId": "A"
        },
        {
          "datasource": {
            "type": "prometheus",
            "uid": "P46855B3906317654"
          },
          "expr": "irate(process_cpu_seconds_total{app=\"istiod\", cluster_name=\"$cluster\"}[1m])",
          "format": "time_series",
          "hide": false,
          "intervalFactor": 2,
          "legendFormat": "Discovery (process)",
          "refId": "C",
          "step": 2
        },
        {
          "datasource": {
            "type": "prometheus",
            "uid": "P46855B3906317654"
          },
          "expr": "sum(irate(container_cpu_usage_seconds_total{container=\"istio-proxy\", pod=~\"istiod-.*|istio-pilot-.*\", cluster_name=\"$cluster\"}[1m]))",
          "format": "time_series",
          "hide": false,
          "intervalFactor": 2,
          "legendFormat": "Sidecar (container)",
          "refId": "B",
          "step": 2
        }
      ],
      "thresholds": [],
      "timeRegions": [],
      "title": "CPU",
      "tooltip": {
        "shared": true,
        "sort": 0,
        "value_type": "individual"
      },
      "type": "graph",
      "xaxis": {
        "mode": "time",
        "show": true,
        "values": []
      },
      "yaxes": [
        {
          "format": "short",
          "logBase": 1,
          "show": true
        },
        {
          "format": "short",
          "logBase": 1,
          "show": true
        }
      ],
      "yaxis": {
        "align": false
      }
    },
    {
      "aliasColors": {},
      "bars": false,
      "dashLength": 10,
      "dashes": false,
      "datasource": {
        "type": "prometheus",
        "uid": "P46855B3906317654"
      },
      "fill": 1,
      "fillGradient": 0,
      "gridPos": {
        "h": 7,
        "w": 6,
        "x": 12,
        "y": 7
      },
      "hiddenSeries": false,
      "id": 7,
      "legend": {
        "avg": false,
        "current": false,
        "max": false,
        "min": false,
        "show": true,
        "total": false,
        "values": false
      },
      "lines": true,
      "linewidth": 1,
      "links": [],
      "nullPointMode": "null",
      "options": {
        "alertThreshold": true
      },
      "percentage": false,
      "pluginVersion": "8.5.2",
      "pointradius": 5,
      "points": false,
      "renderer": "flot",
      "seriesOverrides": [],
      "spaceLength": 10,
      "stack": false,
      "steppedLine": false,
      "targets": [
        {
          "datasource": {
            "type": "prometheus",
            "uid": "P46855B3906317654"
          },
          "expr": "container_fs_usage_bytes{container=\"discovery\", pod=~\"istiod-.*|istio-pilot-.*\", cluster_name=\"$cluster\"}",
          "format": "time_series",
          "intervalFactor": 2,
          "legendFormat": "Discovery",
          "refId": "B",
          "step": 2
        },
        {
          "datasource": {
            "type": "prometheus",
            "uid": "P46855B3906317654"
          },
          "expr": "container_fs_usage_bytes{container=\"istio-proxy\", pod=~\"istiod-.*|istio-pilot-.*\", cluster_name=\"$cluster\"}",
          "format": "time_series",
          "intervalFactor": 1,
          "legendFormat": "Sidecar",
          "refId": "A"
        }
      ],
      "thresholds": [],
      "timeRegions": [],
      "title": "Disk",
      "tooltip": {
        "shared": true,
        "sort": 0,
        "value_type": "individual"
      },
      "type": "graph",
      "xaxis": {
        "mode": "time",
        "show": true,
        "values": []
      },
      "yaxes": [
        {
          "format": "bytes",
          "label": "",
          "logBase": 1,
          "show": true
        },
        {
          "format": "none",
          "label": "",
          "logBase": 1024,
          "show": false
        }
      ],
      "yaxis": {
        "align": false
      }
    },
    {
      "aliasColors": {},
      "bars": false,
      "dashLength": 10,
      "dashes": false,
      "datasource": {
        "type": "prometheus",
        "uid": "P46855B3906317654"
      },
      "fill": 1,
      "fillGradient": 0,
      "gridPos": {
        "h": 7,
        "w": 6,
        "x": 18,
        "y": 7
      },
      "hiddenSeries": false,
      "id": 4,
      "legend": {
        "avg": false,
        "current": false,
        "max": false,
        "min": false,
        "show": false,
        "total": false,
        "values": false
      },
      "lines": true,
      "linewidth": 1,
      "links": [],
      "nullPointMode": "null",
      "options": {
        "alertThreshold": true
      },
      "percentage": false,
      "pluginVersion": "8.5.2",
      "pointradius": 5,
      "points": false,
      "renderer": "flot",
      "seriesOverrides": [],
      "spaceLength": 10,
      "stack": false,
      "steppedLine": false,
      "targets": [
        {
          "datasource": {
            "type": "prometheus",
            "uid": "P46855B3906317654"
          },
          "expr": "go_goroutines{app=\"istiod\", cluster_name=\"$cluster\"}",
          "format": "time_series",
          "intervalFactor": 2,
          "legendFormat": "Number of Goroutines",
          "refId": "A",
          "step": 2
        }
      ],
      "thresholds": [],
      "timeRegions": [],
      "title": "Goroutines",
      "tooltip": {
        "shared": true,
        "sort": 0,
        "value_type": "individual"
      },
      "type": "graph",
      "xaxis": {
        "mode": "time",
        "show": true,
        "values": []
      },
      "yaxes": [
        {
          "format": "short",
          "label": "",
          "logBase": 1,
          "show": true
        },
        {
          "format": "short",
          "logBase": 1,
          "show": true
        }
      ],
      "yaxis": {
        "align": false
      }
    },
    {
      "collapsed": false,
      "datasource": {
        "type": "prometheus",
        "uid": "P46855B3906317654"
      },
      "gridPos": {
        "h": 1,
        "w": 24,
        "x": 0,
        "y": 14
      },
      "id": 58,
      "panels": [],
      "title": "Pilot Push Information",
      "type": "row"
    },
    {
      "aliasColors": {},
      "bars": true,
      "dashLength": 10,
      "dashes": false,
      "datasource": {
        "type": "prometheus",
        "uid": "P46855B3906317654"
      },
      "description": "Shows the rate of pilot pushes",
      "fill": 1,
      "fillGradient": 0,
      "gridPos": {
        "h": 8,
        "w": 8,
        "x": 0,
        "y": 15
      },
      "hiddenSeries": false,
      "id": 622,
      "legend": {
        "avg": false,
        "current": false,
        "max": false,
        "min": false,
        "show": true,
        "total": false,
        "values": false
      },
      "lines": false,
      "linewidth": 1,
      "links": [],
      "nullPointMode": "null as zero",
      "options": {
        "alertThreshold": true
      },
      "paceLength": 10,
      "percentage": false,
      "pluginVersion": "8.5.2",
      "pointradius": 5,
      "points": false,
      "renderer": "flot",
      "seriesOverrides": [],
      "spaceLength": 10,
      "stack": true,
      "steppedLine": false,
      "targets": [
        {
          "datasource": {
            "type": "prometheus",
            "uid": "P46855B3906317654"
          },
          "expr": "sum(irate(pilot_xds_pushes{type=\"cds\", cluster_name=\"$cluster\"}[1m]))",
          "format": "time_series",
          "intervalFactor": 1,
          "legendFormat": "Cluster",
          "refId": "C"
        },
        {
          "datasource": {
            "type": "prometheus",
            "uid": "P46855B3906317654"
          },
          "expr": "sum(irate(pilot_xds_pushes{type=\"eds\", cluster_name=\"$cluster\"}[1m]))",
          "format": "time_series",
          "intervalFactor": 1,
          "legendFormat": "Endpoints",
          "refId": "D"
        },
        {
          "datasource": {
            "type": "prometheus",
            "uid": "P46855B3906317654"
          },
          "expr": "sum(irate(pilot_xds_pushes{type=\"lds\", cluster_name=\"$cluster\"}[1m]))",
          "format": "time_series",
          "intervalFactor": 1,
          "legendFormat": "Listeners",
          "refId": "A"
        },
        {
          "datasource": {
            "type": "prometheus",
            "uid": "P46855B3906317654"
          },
          "expr": "sum(irate(pilot_xds_pushes{type=\"rds\", cluster_name=\"$cluster\"}[1m]))",
          "format": "time_series",
          "intervalFactor": 1,
          "legendFormat": "Routes",
          "refId": "E"
        },
        {
          "datasource": {
            "type": "prometheus",
            "uid": "P46855B3906317654"
          },
          "expr": "sum(irate(pilot_xds_pushes{type=\"sds\", cluster_name=\"$cluster\"}[1m]))",
          "interval": "",
          "legendFormat": "Secrets",
          "refId": "B"
        },
        {
          "datasource": {
            "type": "prometheus",
            "uid": "P46855B3906317654"
          },
          "expr": "sum(irate(pilot_xds_pushes{type=\"nds\", cluster_name=\"$cluster\"}[1m]))",
          "interval": "",
          "legendFormat": "Nametables",
          "refId": "F"
        }
      ],
      "thresholds": [],
      "timeRegions": [],
      "title": "Pilot Pushes",
      "tooltip": {
        "shared": false,
        "sort": 0,
        "value_type": "individual"
      },
      "type": "graph",
      "xaxis": {
        "mode": "time",
        "show": true,
        "values": [
          "total"
        ]
      },
      "yaxes": [
        {
          "format": "ops",
          "logBase": 1,
          "min": "0",
          "show": true
        },
        {
          "format": "short",
          "logBase": 1,
          "show": false
        }
      ],
      "yaxis": {
        "align": false
      }
    },
    {
      "aliasColors": {},
      "bars": false,
      "dashLength": 10,
      "dashes": false,
      "datasource": {
        "type": "prometheus",
        "uid": "P46855B3906317654"
      },
      "description": "Captures a variety of pilot errors",
      "fill": 1,
      "fillGradient": 0,
      "gridPos": {
        "h": 8,
        "w": 8,
        "x": 8,
        "y": 15
      },
      "hiddenSeries": false,
      "id": 67,
      "legend": {
        "avg": false,
        "current": false,
        "hideEmpty": true,
        "hideZero": true,
        "max": false,
        "min": false,
        "show": true,
        "total": false,
        "values": false
      },
      "lines": true,
      "linewidth": 1,
      "links": [],
      "nullPointMode": "null",
      "options": {
        "alertThreshold": true
      },
      "percentage": false,
      "pluginVersion": "8.5.2",
      "pointradius": 5,
      "points": false,
      "renderer": "flot",
      "seriesOverrides": [],
      "spaceLength": 10,
      "stack": false,
      "steppedLine": false,
      "targets": [
        {
          "datasource": {
            "type": "prometheus",
            "uid": "P46855B3906317654"
          },
          "expr": "sum(pilot_xds_cds_reject{app=\"istiod\", cluster_name=\"$cluster\"}) or (absent(pilot_xds_cds_reject{app=\"istiod\", cluster_name=\"$cluster\"}) - 1)",
          "format": "time_series",
          "hide": false,
          "intervalFactor": 1,
          "legendFormat": "Rejected CDS Configs",
          "refId": "C"
        },
        {
          "datasource": {
            "type": "prometheus",
            "uid": "P46855B3906317654"
          },
          "expr": "sum(pilot_xds_eds_reject{app=\"istiod\", cluster_name=\"$cluster\"}) or (absent(pilot_xds_eds_reject{app=\"istiod\", cluster_name=\"$cluster\"}) - 1)",
          "format": "time_series",
          "hide": false,
          "intervalFactor": 1,
          "legendFormat": "Rejected EDS Configs",
          "refId": "D"
        },
        {
          "datasource": {
            "type": "prometheus",
            "uid": "P46855B3906317654"
          },
          "expr": "sum(pilot_xds_rds_reject{app=\"istiod\", cluster_name=\"$cluster\"}) or (absent(pilot_xds_rds_reject{app=\"istiod\", cluster_name=\"$cluster\"}) - 1)",
          "format": "time_series",
          "hide": false,
          "intervalFactor": 1,
          "legendFormat": "Rejected RDS Configs",
          "refId": "A"
        },
        {
          "datasource": {
            "type": "prometheus",
            "uid": "P46855B3906317654"
          },
          "expr": "sum(pilot_xds_lds_reject{app=\"istiod\", cluster_name=\"$cluster\"}) or (absent(pilot_xds_lds_reject{app=\"istiod\", cluster_name=\"$cluster\"}) - 1)",
          "format": "time_series",
          "hide": false,
          "intervalFactor": 1,
          "legendFormat": "Rejected LDS Configs",
          "refId": "B"
        },
        {
          "datasource": {
            "type": "prometheus",
            "uid": "P46855B3906317654"
          },
          "expr": "sum(rate(pilot_xds_write_timeout{app=\"istiod\", cluster_name=\"$cluster\"}[1m]))",
          "format": "time_series",
          "intervalFactor": 1,
          "legendFormat": "Write Timeouts",
          "refId": "F"
        },
        {
          "datasource": {
            "type": "prometheus",
            "uid": "P46855B3906317654"
          },
          "expr": "sum(rate(pilot_total_xds_internal_errors{app=\"istiod\", cluster_name=\"$cluster\"}[1m]))",
          "format": "time_series",
          "hide": false,
          "intervalFactor": 1,
          "legendFormat": "Internal Errors",
          "refId": "H"
        },
        {
          "datasource": {
            "type": "prometheus",
            "uid": "P46855B3906317654"
          },
          "expr": "sum(rate(pilot_total_xds_rejects{app=\"istiod\", cluster_name=\"$cluster\"}[1m]))",
          "format": "time_series",
          "hide": false,
          "intervalFactor": 1,
          "legendFormat": "Config Rejection Rate",
          "refId": "E"
        },
        {
          "datasource": {
            "type": "prometheus",
            "uid": "P46855B3906317654"
          },
          "expr": "sum(rate(pilot_xds_push_context_errors{app=\"istiod\", cluster_name=\"$cluster\"}[1m]))",
          "format": "time_series",
          "hide": false,
          "intervalFactor": 1,
          "legendFormat": "Push Context Errors",
          "refId": "K"
        },
        {
          "datasource": {
            "type": "prometheus",
            "uid": "P46855B3906317654"
          },
          "expr": "sum(rate(pilot_xds_write_timeout{app=\"istiod\", cluster_name=\"$cluster\"}[1m]))",
          "format": "time_series",
          "intervalFactor": 1,
          "legendFormat": "Push Timeouts",
          "refId": "G"
        }
      ],
      "thresholds": [],
      "timeRegions": [],
      "title": "Pilot Errors",
      "tooltip": {
        "shared": true,
        "sort": 0,
        "value_type": "individual"
      },
      "type": "graph",
      "xaxis": {
        "mode": "time",
        "show": true,
        "values": []
      },
      "yaxes": [
        {
          "format": "short",
          "logBase": 1,
          "show": true
        },
        {
          "format": "short",
          "logBase": 1,
          "show": true
        }
      ],
      "yaxis": {
        "align": false
      }
    },
    {
      "aliasColors": {},
      "bars": false,
      "dashLength": 10,
      "dashes": false,
      "datasource": {
        "type": "prometheus",
        "uid": "P46855B3906317654"
      },
      "description": "Shows the total time it takes to push a config update to a proxy",
      "fill": 1,
      "fillGradient": 0,
      "gridPos": {
        "h": 8,
        "w": 8,
        "x": 16,
        "y": 15
      },
      "hiddenSeries": false,
      "id": 624,
      "legend": {
        "avg": false,
        "current": false,
        "max": false,
        "min": false,
        "show": true,
        "total": false,
        "values": false
      },
      "lines": true,
      "linewidth": 1,
      "links": [],
      "nullPointMode": "null",
      "options": {
        "alertThreshold": true
      },
      "percentage": false,
      "pluginVersion": "8.5.2",
      "pointradius": 2,
      "points": false,
      "renderer": "flot",
      "seriesOverrides": [],
      "spaceLength": 10,
      "stack": false,
      "steppedLine": false,
      "targets": [
        {
          "datasource": {
            "type": "prometheus",
            "uid": "P46855B3906317654"
          },
          "expr": "histogram_quantile(0.5, sum(rate(pilot_proxy_convergence_time_bucket{cluster_name=\"$cluster\"}[1m])) by (le))",
          "format": "time_series",
          "intervalFactor": 1,
          "legendFormat": "p50 ",
          "refId": "A"
        },
        {
          "datasource": {
            "type": "prometheus",
            "uid": "P46855B3906317654"
          },
          "expr": "histogram_quantile(0.9, sum(rate(pilot_proxy_convergence_time_bucket{cluster_name=\"$cluster\"}[1m])) by (le))",
          "format": "time_series",
          "intervalFactor": 1,
          "legendFormat": "p90",
          "refId": "B"
        },
        {
          "datasource": {
            "type": "prometheus",
            "uid": "P46855B3906317654"
          },
          "expr": "histogram_quantile(0.99, sum(rate(pilot_proxy_convergence_time_bucket{cluster_name=\"$cluster\"}[1m])) by (le))",
          "format": "time_series",
          "intervalFactor": 1,
          "legendFormat": "p99",
          "refId": "C"
        },
        {
          "datasource": {
            "type": "prometheus",
            "uid": "P46855B3906317654"
          },
          "expr": "histogram_quantile(0.999, sum(rate(pilot_proxy_convergence_time_bucket{cluster_name=\"$cluster\"}[1m])) by (le))",
          "format": "time_series",
          "intervalFactor": 1,
          "legendFormat": "p99.9",
          "refId": "D"
        }
      ],
      "thresholds": [],
      "timeRegions": [],
      "title": "Proxy Push Time",
      "tooltip": {
        "shared": true,
        "sort": 0,
        "value_type": "individual"
      },
      "type": "graph",
      "xaxis": {
        "mode": "time",
        "show": true,
        "values": []
      },
      "yaxes": [
        {
          "format": "s",
          "logBase": 1,
          "show": true
        },
        {
          "format": "short",
          "logBase": 1,
          "show": true
        }
      ],
      "yaxis": {
        "align": false
      }
    },
    {
      "aliasColors": {},
      "bars": false,
      "dashLength": 10,
      "dashes": false,
      "datasource": {
        "type": "prometheus",
        "uid": "P46855B3906317654"
      },
      "fill": 1,
      "fillGradient": 0,
      "gridPos": {
        "h": 8,
        "w": 12,
        "x": 0,
        "y": 23
      },
      "hiddenSeries": false,
      "id": 45,
      "legend": {
        "avg": false,
        "current": false,
        "hideEmpty": true,
        "hideZero": true,
        "max": false,
        "min": false,
        "show": true,
        "total": false,
        "values": false
      },
      "lines": true,
      "linewidth": 1,
      "links": [],
      "nullPointMode": "null as zero",
      "options": {
        "alertThreshold": true
      },
      "percentage": false,
      "pluginVersion": "8.5.2",
      "pointradius": 5,
      "points": false,
      "renderer": "flot",
      "seriesOverrides": [],
      "spaceLength": 10,
      "stack": false,
      "steppedLine": false,
      "targets": [
        {
          "datasource": {
            "type": "prometheus",
            "uid": "P46855B3906317654"
          },
          "expr": "pilot_conflict_inbound_listener{app=\"istiod\", cluster_name=\"$cluster\"}",
          "format": "time_series",
          "hide": false,
          "intervalFactor": 1,
          "legendFormat": "Inbound Listeners",
          "refId": "B"
        },
        {
          "datasource": {
            "type": "prometheus",
            "uid": "P46855B3906317654"
          },
          "expr": "pilot_conflict_outbound_listener_http_over_current_tcp{app=\"istiod\", cluster_name=\"$cluster\"}",
          "format": "time_series",
          "hide": false,
          "intervalFactor": 1,
          "legendFormat": "Outbound Listeners (http over current tcp)",
          "refId": "A"
        },
        {
          "datasource": {
            "type": "prometheus",
            "uid": "P46855B3906317654"
          },
          "expr": "pilot_conflict_outbound_listener_tcp_over_current_tcp{app=\"istiod\", cluster_name=\"$cluster\"}",
          "format": "time_series",
          "hide": false,
          "intervalFactor": 1,
          "legendFormat": "Outbound Listeners (tcp over current tcp)",
          "refId": "C"
        },
        {
          "datasource": {
            "type": "prometheus",
            "uid": "P46855B3906317654"
          },
          "expr": "pilot_conflict_outbound_listener_tcp_over_current_http{app=\"istiod\", cluster_name=\"$cluster\"}",
          "format": "time_series",
          "hide": false,
          "intervalFactor": 1,
          "legendFormat": "Outbound Listeners (tcp over current http)",
          "refId": "D"
        }
      ],
      "thresholds": [],
      "timeRegions": [],
      "title": "Conflicts",
      "tooltip": {
        "shared": true,
        "sort": 0,
        "value_type": "individual"
      },
      "type": "graph",
      "xaxis": {
        "mode": "time",
        "show": true,
        "values": []
      },
      "yaxes": [
        {
          "format": "short",
          "logBase": 1,
          "show": true
        },
        {
          "format": "short",
          "logBase": 1,
          "show": false
        }
      ],
      "yaxis": {
        "align": false
      }
    },
    {
      "aliasColors": {},
      "bars": false,
      "dashLength": 10,
      "dashes": false,
      "datasource": {
        "type": "prometheus",
        "uid": "P46855B3906317654"
      },
      "fill": 1,
      "fillGradient": 0,
      "gridPos": {
        "h": 8,
        "w": 12,
        "x": 12,
        "y": 23
      },
      "hiddenSeries": false,
      "id": 47,
      "legend": {
        "avg": false,
        "current": false,
        "max": false,
        "min": false,
        "show": true,
        "total": false,
        "values": false
      },
      "lines": true,
      "linewidth": 1,
      "links": [],
      "nullPointMode": "null",
      "options": {
        "alertThreshold": true
      },
      "percentage": false,
      "pluginVersion": "8.5.2",
      "pointradius": 5,
      "points": false,
      "renderer": "flot",
      "seriesOverrides": [],
      "spaceLength": 10,
      "stack": false,
      "steppedLine": false,
      "targets": [
        {
          "datasource": {
            "type": "prometheus",
            "uid": "P46855B3906317654"
          },
          "expr": "avg(pilot_virt_services{app=\"istiod\", cluster_name=\"$cluster\"})",
          "format": "time_series",
          "intervalFactor": 1,
          "legendFormat": "Virtual Services",
          "refId": "A"
        },
        {
          "datasource": {
            "type": "prometheus",
            "uid": "P46855B3906317654"
          },
          "expr": "avg(pilot_services{app=\"istiod\", cluster_name=\"$cluster\"})",
          "format": "time_series",
          "intervalFactor": 1,
          "legendFormat": "Services",
          "refId": "B"
        },
        {
          "datasource": {
            "type": "prometheus",
            "uid": "P46855B3906317654"
          },
          "expr": "sum(pilot_xds{app=\"istiod\", cluster_name=\"$cluster\"}) by (pod)",
          "format": "time_series",
          "intervalFactor": 1,
          "legendFormat": "Connected Endpoints {{pod}}",
          "refId": "E"
        }
      ],
      "thresholds": [],
      "timeRegions": [],
      "title": "ADS Monitoring",
      "tooltip": {
        "shared": true,
        "sort": 0,
        "value_type": "individual"
      },
      "type": "graph",
      "xaxis": {
        "mode": "time",
        "show": true,
        "values": []
      },
      "yaxes": [
        {
          "format": "short",
          "logBase": 1,
          "show": true
        },
        {
          "format": "short",
          "logBase": 1,
          "show": true
        }
      ],
      "yaxis": {
        "align": false
      }
    },
    {
      "collapsed": false,
      "datasource": {
        "type": "prometheus",
        "uid": "P46855B3906317654"
      },
      "gridPos": {
        "h": 1,
        "w": 24,
        "x": 0,
        "y": 31
      },
      "id": 64,
      "panels": [],
      "title": "Envoy Information",
      "type": "row"
    },
    {
      "aliasColors": {},
      "bars": false,
      "dashLength": 10,
      "dashes": false,
      "datasource": {
        "type": "prometheus",
        "uid": "P46855B3906317654"
      },
      "description": "Shows details about Envoy proxies in the mesh",
      "fill": 1,
      "fillGradient": 0,
      "gridPos": {
        "h": 8,
        "w": 8,
        "x": 0,
        "y": 32
      },
      "hiddenSeries": false,
      "id": 40,
      "legend": {
        "avg": false,
        "current": false,
        "max": false,
        "min": false,
        "show": true,
        "total": false,
        "values": false
      },
      "lines": true,
      "linewidth": 1,
      "links": [],
      "nullPointMode": "null",
      "options": {
        "alertThreshold": true
      },
      "percentage": false,
      "pluginVersion": "8.5.2",
      "pointradius": 5,
      "points": false,
      "renderer": "flot",
      "seriesOverrides": [],
      "spaceLength": 10,
      "stack": false,
      "steppedLine": false,
      "targets": [
        {
          "datasource": {
            "type": "prometheus",
            "uid": "P46855B3906317654"
          },
          "expr": "sum(irate(envoy_cluster_upstream_cx_total{cluster_name=\"xds-grpc\", cluster_name=\"$cluster\"}[1m]))",
          "format": "time_series",
          "hide": false,
          "intervalFactor": 1,
          "legendFormat": "XDS Connections",
          "refId": "C"
        },
        {
          "datasource": {
            "type": "prometheus",
            "uid": "P46855B3906317654"
          },
          "expr": "sum(irate(envoy_cluster_upstream_cx_connect_fail{cluster_name=\"xds-grpc\", cluster_name=\"$cluster\"}[1m]))",
          "format": "time_series",
          "hide": false,
          "intervalFactor": 1,
          "legendFormat": "XDS Connection Failures",
          "refId": "A"
        },
        {
          "datasource": {
            "type": "prometheus",
            "uid": "P46855B3906317654"
          },
          "expr": "sum(increase(envoy_server_hot_restart_epoch{cluster_name=\"$cluster\"}[1m]))",
          "format": "time_series",
          "intervalFactor": 1,
          "legendFormat": "Envoy Restarts",
          "refId": "B"
        }
      ],
      "thresholds": [],
      "timeRegions": [],
      "title": "Envoy Details",
      "tooltip": {
        "shared": true,
        "sort": 0,
        "value_type": "individual"
      },
      "type": "graph",
      "xaxis": {
        "mode": "time",
        "show": true,
        "values": []
      },
      "yaxes": [
        {
          "format": "ops",
          "logBase": 1,
          "show": true
        },
        {
          "format": "ops",
          "logBase": 1,
          "show": false
        }
      ],
      "yaxis": {
        "align": false
      }
    },
    {
      "aliasColors": {},
      "bars": false,
      "dashLength": 10,
      "dashes": false,
      "datasource": {
        "type": "prometheus",
        "uid": "P46855B3906317654"
      },
      "fill": 1,
      "fillGradient": 0,
      "gridPos": {
        "h": 8,
        "w": 8,
        "x": 8,
        "y": 32
      },
      "hiddenSeries": false,
      "id": 41,
      "legend": {
        "avg": false,
        "current": false,
        "max": false,
        "min": false,
        "show": true,
        "total": false,
        "values": false
      },
      "lines": true,
      "linewidth": 1,
      "links": [],
      "nullPointMode": "null",
      "options": {
        "alertThreshold": true
      },
      "percentage": false,
      "pluginVersion": "8.5.2",
      "pointradius": 5,
      "points": false,
      "renderer": "flot",
      "seriesOverrides": [],
      "spaceLength": 10,
      "stack": false,
      "steppedLine": false,
      "targets": [
        {
          "datasource": {
            "type": "prometheus",
            "uid": "P46855B3906317654"
          },
          "expr": "sum(envoy_cluster_upstream_cx_active{cluster_name=\"xds-grpc\", cluster_name=\"$cluster\"})",
          "format": "time_series",
          "intervalFactor": 2,
          "legendFormat": "XDS Active Connections",
          "refId": "C",
          "step": 2
        }
      ],
      "thresholds": [],
      "timeRegions": [],
      "title": "XDS Active Connections",
      "tooltip": {
        "shared": true,
        "sort": 0,
        "value_type": "individual"
      },
      "type": "graph",
      "xaxis": {
        "mode": "time",
        "show": true,
        "values": []
      },
      "yaxes": [
        {
          "format": "short",
          "logBase": 1,
          "show": true
        },
        {
          "format": "short",
          "logBase": 1,
          "show": true
        }
      ],
      "yaxis": {
        "align": false
      }
    },
    {
      "aliasColors": {},
      "bars": false,
      "dashLength": 10,
      "dashes": false,
      "datasource": {
        "type": "prometheus",
        "uid": "P46855B3906317654"
      },
      "description": "Shows the size of XDS requests and responses",
      "fill": 1,
      "fillGradient": 0,
      "gridPos": {
        "h": 8,
        "w": 8,
        "x": 16,
        "y": 32
      },
      "hiddenSeries": false,
      "id": 42,
      "legend": {
        "avg": false,
        "current": false,
        "hideEmpty": false,
        "hideZero": false,
        "max": false,
        "min": false,
        "show": true,
        "total": false,
        "values": false
      },
      "lines": true,
      "linewidth": 1,
      "links": [],
      "nullPointMode": "null",
      "options": {
        "alertThreshold": true
      },
      "percentage": false,
      "pluginVersion": "8.5.2",
      "pointradius": 5,
      "points": false,
      "renderer": "flot",
      "seriesOverrides": [],
      "spaceLength": 10,
      "stack": false,
      "steppedLine": false,
      "targets": [
        {
          "datasource": {
            "type": "prometheus",
            "uid": "P46855B3906317654"
          },
          "expr": "max(rate(envoy_cluster_upstream_cx_rx_bytes_total{cluster_name=\"xds-grpc\", cluster_name=\"$cluster\"}[1m]))",
          "format": "time_series",
          "hide": false,
          "intervalFactor": 1,
          "legendFormat": "XDS Response Bytes Max",
          "refId": "D"
        },
        {
          "datasource": {
            "type": "prometheus",
            "uid": "P46855B3906317654"
          },
          "expr": "quantile(0.5, rate(envoy_cluster_upstream_cx_rx_bytes_total{cluster_name=\"xds-grpc\", cluster_name=\"$cluster\"}[1m]))",
          "format": "time_series",
          "hide": false,
          "intervalFactor": 1,
          "legendFormat": "XDS Response Bytes Average",
          "refId": "B"
        },
        {
          "datasource": {
            "type": "prometheus",
            "uid": "P46855B3906317654"
          },
          "expr": "max(rate(envoy_cluster_upstream_cx_tx_bytes_total{cluster_name=\"xds-grpc\", cluster_name=\"$cluster\"}[1m]))",
          "format": "time_series",
          "intervalFactor": 1,
          "legendFormat": "XDS Request Bytes Max",
          "refId": "A"
        },
        {
          "datasource": {
            "type": "prometheus",
            "uid": "P46855B3906317654"
          },
          "expr": "quantile(.5, rate(envoy_cluster_upstream_cx_tx_bytes_total{cluster_name=\"xds-grpc\", cluster_name=\"$cluster\"}[1m]))",
          "format": "time_series",
          "intervalFactor": 1,
          "legendFormat": "XDS Request Bytes Average",
          "refId": "C"
        }
      ],
      "thresholds": [],
      "timeRegions": [],
      "title": "XDS Requests Size",
      "tooltip": {
        "shared": true,
        "sort": 0,
        "value_type": "individual"
      },
      "type": "graph",
      "xaxis": {
        "mode": "time",
        "show": true,
        "values": []
      },
      "yaxes": [
        {
          "format": "Bps",
          "logBase": 1,
          "show": true
        },
        {
          "format": "ops",
          "logBase": 1,
          "show": false
        }
      ],
      "yaxis": {
        "align": false
      }
    },
    {
      "collapsed": false,
      "datasource": {
        "type": "prometheus",
        "uid": "P46855B3906317654"
      },
      "gridPos": {
        "h": 1,
        "w": 24,
        "x": 0,
        "y": 40
      },
      "id": 626,
      "panels": [],
      "title": "Webhooks",
      "type": "row"
    },
    {
      "aliasColors": {},
      "bars": false,
      "dashLength": 10,
      "dashes": false,
      "datasource": {
        "type": "prometheus",
        "uid": "P46855B3906317654"
      },
      "fieldConfig": {
        "defaults": {
          "links": []
        },
        "overrides": []
      },
      "fill": 1,
      "fillGradient": 0,
      "gridPos": {
        "h": 8,
        "w": 12,
        "x": 0,
        "y": 41
      },
      "hiddenSeries": false,
      "id": 629,
      "legend": {
        "avg": false,
        "current": false,
        "hideEmpty": false,
        "hideZero": false,
        "max": false,
        "min": false,
        "show": true,
        "total": false,
        "values": false
      },
      "lines": true,
      "linewidth": 1,
      "nullPointMode": "null",
      "options": {
        "alertThreshold": true
      },
      "percentage": false,
      "pluginVersion": "8.5.2",
      "pointradius": 2,
      "points": false,
      "renderer": "flot",
      "seriesOverrides": [],
      "spaceLength": 10,
      "stack": false,
      "steppedLine": false,
      "targets": [
        {
          "datasource": {
            "type": "prometheus",
            "uid": "P46855B3906317654"
          },
          "expr": "sum(rate(galley_validation_passed{cluster_name=\"$cluster\"}[1m]))",
          "interval": "",
          "legendFormat": "Validations (Success)",
          "refId": "A"
        },
        {
          "datasource": {
            "type": "prometheus",
            "uid": "P46855B3906317654"
          },
          "expr": "sum(rate(galley_validation_failed{cluster_name=\"$cluster\"}[1m]))",
          "interval": "",
          "legendFormat": "Validation (Failure)",
          "refId": "B"
        }
      ],
      "thresholds": [],
      "timeRegions": [],
      "title": "Configuration Validation",
      "tooltip": {
        "shared": true,
        "sort": 0,
        "value_type": "individual"
      },
      "type": "graph",
      "xaxis": {
        "mode": "time",
        "show": true,
        "values": []
      },
      "yaxes": [
        {
          "format": "short",
          "logBase": 1,
          "show": true
        },
        {
          "format": "short",
          "logBase": 1,
          "show": true
        }
      ],
      "yaxis": {
        "align": false
      }
    },
    {
      "aliasColors": {},
      "bars": false,
      "dashLength": 10,
      "dashes": false,
      "datasource": {
        "type": "prometheus",
        "uid": "P46855B3906317654"
      },
      "description": "",
      "fieldConfig": {
        "defaults": {
          "links": []
        },
        "overrides": []
      },
      "fill": 1,
      "fillGradient": 0,
      "gridPos": {
        "h": 8,
        "w": 12,
        "x": 12,
        "y": 41
      },
      "hiddenSeries": false,
      "id": 630,
      "legend": {
        "avg": false,
        "current": false,
        "hideZero": false,
        "max": false,
        "min": false,
        "show": true,
        "total": false,
        "values": false
      },
      "lines": true,
      "linewidth": 1,
      "nullPointMode": "null",
      "options": {
        "alertThreshold": true
      },
      "percentage": false,
      "pluginVersion": "8.5.2",
      "pointradius": 2,
      "points": false,
      "renderer": "flot",
      "seriesOverrides": [],
      "spaceLength": 10,
      "stack": false,
      "steppedLine": false,
      "targets": [
        {
          "datasource": {
            "type": "prometheus",
            "uid": "P46855B3906317654"
          },
          "expr": "sum(rate(sidecar_injection_success_total{cluster_name=\"$cluster\"}[1m]))",
          "interval": "",
          "legendFormat": "Injections (Success)",
          "refId": "A"
        },
        {
          "datasource": {
            "type": "prometheus",
            "uid": "P46855B3906317654"
          },
          "expr": "sum(rate(sidecar_injection_failure_total{cluster_name=\"$cluster\"}[1m]))",
          "interval": "",
          "legendFormat": "Injections (Failure)",
          "refId": "B"
        }
      ],
      "thresholds": [],
      "timeRegions": [],
      "title": "Sidecar Injection",
      "tooltip": {
        "shared": true,
        "sort": 0,
        "value_type": "individual"
      },
      "type": "graph",
      "xaxis": {
        "mode": "time",
        "show": true,
        "values": []
      },
      "yaxes": [
        {
          "format": "short",
          "logBase": 1,
          "show": true
        },
        {
          "format": "short",
          "logBase": 1,
          "show": true
        }
      ],
      "yaxis": {
        "align": false
      }
    }
  ],
  "refresh": "5s",
  "schemaVersion": 36,
  "style": "dark",
  "tags": [],
  "templating": {
    "list": [
      {
        "current": {
          "selected": false,
          "text": "default",
          "value": "default"
        },
        "hide": 0,
        "includeAll": false,
        "multi": false,
        "name": "datasource",
        "options": [],
        "query": "prometheus",
        "queryValue": "",
        "refresh": 1,
        "regex": "",
        "skipUrlSync": false,
        "type": "datasource"
      },
      {
        "current": {
          "selected": false,
          "text": "main",
          "value": "main"
        },
        "datasource": {
          "type": "prometheus",
          "uid": "P46855B3906317654"
        },
        "definition": "label_values(cluster_name)",
        "hide": 0,
        "includeAll": false,
        "multi": false,
        "name": "cluster",
        "options": [],
        "query": {
          "query": "label_values(cluster_name)",
          "refId": "StandardVariableQuery"
        },
        "refresh": 1,
        "regex": "",
        "skipUrlSync": false,
        "sort": 0,
        "type": "query"
      }
    ]
  },
  "time": {
    "from": "now-5m",
    "to": "now"
  },
  "timepicker": {
    "refresh_intervals": [
      "5s",
      "10s",
      "30s",
      "1m",
      "5m",
      "15m",
      "30m",
      "1h",
      "2h",
      "1d"
    ],
    "time_options": [
      "5m",
      "15m",
      "1h",
      "6h",
      "12h",
      "24h",
      "2d",
      "7d",
      "30d"
    ]
  },
  "timezone": "browser",
  "title": "Istio Control Plane Dashboard",
  "uid": "a9xzp2unk",
  "version": 5,
  "weekStart": ""
}