{
  apiVersion: 'legacy.k8s.keycloak.org/v1alpha1',
  kind: 'KeycloakClient',
  metadata: {
    name: 'thiswayglobal-ai4jobs',
    namespace: 'keycloak-operator',
  },
  spec: {
    realmSelector: {
      matchLabels: {
        app: 'thiswayglobal',
      },
    },
    roles: [],
    client: {
      clientId: 'thiswayglobal-ai4jobs',

      adminUrl: 'https://dev-api.ai4jobs.info/*',
      attributes: {
        'saml.assertion.signature': 'false',
        'saml.force.post.binding': 'false',
        'saml.multivalued.roles': 'false',
        'saml.encrypt': 'false',
        'backchannel.logout.revoke.offline.tokens': 'false',
        'saml.server.signature': 'false',
        'saml.server.signature.keyinfo.ext': 'false',
        'exclude.session.state.from.auth.response': 'false',
        'backchannel.logout.session.required': 'false',
        'client_credentials.use_refresh_token': 'false',
        saml_force_name_id_format: 'false',
        'saml.client.signature': 'false',
        'tls.client.certificate.bound.access.tokens': 'false',
        'saml.authnstatement': 'false',
        'display.on.consent.screen': 'false',
        'saml.onetimeuse.condition': 'false',
      },
      authenticationFlowBindingOverrides: {},
      //authorizationServicesEnabled
      //authorizationSettings
      //baseUrl
      bearerOnly: false,
      clientAuthenticatorType: 'client-secret',
      consentRequired: false,
      defaultClientScopes: [
        'web-origins',
        'read',
        'role_list',
        'profile',
        'roles',
        'write',
        'email',
      ],
      //defaultRoles
      //description
      directAccessGrantsEnabled: true,
      enabled: true,
      frontchannelLogout: false,
      fullScopeAllowed: true,
      implicitFlowEnabled: false,
      nodeReRegistrationTimeout: -1,
      notBefore: 0,
      optionalClientScopes: [
        'address',
        'phone',
        'offline_access',
        'microprofile-jwt',
      ],
      protocol: 'openid-connect',
      protocolMappers: [
        {
          //id: '705e30c7-f94d-43e7-ad34-817d9830c6fe',
          name: 'rvl_client_key',
          protocol: 'openid-connect',
          protocolMapper: 'oidc-usermodel-attribute-mapper',
          consentRequired: false,
          config: {
            'userinfo.token.claim': 'true',
            'user.attribute': 'rvl_client_key',
            'id.token.claim': 'true',
            'access.token.claim': 'true',
            'claim.name': 'rvl_client_key',
            'jsonType.label': 'String',
          },
        },
      ],
      publicClient: true,
      redirectUris: [
        'https://dev-api.ai4jobs.info/*',
        'https://thisway--installdev.lightning.force.com/apex/TWG__AdminTabAuthenticate',
        'http://dev-api.ai4jobs.info/*',
      ],
      rootUrl: 'https://dev-api.ai4jobs.info/*',
      secret: 'ai4jobs',
      serviceAccountsEnabled: false,
      standardFlowEnabled: true,
      surrogateAuthRequired: false,
      webOrigins: [
        'https://dev-api.ai4jobs.info',
      ],
    },
  },
}
