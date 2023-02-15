local argo = import '../libs/argo.libsonnet';
local k8s = import '../libs/k8s.libsonnet';

{
  local _tf_cloud_secret = function(token, wave=null) k8s.secret(
    'terraformrc',
    stringData={
      credentials: 'credentials app.terraform.io {\n  token = "' + token + '"\n}',
    },
    wave=wave,
    namespace='terraform'
  ),
  tf_cloud_secret:: _tf_cloud_secret,

  local _aws_secret = function(keyId, secret, wave=null) k8s.secret(
    'workspacesecrets',
    stringData={
      AWS_ACCESS_KEY_ID: keyId,
      AWS_SECRET_ACCESS_KEY: secret,
    },
    wave=wave,
    namespace='terraform'
  ),
  aws_secret:: _aws_secret,

  local _output = function(name, moduleOutput=null) {
    key: name,
    moduleOutputName: if moduleOutput != null then moduleOutput else name,
  },
  output:: _output,

  local _var = function(name, value, sensitive=false, environmentVariable=false) {
    key: name,
    value: value,
    sensitive: sensitive,
    environmentVariable: environmentVariable,
  },
  var:: _var,

  local _varSecret = function(name, secretName, secretKey, sensitive=true, environmentVariable=false) {
    key: name,
    valueFrom: {
      secretKeyRef: {
        name: secretName,
        key: secretKey,
        optional: false,
      },
    },
    sensitive: sensitive,
    environmentVariable: environmentVariable,
  },
  varSecret:: _varSecret,

  local _workspace = function(name, source, vars=[], region='us-east-1', outputs=[], sshKeyID='tf_modules', wave=null) {
    apiVersion: 'app.terraform.io/v1alpha1',
    kind: 'Workspace',
    metadata: {
      name: argo.config.env_name + '-' + name,
      namespace: 'terraform',
      [if wave != null then 'annotations']: {
        'argocd.argoproj.io/sync-wave': std.toString(wave),
      },
    },
    spec: {
      sshKeyID: sshKeyID,
      organization: argo.config.env.terraform.organization,
      secretsMountPath: '/tmp/secrets',
      omitNamespacePrefix: true,
      module: {
        source: 'github.com:' + source,
      },
      outputs: outputs,
      variables: vars + [
        {
          key: 'AWS_DEFAULT_REGION',
          value: region,
          sensitive: false,
          environmentVariable: true,
        },
        {
          key: 'AWS_ACCESS_KEY_ID',
          sensitive: true,
          environmentVariable: true,
        },
        {
          key: 'AWS_SECRET_ACCESS_KEY',
          sensitive: true,
          environmentVariable: true,
        },
        {
          key: 'CONFIRM_DESTROY',
          value: '1',
          sensitive: false,
          environmentVariable: true,
        },
      ],
      vcs: {
        token_id: argo.config.env.terraform.token_id,
        repo_identifier: argo.config.env.terraform.organization + '/' + source,
        ingress_submodules: false,
        branch: 'main',
      },
    },
  },
  workspace:: _workspace,
}
