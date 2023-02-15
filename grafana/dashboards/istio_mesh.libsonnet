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
  "description": "Istio Mesh Dashboard version 1.13.4",
  "editable": true,
  "fiscalYearStartMonth": 0,
  "gnetId": 7639,
  "graphTooltip": 0,
  "id": 4,
  "iteration": 1652883708809,
  "links": [],
  "liveNow": false,
  "panels": [
    {
      "datasource": {
        "type": "prometheus",
        "uid": "P46855B3906317654"
      },
      "gridPos": {
        "h": 3,
        "w": 24,
        "x": 0,
        "y": 0
      },
      "height": "50px",
      "id": 13,
      "links": [],
      "options": {
        "content": "<div>\n  <div style=\"position: absolute; bottom: 0\">\n    <a href=\"https://istio.io\" target=\"_blank\" style=\"font-size: 30px; text-decoration: none; color: inherit\"><img src=\"https://istio.io/latest/img/istio-bluelogo-nobackground-unframed.svg\" style=\"height: 50px\"> Istio</a>\n  </div>\n  <div style=\"position: absolute; bottom: 0; right: 0; font-size: 15px\">\n    Istio is an <a href=\"https://github.com/istio/istio\" target=\"_blank\">open platform</a> that provides a uniform way to <a href=\"https://istio.io/docs/concepts/security/\" target=\"_blank\">secure</a>,\n    <a href=\"https://istio.io/docs/concepts/traffic-management/\" target=\"_blank\">connect</a>, and \n    <a href=\"https://istio.io/docs/concepts/observability/\" target=\"_blank\">monitor</a> microservices.\n    <br>\n    Need help? <a href=\"https://istio.io/get-involved/\" target=\"_blank\">Join the Istio community</a>.\n  </div>\n</div>",
        "mode": "html"
      },
      "pluginVersion": "8.5.2",
      "style": {
        "font-size": "18pt"
      },
      "transparent": true,
      "type": "text"
    },
    {
      "datasource": {
        "type": "prometheus",
        "uid": "P46855B3906317654"
      },
      "fieldConfig": {
        "defaults": {
          "color": {
            "fixedColor": "rgb(31, 120, 193)",
            "mode": "fixed"
          },
          "mappings": [
            {
              "options": {
                "match": "null",
                "result": {
                  "text": "N/A"
                }
              },
              "type": "special"
            }
          ],
          "thresholds": {
            "mode": "absolute",
            "steps": [
              {
                "color": "green",
                "value": null
              },
              {
                "color": "red",
                "value": 80
              }
            ]
          },
          "unit": "ops"
        },
        "overrides": []
      },
      "gridPos": {
        "h": 3,
        "w": 6,
        "x": 0,
        "y": 3
      },
      "id": 20,
      "links": [],
      "maxDataPoints": 100,
      "options": {
        "colorMode": "none",
        "graphMode": "area",
        "justifyMode": "auto",
        "orientation": "horizontal",
        "reduceOptions": {
          "calcs": [
            "mean"
          ],
          "fields": "",
          "values": false
        },
        "textMode": "auto"
      },
      "pluginVersion": "8.5.2",
      "targets": [
        {
          "datasource": {
            "type": "prometheus",
            "uid": "P46855B3906317654"
          },
          "expr": "round(sum(irate(istio_requests_total{reporter=\"source\", cluster_name=~\"$cluster\"}[1m])), 0.001)",
          "intervalFactor": 1,
          "refId": "A",
          "step": 4
        }
      ],
      "title": "Global Request Volume",
      "type": "stat"
    },
    {
      "datasource": {
        "type": "prometheus",
        "uid": "P46855B3906317654"
      },
      "fieldConfig": {
        "defaults": {
          "color": {
            "fixedColor": "rgb(31, 120, 193)",
            "mode": "fixed"
          },
          "mappings": [
            {
              "options": {
                "match": "null",
                "result": {
                  "text": "N/A"
                }
              },
              "type": "special"
            }
          ],
          "thresholds": {
            "mode": "absolute",
            "steps": [
              {
                "color": "rgba(245, 54, 54, 0.9)",
                "value": null
              },
              {
                "color": "rgba(237, 129, 40, 0.89)",
                "value": 95
              },
              {
                "color": "rgba(50, 172, 45, 0.97)",
                "value": 99
              }
            ]
          },
          "unit": "percentunit"
        },
        "overrides": []
      },
      "gridPos": {
        "h": 3,
        "w": 6,
        "x": 6,
        "y": 3
      },
      "id": 21,
      "links": [],
      "maxDataPoints": 100,
      "options": {
        "colorMode": "none",
        "graphMode": "area",
        "justifyMode": "auto",
        "orientation": "horizontal",
        "reduceOptions": {
          "calcs": [
            "mean"
          ],
          "fields": "",
          "values": false
        },
        "textMode": "auto"
      },
      "pluginVersion": "8.5.2",
      "targets": [
        {
          "datasource": {
            "type": "prometheus",
            "uid": "P46855B3906317654"
          },
          "expr": "sum(rate(istio_requests_total{reporter=\"source\", response_code!~\"5.*\", cluster_name=~\"$cluster\"}[1m])) / sum(rate(istio_requests_total{reporter=\"source\", cluster_name=~\"$cluster\"}[1m]))",
          "format": "time_series",
          "intervalFactor": 1,
          "refId": "A",
          "step": 4
        }
      ],
      "title": "Global Success Rate (non-5xx responses)",
      "type": "stat"
    },
    {
      "datasource": {
        "type": "prometheus",
        "uid": "P46855B3906317654"
      },
      "fieldConfig": {
        "defaults": {
          "color": {
            "fixedColor": "rgb(31, 120, 193)",
            "mode": "fixed"
          },
          "mappings": [
            {
              "options": {
                "match": "null",
                "result": {
                  "text": "N/A"
                }
              },
              "type": "special"
            }
          ],
          "thresholds": {
            "mode": "absolute",
            "steps": [
              {
                "color": "green",
                "value": null
              },
              {
                "color": "red",
                "value": 80
              }
            ]
          },
          "unit": "ops"
        },
        "overrides": []
      },
      "gridPos": {
        "h": 3,
        "w": 6,
        "x": 12,
        "y": 3
      },
      "id": 22,
      "links": [],
      "maxDataPoints": 100,
      "options": {
        "colorMode": "none",
        "graphMode": "area",
        "justifyMode": "auto",
        "orientation": "horizontal",
        "reduceOptions": {
          "calcs": [
            "mean"
          ],
          "fields": "",
          "values": false
        },
        "textMode": "auto"
      },
      "pluginVersion": "8.5.2",
      "targets": [
        {
          "datasource": {
            "type": "prometheus",
            "uid": "P46855B3906317654"
          },
          "expr": "sum(irate(istio_requests_total{reporter=\"source\", response_code=~\"4.*\", cluster_name=~\"$cluster\"}[1m]))",
          "format": "time_series",
          "intervalFactor": 1,
          "refId": "A",
          "step": 4
        }
      ],
      "title": "4xxs",
      "type": "stat"
    },
    {
      "datasource": {
        "type": "prometheus",
        "uid": "P46855B3906317654"
      },
      "fieldConfig": {
        "defaults": {
          "color": {
            "fixedColor": "rgb(31, 120, 193)",
            "mode": "fixed"
          },
          "mappings": [
            {
              "options": {
                "match": "null",
                "result": {
                  "text": "N/A"
                }
              },
              "type": "special"
            }
          ],
          "thresholds": {
            "mode": "absolute",
            "steps": [
              {
                "color": "green",
                "value": null
              },
              {
                "color": "red",
                "value": 80
              }
            ]
          },
          "unit": "ops"
        },
        "overrides": []
      },
      "gridPos": {
        "h": 3,
        "w": 6,
        "x": 18,
        "y": 3
      },
      "id": 23,
      "links": [],
      "maxDataPoints": 100,
      "options": {
        "colorMode": "none",
        "graphMode": "area",
        "justifyMode": "auto",
        "orientation": "horizontal",
        "reduceOptions": {
          "calcs": [
            "mean"
          ],
          "fields": "",
          "values": false
        },
        "textMode": "auto"
      },
      "pluginVersion": "8.5.2",
      "targets": [
        {
          "datasource": {
            "type": "prometheus",
            "uid": "P46855B3906317654"
          },
          "expr": "sum(irate(istio_requests_total{reporter=\"source\", response_code=~\"5.*\", cluster_name=~\"$cluster\"}[1m]))",
          "format": "time_series",
          "intervalFactor": 1,
          "refId": "A",
          "step": 4
        }
      ],
      "title": "5xxs",
      "type": "stat"
    },
    {
      "datasource": {
        "type": "prometheus",
        "uid": "P46855B3906317654"
      },
      "fieldConfig": {
        "defaults": {
          "color": {
            "fixedColor": "rgb(31, 120, 193)",
            "mode": "fixed"
          },
          "mappings": [
            {
              "options": {
                "match": "null",
                "result": {
                  "text": "N/A"
                }
              },
              "type": "special"
            }
          ],
          "thresholds": {
            "mode": "absolute",
            "steps": [
              {
                "color": "green",
                "value": null
              },
              {
                "color": "red",
                "value": 80
              }
            ]
          },
          "unit": "none"
        },
        "overrides": []
      },
      "gridPos": {
        "h": 3,
        "w": 6,
        "x": 0,
        "y": 6
      },
      "id": 113,
      "links": [],
      "maxDataPoints": 100,
      "options": {
        "colorMode": "none",
        "graphMode": "area",
        "justifyMode": "auto",
        "orientation": "horizontal",
        "reduceOptions": {
          "calcs": [
            "lastNotNull"
          ],
          "fields": "",
          "values": false
        },
        "textMode": "auto"
      },
      "pluginVersion": "8.5.2",
      "targets": [
        {
          "datasource": {
            "type": "prometheus",
            "uid": "P46855B3906317654"
          },
          "expr": "max(pilot_k8s_cfg_events{type=\"VirtualService\", event=\"add\", cluster_name=~\"$cluster\"}) - (max(pilot_k8s_cfg_events{type=\"VirtualService\", event=\"delete\", cluster_name=~\"$cluster\"}) or max(up * 0))",
          "format": "time_series",
          "intervalFactor": 1,
          "refId": "A"
        }
      ],
      "title": "Virtual Services",
      "type": "stat"
    },
    {
      "datasource": {
        "type": "prometheus",
        "uid": "P46855B3906317654"
      },
      "fieldConfig": {
        "defaults": {
          "color": {
            "fixedColor": "rgb(31, 120, 193)",
            "mode": "fixed"
          },
          "mappings": [
            {
              "options": {
                "match": "null",
                "result": {
                  "text": "N/A"
                }
              },
              "type": "special"
            }
          ],
          "thresholds": {
            "mode": "absolute",
            "steps": [
              {
                "color": "green",
                "value": null
              },
              {
                "color": "red",
                "value": 80
              }
            ]
          },
          "unit": "none"
        },
        "overrides": []
      },
      "gridPos": {
        "h": 3,
        "w": 6,
        "x": 6,
        "y": 6
      },
      "id": 114,
      "links": [],
      "maxDataPoints": 100,
      "options": {
        "colorMode": "none",
        "graphMode": "area",
        "justifyMode": "auto",
        "orientation": "horizontal",
        "reduceOptions": {
          "calcs": [
            "lastNotNull"
          ],
          "fields": "",
          "values": false
        },
        "textMode": "auto"
      },
      "pluginVersion": "8.5.2",
      "targets": [
        {
          "datasource": {
            "type": "prometheus",
            "uid": "P46855B3906317654"
          },
          "expr": "max(pilot_k8s_cfg_events{type=\"DestinationRule\", event=\"add\", cluster_name=~\"$cluster\"}) - (max(pilot_k8s_cfg_events{type=\"DestinationRule\", event=\"delete\", cluster_name=~\"$cluster\"}) or max(up * 0))",
          "format": "time_series",
          "intervalFactor": 1,
          "refId": "A"
        }
      ],
      "title": "Destination Rules",
      "type": "stat"
    },
    {
      "datasource": {
        "type": "prometheus",
        "uid": "P46855B3906317654"
      },
      "fieldConfig": {
        "defaults": {
          "color": {
            "fixedColor": "rgb(31, 120, 193)",
            "mode": "fixed"
          },
          "mappings": [
            {
              "options": {
                "match": "null",
                "result": {
                  "text": "N/A"
                }
              },
              "type": "special"
            }
          ],
          "thresholds": {
            "mode": "absolute",
            "steps": [
              {
                "color": "green",
                "value": null
              },
              {
                "color": "red",
                "value": 80
              }
            ]
          },
          "unit": "none"
        },
        "overrides": []
      },
      "gridPos": {
        "h": 3,
        "w": 6,
        "x": 12,
        "y": 6
      },
      "id": 115,
      "links": [],
      "maxDataPoints": 100,
      "options": {
        "colorMode": "none",
        "graphMode": "area",
        "justifyMode": "auto",
        "orientation": "horizontal",
        "reduceOptions": {
          "calcs": [
            "lastNotNull"
          ],
          "fields": "",
          "values": false
        },
        "textMode": "auto"
      },
      "pluginVersion": "8.5.2",
      "targets": [
        {
          "datasource": {
            "type": "prometheus",
            "uid": "P46855B3906317654"
          },
          "expr": "max(pilot_k8s_cfg_events{type=\"Gateway\", event=\"add\", cluster_name=~\"$cluster\"}) - (max(pilot_k8s_cfg_events{type=\"Gateway\", event=\"delete\", cluster_name=~\"$cluster\"}) or max(up * 0))",
          "format": "time_series",
          "intervalFactor": 1,
          "refId": "A"
        }
      ],
      "title": "Gateways",
      "type": "stat"
    },
    {
      "datasource": {
        "type": "prometheus",
        "uid": "P46855B3906317654"
      },
      "fieldConfig": {
        "defaults": {
          "color": {
            "fixedColor": "rgb(31, 120, 193)",
            "mode": "fixed"
          },
          "mappings": [
            {
              "options": {
                "match": "null",
                "result": {
                  "text": "N/A"
                }
              },
              "type": "special"
            }
          ],
          "thresholds": {
            "mode": "absolute",
            "steps": [
              {
                "color": "green",
                "value": null
              },
              {
                "color": "red",
                "value": 80
              }
            ]
          },
          "unit": "none"
        },
        "overrides": []
      },
      "gridPos": {
        "h": 3,
        "w": 6,
        "x": 18,
        "y": 6
      },
      "id": 116,
      "links": [],
      "maxDataPoints": 100,
      "options": {
        "colorMode": "none",
        "graphMode": "area",
        "justifyMode": "auto",
        "orientation": "horizontal",
        "reduceOptions": {
          "calcs": [
            "lastNotNull"
          ],
          "fields": "",
          "values": false
        },
        "textMode": "auto"
      },
      "pluginVersion": "8.5.2",
      "targets": [
        {
          "datasource": {
            "type": "prometheus",
            "uid": "P46855B3906317654"
          },
          "expr": "max(pilot_k8s_cfg_events{type=\"WorkloadEntry\", event=\"add\", cluster_name=~\"$cluster\"}) - (max(pilot_k8s_cfg_events{type=\"WorkloadEntry\", event=\"delete\", cluster_name=~\"$cluster\"}) or max(up * 0))",
          "format": "time_series",
          "intervalFactor": 1,
          "refId": "A"
        }
      ],
      "title": "Workload Entries",
      "type": "stat"
    },
    {
      "datasource": {
        "type": "prometheus",
        "uid": "P46855B3906317654"
      },
      "fieldConfig": {
        "defaults": {
          "color": {
            "fixedColor": "rgb(31, 120, 193)",
            "mode": "fixed"
          },
          "mappings": [
            {
              "options": {
                "match": "null",
                "result": {
                  "text": "N/A"
                }
              },
              "type": "special"
            }
          ],
          "thresholds": {
            "mode": "absolute",
            "steps": [
              {
                "color": "green",
                "value": null
              },
              {
                "color": "red",
                "value": 80
              }
            ]
          },
          "unit": "none"
        },
        "overrides": []
      },
      "gridPos": {
        "h": 3,
        "w": 6,
        "x": 0,
        "y": 9
      },
      "id": 117,
      "links": [],
      "maxDataPoints": 100,
      "options": {
        "colorMode": "none",
        "graphMode": "area",
        "justifyMode": "auto",
        "orientation": "horizontal",
        "reduceOptions": {
          "calcs": [
            "lastNotNull"
          ],
          "fields": "",
          "values": false
        },
        "textMode": "auto"
      },
      "pluginVersion": "8.5.2",
      "targets": [
        {
          "datasource": {
            "type": "prometheus",
            "uid": "P46855B3906317654"
          },
          "expr": "max(pilot_k8s_cfg_events{type=\"ServiceEntry\", event=\"add\", cluster_name=~\"$cluster\"}) - (max(pilot_k8s_cfg_events{type=\"ServiceEntry\", event=\"delete\", cluster_name=~\"$cluster\"}) or max(up * 0))",
          "format": "time_series",
          "intervalFactor": 1,
          "refId": "A"
        }
      ],
      "title": "Service Entries",
      "type": "stat"
    },
    {
      "datasource": {
        "type": "prometheus",
        "uid": "P46855B3906317654"
      },
      "fieldConfig": {
        "defaults": {
          "color": {
            "fixedColor": "rgb(31, 120, 193)",
            "mode": "fixed"
          },
          "mappings": [
            {
              "options": {
                "match": "null",
                "result": {
                  "text": "N/A"
                }
              },
              "type": "special"
            }
          ],
          "thresholds": {
            "mode": "absolute",
            "steps": [
              {
                "color": "green",
                "value": null
              },
              {
                "color": "red",
                "value": 80
              }
            ]
          },
          "unit": "none"
        },
        "overrides": []
      },
      "gridPos": {
        "h": 3,
        "w": 6,
        "x": 6,
        "y": 9
      },
      "id": 90,
      "links": [],
      "maxDataPoints": 100,
      "options": {
        "colorMode": "none",
        "graphMode": "area",
        "justifyMode": "auto",
        "orientation": "horizontal",
        "reduceOptions": {
          "calcs": [
            "lastNotNull"
          ],
          "fields": "",
          "values": false
        },
        "textMode": "auto"
      },
      "pluginVersion": "8.5.2",
      "targets": [
        {
          "datasource": {
            "type": "prometheus",
            "uid": "P46855B3906317654"
          },
          "expr": "max(pilot_k8s_cfg_events{type=\"PeerAuthentication\", event=\"add\", cluster_name=~\"$cluster\"}) - (max(pilot_k8s_cfg_events{type=\"PeerAuthentication\", event=\"delete\", cluster_name=~\"$cluster\"}) or max(up * 0))",
          "format": "time_series",
          "intervalFactor": 1,
          "refId": "A"
        }
      ],
      "title": "PeerAuthentication Policies",
      "type": "stat"
    },
    {
      "datasource": {
        "type": "prometheus",
        "uid": "P46855B3906317654"
      },
      "fieldConfig": {
        "defaults": {
          "color": {
            "fixedColor": "rgb(31, 120, 193)",
            "mode": "fixed"
          },
          "mappings": [
            {
              "options": {
                "match": "null",
                "result": {
                  "text": "N/A"
                }
              },
              "type": "special"
            }
          ],
          "thresholds": {
            "mode": "absolute",
            "steps": [
              {
                "color": "green",
                "value": null
              },
              {
                "color": "red",
                "value": 80
              }
            ]
          },
          "unit": "none"
        },
        "overrides": []
      },
      "gridPos": {
        "h": 3,
        "w": 6,
        "x": 12,
        "y": 9
      },
      "id": 91,
      "links": [],
      "maxDataPoints": 100,
      "options": {
        "colorMode": "none",
        "graphMode": "area",
        "justifyMode": "auto",
        "orientation": "horizontal",
        "reduceOptions": {
          "calcs": [
            "lastNotNull"
          ],
          "fields": "",
          "values": false
        },
        "textMode": "auto"
      },
      "pluginVersion": "8.5.2",
      "targets": [
        {
          "datasource": {
            "type": "prometheus",
            "uid": "P46855B3906317654"
          },
          "expr": "max(pilot_k8s_cfg_events{type=\"RequestAuthentication\", event=\"add\", cluster_name=~\"$cluster\"}) - (max(pilot_k8s_cfg_events{type=\"RequestAuthentication\", event=\"delete\", cluster_name=~\"$cluster\"}) or max(up * 0))",
          "format": "time_series",
          "intervalFactor": 1,
          "refId": "A"
        }
      ],
      "title": "RequestAuthentication Policies",
      "type": "stat"
    },
    {
      "datasource": {
        "type": "prometheus",
        "uid": "P46855B3906317654"
      },
      "fieldConfig": {
        "defaults": {
          "color": {
            "fixedColor": "rgb(31, 120, 193)",
            "mode": "fixed"
          },
          "mappings": [
            {
              "options": {
                "match": "null",
                "result": {
                  "text": "N/A"
                }
              },
              "type": "special"
            }
          ],
          "thresholds": {
            "mode": "absolute",
            "steps": [
              {
                "color": "green",
                "value": null
              },
              {
                "color": "red",
                "value": 80
              }
            ]
          },
          "unit": "none"
        },
        "overrides": []
      },
      "gridPos": {
        "h": 3,
        "w": 6,
        "x": 18,
        "y": 9
      },
      "id": 92,
      "links": [],
      "maxDataPoints": 100,
      "options": {
        "colorMode": "none",
        "graphMode": "area",
        "justifyMode": "auto",
        "orientation": "horizontal",
        "reduceOptions": {
          "calcs": [
            "lastNotNull"
          ],
          "fields": "",
          "values": false
        },
        "textMode": "auto"
      },
      "pluginVersion": "8.5.2",
      "targets": [
        {
          "datasource": {
            "type": "prometheus",
            "uid": "P46855B3906317654"
          },
          "expr": "max(pilot_k8s_cfg_events{type=\"AuthorizationPolicy\", event=\"add\", cluster_name=~\"$cluster\"}) - (max(pilot_k8s_cfg_events{type=\"AuthorizationPolicy\", event=\"delete\", cluster_name=~\"$cluster\"}) or max(up * 0))",
          "format": "time_series",
          "intervalFactor": 1,
          "refId": "A"
        }
      ],
      "title": "Authorization Policies",
      "type": "stat"
    },
    {
      "columns": [],
      "datasource": {
        "type": "prometheus",
        "uid": "P46855B3906317654"
      },
      "fontSize": "100%",
      "gridPos": {
        "h": 21,
        "w": 24,
        "x": 0,
        "y": 12
      },
      "hideTimeOverride": false,
      "id": 73,
      "links": [],
      "repeatDirection": "v",
      "scroll": true,
      "showHeader": true,
      "sort": {
        "col": 5,
        "desc": true
      },
      "styles": [
        {
          "alias": "Workload",
          "align": "auto",
          "colors": [
            "rgba(245, 54, 54, 0.9)",
            "rgba(237, 129, 40, 0.89)",
            "rgba(50, 172, 45, 0.97)"
          ],
          "dateFormat": "YYYY-MM-DD HH:mm:ss",
          "decimals": 2,
          "link": false,
          "linkTargetBlank": false,
          "linkTooltip": "Workload dashboard",
          "linkUrl": "/dashboard/db/istio-workload-dashboard?var-namespace=${__cell_3:raw}&var-workload=${__cell_2:raw}",
          "pattern": "destination_workload",
          "preserveFormat": false,
          "sanitize": false,
          "thresholds": [],
          "type": "hidden",
          "unit": "short"
        },
        {
          "alias": "",
          "align": "auto",
          "colors": [
            "rgba(245, 54, 54, 0.9)",
            "rgba(237, 129, 40, 0.89)",
            "rgba(50, 172, 45, 0.97)"
          ],
          "dateFormat": "YYYY-MM-DD HH:mm:ss",
          "decimals": 2,
          "pattern": "Time",
          "thresholds": [],
          "type": "hidden",
          "unit": "short"
        },
        {
          "alias": "Requests",
          "align": "auto",
          "colors": [
            "rgba(245, 54, 54, 0.9)",
            "rgba(237, 129, 40, 0.89)",
            "rgba(50, 172, 45, 0.97)"
          ],
          "dateFormat": "YYYY-MM-DD HH:mm:ss",
          "decimals": 2,
          "pattern": "Value #A",
          "thresholds": [],
          "type": "number",
          "unit": "ops"
        },
        {
          "alias": "P50 Latency",
          "align": "auto",
          "colors": [
            "rgba(245, 54, 54, 0.9)",
            "rgba(237, 129, 40, 0.89)",
            "rgba(50, 172, 45, 0.97)"
          ],
          "dateFormat": "YYYY-MM-DD HH:mm:ss",
          "decimals": 2,
          "pattern": "Value #B",
          "thresholds": [],
          "type": "number",
          "unit": "s"
        },
        {
          "alias": "P90 Latency",
          "align": "auto",
          "colors": [
            "rgba(245, 54, 54, 0.9)",
            "rgba(237, 129, 40, 0.89)",
            "rgba(50, 172, 45, 0.97)"
          ],
          "dateFormat": "YYYY-MM-DD HH:mm:ss",
          "decimals": 2,
          "pattern": "Value #C",
          "thresholds": [],
          "type": "number",
          "unit": "s"
        },
        {
          "alias": "P99 Latency",
          "align": "auto",
          "colors": [
            "rgba(245, 54, 54, 0.9)",
            "rgba(237, 129, 40, 0.89)",
            "rgba(50, 172, 45, 0.97)"
          ],
          "dateFormat": "YYYY-MM-DD HH:mm:ss",
          "decimals": 2,
          "pattern": "Value #D",
          "thresholds": [],
          "type": "number",
          "unit": "s"
        },
        {
          "alias": "Success Rate",
          "align": "auto",
          "colorMode": "cell",
          "colors": [
            "rgba(245, 54, 54, 0.9)",
            "rgba(237, 129, 40, 0.89)",
            "rgba(50, 172, 45, 0.97)"
          ],
          "dateFormat": "YYYY-MM-DD HH:mm:ss",
          "decimals": 2,
          "pattern": "Value #E",
          "thresholds": [
            ".95",
            " 1.00"
          ],
          "type": "number",
          "unit": "percentunit"
        },
        {
          "alias": "Workload",
          "align": "auto",
          "colors": [
            "rgba(245, 54, 54, 0.9)",
            "rgba(237, 129, 40, 0.89)",
            "rgba(50, 172, 45, 0.97)"
          ],
          "dateFormat": "YYYY-MM-DD HH:mm:ss",
          "decimals": 2,
          "link": true,
          "linkTooltip": "$__cell dashboard",
          "linkUrl": "/dashboard/db/istio-workload-dashboard?var-workload=${__cell_2:raw}&var-namespace=${__cell_3:raw}",
          "pattern": "destination_workload_var",
          "thresholds": [],
          "type": "number",
          "unit": "short"
        },
        {
          "alias": "Service",
          "align": "auto",
          "colors": [
            "rgba(245, 54, 54, 0.9)",
            "rgba(237, 129, 40, 0.89)",
            "rgba(50, 172, 45, 0.97)"
          ],
          "dateFormat": "YYYY-MM-DD HH:mm:ss",
          "decimals": 2,
          "link": true,
          "linkTooltip": "$__cell dashboard",
          "linkUrl": "/dashboard/db/istio-service-dashboard?var-service=${__cell_1:raw}",
          "pattern": "destination_service",
          "thresholds": [],
          "type": "string",
          "unit": "short"
        },
        {
          "alias": "",
          "align": "auto",
          "colors": [
            "rgba(245, 54, 54, 0.9)",
            "rgba(237, 129, 40, 0.89)",
            "rgba(50, 172, 45, 0.97)"
          ],
          "dateFormat": "YYYY-MM-DD HH:mm:ss",
          "decimals": 2,
          "pattern": "destination_workload_namespace",
          "thresholds": [],
          "type": "hidden",
          "unit": "short"
        }
      ],
      "targets": [
        {
          "datasource": {
            "type": "prometheus",
            "uid": "P46855B3906317654"
          },
          "expr": "label_join(sum(rate(istio_requests_total{reporter=\"source\", response_code=\"200\", cluster_name=~\"$cluster\"}[1m])) by (destination_workload, destination_workload_namespace, destination_service), \"destination_workload_var\", \".\", \"destination_workload\", \"destination_workload_namespace\")",
          "format": "table",
          "hide": false,
          "instant": true,
          "intervalFactor": 1,
          "legendFormat": "{{ destination_workload}}.{{ destination_workload_namespace }}",
          "refId": "A"
        },
        {
          "datasource": {
            "type": "prometheus",
            "uid": "P46855B3906317654"
          },
          "expr": "label_join((histogram_quantile(0.50, sum(rate(istio_request_duration_milliseconds_bucket{reporter=\"source\", cluster_name=~\"$cluster\"}[1m])) by (le, destination_workload, destination_workload_namespace)) / 1000) or histogram_quantile(0.50, sum(rate(istio_request_duration_seconds_bucket{reporter=\"source\", cluster_name=~\"$cluster\"}[1m])) by (le, destination_workload, destination_workload_namespace)), \"destination_workload_var\", \".\", \"destination_workload\", \"destination_workload_namespace\")",
          "format": "table",
          "hide": false,
          "instant": true,
          "intervalFactor": 1,
          "legendFormat": "{{ destination_workload}}.{{ destination_workload_namespace }}",
          "refId": "B"
        },
        {
          "datasource": {
            "type": "prometheus",
            "uid": "P46855B3906317654"
          },
          "expr": "label_join((histogram_quantile(0.90, sum(rate(istio_request_duration_milliseconds_bucket{reporter=\"source\", cluster_name=~\"$cluster\"}[1m])) by (le, destination_workload, destination_workload_namespace)) / 1000) or histogram_quantile(0.90, sum(rate(istio_request_duration_seconds_bucket{reporter=\"source\", cluster_name=~\"$cluster\"}[1m])) by (le, destination_workload, destination_workload_namespace)), \"destination_workload_var\", \".\", \"destination_workload\", \"destination_workload_namespace\")",
          "format": "table",
          "hide": false,
          "instant": true,
          "intervalFactor": 1,
          "legendFormat": "{{ destination_workload }}.{{ destination_workload_namespace }}",
          "refId": "C"
        },
        {
          "datasource": {
            "type": "prometheus",
            "uid": "P46855B3906317654"
          },
          "expr": "label_join((histogram_quantile(0.99, sum(rate(istio_request_duration_milliseconds_bucket{reporter=\"source\", cluster_name=~\"$cluster\"}[1m])) by (le, destination_workload, destination_workload_namespace)) / 1000) or histogram_quantile(0.99, sum(rate(istio_request_duration_seconds_bucket{reporter=\"source\", cluster_name=~\"$cluster\"}[1m])) by (le, destination_workload, destination_workload_namespace)), \"destination_workload_var\", \".\", \"destination_workload\", \"destination_workload_namespace\")",
          "format": "table",
          "hide": false,
          "instant": true,
          "intervalFactor": 1,
          "legendFormat": "{{ destination_workload }}.{{ destination_workload_namespace }}",
          "refId": "D"
        },
        {
          "datasource": {
            "type": "prometheus",
            "uid": "P46855B3906317654"
          },
          "expr": "label_join((sum(rate(istio_requests_total{reporter=\"source\", response_code!~\"5.*\", cluster_name=~\"$cluster\"}[1m])) by (destination_workload, destination_workload_namespace) / sum(rate(istio_requests_total{reporter=\"source\", cluster_name=~\"$cluster\"}[1m])) by (destination_workload, destination_workload_namespace)), \"destination_workload_var\", \".\", \"destination_workload\", \"destination_workload_namespace\")",
          "format": "table",
          "hide": false,
          "instant": true,
          "interval": "",
          "intervalFactor": 1,
          "legendFormat": "{{ destination_workload }}.{{ destination_workload_namespace }}",
          "refId": "E"
        }
      ],
      "title": "HTTP/GRPC Workloads",
      "transform": "table",
      "type": "table-old"
    },
    {
      "columns": [],
      "datasource": {
        "type": "prometheus",
        "uid": "P46855B3906317654"
      },
      "fontSize": "100%",
      "gridPos": {
        "h": 18,
        "w": 24,
        "x": 0,
        "y": 33
      },
      "hideTimeOverride": false,
      "id": 109,
      "links": [],
      "repeatDirection": "v",
      "scroll": true,
      "showHeader": true,
      "sort": {
        "col": 5,
        "desc": true
      },
      "styles": [
        {
          "alias": "Workload",
          "align": "auto",
          "colors": [
            "rgba(245, 54, 54, 0.9)",
            "rgba(237, 129, 40, 0.89)",
            "rgba(50, 172, 45, 0.97)"
          ],
          "dateFormat": "YYYY-MM-DD HH:mm:ss",
          "decimals": 2,
          "link": false,
          "linkTargetBlank": false,
          "linkTooltip": "$__cell dashboard",
          "linkUrl": "/dashboard/db/istio-workload-dashboard?var-namespace=${__cell_3:raw}&var-workload=${__cell_2:raw}",
          "pattern": "destination_workload",
          "preserveFormat": false,
          "sanitize": false,
          "thresholds": [],
          "type": "hidden",
          "unit": "short"
        },
        {
          "alias": "Bytes Sent",
          "align": "auto",
          "colors": [
            "rgba(245, 54, 54, 0.9)",
            "rgba(237, 129, 40, 0.89)",
            "rgba(50, 172, 45, 0.97)"
          ],
          "dateFormat": "YYYY-MM-DD HH:mm:ss",
          "decimals": 2,
          "pattern": "Value #A",
          "thresholds": [
            ""
          ],
          "type": "number",
          "unit": "Bps"
        },
        {
          "alias": "Bytes Received",
          "align": "auto",
          "colors": [
            "rgba(245, 54, 54, 0.9)",
            "rgba(237, 129, 40, 0.89)",
            "rgba(50, 172, 45, 0.97)"
          ],
          "dateFormat": "YYYY-MM-DD HH:mm:ss",
          "decimals": 2,
          "pattern": "Value #B",
          "thresholds": [],
          "type": "number",
          "unit": "Bps"
        },
        {
          "alias": "",
          "align": "auto",
          "colors": [
            "rgba(245, 54, 54, 0.9)",
            "rgba(237, 129, 40, 0.89)",
            "rgba(50, 172, 45, 0.97)"
          ],
          "dateFormat": "YYYY-MM-DD HH:mm:ss",
          "decimals": 2,
          "pattern": "Time",
          "thresholds": [],
          "type": "hidden",
          "unit": "short"
        },
        {
          "alias": "Workload",
          "align": "auto",
          "colors": [
            "rgba(245, 54, 54, 0.9)",
            "rgba(237, 129, 40, 0.89)",
            "rgba(50, 172, 45, 0.97)"
          ],
          "dateFormat": "YYYY-MM-DD HH:mm:ss",
          "decimals": 2,
          "link": true,
          "linkTooltip": "$__cell dashboard",
          "linkUrl": "/dashboard/db/istio-workload-dashboard?var-namespace=${__cell_3:raw}&var-workload=${__cell_2:raw}",
          "pattern": "destination_workload_var",
          "thresholds": [],
          "type": "string",
          "unit": "short"
        },
        {
          "alias": "",
          "align": "auto",
          "colors": [
            "rgba(245, 54, 54, 0.9)",
            "rgba(237, 129, 40, 0.89)",
            "rgba(50, 172, 45, 0.97)"
          ],
          "dateFormat": "YYYY-MM-DD HH:mm:ss",
          "decimals": 2,
          "pattern": "destination_workload_namespace",
          "thresholds": [],
          "type": "hidden",
          "unit": "short"
        },
        {
          "alias": "Service",
          "align": "auto",
          "colors": [
            "rgba(245, 54, 54, 0.9)",
            "rgba(237, 129, 40, 0.89)",
            "rgba(50, 172, 45, 0.97)"
          ],
          "dateFormat": "YYYY-MM-DD HH:mm:ss",
          "decimals": 2,
          "link": true,
          "linkTooltip": "$__cell dashboard",
          "linkUrl": "/dashboard/db/istio-service-dashboard?var-service=${__cell_1:raw}",
          "pattern": "destination_service",
          "thresholds": [],
          "type": "number",
          "unit": "short"
        }
      ],
      "targets": [
        {
          "datasource": {
            "type": "prometheus",
            "uid": "P46855B3906317654"
          },
          "expr": "label_join(sum(rate(istio_tcp_received_bytes_total{reporter=\"source\", cluster_name=~\"$cluster\"}[1m])) by (destination_workload, destination_workload_namespace, destination_service), \"destination_workload_var\", \".\", \"destination_workload\", \"destination_workload_namespace\")",
          "format": "table",
          "hide": false,
          "instant": true,
          "intervalFactor": 1,
          "legendFormat": "{{ destination_workload }}",
          "refId": "A"
        },
        {
          "datasource": {
            "type": "prometheus",
            "uid": "P46855B3906317654"
          },
          "expr": "label_join(sum(rate(istio_tcp_sent_bytes_total{reporter=\"source\", cluster_name=~\"$cluster\"}[1m])) by (destination_workload, destination_workload_namespace, destination_service), \"destination_workload_var\", \".\", \"destination_workload\", \"destination_workload_namespace\")",
          "format": "table",
          "hide": false,
          "instant": true,
          "intervalFactor": 1,
          "legendFormat": "{{ destination_workload }}",
          "refId": "B"
        }
      ],
      "title": "TCP Workloads",
      "transform": "table",
      "type": "table-old"
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
        "h": 9,
        "w": 24,
        "x": 0,
        "y": 51
      },
      "hiddenSeries": false,
      "id": 111,
      "legend": {
        "alignAsTable": false,
        "avg": false,
        "current": false,
        "max": false,
        "min": false,
        "rightSide": false,
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
          "expr": "sum(istio_build{cluster_name=~\"$cluster\"}) by (component, tag)",
          "format": "time_series",
          "intervalFactor": 1,
          "legendFormat": "{{ component }}: {{ tag }}",
          "refId": "A"
        }
      ],
      "thresholds": [],
      "timeRegions": [],
      "title": "Istio Components by Version",
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
    "from": "2022-05-18T14:19:03.860Z",
    "to": "2022-05-18T14:29:03.862Z"
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
  "title": "Istio Mesh Dashboard",
  "uid": "QAVqA2Xnk",
  "version": 3,
  "weekStart": ""
}