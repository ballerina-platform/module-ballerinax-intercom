
# Ballerina intercom connector

[![Build](https://github.com/ballerina-platform/module-ballerinax-intercom/actions/workflows/ci.yml/badge.svg)](https://github.com/ballerina-platform/module-ballerinax-intercom/actions/workflows/ci.yml)
[![Trivy](https://github.com/ballerina-platform/module-ballerinax-intercom/actions/workflows/trivy-scan.yml/badge.svg)](https://github.com/ballerina-platform/module-ballerinax-intercom/actions/workflows/trivy-scan.yml)
[![GraalVM Check](https://github.com/ballerina-platform/module-ballerinax-intercom/actions/workflows/build-with-bal-test-graalvm.yml/badge.svg)](https://github.com/ballerina-platform/module-ballerinax-intercom/actions/workflows/build-with-bal-test-graalvm.yml)
[![GitHub Last Commit](https://img.shields.io/github/last-commit/ballerina-platform/module-ballerinax-intercom.svg)](https://github.com/ballerina-platform/module-ballerinax-intercom/commits/master)
[![GitHub Issues](https://img.shields.io/github/issues/ballerina-platform/ballerina-library/module/intercom.svg?label=Open%20Issues)](https://github.com/ballerina-platform/ballerina-library/labels/module%intercom)

## Overview

[Intercom](https://www.intercom.com/) is a customer service platform that enables businesses to communicate with customers through messaging, support, and engagement tools, helping companies build better customer relationships at scale.

The `ballerinax/intercom` package offers APIs to connect and interact with [Intercom API](https://developers.intercom.com/) endpoints, specifically based on [Intercom API v2.11](https://developers.intercom.com/docs/references/rest-api).
## Setup guide

To use the Intercom connector, you must have access to the Intercom API through an [Intercom developer account](https://developers.intercom.com/) and obtain an API access token. If you do not have an Intercom account, you can sign up for one [here](https://www.intercom.com/help/en/collections/3604584-getting-started).

### Step 1: Create an Intercom Account

1. Navigate to the [Intercom website](https://www.intercom.com/) and sign up for an account or log in if you already have one.

2. Ensure you have a paid plan, as API access is only available to customers on paid Intercom plans (Starter, Pro, or Premium).

### Step 2: Generate an API Access Token

1. Log in to your Intercom workspace.

2. Navigate to Settings by clicking on the gear icon in the bottom left corner.

3. In the Settings menu, select "Developers" from the left sidebar.

4. Click on "Developer Hub" and then select "New app" to create a new app, or use an existing app.

5. Once in your app, go to the "Authentication" section and copy your Access Token.

> **Tip:** You must copy and store this key somewhere safe. It won't be visible again in your account settings for security reasons.
## Quickstart

To use the `intercom` connector in your Ballerina application, update the `.bal` file as follows:

### Step 1: Import the module

```ballerina
import ballerinax/intercom;
```

### Step 2: Instantiate a new connector

1. Create a `Config.toml` file and configure the obtained access token:

```toml
token = "<Your_Intercom_Access_Token>"
```

2. Create a `intercom:ConnectionConfig` and initialize the client:

```ballerina
configurable string token = ?;

final intercom:Client intercomClient = check new({
    auth: {
        token
    }
});
```

### Step 3: Invoke the connector operation

Now, utilize the available connector operations.

#### Create a contact

```ballerina
public function main() returns error? {
    intercom:ContactsBody newContact = {
        'type: "segment.list",
        segments: ["new_leads"]
    };

    intercom:Contact response = check intercomClient->/contacts.post(newContact);
}
```

### Step 4: Run the Ballerina application

```bash
bal run
```
## Examples

The `Intercom` connector provides practical examples illustrating usage in various scenarios. Explore these [examples](https://github.com/ballerina-platform/module-ballerinax-intercom/tree/main/examples), covering the following use cases:

1. [Support team analytics](https://github.com/ballerina-platform/module-ballerinax-intercom/tree/main/examples/support-team-analytics) - Demonstrates how to analyze support team performance and metrics using Ballerina connector for Intercom.
2. [Priority ticket escalation](https://github.com/ballerina-platform/module-ballerinax-intercom/tree/main/examples/priority-ticket-escalation) - Illustrates automating the escalation of high-priority support tickets.
3. [Support ticket automation](https://github.com/ballerina-platform/module-ballerinax-intercom/tree/main/examples/support-ticket-automation) - Shows how to automate support ticket creation and management workflows.
4. [Knowledge base management](https://github.com/ballerina-platform/module-ballerinax-intercom/tree/main/examples/knowledge-base-management) - Demonstrates managing and updating knowledge base articles programmatically.
## Build from the source

### Setting up the prerequisites

1. Download and install Java SE Development Kit (JDK) version 21. You can download it from either of the following sources:

    * [Oracle JDK](https://www.oracle.com/java/technologies/downloads/)
    * [OpenJDK](https://adoptium.net/)

    > **Note:** After installation, remember to set the `JAVA_HOME` environment variable to the directory where JDK was installed.

2. Download and install [Ballerina Swan Lake](https://ballerina.io/).

3. Download and install [Docker](https://www.docker.com/get-started).

    > **Note**: Ensure that the Docker daemon is running before executing any tests.

4. Export Github Personal access token with read package permissions as follows,

    ```bash
    export packageUser=<Username>
    export packagePAT=<Personal access token>
    ```

### Build options

Execute the commands below to build from the source.

1. To build the package:

    ```bash
    ./gradlew clean build
    ```

2. To run the tests:

    ```bash
    ./gradlew clean test
    ```

3. To build the without the tests:

    ```bash
    ./gradlew clean build -x test
    ```

4. To run tests against different environments:

    ```bash
    ./gradlew clean test -Pgroups=<Comma separated groups/test cases>
    ```

5. To debug the package with a remote debugger:

    ```bash
    ./gradlew clean build -Pdebug=<port>
    ```

6. To debug with the Ballerina language:

    ```bash
    ./gradlew clean build -PbalJavaDebug=<port>
    ```

7. Publish the generated artifacts to the local Ballerina Central repository:

    ```bash
    ./gradlew clean build -PpublishToLocalCentral=true
    ```

8. Publish the generated artifacts to the Ballerina Central repository:

    ```bash
    ./gradlew clean build -PpublishToCentral=true
    ```

## Contribute to Ballerina

As an open-source project, Ballerina welcomes contributions from the community.

For more information, go to the [contribution guidelines](https://github.com/ballerina-platform/ballerina-lang/blob/master/CONTRIBUTING.md).

## Code of conduct

All the contributors are encouraged to read the [Ballerina Code of Conduct](https://ballerina.io/code-of-conduct).


## Useful links

* For more information go to the [`intercom` package](https://central.ballerina.io/ballerinax/intercom/latest).
* For example demonstrations of the usage, go to [Ballerina By Examples](https://ballerina.io/learn/by-example/).
* Chat live with us via our [Discord server](https://discord.gg/ballerinalang).
* Post all technical questions on Stack Overflow with the [#ballerina](https://stackoverflow.com/questions/tagged/ballerina) tag.
