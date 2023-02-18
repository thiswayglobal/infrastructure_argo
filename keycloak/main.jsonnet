local argo = import '../libs/argo.libsonnet';
local istio = import '../libs/istio.libsonnet';
local k8s = import '../libs/k8s.libsonnet';
local k = import '../libs/keycloak.libsonnet';


k.keycloak('test1', argo.config.rds.keycloak)
