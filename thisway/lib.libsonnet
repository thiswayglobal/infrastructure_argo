local argo = import '../libs/argo.libsonnet';
local istio = import '../libs/istio.libsonnet';
local k8s = import '../libs/k8s.libsonnet';

{
  local _service = function(name, resources, wave, arg=null) [
    k8s.deployment(
      name,
      [
        k8s.deployment_container(
          argo.config.env.thisway.image,
          name,
          [
            k8s.deployment_container_port('hazelcast', 5701, 'TCP'),
            k8s.deployment_container_port('app', 8080, 'TCP'),
            k8s.deployment_container_port('prometheus', 8081, 'TCP'),
          ],
          startup_probe=k8s.deployment_container_http_probe('prometheus', '/actuator/health/liveness', failureThreshold=10, periodSeconds=20),
          liveness_probe=k8s.deployment_container_http_probe('prometheus', '/actuator/health/liveness'),
          readiness_probe=k8s.deployment_container_http_probe('prometheus', '/actuator/health/readiness'),
          env=[
            k8s.var('KUBERNETES_NAMESPACE', argo.config.app_name),
            k8s.var('HAZELCAST_SERVICE', 'ai4jobs'),
            k8s.var('HTTP2_DISABLE', 'true'),
            k8s.var('SPRING_PROFILES_ACTIVE', 'newdev,kubernetes'),
            k8s.var('JAVA_OPTS', '-Ddebug -XX:InitialRAMPercentage=20.0 -XX:MinRAMPercentage=50.0 -XX:MaxRAMPercentage=80.0 -XX:+HeapDumpOnOutOfMemoryError -XX:+ExitOnOutOfMemoryError -Djava.net.preferIPv4Stack=true -Djava.net.preferIPv4Addresses=true -XX:+UnlockExperimentalVMOptions -XX:+UseContainerSupport'),
          ],
          args=['/' + name],

          volumeMounts=[
            {
              name: 'config',
              mountPath: '/META_INF/resources/application.yaml',
              subPath: 'config',
            },
          ],

          resources=resources,
        ),
      ],
      podsAnnotations={
        'prometheus.io/scrape': 'true',
        'prometheus.io/path': '/actuator/prometheus',
        'prometheus.io/port': '8081',
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
      wave=wave
    ),

    k8s.service(
      name,
      { app: name },
      [
        k8s.service_port('app', 80, 'app'),
        k8s.service_port('hazelcast', 5701, 'hazelcast'),
        k8s.service_port('prometheus', 8081, 'prometheus'),
      ],
      wave=20
    ),

  ],
  service:: _service,
}
