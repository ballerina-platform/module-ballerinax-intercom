import ballerina/io;
import ballerinax/intercom;

configurable string accessToken = ?;
configurable string ticketTypeId = ?;
configurable string adminId = ?;

const ESCALATION_EMAIL = "escalation-test@example.com";

public function main() returns error? {
    intercom:ConnectionConfig config = {auth: {token: accessToken}};
    intercom:Client intercomClient = check new (config);

    io:println("=== Priority Ticket Escalation Workflow ===\n");

    // Step 1: Create a contact (or find existing) to represent the affected customer
    io:println("Step 1: Creating escalation contact...");
    string contactId = "";
    intercom:ContactWithPush|error contactResult = intercomClient->/contacts.post({
        email: ESCALATION_EMAIL,
        name: "Escalation Test User",
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
        intercom:SingleFilterSearchRequest emailFilter = {'field: "email", operator: "=", value: ESCALATION_EMAIL};
        intercom:SearchRequest contactSearch = {query: emailFilter};
        intercom:ContactList existing = check intercomClient->/contacts/search.post(contactSearch);
        intercom:Contact[]? existingData = existing.data;
        if existingData is intercom:Contact[] && existingData.length() > 0 {
            contactId = existingData[0].id ?: "";
            io:println(string `Contact already exists (ID: ${contactId})`);
        } else {
            return error("Could not create or find escalation contact");
        }
    }
    io:println();

    // Step 2: Create a high-priority ticket for this contact
    io:println("Step 2: Creating high-priority ticket...");
    intercom:CreateTicketRequest ticketPayload = {
        ticketTypeId: ticketTypeId,
        contacts: [<intercom:ID>{id: contactId}]
    };
    intercom:Ticket ticket = check intercomClient->/tickets.post(ticketPayload);
    string ticketId = (ticket["id"] is string) ? <string>ticket["id"] : "";
    io:println(string `Ticket created (ID: ${ticketId})`);
    io:println();

    // Step 3: Reply to the ticket as an admin to acknowledge escalation
    io:println("Step 3: Sending acknowledgement reply...");
    intercom:AdminReplyTicketRequest replyPayload = {
        adminId: adminId,
        messageType: "comment",
        'type: "admin",
        body: "Your request has been escalated to our specialist team. We will get back to you within 2 hours."
    };
    intercom:TicketReply reply = check intercomClient->/tickets/[ticketId]/reply.post(replyPayload);
    string replyType = (reply["type"] is string) ? <string>reply["type"] : "";
    io:println(string `Reply sent (type: ${replyType})`);
    io:println();

    // Step 4: Mark the ticket as open (escalated state)
    io:println("Step 4: Marking ticket as open/escalated...");
    intercom:Ticket updated = check intercomClient->/tickets/[ticketId].put({open: true});
    anydata openRaw = updated["open"];
    boolean isOpen = (openRaw is boolean) ? openRaw : false;
    io:println(string `Ticket state updated — open: ${isOpen}`);
    io:println();

    // Step 5: Clean up — delete the test ticket and contact
    io:println("Step 5: Cleaning up test resources...");
    intercom:TicketDeleted deletedTicket = check intercomClient->/tickets/[ticketId].delete();
    io:println(string `Ticket deleted: ${deletedTicket.id == ticketId}`);
    intercom:ContactDeleted deletedContact = check intercomClient->/contacts/[contactId].delete();
    io:println(string `Contact deleted: ${deletedContact.id == contactId}`);

    io:println("\n=== Priority Ticket Escalation Workflow Complete ===");
}
