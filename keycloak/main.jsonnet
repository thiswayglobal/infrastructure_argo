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

  k8s.sa('patch'),
  k8s.role('patch', [
    {
      apiGroups: ['*'],
      resources: ['*'],
      verbs: ['*'],
    },
  ]),
  k8s.roleBinding('patch', 'patch', 'patch'),

  {
    apiVersion: 'redhatcop.redhat.io/v1alpha1',
    kind: 'Patch',
    metadata: {
      name: 'patch1',
      namespace: 'keycloak-operator',
    },
    spec: {
      serviceAccountRef: {
        name: 'patch',
      },
      patches: {
        patch1: {
          targetObjectRef: {
            apiVersion: 'v1',
            kind: 'Secret',
            name: 'credential-external-keycloak',
            namespace: 'keycloak-operator',
          },
          patchTemplate: std.manifestYamlDoc(
            {
              data: {
                ADMIN_USERNAME: '"{{ (index . 1).data.username }}"',
              },
            },
          ),
          patchType: 'application/json-patch+json',
          sourceObjectRefs: [
            {
              apiVersion: 'v1',
              kind: 'Secret',
              name: 'test1-initial-admin',
              namespace: 'keycloak-operator',
            },
          ],
        },
      },
    },
  },
]
