local argo = import '../libs/argo.libsonnet';

{
  local _provisioner = function(name, taintKey, taintValue) {
    apiVersion: 'karpenter.sh/v1alpha5',
    kind: 'Provisioner',
    metadata: {
      name: name,
    },
    spec: {
      //      taints: [
      //        {
      //          key: taintKey,
      //          value: taintValue,
      //          effect: 'NoSchedule',
      //        },
      //        {
      //          key: taintKey,
      //          value: taintValue,
      //          effect: 'NoExecute',
      //        },
      //      ],
      limits: {
        resources: {
          cpu: '20',
        },
      },
      requirements: [
        {
          key: 'karpenter.sh/capacity-type',
          operator: 'In',
          values: [
            'spot',
            'on-demand',
          ],
        },
        {
          key: 'kubernetes.io/arch',
          operator: 'In',
          values: [
            'amd64',
          ],
        },
      ],
      provider: {
        metadataOptions: {
          httpEndpoint: 'enabled',
          httpProtocolIPv6: 'disabled',
          httpPutResponseHopLimit: 64,
          httpTokens: 'optional',
        },
        subnetSelector: {
          ['kubernetes.io/cluster/' + argo.config.cluster_name]: '*',
          type: 'private',
        },
        securityGroupSelector: {
          ['kubernetes.io/cluster/' + argo.config.cluster_name]: 'node',
        },
      },
      //ttlSecondsAfterEmpty: 30,
      consolidation: {
        enabled: true,
      },
    },
  },
  provisioner:: _provisioner,
}
