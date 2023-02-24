local argo = import '../libs/argo.libsonnet';
local k8s = import '../libs/k8s.libsonnet';

[
  k8s.deployment(
    'hz-management',
    [
      k8s.deployment_container(
        'hazelcast/management-center:4.2020.12',
        'hz-management',
        [k8s.deployment_container_port('http', 8080, 'TCP')],
        k8s.deployment_container_http_probe('http'),
        env=[
          k8s.var('HTTP2_DISABLE', 'true'),
          k8s.var('JAVA_OPTS', 'value: -XX:InitialRAMPercentage=20.0 -XX:MinRAMPercentage=50.0 -XX:MaxRAMPercentage=80.0 -XX:+HeapDumpOnOutOfMemoryError -XX:+ExitOnOutOfMemoryError -Djava.net.preferIPv4Stack=true -Djava.net.preferIPv4Addresses=true -XX:+UnlockExperimentalVMOptions -XX:+UseContainerSupport'),
          k8s.var('HZ_CLUSTERNAME', 'ai4jobs-cluster'),
          k8s.var('HZ_NETWORK_PORT_AUTOINCREMENT', 'true'),
          k8s.var('HZ_NETWORK_PORT_PORTCOUNT', '100'),
          k8s.var('HZ_NETWORK_PORT_PORT', '5701'),
          k8s.var('MC_CONTEXT_PATH', 'hzman'),

        ],
        resources=k8s.deployment_container_resources('100m', '3Gi', '1', '3Gi'),
      ),
    ],
    sa='app',
    wave=20
  ),

  k8s.service(
    'hz-management',
    { app: 'hz-management' },
    [k8s.service_port('http', 80, 'http')],
    wave=20
  ),
]
