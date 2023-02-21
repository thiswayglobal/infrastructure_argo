local argo = import '../libs/argo.libsonnet';
local istio = import '../libs/istio.libsonnet';
local k8s = import '../libs/k8s.libsonnet';
local k = import '../libs/keycloak.libsonnet';
local p = import '../libs/patch.libsonnet';

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

  {
    apiVersion: 'legacy.k8s.keycloak.org/v1alpha1',
    kind: 'ExternalKeycloak',
    metadata: {
      name: 'external-keycloak',
      namespace: 'keycloak-operator',
      labels: {
        app: 'external-sso',
      },
    },
    spec: {
      url: 'https://test1-service:8080',
      contextRoot: '/',
    },
  },

  k8s.secret(
    'credential-external-keycloak',
    stringData={
      ADMIN_USERNAME: '',
      ADMIN_PASSWORD: '',
    },
    namespace='keycloak-operator'
  ),

  //https://github.com/keycloak/keycloak-realm-operator
  p.patch(
    'patch1',
    {
      apiVersion: 'v1',
      kind: 'Secret',
      name: 'credential-external-keycloak',
      namespace: 'keycloak-operator',
    },
    [
      {
        apiVersion: 'v1',
        kind: 'Secret',
        name: 'test1-initial-admin',
        namespace: 'keycloak-operator',
      },
    ],
    {
      data: {
        ADMIN_USERNAME: '{{ (index . 1).data.username }}',
        ADMIN_PASSWORD: '{{ (index . 1).data.password }}',
      },
    }
  ),

  import 'realm.libsonnet',
]
