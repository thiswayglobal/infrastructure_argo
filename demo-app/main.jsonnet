local argo = import '../libs/argo.libsonnet';
local istio = import '../libs/istio.libsonnet';
local k8s = import '../libs/k8s.libsonnet';

local config = argo.config;
[
  k8s.ns(argo.config.app_name, true, wave=10),

  k8s.deployment(
    'demo-app',
    [
      k8s.deployment_container(
        argo.branches[argo.config.env.demo_app.version],
        'demo-app',
        [k8s.deployment_container_port('http', 80, 'TCP')],
        k8s.deployment_container_http_probe('http')
      ),
    ],
    wave=20
  ),

  k8s.service(
    'demo-app',
    { app: 'demo-app' },
    [k8s.service_port('http', 80, 'http')],
    wave=20
  ),

  istio.virtualService(
    'demo-app',
    [istio.virtualServiceRule(['/'], 'demo-app', 80)],
    [argo.config.env.demo_app.domain],
    wave=20
  ),
]
