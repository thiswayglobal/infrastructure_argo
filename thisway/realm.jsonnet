{
  apiVersion: 'legacy.k8s.keycloak.org/v1alpha1',
  kind: 'KeycloakRealm',
  metadata: {
    name: 'thiswayglobal',
    namespace: 'keycloak-operator',
    labels: {
      app: 'external-sso',
    },
  },
  spec: {
    instanceSelector: {
      matchLabels: {
        app: 'external-sso',
      },
    },
    realm: {
      id: 'thiswayglobal',
      realm: 'thiswayglobal',
      enabled: true,
      displayName: 'ThisWayGlobal',

      accessTokenLifespan: 86400,
      accessTokenLifespanForImplicitFlow: 900,
      //accountTheme	<string>
      adminEventsDetailsEnabled: false,
      adminEventsEnabled: false,
      //adminTheme	<string>

      authenticationFlows: [
        {
          id: 'dc8e8397-fe58-40c0-b9b8-a6d18f10a671',
          alias: 'Circa first broker login',
          description: 'Actions taken after first broker login with identity provider account, which is not yet linked to any Keycloak account',
          providerId: 'basic-flow',
          //topLevel: true,
          //builtIn: false,
          authenticationExecutions: [
            {
              authenticatorConfig: 'review profile config',
              authenticator: 'idp-review-profile',
              requirement: 'REQUIRED',
              priority: 10,
              userSetupAllowed: false,
              authenticatorFlow: false,
            },
            {
              requirement: 'REQUIRED',
              priority: 20,
              flowAlias: 'Circa first broker login User creation or linking',
              userSetupAllowed: false,
              authenticatorFlow: true,
            },
          ],
        },
        /*
        {
          id: 'bf22082d-aefb-4504-bddf-5176b07bf977',
          alias: 'Circa first broker login Account verification options',
          description: 'Method with which to verity the existing account',
          providerId: 'basic-flow',
          topLevel: false,
          builtIn: false,
          authenticationExecutions: [
            {
              authenticator: 'idp-email-verification',
              requirement: 'DISABLED',
              priority: 10,
              userSetupAllowed: false,
              authenticatorFlow: false,
            },
            {
              requirement: 'DISABLED',
              priority: 20,
              flowAlias: 'Circa first broker login Verify Existing Account by Re-authentication',
              userSetupAllowed: false,
              authenticatorFlow: true,
            },
          ],
        },
        {
          id: 'e3d9497d-6c4e-401b-9462-a9a898f3aa72',
          alias: 'Circa first broker login First broker login - Conditional OTP',
          description: 'Flow to determine if the OTP is required for the authentication',
          providerId: 'basic-flow',
          topLevel: false,
          builtIn: false,
          authenticationExecutions: [
            {
              authenticator: 'conditional-user-configured',
              requirement: 'REQUIRED',
              priority: 10,
              userSetupAllowed: false,
              authenticatorFlow: false,
            },
            {
              authenticator: 'auth-otp-form',
              requirement: 'REQUIRED',
              priority: 20,
              userSetupAllowed: false,
              authenticatorFlow: false,
            },
          ],
        },
        {
          id: 'f3b8d545-f66c-4272-85fa-173725f328e2',
          alias: 'Circa first broker login Handle Existing Account',
          description: 'Handle what to do if there is existing account with same email/username like authenticated identity provider',
          providerId: 'basic-flow',
          topLevel: false,
          builtIn: false,
          authenticationExecutions: [
            {
              authenticator: 'idp-confirm-link',
              requirement: 'REQUIRED',
              priority: 10,
              userSetupAllowed: false,
              authenticatorFlow: false,
            },
            {
              requirement: 'REQUIRED',
              priority: 20,
              flowAlias: 'Circa first broker login Account verification options',
              userSetupAllowed: false,
              authenticatorFlow: true,
            },
          ],
        },
        {
          id: '5ef0dfef-63e6-4f2c-aea5-9d0d47e34dc9',
          alias: 'Circa first broker login User creation or linking',
          description: 'Flow for the existing/non-existing user alternatives',
          providerId: 'basic-flow',
          topLevel: false,
          builtIn: false,
          authenticationExecutions: [
            {
              authenticatorConfig: 'create unique user config',
              authenticator: 'idp-create-user-if-unique',
              requirement: 'ALTERNATIVE',
              priority: 10,
              userSetupAllowed: false,
              authenticatorFlow: false,
            },
            {
              requirement: 'ALTERNATIVE',
              priority: 20,
              flowAlias: 'Circa first broker login Handle Existing Account',
              userSetupAllowed: false,
              authenticatorFlow: true,
            },
          ],
        },
        {
          id: '4fb6cd4d-e29b-40a3-ae98-5cf8d932ff83',
          alias: 'Circa first broker login Verify Existing Account by Re-authentication',
          description: 'Reauthentication of existing account',
          providerId: 'basic-flow',
          topLevel: false,
          builtIn: false,
          authenticationExecutions: [
            {
              authenticator: 'idp-username-password-form',
              requirement: 'REQUIRED',
              priority: 10,
              userSetupAllowed: false,
              authenticatorFlow: false,
            },
            {
              requirement: 'CONDITIONAL',
              priority: 20,
              flowAlias: 'Circa first broker login First broker login - Conditional OTP',
              userSetupAllowed: false,
              authenticatorFlow: true,
            },
          ],
        },
        */
      ],

      authenticatorConfig: [
        {
          id: '885ab0e6-0555-4973-854a-57c726c6deb3',
          alias: 'create unique user config',
          config: {
            'require.password.update.after.registration': 'false',
          },
        },
        {
          id: '42a13889-294b-42f8-a9ff-9d5edcf7946e',
          alias: 'review profile config',
          config: {
            'update.profile.on.first.login': 'off',
          },
        },
      ],
      browserFlow: 'browser',
      bruteForceProtected: true,
      clientAuthenticationFlow: 'clients',
      clientScopeMappings: {
        account: [
          {
            client: 'account-console',
            roles: [
              'manage-account',
            ],
          },
        ],
      },
      defaultDefaultClientScopes: [
        'profile',
        'role_list',
        'web-origins',
        'email',
        'roles',
      ],
      directGrantFlow: 'direct grant',
      displayNameHtml: '<b><u>ThisWayGlobal</u></b><p><h1>AI4Jobs</h1></p>',
      dockerAuthenticationFlow: 'docker auth',
      duplicateEmailsAllowed: false,
      editUsernameAllowed: false,
      //emailTheme
      eventsEnabled: false,
      eventsListeners: [
        'jboss-logging',
      ],
      failureFactor: 5,
      identityProviderMappers: [
        {
          id: '81fd65f8-4589-4a42-96ff-f3829481851a',
          name: 'OIDC SSO company_id',
          identityProviderAlias: 'circa',
          identityProviderMapper: 'oidc-user-attribute-idp-mapper',
          config: {
            claim: 'company_id',
            'user.attribute': 'rvl_client_key',
          },
        },
      ],
      /*
      identityProviders: [
        {
          alias: 'circa',
          displayName: 'Login with Circa',
          internalId: '91049c5e-ea0b-4850-b87d-11286ff508b5',
          providerId: 'oidc',
          enabled: true,
          trustEmail: true,
          storeToken: false,
          addReadTokenRoleOnCreate: false,
          linkOnly: false,
          firstBrokerLoginFlowAlias: 'first broker login',
          config: {
            hideOnLoginPage: 'false',
            clientId: 'e250012a-cbbf-46db-9447-9113a37c27f5',
            tokenUrl: 'https://employer.circaworks.com/connect/token',
            authorizationUrl: 'https://employer.circaworks.com/account/oauth/login',
            clientAuthMethod: 'client_secret_post',
            syncMode: 'LEGACY',
            clientSecret: '**********',
            defaultScope: 'openid',
            useJwksUrl: 'true',
          },
        },
      ],
      */
      internationalizationEnabled: false,
      loginTheme: 'circa',
      loginWithEmailAllowed: true,
      maxDeltaTimeSeconds: 43200,
      maxFailureWaitSeconds: 900,
      minimumQuickLoginWaitSeconds: 60,
      otpPolicyAlgorithm: 'HmacSHA1',
      otpPolicyDigits: 6,
      otpPolicyInitialCounter: 0,
      otpPolicyLookAheadWindow: 1,
      otpPolicyPeriod: 30,
      otpPolicyType: 'totp',
      otpSupportedApplications: [
        'FreeOTP',
        'Google Authenticator',
      ],
      permanentLockout: false,
      quickLoginCheckMilliSeconds: 1000,
      registrationAllowed: false,
      registrationEmailAsUsername: false,
      registrationFlow: 'registration',
      rememberMe: false,
      resetCredentialsFlow: 'reset credentials',
      resetPasswordAllowed: false,
      /*
      roles: {
        realm: [
          {
            id: '72869b98-a104-47e8-85ff-64606b1e358b',
            name: 'discover',
            description: '${role_discover}',
            composite: false,
            clientRole: false,
            containerId: 'thiswayglobal',
            attributes: {},
          },
          {
            id: 'dea8f974-af2e-4f0b-b828-e7adb128a9fd',
            name: 'reveal',
            composite: false,
            clientRole: false,
            containerId: 'thiswayglobal',
            attributes: {},
          },
          {
            id: 'db423ce5-2313-4d0b-b19a-76821c1d397e',
            name: 'CS',
            description: 'Customer Support',
            composite: false,
            clientRole: false,
            containerId: 'thiswayglobal',
            attributes: {},
          },
          {
            id: '3bcf16e5-6184-4dd9-9aab-f65d8a431578',
            name: 'deladmin',
            description: 'Delegated Admin',
            composite: false,
            clientRole: false,
            containerId: 'thiswayglobal',
            attributes: {},
          },
          {
            id: '3f931708-3e0f-4cdd-83bd-82230cbb4e32',
            name: 'talentmap',
            description: '${talentmap}',
            composite: false,
            clientRole: false,
            containerId: 'thiswayglobal',
            attributes: {},
          },
          {
            id: 'f57d60dc-94fe-47d8-80c8-6a9f2fd42c87',
            name: 'score',
            description: '${score}',
            composite: false,
            clientRole: false,
            containerId: 'thiswayglobal',
            attributes: {},
          },
          {
            id: '7d548ca0-fbb2-4c8e-bfd5-377c5fe5b6df',
            name: 'admin',
            description: '${admin}',
            composite: false,
            clientRole: false,
            containerId: 'thiswayglobal',
            attributes: {},
          },
          {
            id: 'c7982753-325c-4a49-a8a5-3a27896667d0',
            name: 'user',
            description: '${role_user}',
            composite: false,
            clientRole: false,
            containerId: 'thiswayglobal',
            attributes: {},
          },
        ],
        client: {
          'realm-management': [
            {
              id: '24654fd5-3968-4b41-9be2-ccf5c98665b6',
              name: 'manage-clients',
              description: '${role_manage-clients}',
              composite: false,
              clientRole: true,
              containerId: 'ced6f414-e425-4872-b0be-397be497dc9f',
              attributes: {},
            },
            {
              id: 'f1eef000-34d4-46e7-854e-470be27e5ea0',
              name: 'query-realms',
              description: '${role_query-realms}',
              composite: false,
              clientRole: true,
              containerId: 'ced6f414-e425-4872-b0be-397be497dc9f',
              attributes: {},
            },
            {
              id: 'eeae3d31-409b-4c1b-9b1a-cf4e0922e9d6',
              name: 'view-realm',
              description: '${role_view-realm}',
              composite: false,
              clientRole: true,
              containerId: 'ced6f414-e425-4872-b0be-397be497dc9f',
              attributes: {},
            },
            {
              id: '02ac5d35-1bac-4c5a-a92d-a2467c49233f',
              name: 'manage-users',
              description: '${role_manage-users}',
              composite: false,
              clientRole: true,
              containerId: 'ced6f414-e425-4872-b0be-397be497dc9f',
              attributes: {},
            },
            {
              id: '6ef72a29-0bc5-481b-bfc5-4e19dc309f5c',
              name: 'view-clients',
              description: '${role_view-clients}',
              composite: true,
              composites: {
                client: {
                  'realm-management': [
                    'query-clients',
                  ],
                },
              },
              clientRole: true,
              containerId: 'ced6f414-e425-4872-b0be-397be497dc9f',
              attributes: {},
            },
            {
              id: '2d65c624-08d7-4317-a1b9-8ef38fcc04e5',
              name: 'realm-admin',
              description: '${role_realm-admin}',
              composite: true,
              composites: {
                client: {
                  'realm-management': [
                    'manage-clients',
                    'query-realms',
                    'view-realm',
                    'manage-users',
                    'view-clients',
                    'impersonation',
                    'query-groups',
                    'view-events',
                    'manage-identity-providers',
                    'manage-events',
                    'view-identity-providers',
                    'view-users',
                    'manage-realm',
                    'manage-authorization',
                    'view-authorization',
                    'create-client',
                    'query-clients',
                    'query-users',
                  ],
                },
              },
              clientRole: true,
              containerId: 'ced6f414-e425-4872-b0be-397be497dc9f',
              attributes: {},
            },
            {
              id: '1e7a1cb1-9c8d-44df-8eb4-394ecb8a8d90',
              name: 'impersonation',
              description: '${role_impersonation}',
              composite: false,
              clientRole: true,
              containerId: 'ced6f414-e425-4872-b0be-397be497dc9f',
              attributes: {},
            },
            {
              id: '3e297998-8f6d-47a9-8291-6a3726363519',
              name: 'query-groups',
              description: '${role_query-groups}',
              composite: false,
              clientRole: true,
              containerId: 'ced6f414-e425-4872-b0be-397be497dc9f',
              attributes: {},
            },
            {
              id: '6d76c4d3-9340-40d3-bc2a-e61ed031b666',
              name: 'view-events',
              description: '${role_view-events}',
              composite: false,
              clientRole: true,
              containerId: 'ced6f414-e425-4872-b0be-397be497dc9f',
              attributes: {},
            },
            {
              id: 'b8919446-8dd5-40dd-b858-154948567c59',
              name: 'manage-events',
              description: '${role_manage-events}',
              composite: false,
              clientRole: true,
              containerId: 'ced6f414-e425-4872-b0be-397be497dc9f',
              attributes: {},
            },
            {
              id: 'a1affcb3-db9a-4bda-bf8e-63ffaa58c615',
              name: 'manage-identity-providers',
              description: '${role_manage-identity-providers}',
              composite: false,
              clientRole: true,
              containerId: 'ced6f414-e425-4872-b0be-397be497dc9f',
              attributes: {},
            },
            {
              id: '97d338ab-e23e-456e-8079-fc379d9d08c4',
              name: 'view-identity-providers',
              description: '${role_view-identity-providers}',
              composite: false,
              clientRole: true,
              containerId: 'ced6f414-e425-4872-b0be-397be497dc9f',
              attributes: {},
            },
            {
              id: '8f5d1592-4aae-4d85-b767-8cd7a565e9fc',
              name: 'view-users',
              description: '${role_view-users}',
              composite: true,
              composites: {
                client: {
                  'realm-management': [
                    'query-groups',
                    'query-users',
                  ],
                },
              },
              clientRole: true,
              containerId: 'ced6f414-e425-4872-b0be-397be497dc9f',
              attributes: {},
            },
            {
              id: '8c5991bd-c47f-4a9d-aee7-cbc4033f0a58',
              name: 'manage-realm',
              description: '${role_manage-realm}',
              composite: false,
              clientRole: true,
              containerId: 'ced6f414-e425-4872-b0be-397be497dc9f',
              attributes: {},
            },
            {
              id: 'c57a5c4c-6ff8-44fa-acf4-e8a53d3ef51d',
              name: 'manage-authorization',
              description: '${role_manage-authorization}',
              composite: false,
              clientRole: true,
              containerId: 'ced6f414-e425-4872-b0be-397be497dc9f',
              attributes: {},
            },
            {
              id: '1d2acb27-c61d-498b-9c82-432490c787f0',
              name: 'view-authorization',
              description: '${role_view-authorization}',
              composite: false,
              clientRole: true,
              containerId: 'ced6f414-e425-4872-b0be-397be497dc9f',
              attributes: {},
            },
            {
              id: '1603d3b6-16e6-4860-8be5-93a0c5aab88f',
              name: 'create-client',
              description: '${role_create-client}',
              composite: false,
              clientRole: true,
              containerId: 'ced6f414-e425-4872-b0be-397be497dc9f',
              attributes: {},
            },
            {
              id: '25bac061-4dbd-4a48-bc14-94c80770eec2',
              name: 'query-clients',
              description: '${role_query-clients}',
              composite: false,
              clientRole: true,
              containerId: 'ced6f414-e425-4872-b0be-397be497dc9f',
              attributes: {},
            },
            {
              id: 'b75090f6-3a19-4615-8579-9f70e3e777fb',
              name: 'query-users',
              description: '${role_query-users}',
              composite: false,
              clientRole: true,
              containerId: 'ced6f414-e425-4872-b0be-397be497dc9f',
              attributes: {},
            },
          ],
          ai4jobs: [],
          'twg-trusted-client': [],
          'ai4jobs-circa': [],
          'security-admin-console': [],
          'admin-cli': [],
          'ai4jobs-salesforce': [],
          'account-console': [],
          broker: [
            {
              id: 'e3455650-dd3c-4227-895b-97a476f9402c',
              name: 'read-token',
              description: '${role_read-token}',
              composite: false,
              clientRole: true,
              containerId: '3a77f7ca-e96a-4911-834f-98e8bb2c7046',
              attributes: {},
            },
          ],
          account: [
            {
              id: 'bd8ff234-047a-4fe0-94ff-8224240540bb',
              name: 'manage-account',
              description: '${role_manage-account}',
              composite: true,
              composites: {
                client: {
                  account: [
                    'manage-account-links',
                  ],
                },
              },
              clientRole: true,
              containerId: 'd0fafe9c-2e82-4800-b93d-a6f5e91a5362',
              attributes: {},
            },
            {
              id: '5cd04ad0-61a0-49d0-a6e1-56d3bb5af4ea',
              name: 'manage-account-links',
              description: '${role_manage-account-links}',
              composite: false,
              clientRole: true,
              containerId: 'd0fafe9c-2e82-4800-b93d-a6f5e91a5362',
              attributes: {},
            },
            {
              id: 'be383aba-aea5-442b-869d-35a6b0d7f668',
              name: 'view-profile',
              description: '${role_view-profile}',
              composite: false,
              clientRole: true,
              containerId: 'd0fafe9c-2e82-4800-b93d-a6f5e91a5362',
              attributes: {},
            },
            {
              id: '4c7cf3a7-004b-41be-bc95-6179ff77d916',
              name: 'manage-consent',
              description: '${role_manage-consent}',
              composite: true,
              composites: {
                client: {
                  account: [
                    'view-consent',
                  ],
                },
              },
              clientRole: true,
              containerId: 'd0fafe9c-2e82-4800-b93d-a6f5e91a5362',
              attributes: {},
            },
            {
              id: 'b6e985d5-cf72-4509-afec-4ee4ecfbd90c',
              name: 'view-consent',
              description: '${role_view-consent}',
              composite: false,
              clientRole: true,
              containerId: 'd0fafe9c-2e82-4800-b93d-a6f5e91a5362',
              attributes: {},
            },
            {
              id: '8529d2d4-b302-44b4-a8b1-1474a55023a2',
              name: 'view-applications',
              description: '${role_view-applications}',
              composite: false,
              clientRole: true,
              containerId: 'd0fafe9c-2e82-4800-b93d-a6f5e91a5362',
              attributes: {},
            },
            {
              id: '34ef7e69-e32a-477b-aa31-1d80fe7e5deb',
              name: 'delete-account',
              description: '${role_delete-account}',
              composite: false,
              clientRole: true,
              containerId: 'd0fafe9c-2e82-4800-b93d-a6f5e91a5362',
              attributes: {},
            },
          ],
        },
      },
      */
      scopeMappings: [
        {
          clientScope: 'offline_access',
          roles: [
            'offline_access',
          ],
        },
      ],
      smtpServer: {},
      sslRequired: 'external',
      supportedLocales: [
        '',
      ],
      userManagedAccessAllowed: false,
      verifyEmail: false,
      waitIncrementSeconds: 60,


      enabledEventTypes: [],
    },
  },
}
