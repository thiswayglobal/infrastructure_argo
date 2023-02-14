{
  local _imagePullSecret = function(name, secretName, targetNamespace, targetName='aws-ecr', wave=null) {
    apiVersion: 'images.banzaicloud.io/v1alpha1',
    kind: 'ImagePullSecret',
    metadata: {
      name: name,
      annotations: {
        [if wave != null then 'argocd.argoproj.io/sync-wave']: std.toString(wave),
        'argocd.argoproj.io/sync-options': 'SkipDryRunOnMissingResource=true',
      },
    },
    spec: {
      registry: {
        credentials: [
          {
            name: secretName,
            namespace: 'kube-system',
          },
        ],
      },
      target: {
        namespaces: {
          names: [targetNamespace],
        },
        secret: {
          name: targetName,
        },
      },
    },
  },
  imagePullSecret:: _imagePullSecret,
}
