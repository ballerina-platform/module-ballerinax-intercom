# Examples

The `intercom` connector provides practical examples illustrating usage in various scenarios. Explore these [examples](https://github.com/ballerina-platform/module-ballerinax-intercom/tree/main/examples), covering use cases like support team analytics, priority ticket escalation, and support ticket automation.

1. [Support team analytics](https://github.com/ballerina-platform/module-ballerinax-intercom/tree/main/examples/support-team-analytics) - Analyze support team performance metrics and generate insights from customer interaction data.

2. [Priority ticket escalation](https://github.com/ballerina-platform/module-ballerinax-intercom/tree/main/examples/priority-ticket-escalation) - Automatically escalate high-priority support tickets based on predefined criteria and customer importance.

3. [Support ticket automation](https://github.com/ballerina-platform/module-ballerinax-intercom/tree/main/examples/support-ticket-automation) - Automate the creation, assignment, and management of support tickets in Intercom.

4. [Knowledge base management](https://github.com/ballerina-platform/module-ballerinax-intercom/tree/main/examples/knowledge-base-management) - Manage and update knowledge base articles and help center content programmatically.

## Prerequisites

1. Generate Intercom credentials to authenticate the connector as described in the [Setup guide](https://central.ballerina.io/ballerinax/intercom/latest#setup-guide).

2. For each example, create a `Config.toml` file with the required configuration. Here's an example of how your `Config.toml` file should look:

    ```toml
    token = "<Access Token>"
    ```

## Running an Example

Execute the following commands to build an example from the source:

* To build an example:

    ```bash
    bal build
    ```

* To run an example:

    ```bash
    bal run
    ```