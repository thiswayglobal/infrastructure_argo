local argo = import '../libs/argo.libsonnet';
local cm = import '../libs/cert-manager.libsonnet';
local istio = import '../libs/istio.libsonnet';
local k8s = import '../libs/k8s.libsonnet';
local prom = import '../libs/prometheus.libsonnet';

local all_domains = argo.config.env.domains + ['grafana.' + argo.config.domain];
local demo_app = [
  'demo-app-' + name + '.dev-ai4jobs.com'
  for name in std.objectFields(argo.config.env.demo_app.environments)
];
[
  cm.selfSignedClusterIssuer(wave=20),

  istio.ingress(all_domains, '32766', wave=10),
  istio.gw('http', all_domains, 'istio-system', wave=30),
  istio.remoteIpFixFilter('istio-system'),
]
+ istio.gws('main', all_domains + demo_app, 'istio-system', wave=30)
