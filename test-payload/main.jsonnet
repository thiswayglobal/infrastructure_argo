local argo = import '../libs/argo.libsonnet';
local istio = import '../libs/istio.libsonnet';
local k8s = import '../libs/k8s.libsonnet';

local config = argo.config;
[
  k8s.ns('test-payload', true, wave=10),

  k8s.deployment(
    'echoserver', [
      k8s.deployment_container(
        'ealen/echo-server:latest',
        'echoserver',
        [k8s.deployment_container_port('http', 80, 'TCP')],
        k8s.deployment_container_http_probe('http')
      ),
    ], namespace='test-payload', wave=20
  ),

  k8s.service(
    'echoserver',
    { app: 'echoserver' },
    [k8s.service_port('http', 80, 'http')],
    namespace='test-payload',
    wave=20
  ),

  istio.virtualService(
    'echoserver',
    [istio.virtualServiceRule(['/'], 'echoserver', 80)],
    [argo.config.env.test_payload.domain],
    namespace='test-payload',
    wave=20
  ),
]
