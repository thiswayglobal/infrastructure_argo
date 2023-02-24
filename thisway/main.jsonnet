local argo = import '../libs/argo.libsonnet';
local hashicorp = import '../libs/hashicorp.libsonnet';
local istio = import '../libs/istio.libsonnet';
local k8s = import '../libs/k8s.libsonnet';

[
  k8s.ns(argo.config.app_name, true),

  hashicorp.workspace(
    argo.config.app_name,
    'app_tf',
    region=argo.config.region,
    vars=[
      hashicorp.var('env_name', argo.config.app_name),
      hashicorp.var('irsa_namespace', argo.config.app_name),
      hashicorp.var('irsa_sa', 'app'),
      hashicorp.var('irsa_cluster_name', argo.config.cluster_name),
      hashicorp.var('irsa_oidc_url', argo.config.oidc_url),
      hashicorp.var('irsa_oidc_arn', argo.config.oidc_arn),

      hashicorp.var('mysql_endpoint', argo.config.rds.master.db_host),
      hashicorp.var('mysql_user', argo.config.rds.master.db_user),
      hashicorp.var('mysql_pass', argo.config.rds.master.db_pass),
      hashicorp.var('keycloak_endpoint', 'https://' + argo.config.env.keycloak.domain),
      hashicorp.var('keycloak_user', 'aaa'),
      hashicorp.var('keycloak_pass', 'aaa'),
      hashicorp.var('keycloak_realm', 'aaa'),
      hashicorp.var('keycloak_client_secret', 'aaa'),
    ],
    outputs=[
      hashicorp.output('config'),
    ],
    wave=10,
  ),
]
