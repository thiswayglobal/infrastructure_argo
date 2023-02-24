local argo = import '../libs/argo.libsonnet';
local istio = import '../libs/istio.libsonnet';
local k8s = import '../libs/k8s.libsonnet';

[
  k8s.deployment(
    'ai4jobs',
    [
      k8s.deployment_container(
        '957377755024.dkr.ecr.us-east-2.amazonaws.com/thisway:6.0.0.14',
        'ai4jobs',
        [
          k8s.deployment_container_port('hazelcast', 5701, 'TCP'),
          k8s.deployment_container_port('app', 8080, 'TCP'),
          k8s.deployment_container_port('prometheus', 8086, 'TCP'),
        ],
        //startup_probe=k8s.deployment_container_http_probe('prometheus', '/actuator/health/liveness', failureThreshold=10, periodSeconds=20),
        //liveness_probe=k8s.deployment_container_http_probe('prometheus', '/actuator/health/liveness'),
        //readiness_probe=k8s.deployment_container_http_probe('prometheus', '/actuator/health/readiness'),
        env=[
          k8s.var('KUBERNETES_NAMESPACE', argo.config.app_name),
          k8s.var('HAZELCAST_SERVICE', 'ai4jobs'),
          k8s.var('HTTP2_DISABLE', 'true'),
          k8s.var('SPRING_PROFILES_ACTIVE', 'newdev,kubernetes'),
          k8s.var('JAVA_OPTS', '-XX:InitialRAMPercentage=20.0 -XX:MinRAMPercentage=50.0 -XX:MaxRAMPercentage=80.0 -XX:+HeapDumpOnOutOfMemoryError -XX:+ExitOnOutOfMemoryError -Djava.net.preferIPv4Stack=true -Djava.net.preferIPv4Addresses=true -XX:+UnlockExperimentalVMOptions -XX:+UseContainerSupport'),
        ],
        args=['/ai4jobs'],
        /*
        volumeMounts=[
          {
            name: 'config',
            mountPath: '/META_INF/resources/application.yaml',
            subPath: 'config',
          },
        ],
        */
      ),
    ],
    podsAnnotations={
      'prometheus.io/scrape': 'true',
      'prometheus.io/path': '/actuator/prometheus',
      'prometheus.io/port': '8086',
    },
    volumes=[
      {
        name: 'config',
        secret: {
          secretName: 'tf-output',
        },
      },
    ],
    sa='app',
    wave=20
  ),
]
