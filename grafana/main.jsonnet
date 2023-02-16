local g = import '../libs/grafana.libsonnet';
local istio = import '../libs/istio.libsonnet';
local k8s = import '../libs/k8s.libsonnet';

local amp_url = std.extVar('amp_url');
local region = std.extVar('region');
local domain = std.extVar('grafana_domain');
local grafana_irsa_arn = std.extVar('grafana_irsa_arn');

[
  k8s.ns('grafana', true, wave=10),
  istio.virtualService(
    'grafana',
    [istio.virtualServiceRule(['/'], 'grafana', 3000)],
    [domain],
    wave=20
  ),

  g.grafana('grafana', irsa_arn=grafana_irsa_arn, wave=20),
  g.dataSource('amp', amp_url, region, wave=20),

  g.dashboard('istio-control-plane', importstr 'dashboards/istio_control_plane.libsonnet', wave=20),
  g.dashboard('istio-mesh', importstr 'dashboards/istio_mesh.libsonnet', wave=20),
  g.dashboard('istio-service', importstr 'dashboards/istio-service.libsonnet', wave=20),
  g.dashboard('istio-workload', importstr 'dashboards/istio-workload.libsonnet', wave=20),
  g.dashboard('k8s-pods-resources', importstr 'dashboards/k8s-pods-resources.libsonnet', wave=20),
  g.dashboard('k8s', importstr 'dashboards/k8s.libsonnet', wave=20),
]
