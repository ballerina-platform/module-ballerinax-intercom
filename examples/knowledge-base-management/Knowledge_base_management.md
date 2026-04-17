# Knowledge Base Management

This example demonstrates how to manage customer support knowledge base content using the Intercom platform. The script retrieves existing collections, creates new FAQ articles, and updates article content based on customer feedback.

## Prerequisites

1. **Intercom Setup**
   > Refer to the [Intercom setup guide](https://central.ballerina.io/ballerinax/intercom/latest#setup-guide) to obtain the necessary credentials.

2. For this example, create a `Config.toml` file with your credentials:

```toml
accessToken = "<Your Access Token>"
```

## Run the Example

Execute the following command to run the example. The script will print its progress to the console.

```shell
bal run
```

The script will perform the following operations:
1. Retrieve existing collection structure from your Intercom help center
2. Create a new FAQ article with proper categorization
3. Update the article content based on customer feedback scenarios

You should see output indicating the success of each step in the knowledge base management process.