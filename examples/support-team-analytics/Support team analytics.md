# Support Team Analytics

This example demonstrates how to analyze customer support team performance by retrieving team data and searching conversations to generate insights for workload distribution and training optimization.

## Prerequisites

1. **Intercom Setup**
   > Refer to the [Intercom setup guide](https://central.ballerina.io/ballerinax/intercom/latest) to obtain the necessary credentials.

2. For this example, create a `Config.toml` file with your credentials:

```toml
accessToken = "<Your Access Token>"
```

## Run the Example

Execute the following command to run the example. The script will print its progress to the console.

```shell
bal run
```

The script will:
1. Retrieve all support teams from your Intercom workspace
2. Search for conversations handled by support teams
3. Analyze the data and provide a performance summary with actionable insights