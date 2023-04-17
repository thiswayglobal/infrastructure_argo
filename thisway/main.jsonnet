local argo = import '../libs/argo.libsonnet';
local hashicorp = import '../libs/hashicorp.libsonnet';
local istio = import '../libs/istio.libsonnet';
local k8s = import '../libs/k8s.libsonnet';
local k = import '../libs/keycloak.libsonnet';
local p = import '../libs/patch.libsonnet';
local l = import 'lib.libsonnet';

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
      hashicorp.var('keycloak_endpoint_external', 'https://' + argo.config.env.keycloak.domain),
      hashicorp.var('keycloak_endpoint_internal', 'http://test1-service.keycloak-operator.svc:8080'),
      hashicorp.var('app_endpoint', 'https://' + argo.config.env.thisway.domain),

      hashicorp.var('mysql57_endpoint', argo.config.rds57.master.db_host),
      hashicorp.var('mysql57_user', argo.config.rds57.master.db_user),
      hashicorp.var('mysql57_pass', argo.config.rds57.master.db_pass),

      hashicorp.varSecret('keycloak_user', 'keycloak-admin', 'username'),
      hashicorp.varSecret('keycloak_pass', 'keycloak-admin', 'password'),

      hashicorp.var('open_search_endpoint_discover', argo.config.open_search_endpoint_discover),
      hashicorp.var('open_search_endpoint_reveal', argo.config.open_search_endpoint_reveal),
    ],
    outputs=[
      hashicorp.output('s3_arns'),
      hashicorp.output('s3_names'),
      hashicorp.output('sqs_arns'),
      hashicorp.output('sqs_names'),
      hashicorp.output('keycloak_realm'),
      hashicorp.output('keycloak_user'),
      hashicorp.output('keycloak_user_pass'),
      hashicorp.output('keycloak_client'),
      hashicorp.output('sqs_names'),
    ],
    wave=10,
  ),

  k8s.role(
    'namespace-reader',
    [
      {
        apiGroups: [
          '',
        ],
        resources: [
          'configmaps',
          'pods',
          'nodes',
          'services',
          'endpoints',
          'secrets',
        ],
        verbs: [
          'get',
          'list',
          'watch',
        ],
      },
    ],
    wave=10
  ),
  k8s.cluster_role(
    'hazelcast-' + argo.config.app_name,
    [
      {
        apiGroups: [
          '',
          'apps',
        ],
        resources: [
          'endpoints',
          'pods',
          'nodes',
          'services',
          'statefulsets',
        ],
        verbs: [
          'get',
          'list',
          'watch',
        ],
      },
      {
        apiGroups: [
          'discovery.k8s.io',
        ],
        resources: [
          'endpointslices',
        ],
        verbs: [
          'get',
          'list',
        ],
      },
    ],
    wave=10
  ),
  k8s.roleBinding('namespace-reader', 'namespace-reader', 'app', wave=20),
  k8s.clusterRoleBinding('hazelcast-' + argo.config.app_name, 'hazelcast-' + argo.config.app_name, 'app', argo.config.app_name, wave=20),

  k8s.service(
    'hazelcast',
    { hazelcast: 'cluster' },
    [
      k8s.service_port('hazelcast', 5701, 'tcp-hazelcast', appProtocol='tcp'),
    ],
    clusterIp='None',
    labels={
      hzcluster: 'ai4jobs',
    },
  ),

  istio.virtualService(
    'vs',
    [
      istio.virtualServiceRule(['/api/v3/partner/'], 'ai4jobs', 80, rewritePrefix='/ai4jobs/api/v3/partner/'),
      istio.virtualServiceRule(['/api/v2/partner/'], 'ai4jobs', 80, rewritePrefix='/ai4jobs/api/v2/partner/'),
      istio.virtualServiceRule(['/discover'], 'discover', 80),
      istio.virtualServiceRule(['/score'], 'score', 80),
      istio.virtualServiceRule(['/reveal'], 'reveal', 80),
      istio.virtualServiceRule(['/twg'], 'thisway', 80),
      istio.virtualServiceRule(['/attract'], 'attract', 80),
      istio.virtualServiceRule(['/ai4jobs'], 'ai4jobs', 80),
      istio.virtualServiceRule(['/ghio'], 'ghio', 80),
      istio.virtualServiceRule(['/discover'], 'discover', 80),
      istio.virtualServiceRule(['/discover'], 'discover', 80),
      istio.virtualServiceRule(['/discover'], 'discover', 80),
      istio.virtualServiceRule(['/discover'], 'discover', 80),
    ],
    [argo.config.env.thisway.domain],
    wave=20
  ),

  istio.virtualService(
    'keycloak',
    [
      istio.virtualServiceRule(['/oauth/token'], 'test1-service', 8080, rewritePrefix='/realms/' + argo.config.app_name + '/protocol/openid-connect/token'),
    ],
    [argo.config.env.thisway.domain],
    namespace='keycloak-operator',
    wave=20
  ),
  istio.telemetry(wave=30),
]
+
l.service('thisway', k8s.deployment_container_resources('500m', '1Gi', '1', '2Gi'), 20) +
l.service('ai4jobs', k8s.deployment_container_resources('500m', '1Gi', '1', '3Gi'), 20) +
l.service('attract', k8s.deployment_container_resources('500m', '1Gi', '1', '2Gi'), 20) +
l.service('back-office', k8s.deployment_container_resources('500m', '1Gi', '1', '3Gi'), 20) +
l.service('data-export', k8s.deployment_container_resources('500m', '1Gi', '1', '2Gi'), 20) +
l.service('discover', k8s.deployment_container_resources('500m', '1Gi', '1', '3Gi'), 20) +
l.service('discsearch', k8s.deployment_container_resources('500m', '1Gi', '1', '2Gi'), 20, arg='search') +
l.service('ghio', k8s.deployment_container_resources('500m', '1Gi', '1', '2Gi'), 20) +
l.service('ingest-individual', k8s.deployment_container_resources('500m', '1Gi', '1', '4Gi'), 20) +
l.service('ingest-job', k8s.deployment_container_resources('500m', '1Gi', '1', '2Gi'), 20) +
l.service('revsearch', k8s.deployment_container_resources('500m', '1Gi', '1', '3Gi'), 20, arg='search') +
l.service('revealsvc', k8s.deployment_container_resources('500m', '1Gi', '1', '2Gi'), 20) +
l.service('score', k8s.deployment_container_resources('500m', '1Gi', '1', '3Gi'), 20) +
l.service('public', k8s.deployment_container_resources('500m', '1Gi', '1', '3Gi'), 20) +
l.service('reveal', k8s.deployment_container_resources('500m', '1Gi', '1', '3Gi'), 20)
