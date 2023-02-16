local argo = import '../libs/argo.libsonnet';
local hashicorp = import '../libs/hashicorp.libsonnet';
local istio = import '../libs/istio.libsonnet';
local k8s = import '../libs/k8s.libsonnet';

local config = argo.config;
[
  k8s.ns(argo.config.app_name, true, wave=10),

  hashicorp.workspace(
    'demo-app-' + argo.config.app_name_short,
    'demo-app-tf',
    region=argo.config.region,
    vars=[
      hashicorp.var('env_name', argo.config.env_name),
      hashicorp.var('irsa_namespace', argo.config.app_name),
      hashicorp.var('irsa_sa', 'demo-app'),
      hashicorp.var('irsa_cluster_name', argo.config.cluster_name),
      hashicorp.var('irsa_oidc_url', argo.config.oidc_url),
      hashicorp.var('irsa_oidc_arn', argo.config.oidc_arn),
    ],
    outputs=[
      hashicorp.output('irsa_arn'),
      hashicorp.output('sns_test'),
    ],
    wave=10,
  ),

  k8s.deployment(
    'demo-app',
    [
      k8s.deployment_container(
        argo.branches.demo_app[argo.config.env.demo_app.environments[argo.config.app_name_short].version],
        'demo-app',
        [k8s.deployment_container_port('http', 80, 'TCP')],
        k8s.deployment_container_http_probe('http'),
        env=[
          k8s.secretVar('SNS_TEST', argo.config.env_name + '-tf-output', 'sns_test'),
        ],
      ),
    ],
    sa='demo-app',
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
    [argo.config.app_name + '.dev-ai4jobs.com'],
    wave=20
  ),
]
