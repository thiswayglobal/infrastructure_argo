{
  local _keycloak = function(name, db_obj, namespace=null, wave=null) [
    k8s.secret(
      name + '-db',
      {
        username: db_obj.db_user,
        password: db_obj.db_pass,
      },
      wave=wave,
      namespace=namespace
    ),
    {
      apiVersion: 'k8s.keycloak.org/v2alpha1',
      kind: 'Keycloak',
      metadata: {
        name: name,
        [if namespace != null then 'namespace']: namespace,
        [if wave != null then 'annotations']: {
          'argocd.argoproj.io/sync-wave': std.toString(wave),
        },
      },
      spec: {
        instances: 1,
        db: {
          vendor: 'postgres',
          host: db_obj.db_host,
          usernameSecret: {
            name: name + '-db',
            key: 'username',
          },
          passwordSecret: {
            name: name + '-db',
            key: 'password',
          },
        },
        ingress: {
          enabled: false,
        },
      },
    },
  ],
  keycloak:: _keycloak,
}
