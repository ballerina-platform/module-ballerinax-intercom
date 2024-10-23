// Copyright (c) 2024, WSO2 LLC. (http://www.wso2.com).
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

import ballerina/constraint;
import ballerina/http;

# An object containing location meta data about a Intercom contact.
public type contact_location record {
    # Always location
    string? 'type?;
    # The country that the contact is located in
    string? country?;
    # The overal region that the contact is located in
    string? region?;
    # The city that the contact is located in
    string? city?;
};

# A list of Help Centers belonging to the App
public type help_center_list record {
    # The type of the object - `list`.
    "list" 'type?;
    # An array of Help Center objects
    help_center[] data?;
};

# A list of Ticket Part objects for each note and event in the ticket. There is a limit of 500 parts.
public type ticket_parts record {
    # 
    "ticket_part.list" 'type?;
    # A list of Ticket Part objects for each ticket. There is a limit of 500 parts.
    ticket_part[] ticket_parts?;
    # 
    int total_count?;
};

# Represents the Headers record for the operation: MergeContact
public type MergeContactHeaders record {
    intercom_version Intercom\-Version?;
};

# Represents the Headers record for the operation: convertConversationToTicket
public type ConvertConversationToTicketHeaders record {
    intercom_version Intercom\-Version?;
};

# Response returned when an object is deleted
public type deleted_object record {
    # The unique identifier for the news item which you provided in the URL.
    string id?;
    # The type of object which was deleted - news-item.
    "news-item" 'object?;
    # Whether the news item was deleted successfully or not.
    boolean deleted?;
};

# A News Item is a content type in Intercom enabling you to announce product updates, company news, promotions, events and more with your customers.
public type news_item_request record {
    # The title of the news item.
    string title;
    # The news item body, which may contain HTML.
    string body?;
    # The id of the sender of the news item. Must be a teammate on the workspace.
    int sender_id;
    # News items will not be visible to your users in the assigned newsfeeds until they are set live.
    "draft"|"live" state?;
    # When set to `true`, the news item will appear in the messenger newsfeed without showing a notification badge.
    boolean deliver_silently?;
    # Label names displayed to users to categorize the news item.
    string[] labels?;
    # Ordered list of emoji reactions to the news item. When empty, reactions are disabled.
    string[] reactions?;
    # A list of newsfeed_assignments to assign to the specified newsfeed.
    newsfeed_assignment[] newsfeed_assignments?;
};

# Represents the Headers record for the operation: listCompaniesForAContact
public type ListCompaniesForAContactHeaders record {
    intercom_version Intercom\-Version?;
};

public type create_conversation_request_from record {
    # The role associated to the contact - user or lead.
    "lead"|"user"|"contact" 'type;
    # The identifier for the contact which is given by Intercom.
    @constraint:String {maxLength: 24, minLength: 24}
    string id;
};

# Admin priority levels for the team
public type admin_priority_level record {
    # The primary admin ids for the team
    int[]? primary_admin_ids?;
    # The secondary admin ids for the team
    int[]? secondary_admin_ids?;
};

# Payload to create a contact
public type create_contact_request anydata;

# Represents the Headers record for the operation: updateTicketType
public type UpdateTicketTypeHeaders record {
    intercom_version Intercom\-Version?;
};

# Represents the Queries record for the operation: lisDataEvents
public type LisDataEventsQueries record {
    filter filter;
    # summary flag
    boolean summary?;
    # The value must be user
    string 'type;
};

# The author that wrote or triggered the part. Can be a bot, admin, team or user.
public type ticket_part_author record {
    # The type of the author
    "admin"|"bot"|"team"|"user" 'type?;
    # The id of the author
    string id?;
    # The name of the author
    string? name?;
    # The email of the author
    string email?;
};

# The unique identifiers retained after converting or merging.
public type convert_visitor_request_user anydata;

# Represents the Headers record for the operation: retrieveTeam
public type RetrieveTeamHeaders record {
    intercom_version Intercom\-Version?;
};

# Represents the Headers record for the operation: CreateContact
public type CreateContactHeaders record {
    intercom_version Intercom\-Version?;
};

# This will return a list of companies for the App.
public type company_list record {
    # The type of object - `list`.
    "list" 'type?;
    cursor_pages? pages?;
    # The total number of companies.
    int total_count?;
    # An array containing Company Objects.
    company[] data?;
};

# Represents the Headers record for the operation: cancelDataExport
public type CancelDataExportHeaders record {
    intercom_version Intercom\-Version?;
};

# Conversations are how you can communicate with users in Intercom. They are created when a contact replies to an outbound message, or when one admin directly sends a message to a single contact.
public type create_conversation_request record {
    create_conversation_request_from 'from;
    # The content of the message. HTML is not supported.
    string body;
};

# Represents the Headers record for the operation: ListAttachedContacts
public type ListAttachedContactsHeaders record {
    intercom_version Intercom\-Version?;
};

# Provides a set of configurations for controlling the behaviours when communicating with a remote HTTP endpoint.
@display {label: "Connection Config"}
public type ConnectionConfig record {|
    # Configurations related to client authentication
    http:BearerTokenConfig auth;
    # The HTTP version understood by the client
    http:HttpVersion httpVersion = http:HTTP_2_0;
    # Configurations related to HTTP/1.x protocol
    ClientHttp1Settings http1Settings?;
    # Configurations related to HTTP/2 protocol
    http:ClientHttp2Settings http2Settings?;
    # The maximum time to wait (in seconds) for a response before closing the connection
    decimal timeout = 60;
    # The choice of setting `forwarded`/`x-forwarded` header
    string forwarded = "disable";
    # Configurations associated with request pooling
    http:PoolConfiguration poolConfig?;
    # HTTP caching related configurations
    http:CacheConfig cache?;
    # Specifies the way of handling compression (`accept-encoding`) header
    http:Compression compression = http:COMPRESSION_AUTO;
    # Configurations associated with the behaviour of the Circuit Breaker
    http:CircuitBreakerConfig circuitBreaker?;
    # Configurations associated with retrying
    http:RetryConfig retryConfig?;
    # Configurations associated with inbound response size limits
    http:ResponseLimitConfigs responseLimits?;
    # SSL/TLS-related options
    http:ClientSecureSocket secureSocket?;
    # Proxy server related options
    http:ProxyConfig proxy?;
    # Enables the inbound payload validation functionality which provided by the constraint package. Enabled by default
    boolean validation = true;
|};

# Represents the Queries record for the operation: lisDataAttributes
public type LisDataAttributesQueries record {
    # Include archived attributes in the list. By default we return only non archived data attributes.
    boolean include_archived?;
    # Specify the data attribute model to return.
    "contact"|"company"|"conversation" model?;
};

# App is a workspace on Intercom
public type app record {
    # 
    string 'type = "app";
    # The id of the app.
    string id_code?;
    # The name of the app.
    string name?;
    # The Intercom region the app is located in.
    string region?;
    # The timezone of the region where the app is located.
    string timezone?;
    # When the app was created.
    int created_at?;
    # Whether or not the app uses identity verification.
    boolean identity_verification?;
};

# deleted contact object
public type contact_deleted record {
    # always contact
    "contact" 'type?;
    # The unique identifier for the contact which is given by Intercom.
    string id?;
    # The unique identifier for the contact which is provided by the Client.
    string? external_id?;
    # Whether the contact is deleted or not.
    boolean deleted?;
};

# A list used to access other resources from a parent model.
public type addressable_list record {
    # The addressable object type
    string 'type?;
    # The id of the addressable object
    string id?;
    # Url to get more company resources for this contact
    string url?;
};

# reference to contact object
public type contact_reference record {
    # always contact
    "contact" 'type?;
    # The unique identifier for the contact which is given by Intercom.
    string id?;
    # The unique identifier for the contact which is provided by the Client.
    string? external_id?;
};

# Represents the Queries record for the operation: retrieveCompany
public type RetrieveCompanyQueries record {
    # How many results to display per page. Defaults to 15
    int per_page?;
    # The `company_id` of the company to filter by.
    string company_id?;
    # The `name` of the company to filter by.
    string name?;
    # The `tag_id` of the company to filter by.
    string tag_id?;
    # The page of results to fetch. Defaults to first page
    int page?;
    # The `segment_id` of the company to filter by.
    string segment_id?;
};

# Represents the Headers record for the operation: retrieveCompany
public type RetrieveCompanyHeaders record {
    intercom_version Intercom\-Version?;
};

# Represents the Headers record for the operation: createMessage
public type CreateMessageHeaders record {
    intercom_version Intercom\-Version?;
};

# You can convert a Conversation to a Ticket
public type convert_conversation_to_ticket_request record {
    # The ID of the type of ticket you want to convert the conversation to
    string ticket_type_id;
    ticket_contacts attributes?;
};

# Represents the Headers record for the operation: listTags
public type ListTagsHeaders record {
    intercom_version Intercom\-Version?;
};

# Represents the Headers record for the operation: dataEventSummaries
public type DataEventSummariesHeaders record {
    intercom_version Intercom\-Version?;
};

# Represents the Headers record for the operation: createTicketTypeAttribute
public type CreateTicketTypeAttributeHeaders record {
    intercom_version Intercom\-Version?;
};

# A list of tags objects associated with a conversation
public type tags record {
    # The type of the object
    "tag.list" 'type?;
    # A list of tags objects associated with the conversation.
    tag[] tags?;
};

# Represents the Queries record for the operation: retrieveVisitorWithUserId
public type RetrieveVisitorWithUserIdQueries record {
    # The user_id of the Visitor you want to retrieve.
    string user_id;
};

# This will return a summary of data events for the App.
public type data_event_summary record {
    # The type of the object
    "event.summary" 'type?;
    # The email address of the user
    string email?;
    # The Intercom user ID of the user
    string intercom_user_id?;
    # The user ID of the user
    string user_id?;
    # A summary of data events
    data_event_summary_item[] events?;
};

public type detach_contact_from_conversation_request record {
    # The `id` of the admin who is performing the action.
    string admin_id;
};

public type contacts_body create_contact_request;

# Represents the Headers record for the operation: detachContactFromACompany
public type DetachContactFromACompanyHeaders record {
    intercom_version Intercom\-Version?;
};

# Represents the Headers record for the operation: deleteTag
public type DeleteTagHeaders record {
    intercom_version Intercom\-Version?;
};

# This will return a list of articles for the App.
public type article_list record {
    # The type of the object - `list`.
    "list" 'type?;
    cursor_pages? pages?;
    # A count of the total number of articles.
    int total_count?;
    # An array of Article objects
    article_list_item[] data?;
};

# Represents the Headers record for the operation: retrieveHelpCenter
public type RetrieveHelpCenterHeaders record {
    intercom_version Intercom\-Version?;
};

# Represents the Headers record for the operation: listHelpCenters
public type ListHelpCentersHeaders record {
    intercom_version Intercom\-Version?;
};

# The list of contacts affected by a ticket.
public type ticket_contacts record {
    # always contact.list
    "contact.list" 'type?;
    # The list of contacts affected by this ticket.
    contact_reference[] contacts?;
};

# Represents the Headers record for the operation: ListAttachedSegmentsForCompanies
public type ListAttachedSegmentsForCompaniesHeaders record {
    intercom_version Intercom\-Version?;
};

public type customer_request record {string intercom_user_id;}|record {string user_id;}|record {string email;}?;

public type id_reply_body contact_reply_ticket_request|admin_reply_ticket_request;

# Represents the Headers record for the operation: createNewsItem
public type CreateNewsItemHeaders record {
    intercom_version Intercom\-Version?;
};

public type tags_id_body_1 record {
    # The unique identifier for the admin which is given by Intercom.
    string admin_id;
};

# Represents the Queries record for the operation: updateConversation
public type UpdateConversationQueries record {
    # Set to plaintext to retrieve conversation messages in plain text.
    string display_as?;
};

# A list of segments objects attached to a specific contact.
public type contact_segments record {
    # The type of the object
    "list" 'type?;
    # Segment objects associated with the contact.
    segment[] data?;
};

# Represents the Headers record for the operation: detachContactFromConversation
public type DetachContactFromConversationHeaders record {
    intercom_version Intercom\-Version?;
};

# Data related to AI Agent involvement in the conversation.
public type ai_agent record {
    # The type of the source that triggered AI Agent involvement in the conversation.
    "essentials_plan_setup"|"profile"|"workflow"|"workflow_preview"|"fin_preview" source_type?;
    # The title of the source that triggered AI Agent involvement in the conversation. If this is `essentials_plan_setup` then it will return `null`.
    string? source_title?;
    # The type of the last answer delivered by AI Agent. If no answer was delivered then this will return `null`
    "ai_answer"|"custom_answer"? last_answer_type?;
    # The resolution state of AI Agent. If no AI or custom answer has been delivered then this will return `null`.
    "assumed_resolution"|"confirmed_resolution"|"routed_to_team"|"abandoned"? resolution_state?;
    # The customer satisfaction rating given to AI Agent, from 1-5.
    int? rating?;
    # The customer satisfaction rating remark given to AI Agent.
    string? rating_remark?;
    content_sources_list content_sources?;
};

# Represents the Headers record for the operation: autoAssignConversation
public type AutoAssignConversationHeaders record {
    intercom_version Intercom\-Version?;
};

public type tag_multiple_users_request_users record {
    # The Intercom defined id representing the user.
    string id?;
};

public type contacts_id_body update_contact_request;

# A list of tags objects in the workspace.
public type tag_list record {
    # The type of the object
    "list" 'type?;
    # A list of tags objects associated with the workspace .
    tag[] data?;
};

public type tags_id_body record {
    # The unique identifier for the admin which is given by Intercom.
    string admin_id;
};

# Represents the Headers record for the operation: downloadDataExport
public type DownloadDataExportHeaders record {
    intercom_version Intercom\-Version?;
};

# Represents the Headers record for the operation: listSegmentsForAContact
public type ListSegmentsForAContactHeaders record {
    intercom_version Intercom\-Version?;
};

# Represents the Headers record for the operation: listTeams
public type ListTeamsHeaders record {
    intercom_version Intercom\-Version?;
};

# Payload of the request to assign a conversation
public type assign_conversation_request record {
    "assignment" message_type;
    "admin"|"team" 'type;
    # The id of the admin who is performing the action.
    string admin_id;
    # The `id` of the `admin` or `team` which will be assigned the conversation. A conversation can be assigned both an admin and a team.\nSet `0` if you want this assign to no admin or team (ie. Unassigned).
    string assignee_id;
    # Optionally you can send a response in the conversation when it is assigned.
    string body?;
};

# Represents the Headers record for the operation: listNewsItems
public type ListNewsItemsHeaders record {
    intercom_version Intercom\-Version?;
};

# Represents the Queries record for the operation: listAllCompanies
public type ListAllCompaniesQueries record {
    # How many results to return per page. Defaults to 15
    int per_page?;
    # The page of results to fetch. Defaults to first page
    int page?;
    # `asc` or `desc`. Return the companies in ascending or descending order. Defaults to desc
    string 'order?;
};

# This will return a summary of a data event for the App.
public type data_event_summary_item record {
    # The name of the event
    string name?;
    # The first time the event was sent
    string first?;
    # The last time the event was sent
    string last?;
    # The number of times the event was sent
    int count?;
    # The description of the event
    string description?;
};

# Represents the Headers record for the operation: convertVisitor
public type ConvertVisitorHeaders record {
    intercom_version Intercom\-Version?;
};

# Teams are groups of admins in Intercom.
public type team record {
    # Value is always "team"
    string 'type?;
    # The id of the team
    string id?;
    # The name of the team
    string name?;
    # The list of admin IDs that are a part of the team.
    int[] admin_ids?;
    admin_priority_level? admin_priority_level?;
};

# Represents the Headers record for the operation: listAdmins
public type ListAdminsHeaders record {
    intercom_version Intercom\-Version?;
};

public type content_sources_list record {
    "content_source.list" 'type?;
    # The total number of content sources used by AI Agent in the conversation.
    int total_count?;
    # The content sources used by AI Agent in the conversation.
    content_source[] content_sources?;
};

# The list of contacts (users or leads) involved in this conversation. This will only contain one customer unless more were added via the group conversation feature.
public type conversation_contacts record {
    # 
    "contact.list" 'type?;
    # The list of contacts (users or leads) involved in this conversation. This will only contain one customer unless more were added via the group conversation feature.
    contact_reference[] contacts?;
};

# Represents the Headers record for the operation: getTicket
public type GetTicketHeaders record {
    intercom_version Intercom\-Version?;
};

# Represents the Headers record for the operation: searchArticles
public type SearchArticlesHeaders record {
    intercom_version Intercom\-Version?;
};

public type untag_company_request_companies record {
    # The Intercom defined id representing the company.
    string id?;
    # The company id you have defined for the company.
    string company_id?;
    # Always set to true
    boolean untag?;
};

# Help Centers contain collections
public type help_center record {
    # The unique identifier for the Help Center which is given by Intercom.
    string id?;
    # The id of the workspace which the Help Center belongs to.
    string workspace_id?;
    # The time when the Help Center was created.
    int created_at?;
    # The time when the Help Center was last updated.
    int updated_at?;
    # The identifier of the Help Center. This is used in the URL of the Help Center.
    string identifier?;
    # Whether the Help Center is turned on or not. This is controlled in your Help Center settings.
    boolean website_turned_on?;
    # The display name of the Help Center only seen by teammates.
    string display_name?;
};

# Search using Intercoms Search APIs.
public type search_request record {
    single_filter_search_request|multiple_filter_search_request query;
    starting_after_paging? pagination?;
};

# Represents the Headers record for the operation: createTicket
public type CreateTicketHeaders record {
    intercom_version Intercom\-Version?;
};

# Provides settings related to HTTP/1.x protocol.
public type ClientHttp1Settings record {|
    # Specifies whether to reuse a connection for multiple requests
    http:KeepAlive keepAlive = http:KEEPALIVE_AUTO;
    # The chunking behaviour of the request
    http:Chunking chunking = http:CHUNKING_AUTO;
    # Proxy server related options
    ProxyConfig proxy?;
|};

# archived contact object
public type contact_archived record {
    # always contact
    "contact" 'type?;
    # The unique identifier for the contact which is given by Intercom.
    string id?;
    # The unique identifier for the contact which is provided by the Client.
    string? external_id?;
    # Whether the contact is archived or not.
    boolean archived?;
};

# Represents the Headers record for the operation: detachTagFromConversation
public type DetachTagFromConversationHeaders record {
    intercom_version Intercom\-Version?;
};

# Tickets are how you track requests from your users.
public type ticket_list record {
    # Always ticket.list
    "ticket.list" 'type?;
    # The list of ticket objects
    ticket[] tickets?;
    # A count of the total number of objects.
    int total_count?;
    cursor_pages? pages?;
};

# The results of an Article search
public type article_search_response record {
    # The type of the object - `list`.
    "list" 'type?;
    # The total number of Articles matching the search query
    int total_count?;
    article_search_response_data data?;
    cursor_pages? pages?;
};

# Represents the Headers record for the operation: updateVisitor
public type UpdateVisitorHeaders record {
    intercom_version Intercom\-Version?;
};

# Represents the Headers record for the operation: listTicketTypes
public type ListTicketTypesHeaders record {
    intercom_version Intercom\-Version?;
};

# Payload of the request to reply on behalf of a contact using their `intercom_user_id`
public type contact_reply_ticket_intercom_user_id_request contact_reply_base_request;

# Represents the Headers record for the operation: createDataExport
public type CreateDataExportHeaders record {
    intercom_version Intercom\-Version?;
};

# An object containing social profiles that a contact has.
public type contact_social_profiles record {
    # A list of social profiles objects associated with the contact.
    social_profile[] data?;
};

# Companies allow you to represent organizations using your product. Each company will have its own description and be associated with contacts. You can fetch, create, update and list companies.
public type company_scroll record {
    # The type of object - `list`
    "list" 'type?;
    company[] data?;
    cursor_pages? pages?;
    # The total number of companies
    int? total_count?;
    # The scroll parameter to use in the next request to fetch the next page of results.
    string scroll_param?;
};

# The SLA Applied object contains the details for which SLA has been applied to this conversation.
# Important: if there are any canceled sla_events for the conversation - meaning an SLA has been manually removed from a conversation, the sla_status will always be returned as null.
public type sla_applied record {
    # object type
    string 'type?;
    # The name of the SLA as given by the teammate when it was created.
    string sla_name?;
    # SLA statuses:
    #             - `hit`: If there’s at least one hit event in the underlying sla_events table, and no “missed” or “canceled” events for the conversation.
    #             - `missed`: If there are any missed sla_events for the conversation and no canceled events. If there’s even a single missed sla event, the status will always be missed. A missed status is not applied when the SLA expires, only the next time a teammate replies.
    #             - `active`: An SLA has been applied to a conversation, but has not yet been fulfilled. SLA status is active only if there are no “hit, “missed”, or “canceled” events.
    "hit"|"missed"|"cancelled"|"active" sla_status?;
};

# A list of admins associated with a given workspace.
public type admin_list record {
    # String representing the object's type. Always has the value `admin.list`.
    string 'type?;
    # A list of admins associated with a given workspace.
    admin[] admins?;
};

public type company_plan record {
    # Value is always "plan"
    string 'type?;
    # The id of the plan
    string id?;
    # The name of the plan
    string name?;
};

# Represents the Headers record for the operation: updateTicketTypeAttribute
public type UpdateTicketTypeAttributeHeaders record {
    intercom_version Intercom\-Version?;
};

# Represents the Headers record for the operation: retrieveArticle
public type RetrieveArticleHeaders record {
    intercom_version Intercom\-Version?;
};

# Represents the Headers record for the operation: createDataEvent
public type CreateDataEventHeaders record {
    intercom_version Intercom\-Version?;
};

# Represents the Headers record for the operation: attachContactToConversation
public type AttachContactToConversationHeaders record {
    intercom_version Intercom\-Version?;
};

# This object represents the avatar associated with the admin.
public type admin_with_app_avatar record {
    # This is a string that identifies the type of the object. It will always have the value `avatar`.
    string 'type = "avatar";
    # This object represents the avatar associated with the admin.
    string? image_url?;
};

# A segment is a group of your contacts defined by the rules that you set.
public type segment record {
    # The type of object.
    "segment" 'type?;
    # The unique identifier representing the segment.
    string id?;
    # The name of the segment.
    string name?;
    # The time the segment was created.
    int created_at?;
    # The time the segment was updated.
    int updated_at?;
    # Type of the contact: contact (lead) or user.
    "contact"|"user" person_type?;
    # The number of items in the user segment. It's returned when `include_count=true` is included in the request.
    int? count?;
};

# Contact are the objects that represent your leads and users in Intercom.
public type contact record {
    # The type of object.
    string 'type?;
    # The unique identifier for the contact which is given by Intercom.
    string id?;
    # The unique identifier for the contact which is provided by the Client.
    string? external_id?;
    # The id of the workspace which the contact belongs to.
    string workspace_id?;
    # The role of the contact.
    string role?;
    # The contact's email.
    string email?;
    # The contact's email domain.
    string email_domain?;
    # The contacts phone.
    string? phone?;
    # The contacts phone number normalized to the E164 format
    string? formatted_phone?;
    # The contacts name.
    string? name?;
    # The id of an admin that has been assigned account ownership of the contact.
    int? owner_id?;
    # Whether the contact has had an email sent to them hard bounce.
    boolean has_hard_bounced?;
    # Whether the contact has marked an email sent to them as spam.
    boolean marked_email_as_spam?;
    # Whether the contact is unsubscribed from emails.
    boolean unsubscribed_from_emails?;
    # (UNIX timestamp) The time when the contact was created.
    int created_at?;
    # (UNIX timestamp) The time when the contact was last updated.
    int updated_at?;
    # (UNIX timestamp) The time specified for when a contact signed up.
    int? signed_up_at?;
    # (UNIX timestamp) The time when the contact was last seen (either where the Intercom Messenger was installed or when specified manually).
    int? last_seen_at?;
    # (UNIX timestamp) The time when the contact last messaged in.
    int? last_replied_at?;
    # (UNIX timestamp) The time when the contact was last messaged.
    int? last_contacted_at?;
    # (UNIX timestamp) The time when the contact last opened an email.
    int? last_email_opened_at?;
    # (UNIX timestamp) The time when the contact last clicked a link in an email.
    int? last_email_clicked_at?;
    # A preferred language setting for the contact, used by the Intercom Messenger even if their browser settings change.
    string? language_override?;
    # The name of the browser which the contact is using.
    string? browser?;
    # The version of the browser which the contact is using.
    string? browser_version?;
    # The language set by the browser which the contact is using.
    string? browser_language?;
    # The operating system which the contact is using.
    string? os?;
    # The name of the Android app which the contact is using.
    string? android_app_name?;
    # The version of the Android app which the contact is using.
    string? android_app_version?;
    # The Android device which the contact is using.
    string? android_device?;
    # The version of the Android OS which the contact is using.
    string? android_os_version?;
    # The version of the Android SDK which the contact is using.
    string? android_sdk_version?;
    # (UNIX timestamp) The time when the contact was last seen on an Android device.
    int? android_last_seen_at?;
    # The name of the iOS app which the contact is using.
    string? ios_app_name?;
    # The version of the iOS app which the contact is using.
    string? ios_app_version?;
    # The iOS device which the contact is using.
    string? ios_device?;
    # The version of iOS which the contact is using.
    string? ios_os_version?;
    # The version of the iOS SDK which the contact is using.
    string? ios_sdk_version?;
    # (UNIX timestamp) The last time the contact used the iOS app.
    int? ios_last_seen_at?;
    # The custom attributes which are set for the contact.
    record {} custom_attributes?;
    contact_avatar? avatar?;
    contact_tags? tags?;
    contact_notes notes?;
    contact_companies companies?;
    contact_location location?;
    contact_social_profiles social_profiles?;
};

# Represents the Headers record for the operation: retrieveConversation
public type RetrieveConversationHeaders record {
    intercom_version Intercom\-Version?;
};

# A list of ticket types associated with a given workspace.
public type ticket_type_list record {
    # String representing the object's type. Always has the value `ticket_type.list`.
    string 'type?;
    # A list of ticket_types associated with a given workspace.
    ticket_type[] ticket_types?;
};

public type update_ticket_request_assignment record {
    # The ID of the admin performing the action.
    string admin_id?;
    # The ID of the admin or team to which the ticket is assigned. Set this 0 to unassign it.
    string assignee_id?;
};

# Conversations are how you can communicate with users in Intercom. They are created when a contact replies to an outbound message, or when one admin directly sends a message to a single contact.
public type conversation record {
    # Always conversation.
    string 'type?;
    # The id representing the conversation.
    string id?;
    # The title given to the conversation.
    string? title?;
    # The time the conversation was created.
    int created_at?;
    # The last time the conversation was updated.
    int updated_at?;
    # The last time a Contact responded to an Admin. In other words, the time a customer started waiting for a response. Set to null if last reply is from an Admin.
    int? waiting_since?;
    # If set this is the time in the future when this conversation will be marked as open. i.e. it will be in a snoozed state until this time. i.e. it will be in a snoozed state until this time.
    int? snoozed_until?;
    # Indicates whether a conversation is open (true) or closed (false).
    boolean open?;
    # Can be set to "open", "closed" or "snoozed".
    "open"|"closed"|"snoozed" state?;
    # Indicates whether a conversation has been read.
    boolean read?;
    # If marked as priority, it will return priority or else not_priority.
    "priority"|"not_priority" priority?;
    # The id of the admin assigned to the conversation. If it's not assigned to an admin it will return null.
    int? admin_assignee_id?;
    # The id of the team assigned to the conversation. If it's not assigned to a team it will return null.
    string? team_assignee_id?;
    tags tags?;
    conversation_rating? conversation_rating?;
    conversation_source 'source?;
    conversation_contacts contacts?;
    conversation_teammates? teammates?;
    custom_attributes custom_attributes?;
    conversation_first_contact_reply? first_contact_reply?;
    sla_applied? sla_applied?;
    conversation_statistics? statistics?;
    conversation_parts conversation_parts?;
    linked_object_list linked_objects?;
    # Indicates whether the AI Agent participated in the conversation.
    boolean ai_agent_participated?;
    ai_agent ai_agent?;
};

# Represents the Headers record for the operation: attachTagToTicket
public type AttachTagToTicketHeaders record {
    intercom_version Intercom\-Version?;
};

# Represents the Headers record for the operation: deleteNewsItem
public type DeleteNewsItemHeaders record {
    intercom_version Intercom\-Version?;
};

# Collections are top level containers for Articles within the Help Center.
public type collection record {
    # The unique identifier for the collection which is given by Intercom.
    string id?;
    # The id of the workspace which the collection belongs to.
    string workspace_id?;
    # The name of the collection. For multilingual collections, this will be the name of the default language's content.
    string name?;
    # The description of the collection. For multilingual help centers, this will be the description of the collection for the default language.
    string? description?;
    # The time when the article was created (seconds). For multilingual articles, this will be the timestamp of creation of the default language's content.
    int created_at?;
    # The time when the article was last updated (seconds). For multilingual articles, this will be the timestamp of last update of the default language's content.
    int updated_at?;
    # The URL of the collection. For multilingual help centers, this will be the URL of the collection for the default language.
    string? url?;
    # The icon of the collection.
    string? icon?;
    # The order of the section in relation to others sections within a collection. Values go from `0` upwards. `0` is the default if there's no order.
    int 'order?;
    # The default locale of the help center. This field is only returned for multilingual help centers.
    string default_locale?;
    group_translated_content? translated_content?;
    # The id of the parent collection. If `null` then it is the first level collection.
    string? parent_id?;
    # The id of the help center the collection is in.
    int? help_center_id?;
};

# Represents the Headers record for the operation: listTagsForAContact
public type ListTagsForAContactHeaders record {
    intercom_version Intercom\-Version?;
};

# This will return a list of Collections for the App.
public type collection_list record {
    # The type of the object - `list`.
    "list" 'type?;
    cursor_pages? pages?;
    # A count of the total number of collections.
    int total_count?;
    # An array of collection objects
    collection[] data?;
};

# The Articles API is a central place to gather all information and take actions on your articles. Articles can live within collections and sections, or alternatively they can stand alone.
public type article article_list_item;

# You can create or update a Company
public type create_or_update_company_request record {
    # The name of the Company
    string name?;
    # The company id you have defined for the company. Can't be updated
    string company_id?;
    # The name of the plan you have associated with the company.
    string plan?;
    # The number of employees in this company.
    int size?;
    # The URL for this company's website. Please note that the value specified here is not validated. Accepts any string.
    string website?;
    # The industry that this company operates in.
    string industry?;
    # A hash of key/value pairs containing any other data about the company you want Intercom to store.
    record {|string...;|} custom_attributes?;
    # The time the company was created by you.
    int remote_created_at?;
    # How much revenue the company generates for your business. Note that this will truncate floats. i.e. it only allow for whole integers, 155.98 will be truncated to 155. Note that this has an upper limit of 2**31-1 or 2147483647..
    int monthly_spend?;
};

# An object containing information on the first users message. For a contact initiated message this will represent the users original message.
public type conversation_first_contact_reply record {
    # 
    int created_at?;
    # 
    string 'type?;
    # 
    string? url?;
};

# Represents the Headers record for the operation: scrollOverAllCompanies
public type ScrollOverAllCompaniesHeaders record {
    intercom_version Intercom\-Version?;
};

# Represents the Queries record for the operation: scrollOverAllCompanies
public type ScrollOverAllCompaniesQueries record {
    # 
    string scroll_param?;
};

# You can tag a single company or a list of companies.
public type untag_company_request record {
    # The name of the tag which will be untagged from the company
    string name;
    # The id or company_id of the company can be passed as input parameters.
    untag_company_request_companies[] companies;
};

# Represents the Headers record for the operation: listConversations
public type ListConversationsHeaders record {
    intercom_version Intercom\-Version?;
};

# Payload of the request to reply on behalf of a contact using their `email`
public type contact_reply_email_request contact_reply_base_request;

# A subscription type lets customers easily opt out of non-essential communications without missing what's important to them.
public type subscription_type record {
    # The type of the object - subscription
    string 'type?;
    # The unique identifier representing the subscription type.
    string id?;
    # The state of the subscription type.
    "live"|"draft"|"archived" state?;
    translation default_translation?;
    # An array of translations objects with the localised version of the subscription type in each available locale within your translation settings.
    translation[] translations?;
    # Describes the type of consent.
    "opt_out"|"opt_in" consent_type?;
    # The message types that this subscription supports - can contain `email` or `sms_message`.
    ("email"|"sms_message")[] content_types?;
};

# Represents the Headers record for the operation: redactConversation
public type RedactConversationHeaders record {
    intercom_version Intercom\-Version?;
};

# Represents the Headers record for the operation: getDataExport
public type GetDataExportHeaders record {
    intercom_version Intercom\-Version?;
};

# You can tag a single company or a list of companies.
public type tag_company_request record {
    # The name of the tag, which will be created if not found.
    string name;
    # The id or company_id of the company can be passed as input parameters.
    tag_company_request_companies[] companies;
};

# A paginated list of activity logs.
public type activity_log_list record {
    # String representing the object's type. Always has the value `activity_log.list`.
    string 'type?;
    cursor_pages? pages?;
    # An array of activity logs
    activity_log[] activity_logs?;
};

# This will return a list of team objects for the App.
public type team_list record {
    # The type of the object
    "team.list" 'type?;
    # A list of team objects
    team[] teams?;
};

# Represents the Headers record for the operation: ArchiveContact
public type ArchiveContactHeaders record {
    intercom_version Intercom\-Version?;
};

# An object containing companies meta data about the companies that a contact has. Up to 10 will be displayed here. Use the url to get more.
public type contact_companies record {
    # Url to get more company resources for this contact
    string url?;
    # Int representing the total number of companyies attached to this contact
    int total_count?;
    # Whether there's more Addressable Objects to be viewed. If true, use the url to view all
    boolean has_more?;
};

# Admins are teammate accounts that have access to a workspace.
public type admin record {
    # String representing the object's type. Always has the value `admin`.
    string 'type?;
    # The id representing the admin.
    string id?;
    # The name of the admin.
    string name?;
    # The email of the admin.
    string email?;
    # The job title of the admin.
    string job_title?;
    # Identifies if this admin is currently set in away mode.
    boolean away_mode_enabled?;
    # Identifies if this admin is set to automatically reassign new conversations to the apps default inbox.
    boolean away_mode_reassign?;
    # Identifies if this admin has a paid inbox seat to restrict/allow features that require them.
    boolean has_inbox_seat?;
    # This object represents the avatar associated with the admin.
    int[] team_ids?;
    # Image for the associated team or teammate
    string? avatar?;
    team_priority_level? team_priority_level?;
};

# Represents the Headers record for the operation: createTag
public type CreateTagHeaders record {
    intercom_version Intercom\-Version?;
};

# A Ticket Part represents a message in the ticket.
public type ticket_part record {
    # Always ticket_part
    string 'type?;
    # The id representing the ticket part.
    string id?;
    # The type of ticket part.
    string part_type?;
    # The message body, which may contain HTML.
    string? body?;
    # The previous state of the ticket.
    "submitted"|"in_progress"|"waiting_on_customer"|"resolved" previous_ticket_state?;
    # The state of the ticket.
    "submitted"|"in_progress"|"waiting_on_customer"|"resolved" ticket_state?;
    # The time the ticket part was created.
    int created_at?;
    # The last time the ticket part was updated.
    int updated_at?;
    reference assigned_to?;
    ticket_part_author author?;
    # A list of attachments for the part.
    part_attachment[] attachments?;
    # The external id of the ticket part
    string? external_id?;
    # Whether or not the ticket part has been redacted.
    boolean redacted?;
};

# The list of segments associated with the company
public type company_segments record {
    # The type of the object
    "segment.list" 'type?;
    segment[] segments?;
};

# Represents the Headers record for the operation: attachSubscriptionTypeToContact
public type AttachSubscriptionTypeToContactHeaders record {
    intercom_version Intercom\-Version?;
};

public type contact_id_tags_body record {
    # The unique identifier for the tag which is given by Intercom
    string id;
};

# Cursor-based pagination is a technique used in the Intercom API to navigate through large amounts of data.
# A "cursor" or pointer is used to keep track of the current position in the result set, allowing the API to return the data in small chunks or "pages" as needed.
public type cursor_pages record {
    # the type of object `pages`.
    "pages" 'type?;
    # The current page
    int page?;
    starting_after_paging? next?;
    # Number of results per page
    int per_page?;
    # Total number of pages
    int total_pages?;
};

# You can create a collection
public type create_collection_request record {
    # The name of the collection. For multilingual collections, this will be the name of the default language's content.
    string name;
    # The description of the collection. For multilingual collections, this will be the description of the default language's content.
    string description?;
    group_translated_content? translated_content?;
    # The id of the parent collection. If `null` then it will be created as the first level collection.
    string? parent_id?;
    # The id of the help center where the collection will be created. If `null` then it will be created in the default help center.
    int? help_center_id?;
};

# Represents the Headers record for the operation: UnarchiveContact
public type UnarchiveContactHeaders record {
    intercom_version Intercom\-Version?;
};

# You can update a collection
public type update_collection_request record {
    # The name of the collection. For multilingual collections, this will be the name of the default language's content.
    string name?;
    # The description of the collection. For multilingual collections, this will be the description of the default language's content.
    string description?;
    group_translated_content? translated_content?;
    # The id of the parent collection. If `null` then it will be updated as the first level collection.
    string? parent_id?;
};

# The data returned about your articles when you list them.
public type article_list_item record {
    # The type of object - `article`.
    "article" 'type = "article";
    # The unique identifier for the article which is given by Intercom.
    string id?;
    # The id of the workspace which the article belongs to.
    string workspace_id?;
    # The title of the article. For multilingual articles, this will be the title of the default language's content.
    string title?;
    # The description of the article. For multilingual articles, this will be the description of the default language's content.
    string? description?;
    # The body of the article in HTML. For multilingual articles, this will be the body of the default language's content.
    string? body?;
    # The id of the author of the article. For multilingual articles, this will be the id of the author of the default language's content. Must be a teammate on the help center's workspace.
    int author_id?;
    # Whether the article is `published` or is a `draft`. For multilingual articles, this will be the state of the default language's content.
    "published"|"draft" state = "draft";
    # The time when the article was created. For multilingual articles, this will be the timestamp of creation of the default language's content in seconds.
    int created_at?;
    # The time when the article was last updated. For multilingual articles, this will be the timestamp of last update of the default language's content in seconds.
    int updated_at?;
    # The URL of the article. For multilingual articles, this will be the URL of the default language's content.
    string? url?;
    # The id of the article's parent collection or section. An article without this field stands alone.
    int? parent_id?;
    # The ids of the article's parent collections or sections. An article without this field stands alone.
    int[] parent_ids?;
    # The type of parent, which can either be a `collection` or `section`.
    string? parent_type?;
    # The default locale of the help center. This field is only returned for multilingual help centers.
    string default_locale?;
    article_translated_content? translated_content?;
};

# Companies allow you to represent organizations using your product. Each company will have its own description and be associated with contacts. You can fetch, create, update and list companies.
public type company record {
    # Value is `company`
    "company" 'type?;
    # The Intercom defined id representing the company.
    string id?;
    # The name of the company.
    string name?;
    # The Intercom defined code of the workspace the company is associated to.
    string app_id?;
    company_plan plan?;
    # The company id you have defined for the company.
    string company_id?;
    # The time the company was created by you.
    int remote_created_at?;
    # The time the company was added in Intercom.
    int created_at?;
    # The last time the company was updated.
    int updated_at?;
    # The time the company last recorded making a request.
    int last_request_at?;
    # The number of employees in the company.
    int size?;
    # The URL for the company website.
    string website?;
    # The industry that the company operates in.
    string industry?;
    # How much revenue the company generates for your business.
    int monthly_spend?;
    # How many sessions the company has recorded.
    int session_count?;
    # The number of users in the company.
    int user_count?;
    # The custom attributes you have set on the company.
    record {|string...;|} custom_attributes?;
    company_tags tags?;
    company_segments segments?;
};

# You can create a Ticket Type Attribute
public type create_ticket_type_attribute_request record {
    # The name of the ticket type attribute
    string name;
    # The description of the attribute presented to the teammate or contact
    string description;
    # The data type of the attribute
    "string"|"list"|"integer"|"decimal"|"boolean"|"datetime"|"files" data_type;
    # Whether the attribute is required to be filled in when teammates are creating the ticket in Inbox.
    boolean required_to_create = false;
    # Whether the attribute is required to be filled in when contacts are creating the ticket in Messenger.
    boolean required_to_create_for_contacts = false;
    # Whether the attribute is visible to teammates when creating a ticket in Inbox.
    boolean visible_on_create = true;
    # Whether the attribute is visible to contacts when creating a ticket in Messenger.
    boolean visible_to_contacts = true;
    # Whether the attribute allows multiple lines of text (only applicable to string attributes)
    boolean multiline?;
    # A comma delimited list of items for the attribute value (only applicable to list attributes)
    string list_items?;
    # Whether the attribute allows multiple files to be attached to it (only applicable to file attributes)
    boolean allow_multiple_values?;
};

# Response returned when an object is deleted
public type deleted_company_object record {
    # The unique identifier for the company which is given by Intercom.
    string id?;
    # The type of object which was deleted. - `company`
    "company" 'object?;
    # Whether the company was deleted successfully or not.
    boolean deleted?;
};

# Represents the Headers record for the operation: retrieveCollection
public type RetrieveCollectionHeaders record {
    intercom_version Intercom\-Version?;
};

# Tickets are how you track requests from your users.
public type ticket record {
    # Always ticket
    "ticket" 'type = "ticket";
    # The unique identifier for the ticket which is given by Intercom.
    string id?;
    # The ID of the Ticket used in the Intercom Inbox and Messenger. Do not use ticket_id for API queries.
    string ticket_id?;
    # Category of the Ticket.
    "Customer"|"Back-office"|"Tracker" category?;
    ticket_contacts ticket_attributes?;
    # The state the ticket is currently in
    "submitted"|"in_progress"|"waiting_on_customer"|"resolved" ticket_state?;
    ticket_type? ticket_type?;
    ticket_contacts contacts?;
    # The id representing the admin assigned to the ticket.
    string admin_assignee_id?;
    # The id representing the team assigned to the ticket.
    string team_assignee_id?;
    # The time the ticket was created as a UTC Unix timestamp.
    int created_at?;
    # The last time the ticket was updated as a UTC Unix timestamp.
    int updated_at?;
    # Whether or not the ticket is open. If false, the ticket is closed.
    boolean open?;
    # The time the ticket will be snoozed until as a UTC Unix timestamp. If null, the ticket is not currently snoozed.
    int snoozed_until?;
    linked_object_list linked_objects?;
    ticket_parts ticket_parts?;
    # Whether or not the ticket is shared with the customer.
    boolean is_shared?;
    # The state the ticket is currently in, in a human readable form - visible in Intercom
    string ticket_state_internal_label?;
    # The state the ticket is currently in, in a human readable form - visible to customers, in the messenger, email and tickets portal.
    string ticket_state_external_label?;
};

public type tag_company_request_companies record {
    # The Intercom defined id representing the company.
    string id?;
    # The company id you have defined for the company.
    string company_id?;
};

# Intercom API version.</br>By default, it's equal to the version set in the app package.
public type intercom_version "1.0"|"1.1"|"1.2"|"1.3"|"1.4"|"2.0"|"2.1"|"2.2"|"2.3"|"2.4"|"2.5"|"2.6"|"2.7"|"2.8"|"2.9"|"2.10"|"2.11"|"Unstable";

# Represents the Headers record for the operation: createTicketType
public type CreateTicketTypeHeaders record {
    intercom_version Intercom\-Version?;
};

# A paginated list of notes associated with a contact.
public type note_list record {
    # String representing the object's type. Always has the value `list`.
    string 'type?;
    # An array of notes.
    note[] data?;
    # A count of the total number of notes.
    int total_count?;
    cursor_pages? pages?;
};

# Message are how you reach out to contacts in Intercom. They are created when an admin sends an outbound message to a contact.
public type message record {
    # The type of the message
    string 'type;
    # The id representing the message.
    string id;
    # The time the conversation was created.
    int created_at;
    # The subject of the message. Only present if message_type: email.
    string subject?;
    # The message body, which may contain HTML.
    string body;
    # The type of message that was sent. Can be email, inapp, facebook or twitter.
    "email"|"inapp"|"facebook"|"twitter" message_type;
    # The associated conversation_id
    string conversation_id?;
};

# Represents the Headers record for the operation: listAllCompanies
public type ListAllCompaniesHeaders record {
    intercom_version Intercom\-Version?;
};

# An object containing tags meta data about the tags that a contact has. Up to 10 will be displayed here. Use the url to get more.
public type contact_tags record {
    # This object represents the tags attached to a contact.
    addressable_list[] data?;
    # url to get more tag resources for this contact
    string url?;
    # Int representing the total number of tags attached to this contact
    int total_count?;
    # Whether there's more Addressable Objects to be viewed. If true, use the url to view all
    boolean has_more?;
};

# The highlighted results of an Article search. In the examples provided my search query is always "my query".
public type article_search_highlights record {
    # The ID of the corresponding article.
    string article_id?;
    # An Article title highlighted.
    article_search_highlights_highlighted_title[] highlighted_title?;
    # An Article description and body text highlighted.
    record {"highlight"|"plain" 'type?; string text?;}[][] highlighted_summary?;
};

# A list of subscription type objects.
public type subscription_type_list record {
    # The type of the object
    "list" 'type?;
    # A list of subscription type objects associated with the workspace .
    subscription_type[] data?;
};

# Represents the Queries record for the operation: searchArticles
public type SearchArticlesQueries record {
    # Return a highlighted version of the matching content within your articles. Refer to the response schema for more details.
    boolean highlight?;
    # The phrase within your articles to search for.
    string phrase?;
    # The ID of the Help Center to search in.
    int help_center_id?;
    # The state of the Articles returned. One of `published`, `draft` or `all`.
    string state?;
};

# A translation object contains the localised details of a subscription type.
public type translation record {
    # The localised name of the subscription type.
    string name?;
    # The localised description of the subscription type.
    string description?;
    # The two character identifier for the language of the translation object.
    string locale?;
};

# Represents the Headers record for the operation: attachTagToContact
public type AttachTagToContactHeaders record {
    intercom_version Intercom\-Version?;
};

# Update an existing visitor.
public type update_visitor_request anydata;

# The data export api is used to view all message sent & viewed in a given timeframe.
public type data_export record {
    # The identifier for your job.
    string job_identfier?;
    # The current state of your job.
    "pending"|"in_progress"|"failed"|"completed"|"no_data"|"canceled" status?;
    # The time after which you will not be able to access the data.
    string download_expires_at?;
    # The location where you can download your data.
    string download_url?;
};

# A ticket type, used to define the data fields to be captured in a ticket.
public type ticket_type record {
    # String representing the object's type. Always has the value `ticket_type`.
    string 'type?;
    # The id representing the ticket type.
    string id?;
    # Category of the Ticket Type.
    "Customer"|"Back-office"|"Tracker" category?;
    # The name of the ticket type
    string name?;
    # The description of the ticket type
    string description?;
    # The icon of the ticket type
    string icon?;
    # The id of the workspace that the ticket type belongs to.
    string workspace_id?;
    ticket_type_attribute_list ticket_type_attributes?;
    # Whether the ticket type is archived or not.
    boolean archived?;
    # The date and time the ticket type was created.
    int created_at?;
    # The date and time the ticket type was last updated.
    int updated_at?;
};

# Represents the Queries record for the operation: listSegments
public type ListSegmentsQueries record {
    # It includes the count of contacts that belong to each segment.
    boolean include_count?;
};

# Represents the Headers record for the operation: createNote
public type CreateNoteHeaders record {
    intercom_version Intercom\-Version?;
};

# Represents the Headers record for the operation: updateArticle
public type UpdateArticleHeaders record {
    intercom_version Intercom\-Version?;
};

public type id_away_body record {
    # Set to "true" to change the status of the admin to away.
    boolean away_mode_enabled;
    # Set to "true" to assign any new conversation replies to your default inbox.
    boolean away_mode_reassign;
};

# An object containing the results of the search.
public type article_search_response_data record {
    # An array of Article objects
    article[] articles?;
    # A corresponding array of highlighted Article content
    article_search_highlights[] highlights?;
};

# A list of all data attributes belonging to a workspace for contacts, companies or conversations.
public type data_attribute_list record {
    # The type of the object
    "list" 'type?;
    # A list of data attributes
    data_attribute[] data?;
};

# Represents the Headers record for the operation: getTicketType
public type GetTicketTypeHeaders record {
    intercom_version Intercom\-Version?;
};

# Phone Switch Response
public type phone_switch record {
    # 
    "phone_call_redirect" 'type = "phone_call_redirect";
    # Phone number in E.164 format, that has received the SMS to continue the conversation in the Messenger.
    string phone?;
};

# Represents the Headers record for the operation: updateNewsItem
public type UpdateNewsItemHeaders record {
    intercom_version Intercom\-Version?;
};

# Represents the Headers record for the operation: findTag
public type FindTagHeaders record {
    intercom_version Intercom\-Version?;
};

# A list of Company Objects
public type contact_attached_companies record {
    # The type of object
    "list" 'type?;
    # An array containing Company Objects
    company[] companies?;
    # The total number of companies associated to this contact
    int total_count?;
    pages_link pages?;
};

public type id_parts_body close_conversation_request|snooze_conversation_request|open_conversation_request|assign_conversation_request;

# A Conversation Part represents a message in the conversation.
public type conversation_part record {
    # Always conversation_part
    string 'type?;
    # The id representing the conversation part.
    string id?;
    # The type of conversation part.
    string part_type?;
    # The message body, which may contain HTML. For Twitter, this will show a generic message regarding why the body is obscured.
    string? body?;
    # The time the conversation part was created.
    int created_at?;
    # The last time the conversation part was updated.
    int updated_at?;
    # The time the user was notified with the conversation part.
    int notified_at?;
    reference assigned_to?;
    conversation_part_author author?;
    # A list of attachments for the part.
    part_attachment[] attachments?;
    # The external id of the conversation part
    string? external_id?;
    # Whether or not the conversation part has been redacted.
    boolean redacted?;
};

public type Quick\ Reply\ Option record {
    string text;
    string uuid;
};

public type contact_reply_base_request record {
    "comment" message_type;
    "user" 'type;
    # The text body of the comment.
    string body;
    # The time the reply was created. If not provided, the current time will be used.
    int created_at?;
    # A list of image URLs that will be added as attachments. You can include up to 10 URLs.
    @constraint:Array {maxLength: 10}
    string[] attachment_urls?;
};

# A list of event summaries for the user. Each event summary should contain the event name, the time the event occurred, and the number of times the event occurred. The event name should be a past tense 'verb-noun' combination, to improve readability, for example `updated-plan`.
public type create_data_event_summaries_request_event_summaries record {
    # The name of the event that occurred. A good event name is typically a past tense 'verb-noun' combination, to improve readability, for example `updated-plan`.
    string event_name?;
    # The number of times the event occurred.
    int count?;
    # The first time the event was sent
    int first?;
    # The last time the event was sent
    int last?;
};

# Activities performed by Admins.
public type activity_log record {
    # The id representing the activity.
    string id?;
    activity_log_performed_by performed_by?;
    activity_log_metadata? metadata?;
    # The time the activity was created.
    int created_at?;
    "admin_assignment_limit_change"|"admin_away_mode_change"|"admin_deletion"|"admin_deprovisioned"|"admin_impersonation_end"|"admin_impersonation_start"|"admin_invite_change"|"admin_invite_creation"|"admin_invite_deletion"|"admin_login_failure"|"admin_login_success"|"admin_logout"|"admin_password_reset_request"|"admin_password_reset_success"|"admin_permission_change"|"admin_provisioned"|"admin_two_factor_auth_change"|"admin_unauthorized_sign_in_method"|"app_admin_join"|"app_authentication_method_change"|"app_data_deletion"|"app_data_export"|"app_google_sso_domain_change"|"app_identity_verification_change"|"app_name_change"|"app_outbound_address_change"|"app_package_installation"|"app_package_token_regeneration"|"app_package_uninstallation"|"app_team_creation"|"app_team_deletion"|"app_team_membership_modification"|"app_timezone_change"|"app_webhook_creation"|"app_webhook_deletion"|"articles_in_messenger_enabled_change"|"bulk_delete"|"bulk_export"|"campaign_deletion"|"campaign_state_change"|"conversation_part_deletion"|"conversation_topic_change"|"conversation_topic_creation"|"conversation_topic_deletion"|"help_center_settings_change"|"inbound_conversations_change"|"inbox_access_change"|"message_deletion"|"message_state_change"|"messenger_look_and_feel_change"|"messenger_search_required_change"|"messenger_spaces_change"|"office_hours_change"|"role_change"|"role_creation"|"role_deletion"|"ruleset_activation_title_preview"|"ruleset_creation"|"ruleset_deletion"|"search_browse_enabled_change"|"search_browse_required_change"|"seat_change"|"seat_revoke"|"security_settings_change"|"temporary_expectation_change"|"upfront_email_collection_change"|"welcome_message_change" activity_type?;
    # A sentence or two describing the activity.
    string activity_description?;
};

# An object containing the different custom attributes associated to the conversation as key-value pairs. For relationship attributes the value will be a list of custom object instance models.
public type custom_attributes record {
};

# An object containing notes meta data about the notes that a contact has. Up to 10 will be displayed here. Use the url to get more.
public type contact_notes record {
    # This object represents the notes attached to a contact.
    addressable_list[] data?;
    # Url to get more company resources for this contact
    string url?;
    # Int representing the total number of companyies attached to this contact
    int total_count?;
    # Whether there's more Addressable Objects to be viewed. If true, use the url to view all
    boolean has_more?;
};

# A News Item is a content type in Intercom enabling you to announce product updates, company news, promotions, events and more with your customers.
public type news_item record {
    # The type of object.
    "news-item" 'type?;
    # The unique identifier for the news item which is given by Intercom.
    string id?;
    # The id of the workspace which the news item belongs to.
    string workspace_id?;
    # The title of the news item.
    string title?;
    # The news item body, which may contain HTML.
    string body?;
    # The id of the sender of the news item. Must be a teammate on the workspace.
    int sender_id?;
    # News items will not be visible to your users in the assigned newsfeeds until they are set live.
    "draft"|"live" state?;
    # A list of newsfeed_assignments to assign to the specified newsfeed.
    newsfeed_assignment[] newsfeed_assignments?;
    # Label names displayed to users to categorize the news item.
    string[] labels?;
    # URL of the image used as cover. Must have .jpg or .png extension.
    string? cover_image_url?;
    # Ordered list of emoji reactions to the news item. When empty, reactions are disabled.
    string[] reactions?;
    # When set to true, the news item will appear in the messenger newsfeed without showing a notification badge.
    boolean deliver_silently?;
    # Timestamp for when the news item was created.
    int created_at?;
    # Timestamp for when the news item was last updated.
    int updated_at?;
};

# unarchived contact object
public type contact_unarchived record {
    # always contact
    "contact" 'type?;
    # The unique identifier for the contact which is given by Intercom.
    string id?;
    # The unique identifier for the contact which is provided by the Client.
    string? external_id?;
    # Whether the contact is archived or not.
    boolean archived?;
};

# The list of teammates who participated in the conversation (wrote at least one conversation part).
public type conversation_teammates record {
    # The type of the object - `admin.list`.
    string 'type?;
    # The list of teammates who participated in the conversation (wrote at least one conversation part).
    reference[] teammates?;
};

# The Translated Content of an Group. The keys are the locale codes and the values are the translated content of the Group.
public type group_translated_content record {
    # The type of object - group_translated_content.
    "group_translated_content"? 'type?;
    group_content? ar?;
    group_content? bg?;
    group_content? bs?;
    group_content? ca?;
    group_content? cs?;
    group_content? da?;
    group_content? de?;
    group_content? el?;
    group_content? en?;
    group_content? es?;
    group_content? et?;
    group_content? fi?;
    group_content? fr?;
    group_content? he?;
    group_content? hr?;
    group_content? hu?;
    group_content? id?;
    group_content? it?;
    group_content? ja?;
    group_content? ko?;
    group_content? lt?;
    group_content? lv?;
    group_content? mn?;
    group_content? nb?;
    group_content? nl?;
    group_content? pl?;
    group_content? pt?;
    group_content? ro?;
    group_content? ru?;
    group_content? sl?;
    group_content? sr?;
    group_content? sv?;
    group_content? tr?;
    group_content? vi?;
    group_content? pt\-BR?;
    group_content? zh\-CN?;
    group_content? zh\-TW?;
};

# Ticket type attribute, used to define each data field to be captured in a ticket.
public type ticket_type_attribute record {
    # String representing the object's type. Always has the value `ticket_type_attribute`.
    string 'type?;
    # The id representing the ticket type attribute.
    string id?;
    # The id of the workspace that the ticket type attribute belongs to.
    string workspace_id?;
    # The name of the ticket type attribute
    string name?;
    # The description of the ticket type attribute
    string description?;
    # The type of the data attribute (allowed values: "string list integer decimal boolean datetime files")
    string data_type?;
    # Input options for the attribute
    record {} input_options?;
    # The order of the attribute against other attributes
    int 'order?;
    # Whether the attribute is required or not for teammates.
    boolean required_to_create = false;
    # Whether the attribute is required or not for contacts.
    boolean required_to_create_for_contacts = false;
    # Whether the attribute is visible or not to teammates.
    boolean visible_on_create = true;
    # Whether the attribute is visible or not to contacts.
    boolean visible_to_contacts = true;
    # Whether the attribute is built in or not.
    boolean default?;
    # The id of the ticket type that the attribute belongs to.
    int ticket_type_id?;
    # Whether the ticket type attribute is archived or not.
    boolean archived?;
    # The date and time the ticket type attribute was created.
    int created_at?;
    # The date and time the ticket type attribute was last updated.
    int updated_at?;
};

# A Social Profile allows you to label your contacts, companies, and conversations and list them using that Social Profile.
public type social_profile record {
    # value is "social_profile"
    string 'type?;
    # The name of the Social media profile
    string name?;
    # The name of the Social media profile
    string url?;
};

# A list of attributes associated with a given ticket type.
public type ticket_type_attribute_list record {
    # String representing the object's type. Always has the value `ticket_type_attributes.list`.
    string 'type?;
    # A list of ticket type attributes associated with a given ticket type.
    ticket_type_attribute[] ticket_type_attributes?;
};

# 
public type create_data_event_request anydata;

# Represents the Headers record for the operation: ListContacts
public type ListContactsHeaders record {
    intercom_version Intercom\-Version?;
};

public type visitor_segments record {
    # The type of the object
    "segment.list" 'type?;
    string[] segments?;
};

public type contact_id_subscriptions_body record {
    # The unique identifier for the subscription which is given by Intercom
    string id;
    # The consent_type of a subscription, opt_out or opt_in.
    string consent_type;
};

# Paginated Response
public type paginated_response record {
    # The type of object
    "list"|"conversation.list" 'type?;
    cursor_pages? pages?;
    # A count of the total number of objects.
    int total_count?;
    # An array of Objects
    (news_item|newsfeed)[] data?;
};

public type visitor_avatar record {
    # 
    string 'type = "avatar";
    # This object represents the avatar associated with the visitor.
    string? image_url?;
};

public type visitor_tags_tags record {
    # The type of the object
    "tag" 'type?;
    # The id of the tag.
    string id?;
    # The name of the tag.
    string name?;
};

# A list of Contact Objects
public type company_attached_contacts record {
    # The type of object - `list`
    "list" 'type?;
    # An array containing Contact Objects
    contact[] data?;
    # The total number of contacts
    int total_count?;
    cursor_pages? pages?;
};

# Payload of the request to reply on behalf of a contact using their `user_id`
public type contact_reply_ticket_user_id_request contact_reply_base_request;

# Details about the Admin involved in the activity.
public type activity_log_performed_by record {
    # String representing the object's type. Always has the value `admin`.
    string 'type?;
    # The id representing the admin.
    string id?;
    # The email of the admin.
    string email?;
    # The IP address of the admin.
    string ip?;
};

# You can update a contact
public type update_contact_request record {
    # The role of the contact.
    string role?;
    # A unique identifier for the contact which is given to Intercom
    string external_id?;
    # The contacts email
    string email?;
    # The contacts phone
    string? phone?;
    # The contacts name
    string? name?;
    # An image URL containing the avatar of a contact
    string? avatar?;
    # The time specified for when a contact signed up
    int? signed_up_at?;
    # The time when the contact was last seen (either where the Intercom Messenger was installed or when specified manually)
    int? last_seen_at?;
    # The id of an admin that has been assigned account ownership of the contact
    int? owner_id?;
    # Whether the contact is unsubscribed from emails
    boolean? unsubscribed_from_emails?;
    # The custom attributes which are set for the contact
    record {}? custom_attributes?;
};

# Data Attributes are metadata used to describe your contact, company and conversation models. These include standard and custom attributes. By using the data attributes endpoint, you can get the global list of attributes for your workspace, as well as create and archive custom attributes.
public type data_attribute record {
    # Value is `data_attribute`.
    "data_attribute" 'type?;
    # The unique identifier for the data attribute which is given by Intercom. Only available for custom attributes.
    int id?;
    # Value is `contact` for user/lead attributes and `company` for company attributes.
    "contact"|"company" model?;
    # Name of the attribute.
    string name?;
    # Full name of the attribute. Should match the name unless it's a nested attribute. We can split full_name on `.` to access nested user object values.
    string full_name?;
    # Readable name of the attribute (i.e. name you see in the UI)
    string label?;
    # Readable description of the attribute.
    string description?;
    # The data type of the attribute.
    "string"|"integer"|"float"|"boolean"|"date" data_type?;
    # List of predefined options for attribute value.
    string[] options?;
    # Can this attribute be updated through API
    boolean api_writable?;
    # Can this attribute be updated by the Messenger
    boolean messenger_writable?;
    # Can this attribute be updated in the UI
    boolean ui_writable?;
    # Set to true if this is a CDA
    boolean custom?;
    # Is this attribute archived. (Only applicable to CDAs)
    boolean archived?;
    # The time the attribute was created as a UTC Unix timestamp
    int created_at?;
    # The time the attribute was last updated as a UTC Unix timestamp
    int updated_at?;
    # Teammate who created the attribute. Only applicable to CDAs
    string admin_id?;
};

# Represents the Headers record for the operation: retrieveNote
public type RetrieveNoteHeaders record {
    intercom_version Intercom\-Version?;
};

# You can create a message
public type create_message_request anydata?;

# Represents the Headers record for the operation: listSubscriptionTypes
public type ListSubscriptionTypesHeaders record {
    intercom_version Intercom\-Version?;
};

# Represents the Queries record for the operation: listConversations
public type ListConversationsQueries record {
    # How many results per page
    @constraint:Int {maxValue: 150}
    int per_page = 20;
    # String used to get the next page of conversations.
    string starting_after?;
};

# Additional data provided about Admin activity.
public type activity_log_metadata record {
    # The way the admin signed in.
    string? sign_in_method?;
    # The unique identifier for the contact which is provided by the Client.
    string? external_id?;
    # The away mode status which is set to true when away and false when returned.
    boolean? away_mode?;
    # The reason the Admin is away.
    string? away_status_reason?;
    # Indicates if conversations should be reassigned while an Admin is away.
    boolean? reassign_conversations?;
    # The action that initiated the status change.
    string? 'source?;
    # Indicates if the status was changed automatically or manually.
    string? auto_changed?;
    # The ID of the Admin who initiated the activity.
    int? update_by?;
    # The name of the Admin who initiated the activity.
    string? update_by_name?;
};

# Represents the Headers record for the operation: detachTagFromTicket
public type DetachTagFromTicketHeaders record {
    intercom_version Intercom\-Version?;
};

# Represents the Headers record for the operation: createPhoneSwitch
public type CreatePhoneSwitchHeaders record {
    intercom_version Intercom\-Version?;
};

# Represents the Headers record for the operation: listActivityLogs
public type ListActivityLogsHeaders record {
    intercom_version Intercom\-Version?;
};

public type visitor_social_profiles record {
    # The type of the object
    "social_profile.list" 'type?;
    string[] social_profiles?;
};

# Represents the Headers record for the operation: searchTickets
public type SearchTicketsHeaders record {
    intercom_version Intercom\-Version?;
};

# You can tag a list of users.
public type tag_multiple_users_request record {
    # The name of the tag, which will be created if not found.
    string name;
    tag_multiple_users_request_users[] users;
};

# Response returned when an object is deleted
public type deleted_collection_object record {
    # The unique identifier for the collection which you provided in the URL.
    string id?;
    # The type of object which was deleted. - `collection`
    "collection" 'object?;
    # Whether the collection was deleted successfully or not.
    boolean deleted?;
};

# Payload of the request to assign a conversation
public type attach_contact_to_conversation_request record {
    # The `id` of the admin who is adding the new participant.
    string admin_id?;
    record {string intercom_user_id; customer_request? customer?;}|record {string user_id; customer_request? customer?;}|record {string email; customer_request? customer?;} customer?;
};

public type ticket_id_tags_body record {
    # The unique identifier for the tag which is given by Intercom
    string id;
    # The unique identifier for the admin which is given by Intercom.
    string admin_id;
};

# 
public type create_data_attribute_request record {
    # The name of the data attribute.
    string name;
    # The model that the data attribute belongs to.
    "contact"|"company" model;
    # The type of data stored for this attribute.
    "string"|"integer"|"float"|"boolean"|"datetime"|"date" data_type;
    # The readable description you see in the UI for the attribute.
    string description?;
    # To create list attributes. Provide a set of hashes with `value` as the key of the options you want to make. `data_type` must be `string`.
    string[] options?;
    # Can this attribute be updated by the Messenger
    boolean messenger_writable?;
};

public type id_companies_body record {
    # The unique identifier for the company which is given by Intercom
    string id;
};

# The Conversation Rating object which contains information on the rating and/or remark added by a Contact and the Admin assigned to the conversation.
public type conversation_rating record {
    # The rating, between 1 and 5, for the conversation.
    int rating?;
    # An optional field to add a remark to correspond to the number rating
    string remark?;
    # The time the rating was requested in the conversation being rated.
    int created_at?;
    contact_reference contact?;
    reference teammate?;
};

# Represents the Headers record for the operation: listSegments
public type ListSegmentsHeaders record {
    intercom_version Intercom\-Version?;
};

# Represents the Headers record for the operation: setAwayAdmin
public type SetAwayAdminHeaders record {
    intercom_version Intercom\-Version?;
};

# Represents the Headers record for the operation: identifyAdmin
public type IdentifyAdminHeaders record {
    intercom_version Intercom\-Version?;
};

# You can update a Ticket
public type update_ticket_request record {
    # The attributes set on the ticket.
    record {} ticket_attributes?;
    # The state of the ticket.
    "in_progress"|"waiting_on_customer"|"resolved" state?;
    # Specify if a ticket is open. Set to false to close a ticket. Closing a ticket will also unsnooze it.
    boolean open?;
    # Specify whether the ticket is visible to users.
    boolean is_shared?;
    # The time you want the ticket to reopen.
    int snoozed_until?;
    update_ticket_request_assignment assignment?;
};

# Represents the Headers record for the operation: listArticles
public type ListArticlesHeaders record {
    intercom_version Intercom\-Version?;
};

# The content source used by AI Agent in the conversation.
public type content_source record {
    # The type of the content source.
    "file"|"article"|"external_content"|"content_snippet"|"workflow_connector_action" content_type?;
    # The internal URL linking to the content source for teammates.
    string url?;
    # The title of the content source.
    string title?;
    # The ISO 639 language code of the content source.
    string locale?;
};

public type conversation_id_tags_body record {
    # The unique identifier for the tag which is given by Intercom
    string id;
    # The unique identifier for the admin which is given by Intercom.
    string admin_id;
};

# Represents the Headers record for the operation: retrieveNewsfeed
public type RetrieveNewsfeedHeaders record {
    intercom_version Intercom\-Version?;
};

# Response returned when an object is deleted
public type deleted_article_object record {
    # The unique identifier for the article which you provided in the URL.
    string id?;
    # The type of object which was deleted. - article
    "article" 'object?;
    # Whether the article was deleted successfully or not.
    boolean deleted?;
};

# You can merge a Visitor to a Contact of role type lead or user.
public type convert_visitor_request record {
    # Represents the role of the Contact model. Accepts `lead` or `user`.
    string 'type;
    convert_visitor_request_user user;
    convert_visitor_request_visitor visitor;
};

# The file attached to a part
public type part_attachment record {
    # The type of attachment
    string 'type?;
    # The name of the attachment
    string name?;
    # The URL of the attachment
    string url?;
    # The content type of the attachment
    string content_type?;
    # The size of the attachment
    int filesize?;
    # The width of the attachment
    int width?;
    # The height of the attachment
    int height?;
};

# The Conversation Part that originated this conversation, which can be Contact, Admin, Campaign, Automated or Operator initiated.
public type conversation_source record {
    # This includes conversation, email, facebook, instagram, phone_call, phone_switch, push, sms, twitter and whatsapp.
    string 'type?;
    # The id representing the message.
    string id?;
    # The conversation's initiation type. Possible values are customer_initiated, campaigns_initiated (legacy campaigns), operator_initiated (Custom bot), automated (Series and other outbounds with dynamic audience message) and admin_initiated (fixed audience message, ticket initiated by an admin, group email).
    string delivered_as?;
    # Optional. The message subject. For Twitter, this will show a generic message regarding why the subject is obscured.
    string subject?;
    # The message body, which may contain HTML. For Twitter, this will show a generic message regarding why the body is obscured.
    string body?;
    conversation_part_author author?;
    # A list of attachments for the part.
    part_attachment[] attachments?;
    # The URL where the conversation was started. For Twitter, Email, and Bots, this will be blank.
    string? url?;
    # Whether or not the source message has been redacted. Only applicable for contact initiated messages.
    boolean redacted?;
};

# A Statistics object containing all information required for reporting, with timestamps and calculated metrics.
public type conversation_statistics record {
    # 
    string 'type?;
    # Duration until last assignment before first admin reply. In seconds.
    int time_to_assignment?;
    # Duration until first admin reply. Subtracts out of business hours. In seconds.
    int time_to_admin_reply?;
    # Duration until conversation was closed first time. Subtracts out of business hours. In seconds.
    int time_to_first_close?;
    # Duration until conversation was closed last time. Subtracts out of business hours. In seconds.
    int time_to_last_close?;
    # Median based on all admin replies after a contact reply. Subtracts out of business hours. In seconds.
    int median_time_to_reply?;
    # Time of first text conversation part from a contact.
    int first_contact_reply_at?;
    # Time of first assignment after first_contact_reply_at.
    int first_assignment_at?;
    # Time of first admin reply after first_contact_reply_at.
    int first_admin_reply_at?;
    # Time of first close after first_contact_reply_at.
    int first_close_at?;
    # Time of last assignment after first_contact_reply_at.
    int last_assignment_at?;
    # Time of first admin reply since most recent assignment.
    int last_assignment_admin_reply_at?;
    # Time of the last conversation part from a contact.
    int last_contact_reply_at?;
    # Time of the last conversation part from an admin.
    int last_admin_reply_at?;
    # Time of the last conversation close.
    int last_close_at?;
    # The last admin who closed the conversation. Returns a reference to an Admin object.
    string last_closed_by_id?;
    # Number of reopens after first_contact_reply_at.
    int count_reopens?;
    # Number of assignments after first_contact_reply_at.
    int count_assignments?;
    # Total number of conversation parts.
    int count_conversation_parts?;
};

# Represents the Headers record for the operation: manageConversation
public type ManageConversationHeaders record {
    intercom_version Intercom\-Version?;
};

# Represents the Headers record for the operation: deleteCollection
public type DeleteCollectionHeaders record {
    intercom_version Intercom\-Version?;
};

# Payload of the request to open a conversation
public type open_conversation_request record {
    "open" message_type;
    # The id of the admin who is performing the action.
    string admin_id;
};

# An object containing metadata about linked conversations and linked tickets. Up to 1000 can be returned.
public type linked_object_list record {
    # Always list.
    "list" 'type?;
    # The total number of linked objects.
    int total_count?;
    # Whether or not there are more linked objects than returned.
    boolean has_more?;
    # An array containing the linked conversations and linked tickets.
    linked_object[] data?;
};

# Represents the Headers record for the operation: createArticle
public type CreateArticleHeaders record {
    intercom_version Intercom\-Version?;
};

public type filter record {|string user_id;|}|record {|string intercom_user_id;|}|record {|string email;|};

public type contact_reply_conversation_request contact_reply_intercom_user_id_request|contact_reply_email_request|contact_reply_user_id_request;

# Payload of the request to update a conversation
public type update_conversation_request record {
    # Mark a conversation as read within Intercom.
    boolean read?;
    custom_attributes custom_attributes?;
};

# Payload of the request to snooze a conversation
public type snooze_conversation_request record {
    "snoozed" message_type;
    # The id of the admin who is performing the action.
    string admin_id;
    # The time you want the conversation to reopen.
    int snoozed_until;
};

# Represents the Headers record for the operation: retrieveNewsItem
public type RetrieveNewsItemHeaders record {
    intercom_version Intercom\-Version?;
};

# Contacts are your users in Intercom.
public type contact_list record {
    # Always list
    "list" 'type?;
    # The list of contact objects
    contact[] data?;
    # A count of the total number of objects.
    int total_count?;
    cursor_pages? pages?;
};

# Represents the Headers record for the operation: deleteArticle
public type DeleteArticleHeaders record {
    intercom_version Intercom\-Version?;
};

public type starting_after_paging record {
    # The number of results to fetch per page.
    int per_page?;
    # The cursor to use in the next request to get the next page of results.
    string? starting_after?;
};

# The Content of a Group.
public type group_content record {
    # The type of object - `group_content` .
    "group_content"? 'type?;
    # The name of the collection or section.
    string name?;
    # The description of the collection. Only available for collections.
    string description?;
};

# Represents the Headers record for the operation: UpdateContact
public type UpdateContactHeaders record {
    intercom_version Intercom\-Version?;
};

# Represents the Headers record for the operation: listNewsfeeds
public type ListNewsfeedsHeaders record {
    intercom_version Intercom\-Version?;
};

# reference to another object
public type reference record {
    # 
    string 'type?;
    # 
    string? id?;
};

# Merge contact data.
public type merge_contacts_request record {
    # The unique identifier for the contact to merge away from. Must be a lead.
    string 'from?;
    # The unique identifier for the contact to merge into. Must be a user.
    string into?;
};

# Represents the Headers record for the operation: ShowContact
public type ShowContactHeaders record {
    intercom_version Intercom\-Version?;
};

# Represents the Headers record for the operation: createOrUpdateCompany
public type CreateOrUpdateCompanyHeaders record {
    intercom_version Intercom\-Version?;
};

public type tags_body create_or_update_tag_request|tag_company_request|untag_company_request|tag_multiple_users_request;

# Assigns a news item to a newsfeed.
public type newsfeed_assignment record {
    # The unique identifier for the newsfeed which is given by Intercom. Publish dates cannot be in the future, to schedule news items use the dedicated feature in app (see this article).
    int newsfeed_id?;
    # Publish date of the news item on the newsfeed, use this field if you want to set a publish date in the past (e.g. when importing existing news items). On write, this field will be ignored if the news item state is "draft".
    int published_at?;
};

# Admins are the teammate accounts that have access to a workspace
public type admin_with_app record {
    # String representing the object's type. Always has the value `admin`.
    string 'type?;
    # The id representing the admin.
    string id?;
    # The name of the admin.
    string name?;
    # The email of the admin.
    string email?;
    # The job title of the admin.
    string job_title?;
    # Identifies if this admin is currently set in away mode.
    boolean away_mode_enabled?;
    # Identifies if this admin is set to automatically reassign new conversations to the apps default inbox.
    boolean away_mode_reassign?;
    # Identifies if this admin has a paid inbox seat to restrict/allow features that require them.
    boolean has_inbox_seat?;
    # This is a list of ids of the teams that this admin is part of.
    int[] team_ids?;
    admin_with_app_avatar avatar?;
    # Identifies if this admin's email is verified.
    boolean? email_verified?;
    app? app?;
};

# Represents the Headers record for the operation: updateConversation
public type UpdateConversationHeaders record {
    intercom_version Intercom\-Version?;
};

# Payload of the request to reply on behalf of a contact using their `intercom_user_id`
public type contact_reply_intercom_user_id_request contact_reply_base_request;

# A tag allows you to label your contacts, companies, and conversations and list them using that tag.
public type tag record {
    # value is "tag"
    string 'type?;
    # The id of the tag
    string id?;
    # The name of the tag
    string name?;
    # The time when the tag was applied to the object
    int applied_at?;
    reference applied_by?;
};

# Represents the Headers record for the operation: detachTagFromContact
public type DetachTagFromContactHeaders record {
    intercom_version Intercom\-Version?;
};

# Request for creating a data export
public type create_data_exports_request record {
    # The start date that you request data for. It must be formatted as a unix timestamp.
    int created_at_after;
    # The end date that you request data for. It must be formatted as a unix timestamp.
    int created_at_before;
};

# Represents the Headers record for the operation: detachSubscriptionTypeToContact
public type DetachSubscriptionTypeToContactHeaders record {
    intercom_version Intercom\-Version?;
};

# Represents the Headers record for the operation: replyConversation
public type ReplyConversationHeaders record {
    intercom_version Intercom\-Version?;
};

# The Translated Content of an Article. The keys are the locale codes and the values are the translated content of the article.
public type article_translated_content record {
    # The type of object - article_translated_content.
    "article_translated_content"? 'type?;
    article_content? ar?;
    article_content? bg?;
    article_content? bs?;
    article_content? ca?;
    article_content? cs?;
    article_content? da?;
    article_content? de?;
    article_content? el?;
    article_content? en?;
    article_content? es?;
    article_content? et?;
    article_content? fi?;
    article_content? fr?;
    article_content? he?;
    article_content? hr?;
    article_content? hu?;
    article_content? id?;
    article_content? it?;
    article_content? ja?;
    article_content? ko?;
    article_content? lt?;
    article_content? lv?;
    article_content? mn?;
    article_content? nb?;
    article_content? nl?;
    article_content? pl?;
    article_content? pt?;
    article_content? ro?;
    article_content? ru?;
    article_content? sl?;
    article_content? sr?;
    article_content? sv?;
    article_content? tr?;
    article_content? vi?;
    article_content? pt\-BR?;
    article_content? zh\-CN?;
    article_content? zh\-TW?;
};

# Represents the Queries record for the operation: retrieveConversation
public type RetrieveConversationQueries record {
    # Set to plaintext to retrieve conversation messages in plain text.
    string display_as?;
};

# A linked conversation or ticket.
public type linked_object record {
    # ticket or conversation
    "ticket"|"conversation" 'type?;
    # The ID of the linked object
    string id?;
    # Category of the Linked Ticket Object.
    "Customer"|"Back-office"|"Tracker"? category?;
};

# Admin priority levels for teams
public type team_priority_level record {
    # The primary team ids for the team
    int[]? primary_team_ids?;
    # The secondary team ids for the team
    int[]? secondary_team_ids?;
};

# The list of tags associated with the company
public type company_tags record {
    # The type of the object
    "tag.list" 'type?;
    tag[][] tags?;
};

# A list of Conversation Part objects for each part message in the conversation. This is only returned when Retrieving a Conversation, and ignored when Listing all Conversations. There is a limit of 500 parts.
public type conversation_parts record {
    # 
    "conversation_part.list" 'type?;
    # A list of Conversation Part objects for each part message in the conversation. This is only returned when Retrieving a Conversation, and ignored when Listing all Conversations. There is a limit of 500 parts.
    conversation_part[] conversation_parts?;
    # 
    int total_count?;
};

# Represents the Headers record for the operation: replyTicket
public type ReplyTicketHeaders record {
    intercom_version Intercom\-Version?;
};

# Properties of the attachment files in a conversation part
public type conversation_attachment_files record {
    # The content type of the file
    string content_type?;
    # The base64 encoded file data.
    string data?;
    # The name of the file.
    string name?;
};

# You can Update an Article
public type update_article_request record {
    # The title of the article.For multilingual articles, this will be the title of the default language's content.
    string title?;
    # The description of the article. For multilingual articles, this will be the description of the default language's content.
    string description?;
    # The content of the article. For multilingual articles, this will be the body of the default language's content.
    string body?;
    # The id of the author of the article. For multilingual articles, this will be the id of the author of the default language's content. Must be a teammate on the help center's workspace.
    int author_id?;
    # Whether the article will be `published` or will be a `draft`. Defaults to draft. For multilingual articles, this will be the state of the default language's content.
    "published"|"draft" state?;
    # The id of the article's parent collection or section. An article without this field stands alone.
    string parent_id?;
    # The type of parent, which can either be a `collection` or `section`.
    string parent_type?;
    article_translated_content? translated_content?;
};

# Represents the Headers record for the operation: listSubscriptionsForAContact
public type ListSubscriptionsForAContactHeaders record {
    intercom_version Intercom\-Version?;
};

# Represents the Queries record for the operation: listActivityLogs
public type ListActivityLogsQueries record {
    # The end date that you request data for. It must be formatted as a UNIX timestamp.
    string created_at_before?;
    # The start date that you request data for. It must be formatted as a UNIX timestamp.
    string created_at_after;
};

# Represents the Headers record for the operation: deleteCompany
public type DeleteCompanyHeaders record {
    intercom_version Intercom\-Version?;
};

# Represents the Headers record for the operation: UpdateCompany
public type UpdateCompanyHeaders record {
    intercom_version Intercom\-Version?;
};

# The request payload for updating a ticket type.
# You can copy the `icon` property for your ticket type from [Twemoji Cheatsheet](https://twemoji-cheatsheet.vercel.app/)
public type update_ticket_type_request record {
    # The name of the ticket type.
    string name?;
    # The description of the ticket type.
    string description?;
    # Category of the Ticket Type.
    "Customer"|"Back-office"|"Tracker" category?;
    # The icon of the ticket type.
    string icon = "🎟️";
    # The archived status of the ticket type.
    boolean archived?;
    # Whether the tickets associated with this ticket type are intended for internal use only or will be shared with customers. This is currently a limited attribute.
    boolean is_internal = false;
};

# Represents the Headers record for the operation: createCollection
public type CreateCollectionHeaders record {
    intercom_version Intercom\-Version?;
};

# A highlighted article title.
public type article_search_highlights_highlighted_title record {
    # The type of text - `highlight` or `plain`.
    "highlight"|"plain" 'type?;
    # The text of the title.
    string text?;
};

# The object who initiated the conversation, which can be a Contact, Admin or Team. Bots and campaigns send messages on behalf of Admins or Teams. For Twitter, this will be blank.
public type conversation_part_author record {
    # The type of the author
    string 'type?;
    # The id of the author
    string id?;
    # The name of the author
    string name?;
    # The email of the author
    string email?;
};

# Payload of the request to reply on behalf of a contact using their `user_id`
public type contact_reply_user_id_request contact_reply_base_request;

# Payload of the request to reply on behalf of an admin
public type admin_reply_ticket_request record {
    "comment"|"note"|"quick_reply" message_type;
    "admin" 'type;
    # The text body of the reply. Notes accept some HTML formatting. Must be present for comment and note message types.
    string body?;
    # The id of the admin who is authoring the comment.
    string admin_id;
    # The time the reply was created. If not provided, the current time will be used.
    int created_at?;
    # The quick reply options to display. Must be present for quick_reply message types.
    Quick\ Reply\ Option[] reply_options?;
    # A list of image URLs that will be added as attachments. You can include up to 10 URLs.
    @constraint:Array {maxLength: 10}
    string[] attachment_urls?;
};

public type visitor_companies record {
    # The type of the object
    "company.list" 'type?;
    company[] companies?;
};

# Represents the Headers record for the operation: retrieveVisitorWithUserId
public type RetrieveVisitorWithUserIdHeaders record {
    intercom_version Intercom\-Version?;
};

public type id_notes_body record {
    # The text of the note.
    string body;
    # The unique identifier of a given contact.
    string contact_id?;
    # The unique identifier of a given admin.
    string admin_id?;
};

# A list of Segment Objects
public type company_attached_segments record {
    # The type of object - `list`
    "list" 'type?;
    # An array containing Segment Objects
    segment[] data?;
};

public type visitor_location_data record {
    # 
    string 'type = "location_data";
    # The city name of the visitor.
    string city_name?;
    # The continent code of the visitor.
    string continent_code?;
    # The country code of the visitor.
    string country_code?;
    # The country name of the visitor.
    string country_name?;
    # The postal code of the visitor.
    string postal_code?;
    # The region name of the visitor.
    string region_name?;
    # The timezone of the visitor.
    string timezone?;
};

# Visitors are useful for representing anonymous people that have not yet been identified. They usually represent website visitors. Visitors are not visible in Intercom platform. The Visitors resource provides methods to fetch, update, convert and delete.
public type visitor record {
    # Value is 'visitor'
    string 'type = "visitor";
    # The Intercom defined id representing the Visitor.
    string id?;
    # Automatically generated identifier for the Visitor.
    string user_id?;
    # Identifies if this visitor is anonymous.
    boolean anonymous?;
    # The email of the visitor.
    string email?;
    # The phone number of the visitor.
    string? phone?;
    # The name of the visitor.
    string? name?;
    # The pseudonym of the visitor.
    string? pseudonym?;
    visitor_avatar avatar?;
    # The id of the app the visitor is associated with.
    string app_id?;
    visitor_companies companies?;
    visitor_location_data location_data?;
    # The time the Lead last recorded making a request.
    int las_request_at?;
    # The time the Visitor was added to Intercom.
    int created_at?;
    # The time the Visitor was added to Intercom.
    int remote_created_at?;
    # The time the Visitor signed up for your product.
    int signed_up_at?;
    # The last time the Visitor was updated.
    int updated_at?;
    # The number of sessions the Visitor has had.
    int session_count?;
    visitor_social_profiles social_profiles?;
    # The id of the admin that owns the Visitor.
    string? owner_id?;
    # Whether the Visitor is unsubscribed from emails.
    boolean unsubscribed_from_emails?;
    # Identifies if this visitor has marked an email as spam.
    boolean marked_email_as_spam?;
    # Identifies if this visitor has had a hard bounce.
    boolean has_hard_bounced?;
    visitor_tags tags?;
    visitor_segments segments?;
    # The custom attributes you have set on the Visitor.
    record {|string...;|} custom_attributes?;
    # The referer of the visitor.
    string? referrer?;
    # The utm_campaign of the visitor.
    string? utm_campaign?;
    # The utm_content of the visitor.
    string? utm_content?;
    # The utm_medium of the visitor.
    string? utm_medium?;
    # The utm_source of the visitor.
    string? utm_source?;
    # The utm_term of the visitor.
    string? utm_term?;
    # Identifies if this visitor has do not track enabled.
    boolean? do_not_track?;
};

# The majority of list resources in the API are paginated to allow clients to traverse data over multiple requests.
# 
# Their responses are likely to contain a pages object that hosts pagination links which a client can use to paginate through the data without having to construct a query. The link relations for the pages field are as follows.
public type pages_link record {
    "pages" 'type?;
    int page?;
    # A link to the next page of results. A response that does not contain a next link does not have further data to fetch.
    string? next?;
    int per_page?;
    int total_pages?;
};

# Notes allow you to annotate and comment on your contacts.
public type note record {
    # String representing the object's type. Always has the value `note`.
    string 'type?;
    # The id of the note.
    string id?;
    # The time the note was created.
    int created_at?;
    note_contact? contact?;
    admin? author?;
    # The body text of the note.
    string body?;
};

# Represents the Headers record for the operation: DeleteContact
public type DeleteContactHeaders record {
    intercom_version Intercom\-Version?;
};

# Represents the Headers record for the operation: lisDataAttributes
public type LisDataAttributesHeaders record {
    intercom_version Intercom\-Version?;
};

# You can create an phone switch
public type create_phone_switch_request record {
    # Phone number in E.164 format, that will receive the SMS to continue the conversation in the Messenger.
    string phone;
    custom_attributes custom_attributes?;
};

# You can send a list of event summaries for a user. Each event summary should contain the event name, the time the event occurred, and the number of times the event occurred. The event name should be a past tense "verb-noun" combination, to improve readability, for example `updated-plan`.
public type create_data_event_summaries_request record {
    # Your identifier for the user.
    string user_id?;
    create_data_event_summaries_request_event_summaries event_summaries?;
};

public type reply_conversation_request contact_reply_conversation_request|admin_reply_conversation_request;

# Represents the Headers record for the operation: listNotes
public type ListNotesHeaders record {
    intercom_version Intercom\-Version?;
};

# Represents the Headers record for the operation: retrieveSegment
public type RetrieveSegmentHeaders record {
    intercom_version Intercom\-Version?;
};

# Represents the Headers record for the operation: updateCollection
public type UpdateCollectionHeaders record {
    intercom_version Intercom\-Version?;
};

# You can update a Ticket Type Attribute
public type update_ticket_type_attribute_request record {
    # The name of the ticket type attribute
    string name?;
    # The description of the attribute presented to the teammate or contact
    string description?;
    # Whether the attribute is required to be filled in when teammates are creating the ticket in Inbox.
    boolean required_to_create = false;
    # Whether the attribute is required to be filled in when contacts are creating the ticket in Messenger.
    boolean required_to_create_for_contacts = false;
    # Whether the attribute is visible to teammates when creating a ticket in Inbox.
    boolean visible_on_create = true;
    # Whether the attribute is visible to contacts when creating a ticket in Messenger.
    boolean visible_to_contacts = true;
    # Whether the attribute allows multiple lines of text (only applicable to string attributes)
    boolean multiline?;
    # A comma delimited list of items for the attribute value (only applicable to list attributes)
    string list_items?;
    # Whether the attribute allows multiple files to be attached to it (only applicable to file attributes)
    boolean allow_multiple_values?;
    # Whether the attribute should be archived and not shown during creation of the ticket (it will still be present on previously created tickets)
    boolean archived?;
};

public type redact_conversation_request record {"conversation_part" 'type; string conversation_id; string conversation_part_id;}|record {"source" 'type; string conversation_id; string source_id;};

# Payload of the request to reply on behalf of an admin
public type admin_reply_conversation_request record {
    "comment"|"note" message_type;
    "admin" 'type;
    # The text body of the reply. Notes accept some HTML formatting. Must be present for comment and note message types.
    string body?;
    # The id of the admin who is authoring the comment.
    string admin_id;
    # The time the reply was created. If not provided, the current time will be used.
    int created_at?;
    # A list of image URLs that will be added as attachments. You can include up to 10 URLs.
    @constraint:Array {maxLength: 10}
    string[] attachment_urls?;
    # A list of files that will be added as attachments. You can include up to 10 files
    @constraint:Array {maxLength: 10}
    conversation_attachment_files[] attachment_files?;
};

# The unique identifiers to convert a single Visitor.
public type convert_visitor_request_visitor anydata;

# Represents the Headers record for the operation: createDataAttribute
public type CreateDataAttributeHeaders record {
    intercom_version Intercom\-Version?;
};

# Represents the Headers record for the operation: listAllCollections
public type ListAllCollectionsHeaders record {
    intercom_version Intercom\-Version?;
};

# Represents the Headers record for the operation: RetrieveACompanyById
public type RetrieveACompanyByIdHeaders record {
    intercom_version Intercom\-Version?;
};

public type contact_avatar record {
    # The type of object
    string 'type?;
    # An image URL containing the avatar of a contact.
    string? image_url?;
};

# Represents the Headers record for the operation: lisDataEvents
public type LisDataEventsHeaders record {
    intercom_version Intercom\-Version?;
};

# A newsfeed is a collection of news items, targeted to a specific audience.
# 
# Newsfeeds currently cannot be edited through the API, please refer to [this article](https://www.intercom.com/help/en/articles/6362267-getting-started-with-news) to set up your newsfeeds in Intercom.
public type newsfeed record {
    # The unique identifier for the newsfeed which is given by Intercom.
    string id?;
    # The type of object.
    "newsfeed" 'type?;
    # The name of the newsfeed. This name will never be visible to your users.
    string name?;
    # Timestamp for when the newsfeed was created.
    int created_at?;
    # Timestamp for when the newsfeed was last updated.
    int updated_at?;
};

# Represents the Headers record for the operation: createConversation
public type CreateConversationHeaders record {
    intercom_version Intercom\-Version?;
};

# You can create or update an existing tag.
public type create_or_update_tag_request record {
    # The name of the tag, which will be created if not found, or the new name for the tag if this is an update request. Names are case insensitive.
    string name;
    # The id of tag to updates.
    string id?;
};

public type visitor_tags record {
    # The type of the object
    "tag.list" 'type?;
    visitor_tags_tags[] tags?;
};

# Represents the contact that the note was created about.
public type note_contact record {
    # String representing the object's type. Always has the value `contact`.
    string 'type?;
    # The id of the contact.
    string id?;
};

# Represents the Headers record for the operation: searchConversations
public type SearchConversationsHeaders record {
    intercom_version Intercom\-Version?;
};

# Search using Intercoms Search APIs with more than one filter.
public type multiple_filter_search_request record {
    # An operator to allow boolean inspection between multiple fields.
    "AND"|"OR" operator?;
    multiple_filter_search_request[]|single_filter_search_request[] value?;
};

# The Content of an Article.
public type article_content record {
    # The type of object - `article_content` .
    "article_content"? 'type?;
    # The title of the article.
    string title?;
    # The description of the article.
    string description?;
    # The body of the article.
    string body?;
    # The ID of the author of the article.
    int author_id?;
    # Whether the article is `published` or is a `draft` .
    "published"|"draft" state?;
    # The time when the article was created (seconds).
    int created_at?;
    # The time when the article was last updated (seconds).
    int updated_at?;
    # The URL of the article.
    string url?;
};

# 
public type update_data_attribute_request record {
    # Whether the attribute is to be archived or not.
    boolean archived?;
    # The readable description you see in the UI for the attribute.
    string description?;
    # To create list attributes. Provide a set of hashes with `value` as the key of the options you want to make. `data_type` must be `string`.
    string[] options?;
    # Can this attribute be updated by the Messenger
    boolean messenger_writable?;
};

# You can create an Article
public type create_article_request record {
    # The title of the article.For multilingual articles, this will be the title of the default language's content.
    string title;
    # The description of the article. For multilingual articles, this will be the description of the default language's content.
    string description?;
    # The content of the article. For multilingual articles, this will be the body of the default language's content.
    string body?;
    # The id of the author of the article. For multilingual articles, this will be the id of the author of the default language's content. Must be a teammate on the help center's workspace.
    int author_id;
    # Whether the article will be `published` or will be a `draft`. Defaults to draft. For multilingual articles, this will be the state of the default language's content.
    "published"|"draft" state?;
    # The id of the article's parent collection or section. An article without this field stands alone.
    int parent_id?;
    # The type of parent, which can either be a `collection` or `section`.
    string parent_type?;
    article_translated_content? translated_content?;
};

# Represents the Headers record for the operation: updateTicket
public type UpdateTicketHeaders record {
    intercom_version Intercom\-Version?;
};

# Proxy server configurations to be used with the HTTP client endpoint.
public type ProxyConfig record {|
    # Host name of the proxy server
    string host = "";
    # Proxy server port
    int port = 0;
    # Proxy server username
    string userName = "";
    # Proxy server password
    @display {label: "", kind: "password"}
    string password = "";
|};

# Represents the Headers record for the operation: attachTagToConversation
public type AttachTagToConversationHeaders record {
    intercom_version Intercom\-Version?;
};

# Represents the Headers record for the operation: SearchContacts
public type SearchContactsHeaders record {
    intercom_version Intercom\-Version?;
};

# Represents the Headers record for the operation: listLiveNewsfeedItems
public type ListLiveNewsfeedItemsHeaders record {
    intercom_version Intercom\-Version?;
};

# Payload of the request to close a conversation
public type close_conversation_request record {
    "close" message_type;
    "admin" 'type;
    # The id of the admin who is performing the action.
    string admin_id;
    # Optionally you can leave a message in the conversation to provide additional context to the user and other teammates.
    string body?;
};

# This will return a list of Segment Objects. The result may also have a pages object if the response is paginated.
public type segment_list record {
    # The type of the object
    "segment.list" 'type?;
    # A list of Segment objects
    segment[] segments?;
    # A pagination object, which may be empty, indicating no further pages to fetch.
    record {} pages?;
};

# The request payload for creating a ticket type.
#   You can copy the `icon` property for your ticket type from [Twemoji Cheatsheet](https://twemoji-cheatsheet.vercel.app/)
public type create_ticket_type_request record {
    # The name of the ticket type.
    string name;
    # The description of the ticket type.
    string description?;
    # Category of the Ticket Type.
    "Customer"|"Back-office"|"Tracker" category?;
    # The icon of the ticket type.
    string icon = "🎟️";
    # Whether the tickets associated with this ticket type are intended for internal use only or will be shared with customers. This is currently a limited attribute.
    boolean is_internal = false;
};

# You can create a Ticket
public type create_ticket_request record {
    # The ID of the type of ticket you want to create
    string ticket_type_id;
    # The list of contacts (users or leads) affected by this ticket. Currently only one is allowed
    (record {string id;}|record {string external_id;}|record {string email;})[] contacts;
    # The ID of the company that the ticket is associated with. The ID that you set upon company creation.
    string company_id?;
    # The time the ticket was created. If not provided, the current time will be used.
    int created_at?;
    ticket_contacts ticket_attributes?;
};

public type contact_reply_ticket_request contact_reply_ticket_intercom_user_id_request|contact_reply_ticket_user_id_request|contact_reply_ticket_email_request;

# Represents the Headers record for the operation: attachContactToACompany
public type AttachContactToACompanyHeaders record {
    intercom_version Intercom\-Version?;
};

# Search using Intercoms Search APIs with a single filter.
public type single_filter_search_request record {
    # The accepted field that you want to search on.
    string 'field?;
    # The accepted operators you can use to define how you want to search for the value.
    "="|"!="|"IN"|"NIN"|"<"|">"|"~"|"!~"|"^"|"$" operator?;
    # The value that you want to search on.
    string value?;
};

# Conversations are how you can communicate with users in Intercom. They are created when a contact replies to an outbound message, or when one admin directly sends a message to a single contact.
public type conversation_list record {
    # Always conversation.list
    "conversation.list" 'type?;
    # The list of conversation objects
    conversation[] conversations?;
    # A count of the total number of objects.
    int total_count?;
    cursor_pages? pages?;
};

# Represents the Headers record for the operation: updateDataAttribute
public type UpdateDataAttributeHeaders record {
    intercom_version Intercom\-Version?;
};

# Represents the Headers record for the operation: retrieveAdmin
public type RetrieveAdminHeaders record {
    intercom_version Intercom\-Version?;
};

# A Ticket Part representing a note, comment, or quick_reply on a ticket
public type ticket_reply record {
    # Always ticket_part
    "ticket_part" 'type?;
    # The id representing the part.
    string id?;
    # Type of the part
    "note"|"comment"|"quick_reply" part_type?;
    # The message body, which may contain HTML.
    string? body?;
    # The time the note was created.
    int created_at?;
    # The last time the note was updated.
    int updated_at?;
    ticket_part_author author?;
    # A list of attachments for the part.
    part_attachment[] attachments?;
    # Whether or not the ticket part has been redacted.
    boolean redacted?;
};

# Payload of the request to reply on behalf of a contact using their `email`
public type contact_reply_ticket_email_request contact_reply_base_request;
