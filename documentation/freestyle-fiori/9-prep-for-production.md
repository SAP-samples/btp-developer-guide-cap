# Prepare HTML5 Applications with Deploy Configurations

1. Navigate to the root folder of the project and run

```sh
cds add html5-repo
```

This command will generate the following configurations

1.1 It updates the `app/manager/package.json` with build scripts and dependencies:

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
    "devDependencies": {
        "@ui5/cli": "^4",
        "ui5-task-zipper": "^3"
    },
    "scripts": {
        "build": "ui5 build preload --clean-dest",
        "start": "ui5 serve"
    }
}
```

1.2 It creates a new file **ui5.yaml** in the folder **app/manager/**.

```yaml
# yaml-language-server: $schema=https://ui5.github.io/cli/schema/ui5.yaml.json
specVersion: '4.0'
metadata:
  name: manager
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
        archiveName: manager
        relativePaths: true
        additionalFiles:
          - xs-app.json
```

> [!NOTE]
> For TypeScript projects, `cds add html5-repo` also adds a `ui5-tooling-transpile-task` entry under `customTasks`. This is not generated for JavaScript projects.

The `ui5.yaml` file contains the configuration to build the SAPUI5 applications for deployment. It includes the builder and custom tasks.

**builder**: Defines the configuration for the build and for excluding certain resources from the build, such as test files and local service directories.

**customTasks**: Specifies custom tasks to be executed during the build process. These tasks can perform various operations to enhance the deployment process. In this case:

- **ui5-task-zipper**: This task zips the application files along with additional files like xs-app.json into an archive named "manager". It executes after the 'generateVersionInfo' task.

2. **Install the dependencies**

As the previous step adds several `dependencies` and `devDependencies` to the html5 apps (`incidents`, `manager`) in the `app` folder. It is recommended to run `npm install` command in all the html5 apps folders (`app/incidents`, `app/manager`).
