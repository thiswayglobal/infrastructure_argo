local argo = import '../libs/argo.libsonnet';

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

  local _grafana = function(name, namespace=null, wave=null) {
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
      [if std.objectHas(argo.config, 'grafana_irsa_arn') then 'serviceAccount']: {
        annotations: {
          'eks.amazonaws.com/role-arn': argo.config.grafana_irsa_arn,
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
        server: {
          root_url: 'https://' + argo.config.env.grafana.domain,
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
        [if std.objectHas(argo.config.env.grafana, 'github_client_id') then 'auth.github']: {
          enabled: true,
          allow_sign_up: true,
          client_id: argo.config.env.grafana.github_client_id,
          client_secret: argo.config.env.grafana.github_client_secret,
          scopes: 'user:email,read:org',
          auth_url: 'https://github.com/login/oauth/authorize',
          token_url: 'https://github.com/login/oauth/access_token',
          api_url: 'https://api.github.com/user',
          team_ids: argo.config.env.grafana.team_ids,
          allowed_organizations: argo.config.env.grafana.organization,
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
