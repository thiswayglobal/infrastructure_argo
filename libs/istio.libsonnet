local cm = import '../libs/cert-manager.libsonnet';
local k8s = import '../libs/k8s.libsonnet';

{
  local _ingress = function(domains, healthcheckPort, tls=true, waf_arn=null, wave=null) k8s.alb_ingress(
    'gw-ingress',
    'gw-ingress',
    domains,
    [
      k8s.alb_ingress_rule(d,
                           [k8s.alb_ingress_rule_path('/', 'istio-gateway', if tls then 443 else 80)],
                           filter_x_forwarded_for=true)
      for d in domains
    ],
    is_internal=false,
    external_dns=true,
    namespace='istio-ingress',
    backendHttps=true,
    annotations={
      'alb.ingress.kubernetes.io/healthcheck-protocol': 'HTTP',  //--HTTPS by default
      'alb.ingress.kubernetes.io/healthcheck-port': healthcheckPort,  //--traffic-port by default
      'alb.ingress.kubernetes.io/healthcheck-path': '/healthz/ready',  //--/ by default
      'alb.ingress.kubernetes.io/actions.filter-x-forwarded-for': std.toString(
        {
          type: 'fixed-response',
          fixedResponseConfig: {
            contentType: 'text/plain',
            statusCode: '400',
            messageBody: 'x-forwarded-for not allowed',
          },
        }
      ),
      'alb.ingress.kubernetes.io/conditions.filter-x-forwarded-for': std.toString(
        [
          {
            field: 'http-header',
            httpHeaderConfig: {
              httpHeaderName: 'x-forwarded-for',
              values: ['*'],
            },
          },
        ]
      ),
    },
    waf_arn=waf_arn,
    wave=wave
  ),
  ingress:: _ingress,

  local _gws = function(name, hosts, namespace, wave=null) [
    {
      apiVersion: 'networking.istio.io/v1alpha3',
      kind: 'Gateway',
      metadata: {
        name: name,
        namespace: namespace,
        [if wave != null then 'annotations']: {
          'argocd.argoproj.io/sync-wave': std.toString(wave),
        },
      },
      spec: {
        selector: {
          istio: 'gateway',
        },
        servers: [
          {
            port: {
              number: 443,
              name: 'https',
              protocol: 'HTTPS',
            },
            tls: {
              mode: 'SIMPLE',
              credentialName: namespace + '-ingress-' + name + '-tls',
            },
            hosts: ['*'],
            //hosts: ['test-payload/*'],
          },
        ],
      },
    },

    cm.cert(namespace + '-ingress-' + name + '-tls',
            namespace + '-ingress-' + name + '-tls',
            hosts[0],
            dnsNames=hosts,
            namespace='istio-ingress',
            wave=wave),
  ],
  gws:: _gws,

  local _virtualServiceRule = function(prefixes, host, port, rewritePrefix=null, cors=null) {
    match: [
      {
        uri: {
          prefix: prefix,
        },
      }
      for prefix in prefixes
    ],
    [if rewritePrefix != null then 'rewrite']: {
      uri: rewritePrefix,
    },
    route: [
      {
        destination: {
          host: host,
          port: {
            number: port,
          },
        },
      },
    ],
    [if cors != null then 'corsPolicy']: cors,
  },
  virtualServiceRule:: _virtualServiceRule,

  local _virtualServiceRuleDirectResponse = function(uri, body, headers, cors=null) {
    match: [
      {
        uri: {
          exact: uri,
        },
      },
    ],
    directResponse: {
      status: 200,
      body: {
        string: std.toString(body),
      },
    },
    headers: {
      response: {
        set: headers,
      },
    },
    [if cors != null then 'corsPolicy']: cors,
  },
  virtualServiceRuleDirectResponse:: _virtualServiceRuleDirectResponse,

  local _virtualService = function(name, rules, hosts, namespace=null, wave=null, gateways=['istio-system/main', 'istio-system/http']) {
    apiVersion: 'networking.istio.io/v1alpha3',
    kind: 'VirtualService',
    metadata: {
      name: name,
      [if namespace != null then 'namespace']: namespace,
      [if wave != null then 'annotations']: {
        'argocd.argoproj.io/sync-wave': std.toString(wave),
      },
    },
    spec: {
      hosts: hosts,
      gateways: gateways,
      http: rules,
    },
  },
  virtualService:: _virtualService,

  local _corsPolicy = function(domain) {
    allowOrigins: [
      {
        exact: domain,
      },
    ],
    allowMethods: [
      'GET',
      'POST',
      'PUT',
      'PATCH',
      'DELETE',
      'OPTIONS',
    ],
    allowCredentials: true,
    allowHeaders: [
      '*',
    ],
    maxAge: '24h',
  },
  corsPolicy:: _corsPolicy,

  local _gw = function(name, hosts, namespace, wave=null) {
    apiVersion: 'networking.istio.io/v1alpha3',
    kind: 'Gateway',
    metadata: {
      name: name,
      namespace: namespace,
      [if wave != null then 'annotations']: {
        'argocd.argoproj.io/sync-wave': std.toString(wave),
      },
    },
    spec: {
      selector: {
        istio: 'gateway',
      },
      servers: [
        {
          port: {
            number: 80,
            name: 'http',
            protocol: 'HTTP',
          },
          hosts: hosts,
        },
      ],
    },
  },
  gw:: _gw,

  local _telemetry = function(namespace=null, wave=null) {
    apiVersion: 'telemetry.istio.io/v1alpha1',
    kind: 'Telemetry',
    metadata: {
      name: 'stdout',
      [if namespace != null then 'namespace']: namespace,
      [if wave != null then 'annotations']: {
        'argocd.argoproj.io/sync-wave': std.toString(wave),
      },
    },
    spec: {
      accessLogging: [
        {
          providers: [
            {
              name: 'envoy',
            },
          ],
        },
      ],
    },
  },
  telemetry:: _telemetry,

  local _authPolicyIpFilter = function(name, ips, selector=null, namespace=null, wave=null) {
    apiVersion: 'security.istio.io/v1beta1',
    kind: 'AuthorizationPolicy',
    metadata: {
      name: name,
      [if namespace != null then 'namespace']: namespace,
      [if wave != null then 'annotations']: {
        'argocd.argoproj.io/sync-wave': std.toString(wave),
      },
    },
    spec: {
      [if selector != null then 'selector']: {
        matchLabels: selector,
      },
      action: 'ALLOW',
      rules: [
        {
          from: [
            {
              source: {
                remoteIpBlocks: ips,
              },
            },
          ],
        },
      ],
    },
  },
  authPolicyIpFilter:: _authPolicyIpFilter,

  local _remoteIpFixFilter = function(namespace) {
    apiVersion: 'networking.istio.io/v1alpha3',
    kind: 'EnvoyFilter',
    metadata: {
      name: 'xff-envoyfilter-alb',
      namespace: namespace,
    },
    spec: {
      configPatches: [
        {
          applyTo: 'NETWORK_FILTER',
          match: {
            context: 'SIDECAR_INBOUND',
            listener: {
              filterChain: {
                filter: {
                  name: 'envoy.filters.network.http_connection_manager',
                },
              },
            },
          },
          patch: {
            operation: 'MERGE',
            value: {
              typed_config: {
                '@type': 'type.googleapis.com/envoy.extensions.filters.network.http_connection_manager.v3.HttpConnectionManager',
                xff_num_trusted_hops: 1,
              },
            },
          },
        },
      ],
    },
  },
  remoteIpFixFilter:: _remoteIpFixFilter,
}
