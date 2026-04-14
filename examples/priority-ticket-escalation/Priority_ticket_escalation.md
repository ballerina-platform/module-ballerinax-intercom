# Priority Ticket Escalation

This example demonstrates how to automate customer support escalation workflows by converting high-priority conversations to tickets, adding categorization tags, and retrieving company context using the Intercom platform.

## Prerequisites

1. **Intercom Setup**
   > Refer the [Intercom setup guide](https://central.ballerina.io/ballerinax/intercom/latest#setup-guide) here.

2. For this example, create a `Config.toml` file with your credentials:

```toml
accessToken = "<Your Access Token>"
serviceUrl = "https://api.intercom.io"
```

## Run the example

Execute the following command to run the example. The script will print its progress to the console.

```shell
bal run
```

The script will:
- Convert a high-priority conversation to a ticket
- Add categorization tags for proper routing
- Retrieve company information for additional context
- Display the complete escalation workflow progress