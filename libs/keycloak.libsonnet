local k8s = import '../libs/k8s.libsonnet';

{
  local _keycloak = function(name, db_obj, wave=null) {
    apiVersion: 'k8s.keycloak.org/v2alpha1',
    kind: 'Keycloak',
    metadata: {
      name: name,
      namespace: 'keycloak-operator',
      [if wave != null then 'annotations']: {
        'argocd.argoproj.io/sync-wave': std.toString(wave),
      },
    },
    spec: {
      instances: 1,
      db: {
        vendor: 'mysql',
        url: 'jdbc:' + db_obj.db_url,
      },
      hostname: {
        strict: false,
      },
      ingress: {
        enabled: false,
      },
      http: {
        httpEnabled: true,
      },
      features: {
        disabled: [
          'step-up-authentication',
        ],
      },
      transaction: {
        xaEnabled: false,
      },
    },
  },
  keycloak:: _keycloak,
}
