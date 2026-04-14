import ballerina/io;
import ballerina/lang.'int as langInt;
import ballerinax/intercom;

configurable string accessToken = ?;
configurable int authorId = ?;

public function main() returns error? {
    intercom:ConnectionConfig config = {auth: {token: accessToken}};
    intercom:Client intercomClient = check new (config);

    io:println("=== Knowledge Base Management ===\n");

    // Step 1: List existing Help Center collections
    io:println("Step 1: Listing existing Help Center collections...");
    intercom:CollectionList collections = check intercomClient->/help_center/collections;
    anydata collectionData = collections["data"];
    int collectionCount = (collectionData is anydata[]) ? collectionData.length() : 0;
    io:println(string `Found ${collectionCount} collection(s).`);
    io:println();

    // Step 2: Create a new article
    io:println("Step 2: Creating a new FAQ article...");
    intercom:Article article = check intercomClient->/articles.post({
        title: "How to reset your password",
        body: "<p>To reset your password, click <strong>Forgot Password</strong> on the login page and follow the instructions sent to your email.</p>",
        authorId: authorId,
        state: "published"
    });
    string articleIdStr = (article["id"] is string) ? <string>article["id"] : "0";
    int articleId = check langInt:fromString(articleIdStr);
    string articleTitle = (article["title"] is string) ? <string>article["title"] : "";
    io:println(string `Created article: "${articleTitle}" (ID: ${articleId})`);
    io:println();

    // Step 3: Update the article with improved content
    io:println("Step 3: Updating article content...");
    intercom:Article updated = check intercomClient->/articles/[articleId].put({
        title: "How to reset your password",
        body: "<p>To reset your password:</p><ol><li>Click <strong>Forgot Password</strong> on the login page.</li><li>Enter your registered email address.</li><li>Check your inbox and follow the reset link.</li></ol>",
        state: "published"
    });
    string updatedTitle = (updated["title"] is string) ? <string>updated["title"] : "";
    string updatedState = (updated["state"] is string) ? <string>updated["state"] : "";
    io:println(string `Updated article: "${updatedTitle}" (state: ${updatedState})`);
    io:println();

    // Step 4: Clean up — delete the article
    io:println("Step 4: Deleting the article...");
    intercom:DeletedArticleObject deleted = check intercomClient->/articles/[articleId].delete();
    anydata deletedRaw = deleted["deleted"];
    boolean isDeleted = (deletedRaw is boolean) ? deletedRaw : false;
    io:println(string `Article deleted: ${isDeleted}`);

    io:println("\n=== Knowledge Base Management Complete ===");
}
