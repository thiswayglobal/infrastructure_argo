local argo = import '../libs/argo.libsonnet';
local istio = import '../libs/istio.libsonnet';
local k8s = import '../libs/k8s.libsonnet';
local k = import '../libs/keycloak.libsonnet';

[
  k8s.ns('keycloak-operator', true, wave=10),
  k.keycloak('test1', argo.config.rds.keycloak, wave=11),

  istio.virtualService(
    'test1',
    [istio.virtualServiceRule(['/'], 'test1-service', 8080)],
    [argo.config.env.keycloak.domain],
    namespace='keycloak-operator',
    wave=20
  ),
]
