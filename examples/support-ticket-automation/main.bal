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
configurable string ticketTypeId = ?;
configurable string adminId = ?;

const AUTOMATION_EMAIL = "automation-test@example.com";

public function main() returns error? {
    intercom:ConnectionConfig config = {auth: {token: accessToken}};
    intercom:Client intercomClient = check new (config);

    io:println("=== Support Ticket Automation ===\n");

    // Step 1: Create a contact (or find existing)
    io:println("Step 1: Creating test contact...");
    string contactId = "";
    intercom:ContactWithPush|error contactResult = intercomClient->/contacts.post({
        email: AUTOMATION_EMAIL,
        name: "Automation Test User",
        role: "user"
    });
    if contactResult is intercom:ContactWithPush {
        contactId = (contactResult["id"] is string) ? <string>contactResult["id"] : "";
        string contactName = (contactResult["name"] is string) ? <string>contactResult["name"] : "";
        io:println(string `Contact created: "${contactName}" (ID: ${contactId})`);
    } else {
        // Only fall back to search on 409 Conflict (contact already exists); propagate all other errors
        if !contactResult.message().includes("409") {
            return contactResult;
        }
        intercom:SingleFilterSearchRequest emailFilter = {'field: "email", operator: "=", value: AUTOMATION_EMAIL};
        intercom:SearchRequest contactSearch = {query: emailFilter};
        intercom:ContactList existing = check intercomClient->/contacts/search.post(contactSearch);
        intercom:Contact[]? existingData = existing.data;
        if existingData is intercom:Contact[] && existingData.length() > 0 {
            contactId = existingData[0].id ?: "";
            io:println(string `Contact already exists (ID: ${contactId})`);
        } else {
            return error("Could not create or find automation contact");
        }
    }
    io:println();

    // Step 2: Create a ticket for the contact
    io:println("Step 2: Creating a support ticket...");
    intercom:CreateTicketRequest ticketPayload = {
        ticketTypeId: ticketTypeId,
        contacts: [<intercom:ID>{id: contactId}]
    };
    intercom:Ticket ticket = check intercomClient->/tickets.post(ticketPayload);
    string ticketId = ticket.id is string ? <string>ticket.id : "";
    io:println(string `Ticket created (ID: ${ticketId})`);
    io:println();

    // Step 3: Retrieve full ticket details
    io:println("Step 3: Retrieving ticket details...");
    intercom:Ticket fetched = check intercomClient->/tickets/[ticketId];
    string fetchedId = (fetched["id"] is string) ? <string>fetched["id"] : "";
    anydata openRaw = fetched["open"];
    boolean isOpen = (openRaw is boolean) ? openRaw : false;
    io:println(string `Ticket ID: ${fetchedId}, open: ${isOpen}`);
    io:println();

    // Step 4: Search for open tickets
    io:println("Step 4: Searching for open tickets...");
    intercom:SingleFilterSearchRequest openFilter = {'field: "open", operator: "=", value: "true"};
    intercom:SearchRequest searchPayload = {query: openFilter};
    intercom:TicketList openTickets = check intercomClient->/tickets/search.post(searchPayload);
    anydata totalRaw = openTickets["totalCount"];
    int totalOpen = (totalRaw is int) ? totalRaw : 0;
    io:println(string `Open tickets found: ${totalOpen}`);
    io:println();

    // Step 5: Send an automated reply
    io:println("Step 5: Sending automated reply...");
    intercom:AdminReplyTicketRequest replyPayload = {
        adminId: adminId,
        messageType: "comment",
        'type: "admin",
        body: "Thank you for contacting support. We have received your ticket and will respond shortly."
    };
    intercom:TicketReply reply = check intercomClient->/tickets/[ticketId]/reply.post(replyPayload);
    string replyType = (reply["type"] is string) ? <string>reply["type"] : "";
    io:println(string `Automated reply sent (type: ${replyType})`);
    io:println();

    // Step 6: Close the ticket
    io:println("Step 6: Closing the ticket...");
    intercom:Ticket closed = check intercomClient->/tickets/[ticketId].put({open: false});
    anydata closedRaw = closed["open"];
    boolean closedOpen = (closedRaw is boolean) ? closedRaw : false;
    io:println(string `Ticket closed — open: ${closedOpen}`);
    io:println();

    // Step 7: Clean up — delete the test ticket and contact
    io:println("Step 7: Cleaning up test resources...");
    intercom:TicketDeleted deletedTicket = check intercomClient->/tickets/[ticketId].delete();
    io:println(string `Ticket deleted: ${deletedTicket.id == ticketId}`);
    intercom:ContactDeleted deleted = check intercomClient->/contacts/[contactId].delete();
    io:println(string `Contact deleted: ${deleted.id == contactId}`);

    io:println("\n=== Support Ticket Automation Complete ===");
}
