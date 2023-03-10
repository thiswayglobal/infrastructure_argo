{
  local _patch = function(name, target, sources, patch, wave=null, patchType='application/strategic-merge-patch+json') {
    apiVersion: 'redhatcop.redhat.io/v1alpha1',
    kind: 'Patch',
    metadata: {
      name: name,
      namespace: 'patch-operator',
      [if wave != null then 'annotations']: {
        'argocd.argoproj.io/sync-wave': std.toString(wave),
      },
    },
    spec: {
      serviceAccountRef: {
        name: 'patch',
      },
      patches: {
        patch1: {
          targetObjectRef: target,
          patchTemplate: std.strReplace(std.strReplace(std.strReplace(std.manifestYamlDoc(patch, quote_keys=false), '"{{', '{{'), '}}"', '}}'), '\\"%s\\"', '"%s"'),
          patchType: patchType,
          sourceObjectRefs: sources,
        },
      },
    },
  },

  patch:: _patch,
}
