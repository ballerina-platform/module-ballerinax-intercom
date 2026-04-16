// Copyright (c) 2026, WSO2 LLC. (http://www.wso2.com).
//
// WSO2 LLC. licenses this file to you under the Apache License,
// Version 2.0 (the "License"); you may not use this file except
// in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing,
// software distributed under the License is distributed on an
// "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
// KIND, either express or implied.  See the License for the
// specific language governing permissions and limitations
// under the License.

import ballerina/io;
import ballerinax/intercom;

configurable string accessToken = ?;

public function main() returns error? {
    intercom:ConnectionConfig config = {auth: {token: accessToken}};
    intercom:Client intercomClient = check new (config);

    io:println("=== Support Team Analytics ===\n");

    // Step 1: Identify the current admin (verify connectivity)
    io:println("Step 1: Identifying current admin...");
    intercom:AdminWithApp me = check intercomClient->/me;
    string adminName = (me["name"] is string) ? <string>me["name"] : "Unknown";
    string adminId = (me["id"] is string) ? <string>me["id"] : "";
    io:println(string `Authenticated as: ${adminName} (ID: ${adminId})`);
    io:println();

    // Step 2: List all admins in the workspace
    io:println("Step 2: Listing all admins...");
    intercom:AdminList admins = check intercomClient->/admins;
    anydata adminsRaw = admins["admins"];
    intercom:Admin[] adminList = (adminsRaw is intercom:Admin[]) ? adminsRaw : [];
    io:println(string `Total admins: ${adminList.length()}`);
    foreach intercom:Admin admin in adminList {
        string name = (admin["name"] is string) ? <string>admin["name"] : "Unknown";
        string email = (admin["email"] is string) ? <string>admin["email"] : "no email";
        io:println(string `  - ${name} (${email})`);
    }
    io:println();

    // Step 3: Search for open conversations
    io:println("Step 3: Searching for open conversations...");
    intercom:SingleFilterSearchRequest stateFilter = {'field: "state", operator: "=", value: "open"};
    intercom:SearchRequest searchPayload = {query: stateFilter};
    intercom:ConversationList openConversations = check intercomClient->/conversations/search.post(searchPayload);
    anydata openCountRaw = openConversations["totalCount"];
    int openCount = (openCountRaw is int) ? openCountRaw : 0;
    io:println(string `Open conversations: ${openCount}`);
    io:println();

    // Step 4: Count contacts
    io:println("Step 4: Retrieving contact count...");
    intercom:ContactList contacts = check intercomClient->/contacts;
    anydata contactCountRaw = contacts["totalCount"];
    int contactCount = (contactCountRaw is int) ? contactCountRaw : 0;
    io:println(string `Total contacts: ${contactCount}`);
    io:println();

    // Summary
    io:println("=== Analytics Summary ===");
    io:println(string `Admins in workspace : ${adminList.length()}`);
    io:println(string `Open conversations  : ${openCount}`);
    io:println(string `Total contacts      : ${contactCount}`);
    io:println("\n=== Support Team Analytics Complete ===");
}
