{
  local _dataSource = function(name, url, region, namespace=null, wave=null) {
    apiVersion: 'integreatly.org/v1alpha1',
    kind: 'GrafanaDataSource',
    metadata: {
      name: name,
      [if namespace != null then 'namespace']: namespace,
      [if wave != null then 'annotations']: {
        'argocd.argoproj.io/sync-wave': std.toString(wave),
      },
    },
    spec: {
      name: name + '.yaml',
      datasources: [
        {
          name: name,
          type: 'prometheus',
          access: 'server',
          url: url,
          isDefault: true,
          version: 1,
          editable: true,
          jsonData: {
            tlsSkipVerify: true,
            timeInterval: '5s',
            sigV4Auth: true,
            sigV4Region: region,
            sigV4AuthType: 'default',
          },
        },
      ],
    },
  },
  dataSource:: _dataSource,

  local _grafana = function(name, irsa_arn=null, namespace=null, wave=null) {
    apiVersion: 'integreatly.org/v1alpha1',
    kind: 'Grafana',
    metadata: {
      name: name,
      [if namespace != null then 'namespace']: namespace,
      [if wave != null then 'annotations']: {
        'argocd.argoproj.io/sync-wave': std.toString(wave),
      },
    },
    spec: {
      [if irsa_arn != null then 'serviceAccount']: {
        annotations: {
          'eks.amazonaws.com/role-arn': irsa_arn,
        },
      },
      client: {
        preferService: true,
      },
      ingress: {
        enabled: false,
        pathType: 'Prefix',
        path: '/',
      },
      config: {
        log: {
          mode: 'console',
          level: 'error',
        },
        'log.frontend': {
          enabled: true,
        },
        auth: {
          sigv4_auth_enabled: true,
        },
        'auth.anonymous': {
          enabled: false,
        },
      },
      service: {
        name: name,
        type: 'ClusterIP',
      },
      dashboardLabelSelector: [
        {
          matchExpressions: [
            {
              key: 'app',
              operator: 'In',
              values: [
                'grafana',
              ],
            },
          ],
        },
      ],
      resources: {
        limits: {
          cpu: '200m',
          memory: '512Mi',
        },
        requests: {
          cpu: '30m',
          memory: '128Mi',
        },
      },
    },
  },
  grafana:: _grafana,

  local _dashboard = function(name, json, namespace=null, wave=null) {
    apiVersion: 'integreatly.org/v1alpha1',
    kind: 'GrafanaDashboard',
    metadata: {
      name: name,
      labels: {
        app: 'grafana',
      },
      [if namespace != null then 'namespace']: namespace,
      [if wave != null then 'annotations']: {
        'argocd.argoproj.io/sync-wave': std.toString(wave),
      },
    },
    spec: {
      json: json,
    },
  },
  dashboard:: _dashboard,
}
