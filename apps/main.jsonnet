local argo = import '../libs/argo.libsonnet';
local cm = import '../libs/cert-manager.libsonnet';
local istio = import '../libs/istio.libsonnet';
local k8s = import '../libs/k8s.libsonnet';
local prom = import '../libs/prometheus.libsonnet';
local cm = import '../libs/cert-manager.libsonnet';
local k = import '../libs/karpenter.libsonnet';
local hashicorp = import '../libs/hashicorp.libsonnet';


local e = import '../libs/env.libsonnet';


e.notDev(secrets.getSealedSecret('ecr', wave=21)) +
[
  argo.app(
    'misc',
    'misc',
    'misc',
    wave=20,
    skipDryRun=true
  ),

  k8s.ns('istio-ingress', istio=true, wave=30),

  argo.app_helm(
    'istio-base',
    'istio-system',
    'https://istio-release.storage.googleapis.com/charts',
    'base',
    '1.16.2',
    ignoreDifferences=[
      {
        group: 'admissionregistration.k8s.io',
        kind: 'ValidatingWebhookConfiguration',
        name: 'istiod-default-validator',
        jqPathExpressions: [
          '.webhooks[0].failurePolicy',
        ],
      },
    ],
    selfHeal=false,
    wave=20
  ),
  argo.app_helm(
    'istio-istiod',
    'istio-system',
    'https://istio-release.storage.googleapis.com/charts',
    'istiod',
    '1.16.2',
    helm_params=[
      //argo.var('meshConfig.h2UpgradePolicy', 'UPGRADE'),
      argo.var('pilot.resources.requests.cpu', '30m'),
      argo.var('pilot.resources.requests.memory', '128Mi'),
      argo.var('global.tracer.zipkin.address', 'zipkin.istio-system.svc:9411'),
      argo.var('pilot.traceSampling', '100'),
      argo.var('meshConfig.enableTracing', 'true'),
      argo.var('meshConfig.defaultConfig.tracing.sampling', '100'),
      //argo.var('sidecarInjectorWebhook.rewriteAppHTTPProbe', 'false'),
      argo.var('global.proxy.resources.requests.cpu', '10m'),
      argo.var('global.proxy.resources.requests.memory', '128Mi'),
      argo.var('global.proxy.resources.limits.cpu', '30m'),
      argo.var('global.proxy.resources.limits.memory', '128Mi'),
      argo.var('global.proxy.holdApplicationUntilProxyStarts', 'true'),

      argo.var('meshConfig.defaultConfig.gatewayTopology.numTrustedProxies', '1'),
    ],
    selfHeal=false,
    wave=20,
    ignoreDifferences=[
      {
        group: 'admissionregistration.k8s.io',
        kind: 'MutatingWebhookConfiguration',
        name: 'istio-sidecar-injector',
        jqPathExpressions: [
          '.webhooks[0].clientConfig.caBundle',
          '.webhooks[1].clientConfig.caBundle',
          '.webhooks[2].clientConfig.caBundle',
          '.webhooks[3].clientConfig.caBundle',
          '.webhooks[4].clientConfig.caBundle',
          '.webhooks[5].clientConfig.caBundle',
          '.webhooks[6].clientConfig.caBundle',
          '.webhooks[7].clientConfig.caBundle',
          '.webhooks[8].clientConfig.caBundle',
          '.webhooks[9].clientConfig.caBundle',
        ],
      },
    ],
  ),
  argo.app_helm(
    'istio-gateway',
    'istio-ingress',
    'https://istio-release.storage.googleapis.com/charts',
    'gateway',
    //'1.13.3',
    '1.16.2',
    createNamespace=false,
    selfHeal=false,
    helm_params=[
      argo.var('service.type', 'NodePort'),
      argo.var('service.ports[0].nodePort', '32766'),
      argo.var('service.ports[0].port', '15021'),
      argo.var('service.ports[0].name', 'status-port'),
      argo.var('service.ports[0].protocol', 'TCP'),
      argo.var('service.ports[0].targetPort', '15021'),
      argo.var('service.ports[1].name', 'http2'),
      argo.var('service.ports[1].port', '80'),
      argo.var('service.ports[1].protocol', 'TCP'),
      argo.var('service.ports[1].targetPort', '80'),
      argo.var('service.ports[2].name', 'https'),
      argo.var('service.ports[2].port', '443'),
      argo.var('service.ports[2].protocol', 'TCP'),
      argo.var('service.ports[2].targetPort', '443'),
      argo.var('service.externalTrafficPolicy', 'Local'),

      argo.var('resources.requests.cpu', '30m'),
      argo.var('resources.requests.memory', '128Mi'),
      argo.var('kind', 'DaemonSet'),
    ],
    wave=30,
    replace=true,
  ),

  argo.app_helm(
    'cert-manager',
    'cert-manager',
    'https://charts.jetstack.io',
    'cert-manager',
    '1.8.0',
    helm_params=[
      argo.var('installCRDs', 'true'),
    ],
    wave=10
  ),


  argo.app('test-payload', 'test-payload', 'test-payload', wave=30),

  argo.app_helm(
    'metrics-server',
    'kube-system',
    'https://kubernetes-sigs.github.io/metrics-server/',
    'metrics-server',
    '3.8.2',
    helm_params=[
      argo.var('replicas', '1'),
      argo.var('metrics.enabled', 'true'),
      argo.var('serviceMonitor.enabled', 'false'),
    ],
    wave=10
  ),


  k.provisioner('default', 'payload', 'true'),


  argo.app_helm(
    'secret-generator',
    'secret-generator',
    'https://helm.mittwald.de',
    'kubernetes-secret-generator',
    '3.4.0',
    wave=20
  ),

  argo.app_helm(
    'imagepullsecrets',
    'kube-system',
    'https://kubernetes-charts.banzaicloud.com',
    'imagepullsecrets',
    '0.3.7',
    wave=20
  ),

  argo.app_helm(
    'patch-operator',
    'patch-operator',
    'https://redhat-cop.github.io/patch-operator',
    'patch-operator',
    '0.1.9',
    wave=20,
    helm_params=[
      argo.var('enableCertManager', 'true'),
    ]
  ),

  argo.app_helm(
    'reloader',
    'reloader',
    'https://stakater.github.io/stakater-charts',
    'reloader',
    '0.0.126',
    wave=20
  ),


]
