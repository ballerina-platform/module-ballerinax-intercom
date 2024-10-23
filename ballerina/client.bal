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

import ballerina/http;

# The intercom API reference.
public isolated client class Client {
    final http:Client clientEp;
    # Gets invoked to initialize the `connector`.
    #
    # + config - The configurations to be used when initializing the `connector` 
    # + serviceUrl - URL of the target service 
    # + return - An error if connector initialization failed 
    public isolated function init(ConnectionConfig config, string serviceUrl = "https://api.intercom.io") returns error? {
        http:ClientConfiguration httpClientConfig = {auth: config.auth, httpVersion: config.httpVersion, timeout: config.timeout, forwarded: config.forwarded, poolConfig: config.poolConfig, compression: config.compression, circuitBreaker: config.circuitBreaker, retryConfig: config.retryConfig, validation: config.validation};
        do {
            if config.http1Settings is ClientHttp1Settings {
                ClientHttp1Settings settings = check config.http1Settings.ensureType(ClientHttp1Settings);
                httpClientConfig.http1Settings = {...settings};
            }
            if config.http2Settings is http:ClientHttp2Settings {
                httpClientConfig.http2Settings = check config.http2Settings.ensureType(http:ClientHttp2Settings);
            }
            if config.cache is http:CacheConfig {
                httpClientConfig.cache = check config.cache.ensureType(http:CacheConfig);
            }
            if config.responseLimits is http:ResponseLimitConfigs {
                httpClientConfig.responseLimits = check config.responseLimits.ensureType(http:ResponseLimitConfigs);
            }
            if config.secureSocket is http:ClientSecureSocket {
                httpClientConfig.secureSocket = check config.secureSocket.ensureType(http:ClientSecureSocket);
            }
            if config.proxy is http:ProxyConfig {
                httpClientConfig.proxy = check config.proxy.ensureType(http:ProxyConfig);
            }
        }
        http:Client httpEp = check new (serviceUrl, httpClientConfig);
        self.clientEp = httpEp;
        return;
    }

    # Delete an article
    #
    # + id - The unique identifier for the article which is given by Intercom.
    # + headers - Headers to be sent with the request 
    # + return - successful 
    resource isolated function delete articles/[int id](DeleteArticleHeaders headers = {}) returns deleted_article_object|error {
        string resourcePath = string `/articles/${getEncodedUri(id)}`;
        map<string|string[]> httpHeaders = getMapForHeaders(headers);
        return self.clientEp->delete(resourcePath, headers = httpHeaders);
    }

    # Delete a company
    #
    # + id - The unique identifier for the company which is given by Intercom
    # + headers - Headers to be sent with the request 
    # + return - Successful 
    resource isolated function delete companies/[string id](DeleteCompanyHeaders headers = {}) returns deleted_company_object|error {
        string resourcePath = string `/companies/${getEncodedUri(id)}`;
        map<string|string[]> httpHeaders = getMapForHeaders(headers);
        return self.clientEp->delete(resourcePath, headers = httpHeaders);
    }

    # Detach a contact from a company
    #
    # + contact_id - The unique identifier for the contact which is given by Intercom
    # + id - The unique identifier for the company which is given by Intercom
    # + headers - Headers to be sent with the request 
    # + return - Successful 
    resource isolated function delete contacts/[string contact_id]/companies/[string id](DetachContactFromACompanyHeaders headers = {}) returns company|error {
        string resourcePath = string `/contacts/${getEncodedUri(contact_id)}/companies/${getEncodedUri(id)}`;
        map<string|string[]> httpHeaders = getMapForHeaders(headers);
        return self.clientEp->delete(resourcePath, headers = httpHeaders);
    }

    # Remove subscription from a contact
    #
    # + contact_id - The unique identifier for the contact which is given by Intercom
    # + id - The unique identifier for the subscription type which is given by Intercom
    # + headers - Headers to be sent with the request 
    # + return - Successful 
    resource isolated function delete contacts/[string contact_id]/subscriptions/[string id](DetachSubscriptionTypeToContactHeaders headers = {}) returns subscription_type|error {
        string resourcePath = string `/contacts/${getEncodedUri(contact_id)}/subscriptions/${getEncodedUri(id)}`;
        map<string|string[]> httpHeaders = getMapForHeaders(headers);
        return self.clientEp->delete(resourcePath, headers = httpHeaders);
    }

    # Remove tag from a contact
    #
    # + contact_id - The unique identifier for the contact which is given by Intercom
    # + id - The unique identifier for the tag which is given by Intercom
    # + headers - Headers to be sent with the request 
    # + return - successful 
    resource isolated function delete contacts/[string contact_id]/tags/[string id](DetachTagFromContactHeaders headers = {}) returns tag|error {
        string resourcePath = string `/contacts/${getEncodedUri(contact_id)}/tags/${getEncodedUri(id)}`;
        map<string|string[]> httpHeaders = getMapForHeaders(headers);
        return self.clientEp->delete(resourcePath, headers = httpHeaders);
    }

    # Delete a contact
    #
    # + id - id
    # + headers - Headers to be sent with the request 
    # + return - successful 
    resource isolated function delete contacts/[string id](DeleteContactHeaders headers = {}) returns contact_deleted|error {
        string resourcePath = string `/contacts/${getEncodedUri(id)}`;
        map<string|string[]> httpHeaders = getMapForHeaders(headers);
        return self.clientEp->delete(resourcePath, headers = httpHeaders);
    }

    # Detach a contact from a group conversation
    #
    # + conversation_id - The identifier for the conversation as given by Intercom.
    # + contact_id - The identifier for the contact as given by Intercom.
    # + headers - Headers to be sent with the request 
    # + return - Detach a contact from a group conversation 
    resource isolated function delete conversations/[string conversation_id]/customers/[string contact_id](detach_contact_from_conversation_request payload, DetachContactFromConversationHeaders headers = {}) returns conversation|error {
        string resourcePath = string `/conversations/${getEncodedUri(conversation_id)}/customers/${getEncodedUri(contact_id)}`;
        map<string|string[]> httpHeaders = getMapForHeaders(headers);
        http:Request request = new;
        json jsonBody = payload.toJson();
        request.setPayload(jsonBody, "application/json");
        return self.clientEp->delete(resourcePath, request, httpHeaders);
    }

    # Remove tag from a conversation
    #
    # + conversation_id - conversation_id
    # + id - id
    # + headers - Headers to be sent with the request 
    # + return - successful 
    resource isolated function delete conversations/[string conversation_id]/tags/[string id](tags_id_body payload, DetachTagFromConversationHeaders headers = {}) returns tag|error {
        string resourcePath = string `/conversations/${getEncodedUri(conversation_id)}/tags/${getEncodedUri(id)}`;
        map<string|string[]> httpHeaders = getMapForHeaders(headers);
        http:Request request = new;
        json jsonBody = payload.toJson();
        request.setPayload(jsonBody, "application/json");
        return self.clientEp->delete(resourcePath, request, httpHeaders);
    }

    # Delete a collection
    #
    # + id - The unique identifier for the collection which is given by Intercom.
    # + headers - Headers to be sent with the request 
    # + return - successful 
    resource isolated function delete help_center/collections/[int id](DeleteCollectionHeaders headers = {}) returns deleted_collection_object|error {
        string resourcePath = string `/help_center/collections/${getEncodedUri(id)}`;
        map<string|string[]> httpHeaders = getMapForHeaders(headers);
        return self.clientEp->delete(resourcePath, headers = httpHeaders);
    }

    # Delete a news item
    #
    # + id - The unique identifier for the news item which is given by Intercom.
    # + headers - Headers to be sent with the request 
    # + return - successful 
    resource isolated function delete news/news_items/[int id](DeleteNewsItemHeaders headers = {}) returns deleted_object|error {
        string resourcePath = string `/news/news_items/${getEncodedUri(id)}`;
        map<string|string[]> httpHeaders = getMapForHeaders(headers);
        return self.clientEp->delete(resourcePath, headers = httpHeaders);
    }

    # Delete tag
    #
    # + id - The unique identifier of a given tag
    # + headers - Headers to be sent with the request 
    # + return - Successful 
    resource isolated function delete tags/[string id](DeleteTagHeaders headers = {}) returns http:Response|error {
        string resourcePath = string `/tags/${getEncodedUri(id)}`;
        map<string|string[]> httpHeaders = getMapForHeaders(headers);
        return self.clientEp->delete(resourcePath, headers = httpHeaders);
    }

    # Remove tag from a ticket
    #
    # + ticket_id - ticket_id
    # + id - The unique identifier for the tag which is given by Intercom
    # + headers - Headers to be sent with the request 
    # + return - successful 
    resource isolated function delete tickets/[string ticket_id]/tags/[string id](tags_id_body_1 payload, DetachTagFromTicketHeaders headers = {}) returns tag|error {
        string resourcePath = string `/tickets/${getEncodedUri(ticket_id)}/tags/${getEncodedUri(id)}`;
        map<string|string[]> httpHeaders = getMapForHeaders(headers);
        http:Request request = new;
        json jsonBody = payload.toJson();
        request.setPayload(jsonBody, "application/json");
        return self.clientEp->delete(resourcePath, request, httpHeaders);
    }

    # List all admins
    #
    # + headers - Headers to be sent with the request 
    # + return - Successful response 
    resource isolated function get admins(ListAdminsHeaders headers = {}) returns admin_list|error {
        string resourcePath = string `/admins`;
        map<string|string[]> httpHeaders = getMapForHeaders(headers);
        return self.clientEp->get(resourcePath, httpHeaders);
    }

    # Retrieve an admin
    #
    # + id - The unique identifier of a given admin
    # + headers - Headers to be sent with the request 
    # + return - Admin found 
    resource isolated function get admins/[int id](RetrieveAdminHeaders headers = {}) returns admin|error {
        string resourcePath = string `/admins/${getEncodedUri(id)}`;
        map<string|string[]> httpHeaders = getMapForHeaders(headers);
        return self.clientEp->get(resourcePath, httpHeaders);
    }

    # List all activity logs
    #
    # + headers - Headers to be sent with the request 
    # + queries - Queries to be sent with the request 
    # + return - Successful response 
    resource isolated function get admins/activity_logs(ListActivityLogsHeaders headers = {}, *ListActivityLogsQueries queries) returns activity_log_list|error {
        string resourcePath = string `/admins/activity_logs`;
        resourcePath = resourcePath + check getPathForQueryParam(queries);
        map<string|string[]> httpHeaders = getMapForHeaders(headers);
        return self.clientEp->get(resourcePath, httpHeaders);
    }

    # List all articles
    #
    # + headers - Headers to be sent with the request 
    # + return - successful 
    resource isolated function get articles(ListArticlesHeaders headers = {}) returns article_list|error {
        string resourcePath = string `/articles`;
        map<string|string[]> httpHeaders = getMapForHeaders(headers);
        return self.clientEp->get(resourcePath, httpHeaders);
    }

    # Retrieve an article
    #
    # + id - The unique identifier for the article which is given by Intercom.
    # + headers - Headers to be sent with the request 
    # + return - Article found 
    resource isolated function get articles/[int id](RetrieveArticleHeaders headers = {}) returns article|error {
        string resourcePath = string `/articles/${getEncodedUri(id)}`;
        map<string|string[]> httpHeaders = getMapForHeaders(headers);
        return self.clientEp->get(resourcePath, httpHeaders);
    }

    # Search for articles
    #
    # + headers - Headers to be sent with the request 
    # + queries - Queries to be sent with the request 
    # + return - Search successful 
    resource isolated function get articles/search(SearchArticlesHeaders headers = {}, *SearchArticlesQueries queries) returns article_search_response|error {
        string resourcePath = string `/articles/search`;
        resourcePath = resourcePath + check getPathForQueryParam(queries);
        map<string|string[]> httpHeaders = getMapForHeaders(headers);
        return self.clientEp->get(resourcePath, httpHeaders);
    }

    # Retrieve companies
    #
    # + headers - Headers to be sent with the request 
    # + queries - Queries to be sent with the request 
    # + return - Successful 
    resource isolated function get companies(RetrieveCompanyHeaders headers = {}, *RetrieveCompanyQueries queries) returns company_list|error {
        string resourcePath = string `/companies`;
        resourcePath = resourcePath + check getPathForQueryParam(queries);
        map<string|string[]> httpHeaders = getMapForHeaders(headers);
        return self.clientEp->get(resourcePath, httpHeaders);
    }

    # Retrieve a company by ID
    #
    # + id - The unique identifier for the company which is given by Intercom
    # + headers - Headers to be sent with the request 
    # + return - Successful 
    resource isolated function get companies/[string id](RetrieveACompanyByIdHeaders headers = {}) returns company|error {
        string resourcePath = string `/companies/${getEncodedUri(id)}`;
        map<string|string[]> httpHeaders = getMapForHeaders(headers);
        return self.clientEp->get(resourcePath, httpHeaders);
    }

    # List attached contacts
    #
    # + id - The unique identifier for the company which is given by Intercom
    # + headers - Headers to be sent with the request 
    # + return - Successful 
    resource isolated function get companies/[string id]/contacts(ListAttachedContactsHeaders headers = {}) returns company_attached_contacts|error {
        string resourcePath = string `/companies/${getEncodedUri(id)}/contacts`;
        map<string|string[]> httpHeaders = getMapForHeaders(headers);
        return self.clientEp->get(resourcePath, httpHeaders);
    }

    # List attached segments for companies
    #
    # + id - The unique identifier for the company which is given by Intercom
    # + headers - Headers to be sent with the request 
    # + return - Successful 
    resource isolated function get companies/[string id]/segments(ListAttachedSegmentsForCompaniesHeaders headers = {}) returns company_attached_segments|error {
        string resourcePath = string `/companies/${getEncodedUri(id)}/segments`;
        map<string|string[]> httpHeaders = getMapForHeaders(headers);
        return self.clientEp->get(resourcePath, httpHeaders);
    }

    # Scroll over all companies
    #
    # + headers - Headers to be sent with the request 
    # + queries - Queries to be sent with the request 
    # + return - Successful 
    resource isolated function get companies/scroll(ScrollOverAllCompaniesHeaders headers = {}, *ScrollOverAllCompaniesQueries queries) returns company_scroll|error {
        string resourcePath = string `/companies/scroll`;
        resourcePath = resourcePath + check getPathForQueryParam(queries);
        map<string|string[]> httpHeaders = getMapForHeaders(headers);
        return self.clientEp->get(resourcePath, httpHeaders);
    }

    # List all contacts
    #
    # + headers - Headers to be sent with the request 
    # + return - successful 
    resource isolated function get contacts(ListContactsHeaders headers = {}) returns contact_list|error {
        string resourcePath = string `/contacts`;
        map<string|string[]> httpHeaders = getMapForHeaders(headers);
        return self.clientEp->get(resourcePath, httpHeaders);
    }

    # List all notes
    #
    # + id - The unique identifier of a contact.
    # + headers - Headers to be sent with the request 
    # + return - Successful response 
    resource isolated function get contacts/[int id]/notes(ListNotesHeaders headers = {}) returns note_list|error {
        string resourcePath = string `/contacts/${getEncodedUri(id)}/notes`;
        map<string|string[]> httpHeaders = getMapForHeaders(headers);
        return self.clientEp->get(resourcePath, httpHeaders);
    }

    # List attached segments for contact
    #
    # + contact_id - The unique identifier for the contact which is given by Intercom
    # + headers - Headers to be sent with the request 
    # + return - successful 
    resource isolated function get contacts/[string contact_id]/segments(ListSegmentsForAContactHeaders headers = {}) returns contact_segments|error {
        string resourcePath = string `/contacts/${getEncodedUri(contact_id)}/segments`;
        map<string|string[]> httpHeaders = getMapForHeaders(headers);
        return self.clientEp->get(resourcePath, httpHeaders);
    }

    # List subscriptions for a contact
    #
    # + contact_id - The unique identifier for the contact which is given by Intercom
    # + headers - Headers to be sent with the request 
    # + return - Successful 
    resource isolated function get contacts/[string contact_id]/subscriptions(ListSubscriptionsForAContactHeaders headers = {}) returns subscription_type_list|error {
        string resourcePath = string `/contacts/${getEncodedUri(contact_id)}/subscriptions`;
        map<string|string[]> httpHeaders = getMapForHeaders(headers);
        return self.clientEp->get(resourcePath, httpHeaders);
    }

    # List tags attached to a contact
    #
    # + contact_id - The unique identifier for the contact which is given by Intercom
    # + headers - Headers to be sent with the request 
    # + return - successful 
    resource isolated function get contacts/[string contact_id]/tags(ListTagsForAContactHeaders headers = {}) returns tag_list|error {
        string resourcePath = string `/contacts/${getEncodedUri(contact_id)}/tags`;
        map<string|string[]> httpHeaders = getMapForHeaders(headers);
        return self.clientEp->get(resourcePath, httpHeaders);
    }

    # Get a contact
    #
    # + id - id
    # + headers - Headers to be sent with the request 
    # + return - successful 
    resource isolated function get contacts/[string id](ShowContactHeaders headers = {}) returns contact|error {
        string resourcePath = string `/contacts/${getEncodedUri(id)}`;
        map<string|string[]> httpHeaders = getMapForHeaders(headers);
        return self.clientEp->get(resourcePath, httpHeaders);
    }

    # List attached companies for contact
    #
    # + id - The unique identifier for the contact which is given by Intercom
    # + headers - Headers to be sent with the request 
    # + return - successful 
    resource isolated function get contacts/[string id]/companies(ListCompaniesForAContactHeaders headers = {}) returns contact_attached_companies|error {
        string resourcePath = string `/contacts/${getEncodedUri(id)}/companies`;
        map<string|string[]> httpHeaders = getMapForHeaders(headers);
        return self.clientEp->get(resourcePath, httpHeaders);
    }

    # List all conversations
    #
    # + headers - Headers to be sent with the request 
    # + queries - Queries to be sent with the request 
    # + return - successful 
    resource isolated function get conversations(ListConversationsHeaders headers = {}, *ListConversationsQueries queries) returns paginated_response|error {
        string resourcePath = string `/conversations`;
        resourcePath = resourcePath + check getPathForQueryParam(queries);
        map<string|string[]> httpHeaders = getMapForHeaders(headers);
        return self.clientEp->get(resourcePath, httpHeaders);
    }

    # Retrieve a conversation
    #
    # + id - The id of the conversation to target
    # + headers - Headers to be sent with the request 
    # + queries - Queries to be sent with the request 
    # + return - conversation found 
    resource isolated function get conversations/[int id](RetrieveConversationHeaders headers = {}, *RetrieveConversationQueries queries) returns conversation|error {
        string resourcePath = string `/conversations/${getEncodedUri(id)}`;
        resourcePath = resourcePath + check getPathForQueryParam(queries);
        map<string|string[]> httpHeaders = getMapForHeaders(headers);
        return self.clientEp->get(resourcePath, httpHeaders);
    }

    # List all data attributes
    #
    # + headers - Headers to be sent with the request 
    # + queries - Queries to be sent with the request 
    # + return - Successful response 
    resource isolated function get data_attributes(LisDataAttributesHeaders headers = {}, *LisDataAttributesQueries queries) returns data_attribute_list|error {
        string resourcePath = string `/data_attributes`;
        resourcePath = resourcePath + check getPathForQueryParam(queries);
        map<string|string[]> httpHeaders = getMapForHeaders(headers);
        return self.clientEp->get(resourcePath, httpHeaders);
    }

    # Download content data export
    #
    # + job_identifier - job_identifier
    # + headers - Headers to be sent with the request 
    # + return - successful 
    resource isolated function get download/content/data/[string job_identifier](DownloadDataExportHeaders headers = {}) returns error? {
        string resourcePath = string `/download/content/data/${getEncodedUri(job_identifier)}`;
        map<string|string[]> httpHeaders = getMapForHeaders(headers);
        return self.clientEp->get(resourcePath, httpHeaders);
    }

    # List all data events
    #
    # + headers - Headers to be sent with the request 
    # + queries - Queries to be sent with the request 
    # + return - Successful response 
    resource isolated function get events(LisDataEventsHeaders headers = {}, *LisDataEventsQueries queries) returns data_event_summary|error {
        string resourcePath = string `/events`;
        map<Encoding> queryParamEncoding = {"filter": {style: FORM, explode: true}};
        resourcePath = resourcePath + check getPathForQueryParam(queries, queryParamEncoding);
        map<string|string[]> httpHeaders = getMapForHeaders(headers);
        return self.clientEp->get(resourcePath, httpHeaders);
    }

    # Show content data export
    #
    # + job_identifier - job_identifier
    # + headers - Headers to be sent with the request 
    # + return - successful 
    resource isolated function get export/content/data/[string job_identifier](GetDataExportHeaders headers = {}) returns data_export|error {
        string resourcePath = string `/export/content/data/${getEncodedUri(job_identifier)}`;
        map<string|string[]> httpHeaders = getMapForHeaders(headers);
        return self.clientEp->get(resourcePath, httpHeaders);
    }

    # List all collections
    #
    # + headers - Headers to be sent with the request 
    # + return - Successful 
    resource isolated function get help_center/collections(ListAllCollectionsHeaders headers = {}) returns collection_list|error {
        string resourcePath = string `/help_center/collections`;
        map<string|string[]> httpHeaders = getMapForHeaders(headers);
        return self.clientEp->get(resourcePath, httpHeaders);
    }

    # Retrieve a collection
    #
    # + id - The unique identifier for the collection which is given by Intercom.
    # + headers - Headers to be sent with the request 
    # + return - Collection found 
    resource isolated function get help_center/collections/[int id](RetrieveCollectionHeaders headers = {}) returns collection|error {
        string resourcePath = string `/help_center/collections/${getEncodedUri(id)}`;
        map<string|string[]> httpHeaders = getMapForHeaders(headers);
        return self.clientEp->get(resourcePath, httpHeaders);
    }

    # List all Help Centers
    #
    # + headers - Headers to be sent with the request 
    # + return - Help Centers found 
    resource isolated function get help_center/help_centers(ListHelpCentersHeaders headers = {}) returns help_center_list|error {
        string resourcePath = string `/help_center/help_centers`;
        map<string|string[]> httpHeaders = getMapForHeaders(headers);
        return self.clientEp->get(resourcePath, httpHeaders);
    }

    # Retrieve a Help Center
    #
    # + id - The unique identifier for the collection which is given by Intercom.
    # + headers - Headers to be sent with the request 
    # + return - Collection found 
    resource isolated function get help_center/help_centers/[int id](RetrieveHelpCenterHeaders headers = {}) returns help_center|error {
        string resourcePath = string `/help_center/help_centers/${getEncodedUri(id)}`;
        map<string|string[]> httpHeaders = getMapForHeaders(headers);
        return self.clientEp->get(resourcePath, httpHeaders);
    }

    # Identify an admin
    #
    # + headers - Headers to be sent with the request 
    # + return - Successful response 
    resource isolated function get me(IdentifyAdminHeaders headers = {}) returns admin_with_app|error {
        string resourcePath = string `/me`;
        map<string|string[]> httpHeaders = getMapForHeaders(headers);
        return self.clientEp->get(resourcePath, httpHeaders);
    }

    # List all news items
    #
    # + headers - Headers to be sent with the request 
    # + return - successful 
    resource isolated function get news/news_items(ListNewsItemsHeaders headers = {}) returns paginated_response|error {
        string resourcePath = string `/news/news_items`;
        map<string|string[]> httpHeaders = getMapForHeaders(headers);
        return self.clientEp->get(resourcePath, httpHeaders);
    }

    # Retrieve a news item
    #
    # + id - The unique identifier for the news item which is given by Intercom.
    # + headers - Headers to be sent with the request 
    # + return - successful 
    resource isolated function get news/news_items/[int id](RetrieveNewsItemHeaders headers = {}) returns news_item|error {
        string resourcePath = string `/news/news_items/${getEncodedUri(id)}`;
        map<string|string[]> httpHeaders = getMapForHeaders(headers);
        return self.clientEp->get(resourcePath, httpHeaders);
    }

    # List all newsfeeds
    #
    # + headers - Headers to be sent with the request 
    # + return - successful 
    resource isolated function get news/newsfeeds(ListNewsfeedsHeaders headers = {}) returns paginated_response|error {
        string resourcePath = string `/news/newsfeeds`;
        map<string|string[]> httpHeaders = getMapForHeaders(headers);
        return self.clientEp->get(resourcePath, httpHeaders);
    }

    # Retrieve a newsfeed
    #
    # + id - The unique identifier for the news feed item which is given by Intercom.
    # + headers - Headers to be sent with the request 
    # + return - successful 
    resource isolated function get news/newsfeeds/[string id](RetrieveNewsfeedHeaders headers = {}) returns newsfeed|error {
        string resourcePath = string `/news/newsfeeds/${getEncodedUri(id)}`;
        map<string|string[]> httpHeaders = getMapForHeaders(headers);
        return self.clientEp->get(resourcePath, httpHeaders);
    }

    # List all live newsfeed items
    #
    # + id - The unique identifier for the news feed item which is given by Intercom.
    # + headers - Headers to be sent with the request 
    # + return - successful 
    resource isolated function get news/newsfeeds/[string id]/items(ListLiveNewsfeedItemsHeaders headers = {}) returns paginated_response|error {
        string resourcePath = string `/news/newsfeeds/${getEncodedUri(id)}/items`;
        map<string|string[]> httpHeaders = getMapForHeaders(headers);
        return self.clientEp->get(resourcePath, httpHeaders);
    }

    # Retrieve a note
    #
    # + id - The unique identifier of a given note
    # + headers - Headers to be sent with the request 
    # + return - Note found 
    resource isolated function get notes/[int id](RetrieveNoteHeaders headers = {}) returns note|error {
        string resourcePath = string `/notes/${getEncodedUri(id)}`;
        map<string|string[]> httpHeaders = getMapForHeaders(headers);
        return self.clientEp->get(resourcePath, httpHeaders);
    }

    # List all segments
    #
    # + headers - Headers to be sent with the request 
    # + queries - Queries to be sent with the request 
    # + return - Successful response 
    resource isolated function get segments(ListSegmentsHeaders headers = {}, *ListSegmentsQueries queries) returns segment_list|error {
        string resourcePath = string `/segments`;
        resourcePath = resourcePath + check getPathForQueryParam(queries);
        map<string|string[]> httpHeaders = getMapForHeaders(headers);
        return self.clientEp->get(resourcePath, httpHeaders);
    }

    # Retrieve a segment
    #
    # + id - The unique identified of a given segment.
    # + headers - Headers to be sent with the request 
    # + return - Successful response 
    resource isolated function get segments/[string id](RetrieveSegmentHeaders headers = {}) returns segment|error {
        string resourcePath = string `/segments/${getEncodedUri(id)}`;
        map<string|string[]> httpHeaders = getMapForHeaders(headers);
        return self.clientEp->get(resourcePath, httpHeaders);
    }

    # List subscription types
    #
    # + headers - Headers to be sent with the request 
    # + return - Successful 
    resource isolated function get subscription_types(ListSubscriptionTypesHeaders headers = {}) returns subscription_type_list|error {
        string resourcePath = string `/subscription_types`;
        map<string|string[]> httpHeaders = getMapForHeaders(headers);
        return self.clientEp->get(resourcePath, httpHeaders);
    }

    # List all tags
    #
    # + headers - Headers to be sent with the request 
    # + return - successful 
    resource isolated function get tags(ListTagsHeaders headers = {}) returns tag_list|error {
        string resourcePath = string `/tags`;
        map<string|string[]> httpHeaders = getMapForHeaders(headers);
        return self.clientEp->get(resourcePath, httpHeaders);
    }

    # Find a specific tag
    #
    # + id - The unique identifier of a given tag
    # + headers - Headers to be sent with the request 
    # + return - Tag found 
    resource isolated function get tags/[string id](FindTagHeaders headers = {}) returns tag|error {
        string resourcePath = string `/tags/${getEncodedUri(id)}`;
        map<string|string[]> httpHeaders = getMapForHeaders(headers);
        return self.clientEp->get(resourcePath, httpHeaders);
    }

    # List all teams
    #
    # + headers - Headers to be sent with the request 
    # + return - successful 
    resource isolated function get teams(ListTeamsHeaders headers = {}) returns team_list|error {
        string resourcePath = string `/teams`;
        map<string|string[]> httpHeaders = getMapForHeaders(headers);
        return self.clientEp->get(resourcePath, httpHeaders);
    }

    # Retrieve a team
    #
    # + id - The unique identifier of a given team.
    # + headers - Headers to be sent with the request 
    # + return - successful 
    resource isolated function get teams/[string id](RetrieveTeamHeaders headers = {}) returns team|error {
        string resourcePath = string `/teams/${getEncodedUri(id)}`;
        map<string|string[]> httpHeaders = getMapForHeaders(headers);
        return self.clientEp->get(resourcePath, httpHeaders);
    }

    # List all ticket types
    #
    # + headers - Headers to be sent with the request 
    # + return - successful 
    resource isolated function get ticket_types(ListTicketTypesHeaders headers = {}) returns ticket_type_list|error {
        string resourcePath = string `/ticket_types`;
        map<string|string[]> httpHeaders = getMapForHeaders(headers);
        return self.clientEp->get(resourcePath, httpHeaders);
    }

    # Retrieve a ticket type
    #
    # + id - The unique identifier for the ticket type which is given by Intercom.
    # + headers - Headers to be sent with the request 
    # + return - Ticket type found 
    resource isolated function get ticket_types/[string id](GetTicketTypeHeaders headers = {}) returns ticket_type|error {
        string resourcePath = string `/ticket_types/${getEncodedUri(id)}`;
        map<string|string[]> httpHeaders = getMapForHeaders(headers);
        return self.clientEp->get(resourcePath, httpHeaders);
    }

    # Retrieve a ticket
    #
    # + id - The unique identifier for the ticket which is given by Intercom.
    # + headers - Headers to be sent with the request 
    # + return - Ticket found 
    resource isolated function get tickets/[string id](GetTicketHeaders headers = {}) returns ticket|error {
        string resourcePath = string `/tickets/${getEncodedUri(id)}`;
        map<string|string[]> httpHeaders = getMapForHeaders(headers);
        return self.clientEp->get(resourcePath, httpHeaders);
    }

    # Retrieve a visitor with User ID
    #
    # + headers - Headers to be sent with the request 
    # + queries - Queries to be sent with the request 
    # + return - successful 
    resource isolated function get visitors(RetrieveVisitorWithUserIdHeaders headers = {}, *RetrieveVisitorWithUserIdQueries queries) returns visitor|error {
        string resourcePath = string `/visitors`;
        resourcePath = resourcePath + check getPathForQueryParam(queries);
        map<string|string[]> httpHeaders = getMapForHeaders(headers);
        return self.clientEp->get(resourcePath, httpHeaders);
    }

    # Create an article
    #
    # + headers - Headers to be sent with the request 
    # + return - article created 
    resource isolated function post articles(create_article_request payload, CreateArticleHeaders headers = {}) returns article|error {
        string resourcePath = string `/articles`;
        map<string|string[]> httpHeaders = getMapForHeaders(headers);
        http:Request request = new;
        json jsonBody = payload.toJson();
        request.setPayload(jsonBody, "application/json");
        return self.clientEp->post(resourcePath, request, httpHeaders);
    }

    # Create or Update a company
    #
    # + headers - Headers to be sent with the request 
    # + return - Successful 
    resource isolated function post companies(create_or_update_company_request payload, CreateOrUpdateCompanyHeaders headers = {}) returns company|error {
        string resourcePath = string `/companies`;
        map<string|string[]> httpHeaders = getMapForHeaders(headers);
        http:Request request = new;
        json jsonBody = payload.toJson();
        request.setPayload(jsonBody, "application/json");
        return self.clientEp->post(resourcePath, request, httpHeaders);
    }

    # List all companies
    #
    # + headers - Headers to be sent with the request 
    # + queries - Queries to be sent with the request 
    # + return - Successful 
    resource isolated function post companies/list(ListAllCompaniesHeaders headers = {}, *ListAllCompaniesQueries queries) returns company_list|error {
        string resourcePath = string `/companies/list`;
        resourcePath = resourcePath + check getPathForQueryParam(queries);
        map<string|string[]> httpHeaders = getMapForHeaders(headers);
        http:Request request = new;
        return self.clientEp->post(resourcePath, request, httpHeaders);
    }

    # Create contact
    #
    # + headers - Headers to be sent with the request 
    # + return - successful 
    resource isolated function post contacts(contacts_body payload, CreateContactHeaders headers = {}) returns contact|error {
        string resourcePath = string `/contacts`;
        map<string|string[]> httpHeaders = getMapForHeaders(headers);
        http:Request request = new;
        json jsonBody = payload.toJson();
        request.setPayload(jsonBody, "application/json");
        return self.clientEp->post(resourcePath, request, httpHeaders);
    }

    # Create a note
    #
    # + id - The unique identifier of a given contact.
    # + headers - Headers to be sent with the request 
    # + return - Successful response 
    resource isolated function post contacts/[int id]/notes(id_notes_body payload, CreateNoteHeaders headers = {}) returns note|error {
        string resourcePath = string `/contacts/${getEncodedUri(id)}/notes`;
        map<string|string[]> httpHeaders = getMapForHeaders(headers);
        http:Request request = new;
        json jsonBody = payload.toJson();
        request.setPayload(jsonBody, "application/json");
        return self.clientEp->post(resourcePath, request, httpHeaders);
    }

    # Add subscription to a contact
    #
    # + contact_id - The unique identifier for the contact which is given by Intercom
    # + headers - Headers to be sent with the request 
    # + return - Successful 
    resource isolated function post contacts/[string contact_id]/subscriptions(contact_id_subscriptions_body payload, AttachSubscriptionTypeToContactHeaders headers = {}) returns subscription_type|error {
        string resourcePath = string `/contacts/${getEncodedUri(contact_id)}/subscriptions`;
        map<string|string[]> httpHeaders = getMapForHeaders(headers);
        http:Request request = new;
        json jsonBody = payload.toJson();
        request.setPayload(jsonBody, "application/json");
        return self.clientEp->post(resourcePath, request, httpHeaders);
    }

    # Add tag to a contact
    #
    # + contact_id - The unique identifier for the contact which is given by Intercom
    # + headers - Headers to be sent with the request 
    # + return - successful 
    resource isolated function post contacts/[string contact_id]/tags(contact_id_tags_body payload, AttachTagToContactHeaders headers = {}) returns tag|error {
        string resourcePath = string `/contacts/${getEncodedUri(contact_id)}/tags`;
        map<string|string[]> httpHeaders = getMapForHeaders(headers);
        http:Request request = new;
        json jsonBody = payload.toJson();
        request.setPayload(jsonBody, "application/json");
        return self.clientEp->post(resourcePath, request, httpHeaders);
    }

    # Archive contact
    #
    # + id - id
    # + headers - Headers to be sent with the request 
    # + return - successful 
    resource isolated function post contacts/[string id]/archive(ArchiveContactHeaders headers = {}) returns contact_archived|error {
        string resourcePath = string `/contacts/${getEncodedUri(id)}/archive`;
        map<string|string[]> httpHeaders = getMapForHeaders(headers);
        http:Request request = new;
        return self.clientEp->post(resourcePath, request, httpHeaders);
    }

    # Attach a Contact to a Company
    #
    # + id - The unique identifier for the contact which is given by Intercom
    # + headers - Headers to be sent with the request 
    # + return - Successful 
    resource isolated function post contacts/[string id]/companies(id_companies_body payload, AttachContactToACompanyHeaders headers = {}) returns company|error {
        string resourcePath = string `/contacts/${getEncodedUri(id)}/companies`;
        map<string|string[]> httpHeaders = getMapForHeaders(headers);
        http:Request request = new;
        json jsonBody = payload.toJson();
        request.setPayload(jsonBody, "application/json");
        return self.clientEp->post(resourcePath, request, httpHeaders);
    }

    # Unarchive contact
    #
    # + id - id
    # + headers - Headers to be sent with the request 
    # + return - successful 
    resource isolated function post contacts/[string id]/unarchive(UnarchiveContactHeaders headers = {}) returns contact_unarchived|error {
        string resourcePath = string `/contacts/${getEncodedUri(id)}/unarchive`;
        map<string|string[]> httpHeaders = getMapForHeaders(headers);
        http:Request request = new;
        return self.clientEp->post(resourcePath, request, httpHeaders);
    }

    # Merge a lead and a user
    #
    # + headers - Headers to be sent with the request 
    # + return - successful 
    resource isolated function post contacts/merge(merge_contacts_request payload, MergeContactHeaders headers = {}) returns contact|error {
        string resourcePath = string `/contacts/merge`;
        map<string|string[]> httpHeaders = getMapForHeaders(headers);
        http:Request request = new;
        json jsonBody = payload.toJson();
        request.setPayload(jsonBody, "application/json");
        return self.clientEp->post(resourcePath, request, httpHeaders);
    }

    # Search contacts
    #
    # + headers - Headers to be sent with the request 
    # + return - successful 
    resource isolated function post contacts/search(search_request payload, SearchContactsHeaders headers = {}) returns contact_list|error {
        string resourcePath = string `/contacts/search`;
        map<string|string[]> httpHeaders = getMapForHeaders(headers);
        http:Request request = new;
        json jsonBody = payload.toJson();
        request.setPayload(jsonBody, "application/json");
        return self.clientEp->post(resourcePath, request, httpHeaders);
    }

    # Creates a conversation
    #
    # + headers - Headers to be sent with the request 
    # + return - conversation created 
    resource isolated function post conversations(create_conversation_request payload, CreateConversationHeaders headers = {}) returns message|error {
        string resourcePath = string `/conversations`;
        map<string|string[]> httpHeaders = getMapForHeaders(headers);
        http:Request request = new;
        json jsonBody = payload.toJson();
        request.setPayload(jsonBody, "application/json");
        return self.clientEp->post(resourcePath, request, httpHeaders);
    }

    # Convert a conversation to a ticket
    #
    # + id - The id of the conversation to target
    # + headers - Headers to be sent with the request 
    # + return - successful 
    resource isolated function post conversations/[int id]/convert(convert_conversation_to_ticket_request payload, ConvertConversationToTicketHeaders headers = {}) returns ticket|error {
        string resourcePath = string `/conversations/${getEncodedUri(id)}/convert`;
        map<string|string[]> httpHeaders = getMapForHeaders(headers);
        http:Request request = new;
        json jsonBody = payload.toJson();
        request.setPayload(jsonBody, "application/json");
        return self.clientEp->post(resourcePath, request, httpHeaders);
    }

    # Add tag to a conversation
    #
    # + conversation_id - conversation_id
    # + headers - Headers to be sent with the request 
    # + return - successful 
    resource isolated function post conversations/[string conversation_id]/tags(conversation_id_tags_body payload, AttachTagToConversationHeaders headers = {}) returns tag|error {
        string resourcePath = string `/conversations/${getEncodedUri(conversation_id)}/tags`;
        map<string|string[]> httpHeaders = getMapForHeaders(headers);
        http:Request request = new;
        json jsonBody = payload.toJson();
        request.setPayload(jsonBody, "application/json");
        return self.clientEp->post(resourcePath, request, httpHeaders);
    }

    # Attach a contact to a conversation
    #
    # + id - The identifier for the conversation as given by Intercom.
    # + headers - Headers to be sent with the request 
    # + return - Attach a contact to a conversation 
    resource isolated function post conversations/[string id]/customers(attach_contact_to_conversation_request payload, AttachContactToConversationHeaders headers = {}) returns conversation|error {
        string resourcePath = string `/conversations/${getEncodedUri(id)}/customers`;
        map<string|string[]> httpHeaders = getMapForHeaders(headers);
        http:Request request = new;
        json jsonBody = payload.toJson();
        request.setPayload(jsonBody, "application/json");
        return self.clientEp->post(resourcePath, request, httpHeaders);
    }

    # Manage a conversation
    #
    # + id - The identifier for the conversation as given by Intercom.
    # + headers - Headers to be sent with the request 
    # + return - Assign a conversation 
    resource isolated function post conversations/[string id]/parts(id_parts_body payload, ManageConversationHeaders headers = {}) returns conversation|error {
        string resourcePath = string `/conversations/${getEncodedUri(id)}/parts`;
        map<string|string[]> httpHeaders = getMapForHeaders(headers);
        http:Request request = new;
        json jsonBody = payload.toJson();
        request.setPayload(jsonBody, "application/json");
        return self.clientEp->post(resourcePath, request, httpHeaders);
    }

    # Reply to a conversation
    #
    # + id - The Intercom provisioned identifier for the conversation or the string "last" to reply to the last part of the conversation
    # + headers - Headers to be sent with the request 
    # + return - User last conversation reply 
    resource isolated function post conversations/[string id]/reply(reply_conversation_request payload, ReplyConversationHeaders headers = {}) returns conversation|error {
        string resourcePath = string `/conversations/${getEncodedUri(id)}/reply`;
        map<string|string[]> httpHeaders = getMapForHeaders(headers);
        http:Request request = new;
        json jsonBody = payload.toJson();
        request.setPayload(jsonBody, "application/json");
        return self.clientEp->post(resourcePath, request, httpHeaders);
    }

    # Run Assignment Rules on a conversation
    #
    # + id - The identifier for the conversation as given by Intercom.
    # + headers - Headers to be sent with the request 
    # + return - Assign a conversation using assignment rules 
    resource isolated function post conversations/[string id]/run_assignment_rules(AutoAssignConversationHeaders headers = {}) returns conversation|error {
        string resourcePath = string `/conversations/${getEncodedUri(id)}/run_assignment_rules`;
        map<string|string[]> httpHeaders = getMapForHeaders(headers);
        http:Request request = new;
        return self.clientEp->post(resourcePath, request, httpHeaders);
    }

    # Redact a conversation part
    #
    # + headers - Headers to be sent with the request 
    # + return - Redact a conversation part 
    resource isolated function post conversations/redact(redact_conversation_request payload, RedactConversationHeaders headers = {}) returns conversation|error {
        string resourcePath = string `/conversations/redact`;
        map<string|string[]> httpHeaders = getMapForHeaders(headers);
        http:Request request = new;
        json jsonBody = payload.toJson();
        request.setPayload(jsonBody, "application/json");
        return self.clientEp->post(resourcePath, request, httpHeaders);
    }

    # Search conversations
    #
    # + headers - Headers to be sent with the request 
    # + return - successful 
    resource isolated function post conversations/search(search_request payload, SearchConversationsHeaders headers = {}) returns conversation_list|error {
        string resourcePath = string `/conversations/search`;
        map<string|string[]> httpHeaders = getMapForHeaders(headers);
        http:Request request = new;
        json jsonBody = payload.toJson();
        request.setPayload(jsonBody, "application/json");
        return self.clientEp->post(resourcePath, request, httpHeaders);
    }

    # Create a data attribute
    #
    # + headers - Headers to be sent with the request 
    # + return - Successful 
    resource isolated function post data_attributes(create_data_attribute_request payload, CreateDataAttributeHeaders headers = {}) returns data_attribute|error {
        string resourcePath = string `/data_attributes`;
        map<string|string[]> httpHeaders = getMapForHeaders(headers);
        http:Request request = new;
        json jsonBody = payload.toJson();
        request.setPayload(jsonBody, "application/json");
        return self.clientEp->post(resourcePath, request, httpHeaders);
    }

    # Submit a data event
    #
    # + headers - Headers to be sent with the request 
    # + return - successful 
    resource isolated function post events(create_data_event_request payload, CreateDataEventHeaders headers = {}) returns http:Response|error {
        string resourcePath = string `/events`;
        map<string|string[]> httpHeaders = getMapForHeaders(headers);
        http:Request request = new;
        json jsonBody = payload.toJson();
        request.setPayload(jsonBody, "application/json");
        return self.clientEp->post(resourcePath, request, httpHeaders);
    }

    # Create event summaries
    #
    # + headers - Headers to be sent with the request 
    # + return - successful 
    resource isolated function post events/summaries(create_data_event_summaries_request payload, DataEventSummariesHeaders headers = {}) returns http:Response|error {
        string resourcePath = string `/events/summaries`;
        map<string|string[]> httpHeaders = getMapForHeaders(headers);
        http:Request request = new;
        json jsonBody = payload.toJson();
        request.setPayload(jsonBody, "application/json");
        return self.clientEp->post(resourcePath, request, httpHeaders);
    }

    # Cancel content data export
    #
    # + job_identifier - job_identifier
    # + headers - Headers to be sent with the request 
    # + return - successful 
    resource isolated function post export/cancel/[string job_identifier](CancelDataExportHeaders headers = {}) returns data_export|error {
        string resourcePath = string `/export/cancel/${getEncodedUri(job_identifier)}`;
        map<string|string[]> httpHeaders = getMapForHeaders(headers);
        http:Request request = new;
        return self.clientEp->post(resourcePath, request, httpHeaders);
    }

    # Create content data export
    #
    # + headers - Headers to be sent with the request 
    # + return - successful 
    resource isolated function post export/content/data(create_data_exports_request payload, CreateDataExportHeaders headers = {}) returns data_export|error {
        string resourcePath = string `/export/content/data`;
        map<string|string[]> httpHeaders = getMapForHeaders(headers);
        http:Request request = new;
        json jsonBody = payload.toJson();
        request.setPayload(jsonBody, "application/json");
        return self.clientEp->post(resourcePath, request, httpHeaders);
    }

    # Create a collection
    #
    # + headers - Headers to be sent with the request 
    # + return - collection created 
    resource isolated function post help_center/collections(create_collection_request payload, CreateCollectionHeaders headers = {}) returns collection|error {
        string resourcePath = string `/help_center/collections`;
        map<string|string[]> httpHeaders = getMapForHeaders(headers);
        http:Request request = new;
        json jsonBody = payload.toJson();
        request.setPayload(jsonBody, "application/json");
        return self.clientEp->post(resourcePath, request, httpHeaders);
    }

    # Create a message
    #
    # + headers - Headers to be sent with the request 
    # + return - admin message created 
    resource isolated function post messages(create_message_request payload, CreateMessageHeaders headers = {}) returns message|error {
        string resourcePath = string `/messages`;
        map<string|string[]> httpHeaders = getMapForHeaders(headers);
        http:Request request = new;
        json jsonBody = payload.toJson();
        request.setPayload(jsonBody, "application/json");
        return self.clientEp->post(resourcePath, request, httpHeaders);
    }

    # Create a news item
    #
    # + headers - Headers to be sent with the request 
    # + return - successful 
    resource isolated function post news/news_items(news_item_request payload, CreateNewsItemHeaders headers = {}) returns news_item|error {
        string resourcePath = string `/news/news_items`;
        map<string|string[]> httpHeaders = getMapForHeaders(headers);
        http:Request request = new;
        json jsonBody = payload.toJson();
        request.setPayload(jsonBody, "application/json");
        return self.clientEp->post(resourcePath, request, httpHeaders);
    }

    # Create a phone Switch
    #
    # + headers - Headers to be sent with the request 
    # + return - successful 
    resource isolated function post phone_call_redirects(create_phone_switch_request payload, CreatePhoneSwitchHeaders headers = {}) returns phone_switch|error {
        string resourcePath = string `/phone_call_redirects`;
        map<string|string[]> httpHeaders = getMapForHeaders(headers);
        http:Request request = new;
        json jsonBody = payload.toJson();
        request.setPayload(jsonBody, "application/json");
        return self.clientEp->post(resourcePath, request, httpHeaders);
    }

    # Create or update a tag, Tag or untag companies, Tag contacts
    #
    # + headers - Headers to be sent with the request 
    # + return - Action successful 
    resource isolated function post tags(tags_body payload, CreateTagHeaders headers = {}) returns tag|error {
        string resourcePath = string `/tags`;
        map<string|string[]> httpHeaders = getMapForHeaders(headers);
        http:Request request = new;
        json jsonBody = payload.toJson();
        request.setPayload(jsonBody, "application/json");
        return self.clientEp->post(resourcePath, request, httpHeaders);
    }

    # Create a ticket type
    #
    # + headers - Headers to be sent with the request 
    # + return - Ticket type created 
    resource isolated function post ticket_types(create_ticket_type_request payload, CreateTicketTypeHeaders headers = {}) returns ticket_type|error {
        string resourcePath = string `/ticket_types`;
        map<string|string[]> httpHeaders = getMapForHeaders(headers);
        http:Request request = new;
        json jsonBody = payload.toJson();
        request.setPayload(jsonBody, "application/json");
        return self.clientEp->post(resourcePath, request, httpHeaders);
    }

    # Create a new attribute for a ticket type
    #
    # + ticket_type_id - The unique identifier for the ticket type which is given by Intercom.
    # + headers - Headers to be sent with the request 
    # + return - Ticket Type Attribute created 
    resource isolated function post ticket_types/[string ticket_type_id]/attributes(create_ticket_type_attribute_request payload, CreateTicketTypeAttributeHeaders headers = {}) returns ticket_type_attribute|error {
        string resourcePath = string `/ticket_types/${getEncodedUri(ticket_type_id)}/attributes`;
        map<string|string[]> httpHeaders = getMapForHeaders(headers);
        http:Request request = new;
        json jsonBody = payload.toJson();
        request.setPayload(jsonBody, "application/json");
        return self.clientEp->post(resourcePath, request, httpHeaders);
    }

    # Create a ticket
    #
    # + headers - Headers to be sent with the request 
    # + return - Successful response 
    resource isolated function post tickets(create_ticket_request payload, CreateTicketHeaders headers = {}) returns ticket|error {
        string resourcePath = string `/tickets`;
        map<string|string[]> httpHeaders = getMapForHeaders(headers);
        http:Request request = new;
        json jsonBody = payload.toJson();
        request.setPayload(jsonBody, "application/json");
        return self.clientEp->post(resourcePath, request, httpHeaders);
    }

    # Reply to a ticket
    #
    # + headers - Headers to be sent with the request 
    # + return - Admin quick_reply reply 
    resource isolated function post tickets/[string id]/reply(id_reply_body payload, ReplyTicketHeaders headers = {}) returns ticket_reply|error {
        string resourcePath = string `/tickets/${getEncodedUri(id)}/reply`;
        map<string|string[]> httpHeaders = getMapForHeaders(headers);
        http:Request request = new;
        json jsonBody = payload.toJson();
        request.setPayload(jsonBody, "application/json");
        return self.clientEp->post(resourcePath, request, httpHeaders);
    }

    # Add tag to a ticket
    #
    # + ticket_id - ticket_id
    # + headers - Headers to be sent with the request 
    # + return - successful 
    resource isolated function post tickets/[string ticket_id]/tags(ticket_id_tags_body payload, AttachTagToTicketHeaders headers = {}) returns tag|error {
        string resourcePath = string `/tickets/${getEncodedUri(ticket_id)}/tags`;
        map<string|string[]> httpHeaders = getMapForHeaders(headers);
        http:Request request = new;
        json jsonBody = payload.toJson();
        request.setPayload(jsonBody, "application/json");
        return self.clientEp->post(resourcePath, request, httpHeaders);
    }

    # Search tickets
    #
    # + headers - Headers to be sent with the request 
    # + return - successful 
    resource isolated function post tickets/search(search_request payload, SearchTicketsHeaders headers = {}) returns ticket_list|error {
        string resourcePath = string `/tickets/search`;
        map<string|string[]> httpHeaders = getMapForHeaders(headers);
        http:Request request = new;
        json jsonBody = payload.toJson();
        request.setPayload(jsonBody, "application/json");
        return self.clientEp->post(resourcePath, request, httpHeaders);
    }

    # Convert a visitor
    #
    # + headers - Headers to be sent with the request 
    # + return - successful 
    resource isolated function post visitors/convert(convert_visitor_request payload, ConvertVisitorHeaders headers = {}) returns contact|error {
        string resourcePath = string `/visitors/convert`;
        map<string|string[]> httpHeaders = getMapForHeaders(headers);
        http:Request request = new;
        json jsonBody = payload.toJson();
        request.setPayload(jsonBody, "application/json");
        return self.clientEp->post(resourcePath, request, httpHeaders);
    }

    # Set an admin to away
    #
    # + id - The unique identifier of a given admin
    # + headers - Headers to be sent with the request 
    # + return - Successful response 
    resource isolated function put admins/[int id]/away(id_away_body payload, SetAwayAdminHeaders headers = {}) returns admin|error {
        string resourcePath = string `/admins/${getEncodedUri(id)}/away`;
        map<string|string[]> httpHeaders = getMapForHeaders(headers);
        http:Request request = new;
        json jsonBody = payload.toJson();
        request.setPayload(jsonBody, "application/json");
        return self.clientEp->put(resourcePath, request, httpHeaders);
    }

    # Update an article
    #
    # + id - The unique identifier for the article which is given by Intercom.
    # + headers - Headers to be sent with the request 
    # + return - successful 
    resource isolated function put articles/[int id](update_article_request payload, UpdateArticleHeaders headers = {}) returns article|error {
        string resourcePath = string `/articles/${getEncodedUri(id)}`;
        map<string|string[]> httpHeaders = getMapForHeaders(headers);
        http:Request request = new;
        json jsonBody = payload.toJson();
        request.setPayload(jsonBody, "application/json");
        return self.clientEp->put(resourcePath, request, httpHeaders);
    }

    # Update a company
    #
    # + id - The unique identifier for the company which is given by Intercom
    # + headers - Headers to be sent with the request 
    # + return - Successful 
    resource isolated function put companies/[string id](UpdateCompanyHeaders headers = {}) returns company|error {
        string resourcePath = string `/companies/${getEncodedUri(id)}`;
        map<string|string[]> httpHeaders = getMapForHeaders(headers);
        http:Request request = new;
        return self.clientEp->put(resourcePath, request, httpHeaders);
    }

    # Update a contact
    #
    # + id - id
    # + headers - Headers to be sent with the request 
    # + return - successful 
    resource isolated function put contacts/[string id](contacts_id_body payload, UpdateContactHeaders headers = {}) returns contact|error {
        string resourcePath = string `/contacts/${getEncodedUri(id)}`;
        map<string|string[]> httpHeaders = getMapForHeaders(headers);
        http:Request request = new;
        json jsonBody = payload.toJson();
        request.setPayload(jsonBody, "application/json");
        return self.clientEp->put(resourcePath, request, httpHeaders);
    }

    # Update a conversation
    #
    # + id - The id of the conversation to target
    # + headers - Headers to be sent with the request 
    # + queries - Queries to be sent with the request 
    # + return - conversation found 
    resource isolated function put conversations/[int id](update_conversation_request payload, UpdateConversationHeaders headers = {}, *UpdateConversationQueries queries) returns conversation|error {
        string resourcePath = string `/conversations/${getEncodedUri(id)}`;
        resourcePath = resourcePath + check getPathForQueryParam(queries);
        map<string|string[]> httpHeaders = getMapForHeaders(headers);
        http:Request request = new;
        json jsonBody = payload.toJson();
        request.setPayload(jsonBody, "application/json");
        return self.clientEp->put(resourcePath, request, httpHeaders);
    }

    # Update a data attribute
    #
    # + id - The data attribute id
    # + headers - Headers to be sent with the request 
    # + return - Successful 
    resource isolated function put data_attributes/[int id](update_data_attribute_request payload, UpdateDataAttributeHeaders headers = {}) returns data_attribute|error {
        string resourcePath = string `/data_attributes/${getEncodedUri(id)}`;
        map<string|string[]> httpHeaders = getMapForHeaders(headers);
        http:Request request = new;
        json jsonBody = payload.toJson();
        request.setPayload(jsonBody, "application/json");
        return self.clientEp->put(resourcePath, request, httpHeaders);
    }

    # Update a collection
    #
    # + id - The unique identifier for the collection which is given by Intercom.
    # + headers - Headers to be sent with the request 
    # + return - successful 
    resource isolated function put help_center/collections/[int id](update_collection_request payload, UpdateCollectionHeaders headers = {}) returns collection|error {
        string resourcePath = string `/help_center/collections/${getEncodedUri(id)}`;
        map<string|string[]> httpHeaders = getMapForHeaders(headers);
        http:Request request = new;
        json jsonBody = payload.toJson();
        request.setPayload(jsonBody, "application/json");
        return self.clientEp->put(resourcePath, request, httpHeaders);
    }

    # Update a news item
    #
    # + id - The unique identifier for the news item which is given by Intercom.
    # + headers - Headers to be sent with the request 
    # + return - successful 
    resource isolated function put news/news_items/[int id](news_item_request payload, UpdateNewsItemHeaders headers = {}) returns news_item|error {
        string resourcePath = string `/news/news_items/${getEncodedUri(id)}`;
        map<string|string[]> httpHeaders = getMapForHeaders(headers);
        http:Request request = new;
        json jsonBody = payload.toJson();
        request.setPayload(jsonBody, "application/json");
        return self.clientEp->put(resourcePath, request, httpHeaders);
    }

    # Update a ticket type
    #
    # + id - The unique identifier for the ticket type which is given by Intercom.
    # + headers - Headers to be sent with the request 
    # + return - Ticket type updated 
    resource isolated function put ticket_types/[string id](update_ticket_type_request payload, UpdateTicketTypeHeaders headers = {}) returns ticket_type|error {
        string resourcePath = string `/ticket_types/${getEncodedUri(id)}`;
        map<string|string[]> httpHeaders = getMapForHeaders(headers);
        http:Request request = new;
        json jsonBody = payload.toJson();
        request.setPayload(jsonBody, "application/json");
        return self.clientEp->put(resourcePath, request, httpHeaders);
    }

    # Update an existing attribute for a ticket type
    #
    # + ticket_type_id - The unique identifier for the ticket type which is given by Intercom.
    # + id - The unique identifier for the ticket type attribute which is given by Intercom.
    # + headers - Headers to be sent with the request 
    # + return - Ticket Type Attribute updated 
    resource isolated function put ticket_types/[string ticket_type_id]/attributes/[string id](update_ticket_type_attribute_request payload, UpdateTicketTypeAttributeHeaders headers = {}) returns ticket_type_attribute|error {
        string resourcePath = string `/ticket_types/${getEncodedUri(ticket_type_id)}/attributes/${getEncodedUri(id)}`;
        map<string|string[]> httpHeaders = getMapForHeaders(headers);
        http:Request request = new;
        json jsonBody = payload.toJson();
        request.setPayload(jsonBody, "application/json");
        return self.clientEp->put(resourcePath, request, httpHeaders);
    }

    # Update a ticket
    #
    # + id - The unique identifier for the ticket which is given by Intercom
    # + headers - Headers to be sent with the request 
    # + return - Successful response 
    resource isolated function put tickets/[string id](update_ticket_request payload, UpdateTicketHeaders headers = {}) returns ticket|error {
        string resourcePath = string `/tickets/${getEncodedUri(id)}`;
        map<string|string[]> httpHeaders = getMapForHeaders(headers);
        http:Request request = new;
        json jsonBody = payload.toJson();
        request.setPayload(jsonBody, "application/json");
        return self.clientEp->put(resourcePath, request, httpHeaders);
    }

    # Update a visitor
    #
    # + headers - Headers to be sent with the request 
    # + return - successful 
    resource isolated function put visitors(update_visitor_request payload, UpdateVisitorHeaders headers = {}) returns visitor|error {
        string resourcePath = string `/visitors`;
        map<string|string[]> httpHeaders = getMapForHeaders(headers);
        http:Request request = new;
        json jsonBody = payload.toJson();
        request.setPayload(jsonBody, "application/json");
        return self.clientEp->put(resourcePath, request, httpHeaders);
    }
}
