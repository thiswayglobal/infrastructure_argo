local argo = import '../libs/argo.libsonnet';

[
  argo.app(
    'demo-app-' + name,
    'demo-app-' + name,
    'demo-app',
    wave=30,
    config={
      app_name_short: name,
    }
  )
  for name in std.objectFields(argo.config.env.demo_app.environments)
]
