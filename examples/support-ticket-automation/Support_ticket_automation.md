# Support Ticket Automation

This example demonstrates how to automate customer support ticket management using Intercom. The script searches for high-priority tickets, retrieves detailed ticket information, and sends personalized responses to streamline support workflows.

## Prerequisites

1. **Intercom Setup**
   > Refer the [Intercom setup guide](https://central.ballerina.io/ballerinax/intercom/latest#setup-guide) here.

2. For this example, create a `Config.toml` file with your credentials:

```toml
accessToken = "<Your Access Token>"
```

## Run the Example

Execute the following command to run the example. The script will print its progress to the console.

```shell
bal run
```

The script will perform the following workflow:
1. Search for high-priority tickets with segments like "high_priority", "urgent", and "escalated"
2. Retrieve detailed information for a specific ticket
3. Send a personalized response to the ticket
4. Display a summary of completed actions