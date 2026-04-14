## Overview

[Intercom](https://www.intercom.com/) is a customer service platform that enables businesses to communicate with customers through messaging, support, and engagement tools, helping companies build better customer relationships at scale.

The `ballerinax/intercom` package offers APIs to connect and interact with [Intercom API](https://developers.intercom.com/) endpoints, specifically based on [Intercom API version 2.10](https://developers.intercom.com/intercom-api-reference/reference/rest-api-introduction).
## Setup guide

To use the Intercom connector, you must have access to the Intercom API through an [Intercom developer account](https://developers.intercom.com/) and obtain an API access token. If you do not have an Intercom account, you can sign up for one [here](https://www.intercom.com/help/en/articles/683-sign-up-for-intercom).

### Step 1: Create an Intercom Account

1. Navigate to the [Intercom website](https://www.intercom.com/) and sign up for an account or log in if you already have one.

2. Ensure you have a paid plan (Starter plan or higher), as API access is not available on the free trial version.

### Step 2: Generate an API Access Token

1. Log in to your Intercom account.

2. Navigate to Settings (gear icon in the top right corner), then select For Developers from the left sidebar.

3. In the Developer Hub, click on Your Apps, then select New app to create a new app or select an existing app.

4. Once in your app, go to the Configure tab and scroll down to the Access Token section to generate your access token.

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
        segments: ["new_users", "trial_customers"]
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

1. [Support team analytics](https://github.com/ballerina-platform/module-ballerinax-intercom/tree/main/examples/support-team-analytics) - Demonstrates how to analyze support team performance metrics using Ballerina connector for Intercom.
2. [Priority ticket escalation](https://github.com/ballerina-platform/module-ballerinax-intercom/tree/main/examples/priority-ticket-escalation) - Illustrates automating the escalation of high-priority support tickets.
3. [Support ticket automation](https://github.com/ballerina-platform/module-ballerinax-intercom/tree/main/examples/support-ticket-automation) - Shows how to automate support ticket creation and management workflows.
4. [Knowledge base management](https://github.com/ballerina-platform/module-ballerinax-intercom/tree/main/examples/knowledge-base-management) - Demonstrates managing and updating knowledge base articles programmatically.