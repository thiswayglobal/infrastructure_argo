local argo = import '../libs/argo.libsonnet';
local cm = import '../libs/cert-manager.libsonnet';
local istio = import '../libs/istio.libsonnet';
local k8s = import '../libs/k8s.libsonnet';
local prom = import '../libs/prometheus.libsonnet';

local all_domains = argo.config.env.domains;

[
  cm.selfSignedClusterIssuer(wave=20),

  istio.ingress(all_domains, '32766', waf_arn=argo.config.waf_arn, wave=10),
  istio.gw('http', all_domains, 'istio-system', wave=30),
  istio.remoteIpFixFilter('istio-system'),
]
+ istio.gws('main', all_domains, 'istio-system', wave=30)
