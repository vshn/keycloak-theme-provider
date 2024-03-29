# VSHN Keycloak Theme and Auth Provider


## VSHN Keycloak IDP Theme

### Local Development

Run `docker compose up` to start a local Keycloak with the VSHN theme.

The VSHN theme is not automatically selected for the account application.
This can be changed in the Admin Console by clicking on Realm Settings and then Theme.

### Deploy to Your Instance

1. Merge your Pull Request to master branch
1. Tag it with
    ```bash
    git tag -am v1.x.y v1.x.y
    git push --tags
    ```
1. This will trigger the GitHub Action and pushes the image to https://quay.io/repository/vshn/keycloak-theme?tab=tags
1. Add the tag of the version to your extraInitContainers ([see codecentric helm chart documentation](https://github.com/codecentric/helm-charts/blob/master/charts/keycloak/README.md#providing-a-custom-theme))
    ```yaml
    extraInitContainers: |
      - name: theme-provider
        image: ghcr.io/vshn/keyloak-theme-provider:v1.x.x
    ```
1. If you plan to use a redirect for the welcome page, then ensure you set `REDIRECT_URL` as environment variable

### Use as InitContainer:
```
spec:
  containers:
    initContainers:
      theme:
        image: ghcr.io/vshn/keycloak-theme-provider:latest
        imagePullPolicy: IfNotPresent
        command:
          - sh
        args:
          - -c
          - |
            echo "Copying theme..."
            cp -R /themes/* /themes/
        volumeMounts:
        - mountPath: /themes
          name: themes
  volumes:
    - emptyDir: {}
      name: themes
```

## Keycloak Auth Provider

Use as InitContainer:
```
spec:
  containers:
    initContainers:
      auth-provider:
        image: ghcr.io/vshn/keycloak-theme-provider:latest
        imagePullPolicy: IfNotPresent
        command:
          - sh
        args:
          - -c
          - |
            echo "Copying auth-providers..."
            cp -R /providers/* /providers/
        volumeMounts:
        - mountPath: /providers
          name: providers
  volumes:
    - emptyDir: {}
      name: providers
```

