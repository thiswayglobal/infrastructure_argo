local k8s = import '../libs/k8s.libsonnet';

{
  local _keycloak = function(name, db_obj, wave=null) [
    k8s.secret(
      name + '-db',
      {
        username: db_obj.db_user,
        password: db_obj.db_pass,
      },
      wave=wave,
      namespace='keycloak-operator'
    ),
    {
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
          vendor: 'postgres',
          //host: db_obj.db_host,
          //database: db_obj.db_name,
          //port: 5432,
          //schema: 'public',
          //poolInitialSize: 1,
          //poolMinSize: 1,
          //poolMaxSize: 100,
          url: 'jdbc:postgresql://' + db_obj.db_host,
          'url-database': db_obj.db_name,
          usernameSecret: {
            name: name + '-db',
            key: 'username',
          },
          passwordSecret: {
            name: name + '-db',
            key: 'password',
          },
        },
        hostname: {
          strict: false,
        },
        ingress: {
          enabled: false,
        },
        /*
        features: {
          disabled: [
            'step-up-authentication',
          ],
        },
        */
        transaction: {
          xaEnabled: false,
        },
      },
    },
  ],
  keycloak:: _keycloak,
}
