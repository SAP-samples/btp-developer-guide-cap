# Prepare HTML5 Applications with Deploy Configurations

1. Navigate to the root folder of the project and run

```sh
cds add html5-repo
```

This command will generate the following configurations

1.1 It adds the build scripts dependencies to the `app/manager/package.json`.

```json
{
    "name": "manager",
    "version": "0.0.1",
    "description": "A Fiori application.",
    "keywords": [
        "ui5",
        "openui5",
        "sapui5"
    ],
    "main": "webapp/index.html",
    "scripts": {
        "deploy-config": "npx -p @sap/ux-ui5-tooling fiori add deploy-config cf",
        "build": "ui5 build preload --clean-dest --config ui5-deploy.yaml",
        "build-local": "ui5 build preload --clean-dest",
        "start": "ui5 serve"
    },
    "devDependencies": {
        "@ui5/cli": "^3.0.0",
        "@sap/ux-ui5-tooling": "1",
        "ui5-task-zipper": "^3"
    },
    "ui5": {
    "dependencies": [
      "ui5-task-zipper"
    ]
  },
    "private": true
}
```

1.2 Creates a new file `ui5-deploy.yaml` in the folder `app/manager`, with the following content

```yaml
# yaml-language-server: $schema=https://sap.github.io/ui5-tooling/schema/ui5.yaml.json
specVersion: '3.1'
metadata:
  name: incidents
type: application
resources:
  configuration:
    propertiesFileSourceEncoding: UTF-8
builder:
  resources:
    excludes:
      - "/test/**"
      - "/localService/**"
  customTasks:
    - name: ui5-task-zipper
      afterTask: generateVersionInfo
      configuration:
        archiveName: incidents
        additionalFiles:
          - xs-app.json
```

2. Add the `ui5-tooling-transpile-task` in the `ui5-deploy.yaml` file under the `customTasks`.

```yaml
- name: ui5-tooling-transpile-task
    afterTask: replaceVersion
    configuration:
      debug: true
      removeConsoleStatements: true
      transpileAsync: true
      transpileTypeScript: true 
```

After adding, make sure the full `ui5-deploy.yaml` file looks like this

```yaml
# yaml-language-server: $schema=https://sap.github.io/ui5-tooling/schema/ui5.yaml.json
specVersion: '2.4'
metadata:
  name: ns.manager
type: application
resources:
  configuration:
    propertiesFileSourceEncoding: UTF-8
builder:
  resources:
    excludes:
      - "/test/**"
      - "/localService/**"
  customTasks:
  - name: webide-extension-task-updateManifestJson
    afterTask: replaceVersion
    configuration:
      appFolder: webapp
      destDir: dist
  - name: ui5-task-zipper
    afterTask: generateCachebusterInfo
    configuration:
      archiveName: nsmanager
      additionalFiles:
      - xs-app.json
  - name: ui5-tooling-transpile-task
    afterTask: replaceVersion
    configuration:
      debug: true
      removeConsoleStatements: true
      transpileAsync: true
      transpileTypeScript: true 

```

The `ui5-deploy.yaml` file contains the configuration to build the SAPUI5 applications for deployment. It includes the builder and custom tasks.

**builder**: Defines the configuration for the build and for excluding certain resources from the build, such as test files and local service directories.

**customTasks**: Specifies custom tasks to be executed during the build process. These tasks can perform various operations to enhance the deployment process. In this case:

- **webide-extension-task-updateManifestJson**: This task updates the manifest.json file in the webapp folder and moves it to the dist folder. It executes after the 'replaceVersion' task.

- **ui5-task-zipper**: This task zips the application files along with additional files like xs-app.json into an archive named "nsmanager". It executes after the 'generateCachebusterInfo' task.

- **ui5-tooling-transpile-task**: This task transpiles TypeScript files into JavaScript. It also performs debugging-related operations and removes console statements. This task executes after the 'replaceVersion' task.
