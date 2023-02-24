{
  local _user = function(name, arn, group) {
    apiVersion: 'iamauthenticator.k8s.aws/v1alpha1',
    kind: 'IAMIdentityMapping',
    metadata: {
      name: 'secrets-operator-role',
    },
    spec: {
      arn: arn,
      groups: [
        group,
      ],
      username: name,
    },
  },
  user:: _user,
}
