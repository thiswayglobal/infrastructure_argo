local argo = import '../libs/argo.libsonnet';
local g = import '../libs/grafana.libsonnet';
local istio = import '../libs/istio.libsonnet';
local k8s = import '../libs/k8s.libsonnet';

[
  k8s.ns('grafana', true, wave=10),
  istio.virtualService(
    'grafana',
    [istio.virtualServiceRule(['/'], 'grafana', 3000)],
    [argo.config.env.grafana.domain],
    wave=20
  ),

  g.grafana('grafana', wave=20),
  g.dataSource('amp', argo.config.amp_url, argo.config.region, wave=20),

  g.dashboard('istio-control-plane', importstr 'dashboards/istio_control_plane.libsonnet', wave=20),
  g.dashboard('istio-mesh', importstr 'dashboards/istio_mesh.libsonnet', wave=20),
  g.dashboard('istio-service', importstr 'dashboards/istio-service.libsonnet', wave=20),
  g.dashboard('istio-workload', importstr 'dashboards/istio-workload.libsonnet', wave=20),
  g.dashboard('k8s-pods-resources', importstr 'dashboards/k8s-pods-resources.libsonnet', wave=20),
  g.dashboard('k8s', importstr 'dashboards/k8s.libsonnet', wave=20),
]
