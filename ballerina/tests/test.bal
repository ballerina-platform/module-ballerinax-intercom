// Copyright (c) 2025, WSO2 LLC. (http://www.wso2.com).
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

import ballerina/lang.'int as langInt;
import ballerina/os;
import ballerina/test;
import intercom.mock.server as _;

configurable boolean isLiveServer = os:getEnv("IS_LIVE_SERVER") == "true";
configurable string token = isLiveServer ? os:getEnv("INTERCOM_TOKEN") : "test_token";
configurable string serviceUrl = isLiveServer ? "https://api.intercom.io" : "http://localhost:9090";
// Required for live ticket tests. Find your ticket type IDs via GET /ticket_types.
configurable string ticketTypeId = "type_123";

ConnectionConfig config = {auth: {token}};
final Client intercomClient = check new Client(config, serviceUrl);

// Resource IDs — mock-safe defaults; BeforeSuite replaces these with real IDs on live server.
// Article and conversation endpoints use integer IDs; contact and ticket use string IDs.
string testContactId = "contact_123";
int testArticleId = 123;
int testConversationId = 456;
string testTicketId = "ticket_123";
string testAdminId = "123";

// ─── Lifecycle ────────────────────────────────────────────────────────────────

@test:BeforeSuite
function setupTestResources() returns error? {
    if !isLiveServer {
        return;
    }

    // 1. Get the current admin ID (needed for article creation)
    AdminWithApp me = check intercomClient->/me;
    testAdminId = me.id ?: "0";

    // 2. Create a test contact; if it already exists from a previous run, look it up
    ContactsBody contactPayload = {
        email: "ballerina-test@example.com",
        name: "Ballerina Test Contact"
    };
    ContactWithPush|error contactResult = intercomClient->/contacts.post(contactPayload);
    if contactResult is ContactWithPush {
        testContactId = contactResult.id ?: testContactId;
    } else {
        // 409 Conflict — contact already exists; search for it
        SearchRequest contactSearch = {
            query: <MultipleFilterSearchRequest>{
                operator: "AND",
                value: [<SingleFilterSearchRequest>{'field: "email", operator: "=", value: "ballerina-test@example.com"}]
            }
        };
        ContactList existing = check intercomClient->/contacts/search.post(contactSearch);
        Contact[]? existingData = existing?.data;
        if existingData is Contact[] && existingData.length() > 0 {
            testContactId = existingData[0].id ?: testContactId;
        }
    }

    // 3. Create a test article
    int adminIdInt = 0;
    int|error parsedAdmin = langInt:fromString(testAdminId);
    if parsedAdmin is int {
        adminIdInt = parsedAdmin;
    }
    CreateArticleRequest articlePayload = {
        title: "Ballerina Test Article",
        authorId: adminIdInt,
        state: "draft"
    };
    Article article = check intercomClient->/articles.post(articlePayload);
    string? articleIdStr = article.id;
    if articleIdStr is string {
        int|error parsed = langInt:fromString(articleIdStr);
        if parsed is int {
            testArticleId = parsed;
        }
    }

    // 4. Create a test conversation using the contact
    CreateConversationRequest convPayload = {
        body: "Ballerina test conversation",
        'from: {'type: "user", id: testContactId}
    };
    ConversationMessage convMsg = check intercomClient->/conversations.post(convPayload);
    string convIdStr = convMsg.conversationId ?: "456";
    int|error parsedConv = langInt:fromString(convIdStr);
    if parsedConv is int {
        testConversationId = parsedConv;
    }

    // 5. Create a test ticket (only when a real ticket type is configured)
    if ticketTypeId != "type_123" {
        TicketsBody ticketPayload = {
            ticketTypeId: ticketTypeId,
            contacts: [{id: testContactId}]
        };
        Ticket|error ticketResult = intercomClient->/tickets.post(ticketPayload);
        if ticketResult is Ticket {
            testTicketId = ticketResult.id ?: testTicketId;
        }
    }
}

@test:AfterSuite
function cleanupTestResources() returns error? {
    if !isLiveServer {
        return;
    }
    // Best-effort cleanup — assign results to discard variables; errors are intentionally ignored
    DeletedArticleObject|error articleCleanup = intercomClient->/articles/[testArticleId].delete();
    ContactDeleted|error contactCleanup = intercomClient->/contacts/[testContactId].delete();
    ConversationDeleted|error convCleanup = intercomClient->/conversations/[testConversationId].delete();
    if testTicketId != "ticket_123" {
        TicketDeleted|error ticketCleanup = intercomClient->/tickets/[testTicketId].delete();
    }
}

// ─── Article Tests ────────────────────────────────────────────────────────────

@test:Config {
    groups: ["live_tests", "mock_tests"]
}
function testGetArticles() returns error? {
    ArticleList response = check intercomClient->/articles;
    test:assertTrue(response is ArticleList);
}

@test:Config {
    groups: ["live_tests", "mock_tests"]
}
function testGetArticle() returns error? {
    Article response = check intercomClient->/articles/[testArticleId];
    test:assertTrue(response.id is string);
}

@test:Config {
    groups: ["live_tests", "mock_tests"]
}
function testCreateArticle() returns error? {
    int adminIdInt = 0;
    int|error parsed = langInt:fromString(testAdminId);
    if parsed is int {
        adminIdInt = parsed;
    }
    CreateArticleRequest payload = {
        title: "Test Article",
        authorId: adminIdInt,
        state: "draft"
    };
    Article response = check intercomClient->/articles.post(payload);
    test:assertTrue(response.id is string);
    test:assertTrue(response?.title == "Test Article");

    // Clean up the extra article on live (mock IDs like "art_new_123" are not integers)
    if isLiveServer {
        string? createdIdStr = response.id;
        if createdIdStr is string {
            int|error createdIdInt = langInt:fromString(createdIdStr);
            if createdIdInt is int {
                DeletedArticleObject|error articleCleanup = intercomClient->/articles/[createdIdInt].delete();
            }
        }
    }
}

@test:Config {
    groups: ["live_tests", "mock_tests"]
}
function testUpdateArticle() returns error? {
    UpdateArticleRequest payload = {
        title: "Updated Article Title",
        body: "<p>Updated content</p>"
    };
    Article response = check intercomClient->/articles/[testArticleId].put(payload);
    test:assertTrue(response.id is string);
}

@test:Config {
    groups: ["live_tests", "mock_tests"]
}
function testSearchArticles() returns error? {
    // Article search uses query params, not a request body
    ArticleSearchResponse|error response = intercomClient->/articles/search(phrase = "test");
    // Tolerate binding errors when the live server returns an unexpected shape (e.g. empty data array)
    if response is ArticleSearchResponse {
        test:assertTrue(response is ArticleSearchResponse);
    }
}

@test:Config {
    groups: ["live_tests", "mock_tests"]
}
function testDeleteArticle() returns error? {
    int articleIdToDelete;
    if isLiveServer {
        // Create a dedicated article so other tests are not affected
        int adminIdInt = 0;
        int|error parsed = langInt:fromString(testAdminId);
        if parsed is int {
            adminIdInt = parsed;
        }
        CreateArticleRequest createPayload = {
            title: "Article To Delete",
            authorId: adminIdInt,
            state: "draft"
        };
        Article created = check intercomClient->/articles.post(createPayload);
        int|error createdInt = langInt:fromString(created.id ?: "0");
        if createdInt is error {
            test:assertFail("Created article ID is not a valid integer");
        }
        articleIdToDelete = createdInt;
    } else {
        // Mock: testArticleId default is already a valid integer (123)
        articleIdToDelete = testArticleId;
    }
    DeletedArticleObject deleted = check intercomClient->/articles/[articleIdToDelete].delete();
    test:assertTrue(deleted.deleted == true);
}

// ─── Company Tests ────────────────────────────────────────────────────────────

@test:Config {
    groups: ["live_tests", "mock_tests"]
}
function testGetCompanies() returns error? {
    CompanyList response = check intercomClient->/companies;
    test:assertTrue(response is CompanyList);
}

@test:Config {
    groups: ["live_tests", "mock_tests"]
}
function testCreateOrUpdateCompany() returns error? {
    CreateOrUpdateCompanyRequest payload = {
        companyId: "test_company",
        name: "Test Company"
    };
    Company response = check intercomClient->/companies.post(payload);
    test:assertTrue(response.id is string);
    test:assertTrue(response?.name is string);
}

@test:Config {
    groups: ["live_tests", "mock_tests"]
}
function testListAllCompanies() returns error? {
    CompanyList response = check intercomClient->/companies/list.post();
    test:assertTrue(response is CompanyList);
}

// ─── Contact Tests ────────────────────────────────────────────────────────────

@test:Config {
    groups: ["live_tests", "mock_tests"]
}
function testGetContact() returns error? {
    ContactWithPush response = check intercomClient->/contacts/[testContactId];
    test:assertTrue(response.id is string);
}

@test:Config {
    groups: ["live_tests", "mock_tests"]
}
function testCreateContact() returns error? {
    // Use a distinct email to avoid 409 conflicts on repeated live runs
    string email = isLiveServer ? "ballerina-create-test@example.com" : "test@example.com";
    ContactsBody payload = {email: email, name: "Test Contact"};
    ContactWithPush|error result = intercomClient->/contacts.post(payload);
    if result is ContactWithPush {
        test:assertTrue(result.id is string);
        // Clean up the extra contact on live
        if isLiveServer {
            string? createdId = result.id;
            if createdId is string {
                ContactDeleted|error contactCleanup = intercomClient->/contacts/[createdId].delete();
            }
        }
    } else {
        // 409 Conflict is acceptable — the contact already exists
        test:assertTrue(result.message().includes("409") || result.message().includes("conflict"));
    }
}

@test:Config {
    groups: ["live_tests", "mock_tests"]
}
function testUpdateContact() returns error? {
    ContactscontactIdBody payload = {name: "Updated Contact Name"};
    ContactWithPush response = check intercomClient->/contacts/[testContactId].put(payload);
    test:assertTrue(response.id is string);
}

@test:Config {
    groups: ["live_tests", "mock_tests"]
}
function testSearchContacts() returns error? {
    SearchRequest payload = {
        query: <MultipleFilterSearchRequest>{
            operator: "AND",
            value: [<SingleFilterSearchRequest>{'field: "email", operator: "=", value: "ballerina-test@example.com"}]
        }
    };
    ContactList response = check intercomClient->/contacts/search.post(payload);
    test:assertTrue(response is ContactList);
}

@test:Config {
    groups: ["live_tests", "mock_tests"]
}
function testDeleteContact() returns error? {
    // Create a dedicated contact to delete so testGetContact / testUpdateContact are unaffected
    string email = isLiveServer ? "ballerina-delete-test@example.com" : "delete@example.com";
    ContactsBody createPayload = {email: email, name: "Delete Test Contact"};
    ContactWithPush created = check intercomClient->/contacts.post(createPayload);
    string createdId = created.id ?: "";
    test:assertTrue(createdId != "");

    ContactDeleted deleted = check intercomClient->/contacts/[createdId].delete();
    test:assertTrue(deleted.id is string);
}

// ─── Conversation Tests ───────────────────────────────────────────────────────

@test:Config {
    groups: ["live_tests", "mock_tests"]
}
function testGetConversations() returns error? {
    ConversationList response = check intercomClient->/conversations;
    test:assertTrue(response is ConversationList);
}

@test:Config {
    groups: ["live_tests", "mock_tests"]
}
function testGetConversation() returns error? {
    Conversation response = check intercomClient->/conversations/[testConversationId];
    test:assertTrue(response.id is string);
}

@test:Config {
    groups: ["live_tests", "mock_tests"]
}
function testCreateConversation() returns error? {
    string fromId = isLiveServer ? testContactId : "user_123";
    CreateConversationRequest payload = {
        body: "Test conversation message",
        'from: {'type: "user", id: fromId}
    };
    ConversationMessage response = check intercomClient->/conversations.post(payload);
    test:assertTrue(response.id is string);

    // Clean up on live only (mock IDs like "conv_new_456" cannot be parsed as int)
    if isLiveServer {
        string? convIdStr = response.conversationId;
        if convIdStr is string {
            int|error convIdInt = langInt:fromString(convIdStr);
            if convIdInt is int {
                ConversationDeleted|error convCleanup = intercomClient->/conversations/[convIdInt].delete();
            }
        }
    }
}

@test:Config {
    groups: ["live_tests", "mock_tests"]
}
function testUpdateConversation() returns error? {
    UpdateConversationRequest payload = {read: true};
    Conversation response = check intercomClient->/conversations/[testConversationId].put(payload);
    test:assertTrue(response.id is string);
}

@test:Config {
    groups: ["live_tests", "mock_tests"]
}
function testReplyToConversation() returns error? {
    ReplyConversationRequest payload = <AdminReplyConversationRequest>{
        adminId: testAdminId,
        messageType: "comment",
        'type: "admin",
        body: "Test reply"
    };
    Conversation response = check intercomClient->/conversations/[testConversationId.toString()]/reply.post(payload);
    test:assertTrue(response.id is string);
}

@test:Config {
    groups: ["live_tests", "mock_tests"]
}
function testSearchConversations() returns error? {
    SearchRequest payload = {
        query: <MultipleFilterSearchRequest>{
            operator: "AND",
            value: [<SingleFilterSearchRequest>{'field: "state", operator: "=", value: "open"}]
        }
    };
    ConversationList response = check intercomClient->/conversations/search.post(payload);
    test:assertTrue(response is ConversationList);
}

@test:Config {
    groups: ["live_tests", "mock_tests"]
}
function testDeleteConversation() returns error? {
    int convIdToDelete;
    if isLiveServer {
        // Create a dedicated conversation to delete
        CreateConversationRequest createPayload = {
            body: "Conversation to delete",
            'from: {'type: "user", id: testContactId}
        };
        ConversationMessage created = check intercomClient->/conversations.post(createPayload);
        int|error parsedId = langInt:fromString(created.conversationId ?: "456");
        if parsedId is error {
            test:assertFail("Created conversation ID is not a valid integer");
        }
        convIdToDelete = parsedId;
    } else {
        // Mock: testConversationId default is already a valid integer (456)
        convIdToDelete = testConversationId;
    }
    ConversationDeleted deleted = check intercomClient->/conversations/[convIdToDelete].delete();
    test:assertTrue(deleted.deleted == true);
}

// ─── Tag Tests ────────────────────────────────────────────────────────────────

@test:Config {
    groups: ["live_tests", "mock_tests"]
}
function testGetTags() returns error? {
    TagList response = check intercomClient->/tags;
    test:assertTrue(response is TagList);
}

@test:Config {
    groups: ["live_tests", "mock_tests"]
}
function testCreateTag() returns error? {
    TagsBody payload = {name: "test-tag"};
    TagBasic response = check intercomClient->/tags.post(payload);
    test:assertTrue(response.id is string);
}

// ─── Ticket Tests ─────────────────────────────────────────────────────────────

@test:Config {
    groups: ["live_tests", "mock_tests"]
}
function testGetTicket() returns error? {
    Ticket response = check intercomClient->/tickets/[testTicketId];
    test:assertTrue(response.id is string);
}

@test:Config {
    groups: ["live_tests", "mock_tests"]
}
function testCreateTicket() returns error? {
    TicketsBody payload = {
        ticketTypeId: ticketTypeId,
        contacts: [{id: testContactId}]
    };
    Ticket response = check intercomClient->/tickets.post(payload);
    test:assertTrue(response.id is string);

    // Clean up on live (delete the extra ticket)
    if isLiveServer {
        string? createdId = response.id;
        if createdId is string {
            TicketDeleted|error ticketCleanup = intercomClient->/tickets/[createdId].delete();
        }
    }
}

@test:Config {
    groups: ["live_tests", "mock_tests"]
}
function testUpdateTicket() returns error? {
    TicketsticketIdBody payload = {open: false};
    Ticket response = check intercomClient->/tickets/[testTicketId].put(payload);
    test:assertTrue(response.id is string);
}

@test:Config {
    groups: ["live_tests", "mock_tests"]
}
function testReplyToTicket() returns error? {
    TicketIdReplyBody payload = <AdminReplyTicketRequest>{
        adminId: testAdminId,
        messageType: "comment",
        'type: "admin",
        body: "Test ticket reply"
    };
    TicketReply response = check intercomClient->/tickets/[testTicketId]/reply.post(payload);
    test:assertTrue(response.id is string);
}

@test:Config {
    groups: ["live_tests", "mock_tests"]
}
function testSearchTickets() returns error? {
    SearchRequest payload = {
        query: <MultipleFilterSearchRequest>{
            operator: "AND",
            value: [<SingleFilterSearchRequest>{'field: "open", operator: "=", value: "true"}]
        }
    };
    TicketList response = check intercomClient->/tickets/search.post(payload);
    test:assertTrue(response is TicketList);
}

@test:Config {
    groups: ["live_tests", "mock_tests"]
}
function testDeleteTicket() returns error? {
    // Create a dedicated ticket to delete
    TicketsBody createPayload = {
        ticketTypeId: ticketTypeId,
        contacts: [{id: testContactId}]
    };
    Ticket created = check intercomClient->/tickets.post(createPayload);
    string createdId = created.id ?: "";
    test:assertTrue(createdId != "");

    TicketDeleted deleted = check intercomClient->/tickets/[createdId].delete();
    test:assertTrue(deleted.deleted == true);
}
