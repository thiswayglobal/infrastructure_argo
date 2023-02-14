local argo = import '../libs/argo.libsonnet';

{

  local _toDev = function(value) if argo.config.env_name == 'dev' then [value] else [],
  toDev:: _toDev,

  local _notDev = function(value) if argo.config.env_name != 'dev' then [value] else [],
  notDev:: _notDev,

  local _toPreprod = function(value) if argo.config.env_name == 'preprod' then [value] else [],
  toPreprod:: _toPreprod,

  local _notPreprod = function(value) if argo.config.env_name != 'preprod' then [value] else [],
  notPreprod:: _notPreprod,


  local _toProd = function(value) if argo.config.env_name == 'prod' then [value] else [],
  toProd:: _toProd,
}
