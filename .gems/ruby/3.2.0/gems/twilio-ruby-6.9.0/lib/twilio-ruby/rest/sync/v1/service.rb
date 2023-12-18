##
#    This code was generated by
#    ___ _ _ _ _ _    _ ____    ____ ____ _    ____ ____ _  _ ____ ____ ____ ___ __   __
#     |  | | | | |    | |  | __ |  | |__| | __ | __ |___ |\ | |___ |__/ |__|  | |  | |__/
#     |  |_|_| | |___ | |__|    |__| |  | |    |__] |___ | \| |___ |  \ |  |  | |__| |  \
#
#    Twilio - Sync
#    This is the public Twilio REST API.
#
#    NOTE: This class is auto generated by OpenAPI Generator.
#    https://openapi-generator.tech
#    Do not edit the class manually.
#


module Twilio
    module REST
        class Sync < SyncBase
            class V1 < Version
                class ServiceList < ListResource
                    ##
                    # Initialize the ServiceList
                    # @param [Version] version Version that contains the resource
                    # @return [ServiceList] ServiceList
                    def initialize(version)
                        super(version)
                        # Path Solution
                        @solution = {  }
                        @uri = "/Services"
                        
                    end
                    ##
                    # Create the ServiceInstance
                    # @param [String] friendly_name A string that you assign to describe the resource.
                    # @param [String] webhook_url The URL we should call when Sync objects are manipulated.
                    # @param [Boolean] reachability_webhooks_enabled Whether the service instance should call `webhook_url` when client endpoints connect to Sync. The default is `false`.
                    # @param [Boolean] acl_enabled Whether token identities in the Service must be granted access to Sync objects by using the [Permissions](https://www.twilio.com/docs/sync/api/sync-permissions) resource.
                    # @param [Boolean] reachability_debouncing_enabled Whether every `endpoint_disconnected` event should occur after a configurable delay. The default is `false`, where the `endpoint_disconnected` event occurs immediately after disconnection. When `true`, intervening reconnections can prevent the `endpoint_disconnected` event.
                    # @param [String] reachability_debouncing_window The reachability event delay in milliseconds if `reachability_debouncing_enabled` = `true`.  Must be between 1,000 and 30,000 and defaults to 5,000. This is the number of milliseconds after the last running client disconnects, and a Sync identity is declared offline, before the `webhook_url` is called if all endpoints remain offline. A reconnection from the same identity by any endpoint during this interval prevents the call to `webhook_url`.
                    # @param [Boolean] webhooks_from_rest_enabled Whether the Service instance should call `webhook_url` when the REST API is used to update Sync objects. The default is `false`.
                    # @return [ServiceInstance] Created ServiceInstance
                    def create(
                        friendly_name: :unset, 
                        webhook_url: :unset, 
                        reachability_webhooks_enabled: :unset, 
                        acl_enabled: :unset, 
                        reachability_debouncing_enabled: :unset, 
                        reachability_debouncing_window: :unset, 
                        webhooks_from_rest_enabled: :unset
                    )

                        data = Twilio::Values.of({
                            'FriendlyName' => friendly_name,
                            'WebhookUrl' => webhook_url,
                            'ReachabilityWebhooksEnabled' => reachability_webhooks_enabled,
                            'AclEnabled' => acl_enabled,
                            'ReachabilityDebouncingEnabled' => reachability_debouncing_enabled,
                            'ReachabilityDebouncingWindow' => reachability_debouncing_window,
                            'WebhooksFromRestEnabled' => webhooks_from_rest_enabled,
                        })

                        payload = @version.create('POST', @uri, data: data)
                        ServiceInstance.new(
                            @version,
                            payload,
                        )
                    end

                
                    ##
                    # Lists ServiceInstance records from the API as a list.
                    # Unlike stream(), this operation is eager and will load `limit` records into
                    # memory before returning.
                    # @param [Integer] limit Upper limit for the number of records to return. stream()
                    #    guarantees to never return more than limit.  Default is no limit
                    # @param [Integer] page_size Number of records to fetch per request, when
                    #    not set will use the default value of 50 records.  If no page_size is defined
                    #    but a limit is defined, stream() will attempt to read the limit with the most
                    #    efficient page size, i.e. min(limit, 1000)
                    # @return [Array] Array of up to limit results
                    def list(limit: nil, page_size: nil)
                        self.stream(
                            limit: limit,
                            page_size: page_size
                        ).entries
                    end

                    ##
                    # Streams Instance records from the API as an Enumerable.
                    # This operation lazily loads records as efficiently as possible until the limit
                    # is reached.
                    # @param [Integer] limit Upper limit for the number of records to return. stream()
                    #    guarantees to never return more than limit.  Default is no limit
                    # @param [Integer] page_size Number of records to fetch per request, when
                    #    not set will use the default value of 50 records.  If no page_size is defined
                    #    but a limit is defined, stream() will attempt to read the limit with the most
                    #    efficient page size, i.e. min(limit, 1000)
                    # @return [Enumerable] Enumerable that will yield up to limit results
                    def stream(limit: nil, page_size: nil)
                        limits = @version.read_limits(limit, page_size)

                        page = self.page(
                            page_size: limits[:page_size], )

                        @version.stream(page, limit: limits[:limit], page_limit: limits[:page_limit])
                    end

                    ##
                    # When passed a block, yields ServiceInstance records from the API.
                    # This operation lazily loads records as efficiently as possible until the limit
                    # is reached.
                    def each
                        limits = @version.read_limits

                        page = self.page(page_size: limits[:page_size], )

                        @version.stream(page,
                            limit: limits[:limit],
                            page_limit: limits[:page_limit]).each {|x| yield x}
                    end

                    ##
                    # Retrieve a single page of ServiceInstance records from the API.
                    # Request is executed immediately.
                    # @param [String] page_token PageToken provided by the API
                    # @param [Integer] page_number Page Number, this value is simply for client state
                    # @param [Integer] page_size Number of records to return, defaults to 50
                    # @return [Page] Page of ServiceInstance
                    def page(page_token: :unset, page_number: :unset, page_size: :unset)
                        params = Twilio::Values.of({
                            'PageToken' => page_token,
                            'Page' => page_number,
                            'PageSize' => page_size,
                        })

                        response = @version.page('GET', @uri, params: params)

                        ServicePage.new(@version, response, @solution)
                    end

                    ##
                    # Retrieve a single page of ServiceInstance records from the API.
                    # Request is executed immediately.
                    # @param [String] target_url API-generated URL for the requested results page
                    # @return [Page] Page of ServiceInstance
                    def get_page(target_url)
                        response = @version.domain.request(
                            'GET',
                            target_url
                        )
                    ServicePage.new(@version, response, @solution)
                    end
                    


                    # Provide a user friendly representation
                    def to_s
                        '#<Twilio.Sync.V1.ServiceList>'
                    end
                end


                class ServiceContext < InstanceContext
                    ##
                    # Initialize the ServiceContext
                    # @param [Version] version Version that contains the resource
                    # @param [String] sid The SID of the Service resource to update.
                    # @return [ServiceContext] ServiceContext
                    def initialize(version, sid)
                        super(version)

                        # Path Solution
                        @solution = { sid: sid,  }
                        @uri = "/Services/#{@solution[:sid]}"

                        # Dependents
                        @sync_streams = nil
                        @sync_lists = nil
                        @sync_maps = nil
                        @documents = nil
                    end
                    ##
                    # Delete the ServiceInstance
                    # @return [Boolean] True if delete succeeds, false otherwise
                    def delete

                        @version.delete('DELETE', @uri)
                    end

                    ##
                    # Fetch the ServiceInstance
                    # @return [ServiceInstance] Fetched ServiceInstance
                    def fetch

                        payload = @version.fetch('GET', @uri)
                        ServiceInstance.new(
                            @version,
                            payload,
                            sid: @solution[:sid],
                        )
                    end

                    ##
                    # Update the ServiceInstance
                    # @param [String] webhook_url The URL we should call when Sync objects are manipulated.
                    # @param [String] friendly_name A string that you assign to describe the resource.
                    # @param [Boolean] reachability_webhooks_enabled Whether the service instance should call `webhook_url` when client endpoints connect to Sync. The default is `false`.
                    # @param [Boolean] acl_enabled Whether token identities in the Service must be granted access to Sync objects by using the [Permissions](https://www.twilio.com/docs/sync/api/sync-permissions) resource.
                    # @param [Boolean] reachability_debouncing_enabled Whether every `endpoint_disconnected` event should occur after a configurable delay. The default is `false`, where the `endpoint_disconnected` event occurs immediately after disconnection. When `true`, intervening reconnections can prevent the `endpoint_disconnected` event.
                    # @param [String] reachability_debouncing_window The reachability event delay in milliseconds if `reachability_debouncing_enabled` = `true`.  Must be between 1,000 and 30,000 and defaults to 5,000. This is the number of milliseconds after the last running client disconnects, and a Sync identity is declared offline, before the webhook is called if all endpoints remain offline. A reconnection from the same identity by any endpoint during this interval prevents the webhook from being called.
                    # @param [Boolean] webhooks_from_rest_enabled Whether the Service instance should call `webhook_url` when the REST API is used to update Sync objects. The default is `false`.
                    # @return [ServiceInstance] Updated ServiceInstance
                    def update(
                        webhook_url: :unset, 
                        friendly_name: :unset, 
                        reachability_webhooks_enabled: :unset, 
                        acl_enabled: :unset, 
                        reachability_debouncing_enabled: :unset, 
                        reachability_debouncing_window: :unset, 
                        webhooks_from_rest_enabled: :unset
                    )

                        data = Twilio::Values.of({
                            'WebhookUrl' => webhook_url,
                            'FriendlyName' => friendly_name,
                            'ReachabilityWebhooksEnabled' => reachability_webhooks_enabled,
                            'AclEnabled' => acl_enabled,
                            'ReachabilityDebouncingEnabled' => reachability_debouncing_enabled,
                            'ReachabilityDebouncingWindow' => reachability_debouncing_window,
                            'WebhooksFromRestEnabled' => webhooks_from_rest_enabled,
                        })

                        payload = @version.update('POST', @uri, data: data)
                        ServiceInstance.new(
                            @version,
                            payload,
                            sid: @solution[:sid],
                        )
                    end

                    ##
                    # Access the sync_streams
                    # @return [SyncStreamList]
                    # @return [SyncStreamContext] if sid was passed.
                    def sync_streams(sid=:unset)

                        raise ArgumentError, 'sid cannot be nil' if sid.nil?

                        if sid != :unset
                            return SyncStreamContext.new(@version, @solution[:sid],sid )
                        end

                        unless @sync_streams
                            @sync_streams = SyncStreamList.new(
                                @version, service_sid: @solution[:sid], )
                        end

                     @sync_streams
                    end
                    ##
                    # Access the sync_lists
                    # @return [SyncListList]
                    # @return [SyncListContext] if sid was passed.
                    def sync_lists(sid=:unset)

                        raise ArgumentError, 'sid cannot be nil' if sid.nil?

                        if sid != :unset
                            return SyncListContext.new(@version, @solution[:sid],sid )
                        end

                        unless @sync_lists
                            @sync_lists = SyncListList.new(
                                @version, service_sid: @solution[:sid], )
                        end

                     @sync_lists
                    end
                    ##
                    # Access the sync_maps
                    # @return [SyncMapList]
                    # @return [SyncMapContext] if sid was passed.
                    def sync_maps(sid=:unset)

                        raise ArgumentError, 'sid cannot be nil' if sid.nil?

                        if sid != :unset
                            return SyncMapContext.new(@version, @solution[:sid],sid )
                        end

                        unless @sync_maps
                            @sync_maps = SyncMapList.new(
                                @version, service_sid: @solution[:sid], )
                        end

                     @sync_maps
                    end
                    ##
                    # Access the documents
                    # @return [DocumentList]
                    # @return [DocumentContext] if sid was passed.
                    def documents(sid=:unset)

                        raise ArgumentError, 'sid cannot be nil' if sid.nil?

                        if sid != :unset
                            return DocumentContext.new(@version, @solution[:sid],sid )
                        end

                        unless @documents
                            @documents = DocumentList.new(
                                @version, service_sid: @solution[:sid], )
                        end

                     @documents
                    end

                    ##
                    # Provide a user friendly representation
                    def to_s
                        context = @solution.map{|k, v| "#{k}: #{v}"}.join(',')
                        "#<Twilio.Sync.V1.ServiceContext #{context}>"
                    end

                    ##
                    # Provide a detailed, user friendly representation
                    def inspect
                        context = @solution.map{|k, v| "#{k}: #{v}"}.join(',')
                        "#<Twilio.Sync.V1.ServiceContext #{context}>"
                    end
                end

                class ServicePage < Page
                    ##
                    # Initialize the ServicePage
                    # @param [Version] version Version that contains the resource
                    # @param [Response] response Response from the API
                    # @param [Hash] solution Path solution for the resource
                    # @return [ServicePage] ServicePage
                    def initialize(version, response, solution)
                        super(version, response)

                        # Path Solution
                        @solution = solution
                    end

                    ##
                    # Build an instance of ServiceInstance
                    # @param [Hash] payload Payload response from the API
                    # @return [ServiceInstance] ServiceInstance
                    def get_instance(payload)
                        ServiceInstance.new(@version, payload)
                    end

                    ##
                    # Provide a user friendly representation
                    def to_s
                        '<Twilio.Sync.V1.ServicePage>'
                    end
                end
                class ServiceInstance < InstanceResource
                    ##
                    # Initialize the ServiceInstance
                    # @param [Version] version Version that contains the resource
                    # @param [Hash] payload payload that contains response from Twilio
                    # @param [String] account_sid The SID of the
                    #   {Account}[https://www.twilio.com/docs/iam/api/account] that created this Service
                    #   resource.
                    # @param [String] sid The SID of the Call resource to fetch.
                    # @return [ServiceInstance] ServiceInstance
                    def initialize(version, payload , sid: nil)
                        super(version)
                        
                        # Marshaled Properties
                        @properties = { 
                            'sid' => payload['sid'],
                            'unique_name' => payload['unique_name'],
                            'account_sid' => payload['account_sid'],
                            'friendly_name' => payload['friendly_name'],
                            'date_created' => Twilio.deserialize_iso8601_datetime(payload['date_created']),
                            'date_updated' => Twilio.deserialize_iso8601_datetime(payload['date_updated']),
                            'url' => payload['url'],
                            'webhook_url' => payload['webhook_url'],
                            'webhooks_from_rest_enabled' => payload['webhooks_from_rest_enabled'],
                            'reachability_webhooks_enabled' => payload['reachability_webhooks_enabled'],
                            'acl_enabled' => payload['acl_enabled'],
                            'reachability_debouncing_enabled' => payload['reachability_debouncing_enabled'],
                            'reachability_debouncing_window' => payload['reachability_debouncing_window'] == nil ? payload['reachability_debouncing_window'] : payload['reachability_debouncing_window'].to_i,
                            'links' => payload['links'],
                        }

                        # Context
                        @instance_context = nil
                        @params = { 'sid' => sid  || @properties['sid']  , }
                    end

                    ##
                    # Generate an instance context for the instance, the context is capable of
                    # performing various actions.  All instance actions are proxied to the context
                    # @return [ServiceContext] CallContext for this CallInstance
                    def context
                        unless @instance_context
                            @instance_context = ServiceContext.new(@version , @params['sid'])
                        end
                        @instance_context
                    end
                    
                    ##
                    # @return [String] The unique string that we created to identify the Service resource.
                    def sid
                        @properties['sid']
                    end
                    
                    ##
                    # @return [String] An application-defined string that uniquely identifies the resource. It can be used in place of the resource's `sid` in the URL to address the resource. It is a read-only property, it cannot be assigned using REST API.
                    def unique_name
                        @properties['unique_name']
                    end
                    
                    ##
                    # @return [String] The SID of the [Account](https://www.twilio.com/docs/iam/api/account) that created the Service resource.
                    def account_sid
                        @properties['account_sid']
                    end
                    
                    ##
                    # @return [String] The string that you assigned to describe the resource.
                    def friendly_name
                        @properties['friendly_name']
                    end
                    
                    ##
                    # @return [Time] The date and time in GMT when the resource was created specified in [ISO 8601](https://en.wikipedia.org/wiki/ISO_8601) format.
                    def date_created
                        @properties['date_created']
                    end
                    
                    ##
                    # @return [Time] The date and time in GMT when the resource was last updated specified in [ISO 8601](https://en.wikipedia.org/wiki/ISO_8601) format.
                    def date_updated
                        @properties['date_updated']
                    end
                    
                    ##
                    # @return [String] The absolute URL of the Service resource.
                    def url
                        @properties['url']
                    end
                    
                    ##
                    # @return [String] The URL we call when Sync objects are manipulated.
                    def webhook_url
                        @properties['webhook_url']
                    end
                    
                    ##
                    # @return [Boolean] Whether the Service instance should call `webhook_url` when the REST API is used to update Sync objects. The default is `false`.
                    def webhooks_from_rest_enabled
                        @properties['webhooks_from_rest_enabled']
                    end
                    
                    ##
                    # @return [Boolean] Whether the service instance calls `webhook_url` when client endpoints connect to Sync. The default is `false`.
                    def reachability_webhooks_enabled
                        @properties['reachability_webhooks_enabled']
                    end
                    
                    ##
                    # @return [Boolean] Whether token identities in the Service must be granted access to Sync objects by using the [Permissions](https://www.twilio.com/docs/sync/api/sync-permissions) resource. It is disabled (false) by default.
                    def acl_enabled
                        @properties['acl_enabled']
                    end
                    
                    ##
                    # @return [Boolean] Whether every `endpoint_disconnected` event should occur after a configurable delay. The default is `false`, where the `endpoint_disconnected` event occurs immediately after disconnection. When `true`, intervening reconnections can prevent the `endpoint_disconnected` event.
                    def reachability_debouncing_enabled
                        @properties['reachability_debouncing_enabled']
                    end
                    
                    ##
                    # @return [String] The reachability event delay in milliseconds if `reachability_debouncing_enabled` = `true`.  Must be between 1,000 and 30,000 and defaults to 5,000. This is the number of milliseconds after the last running client disconnects, and a Sync identity is declared offline, before `webhook_url` is called, if all endpoints remain offline. A reconnection from the same identity by any endpoint during this interval prevents the reachability event from occurring.
                    def reachability_debouncing_window
                        @properties['reachability_debouncing_window']
                    end
                    
                    ##
                    # @return [Hash] The URLs of related resources.
                    def links
                        @properties['links']
                    end
                    
                    ##
                    # Delete the ServiceInstance
                    # @return [Boolean] True if delete succeeds, false otherwise
                    def delete

                        context.delete
                    end

                    ##
                    # Fetch the ServiceInstance
                    # @return [ServiceInstance] Fetched ServiceInstance
                    def fetch

                        context.fetch
                    end

                    ##
                    # Update the ServiceInstance
                    # @param [String] webhook_url The URL we should call when Sync objects are manipulated.
                    # @param [String] friendly_name A string that you assign to describe the resource.
                    # @param [Boolean] reachability_webhooks_enabled Whether the service instance should call `webhook_url` when client endpoints connect to Sync. The default is `false`.
                    # @param [Boolean] acl_enabled Whether token identities in the Service must be granted access to Sync objects by using the [Permissions](https://www.twilio.com/docs/sync/api/sync-permissions) resource.
                    # @param [Boolean] reachability_debouncing_enabled Whether every `endpoint_disconnected` event should occur after a configurable delay. The default is `false`, where the `endpoint_disconnected` event occurs immediately after disconnection. When `true`, intervening reconnections can prevent the `endpoint_disconnected` event.
                    # @param [String] reachability_debouncing_window The reachability event delay in milliseconds if `reachability_debouncing_enabled` = `true`.  Must be between 1,000 and 30,000 and defaults to 5,000. This is the number of milliseconds after the last running client disconnects, and a Sync identity is declared offline, before the webhook is called if all endpoints remain offline. A reconnection from the same identity by any endpoint during this interval prevents the webhook from being called.
                    # @param [Boolean] webhooks_from_rest_enabled Whether the Service instance should call `webhook_url` when the REST API is used to update Sync objects. The default is `false`.
                    # @return [ServiceInstance] Updated ServiceInstance
                    def update(
                        webhook_url: :unset, 
                        friendly_name: :unset, 
                        reachability_webhooks_enabled: :unset, 
                        acl_enabled: :unset, 
                        reachability_debouncing_enabled: :unset, 
                        reachability_debouncing_window: :unset, 
                        webhooks_from_rest_enabled: :unset
                    )

                        context.update(
                            webhook_url: webhook_url, 
                            friendly_name: friendly_name, 
                            reachability_webhooks_enabled: reachability_webhooks_enabled, 
                            acl_enabled: acl_enabled, 
                            reachability_debouncing_enabled: reachability_debouncing_enabled, 
                            reachability_debouncing_window: reachability_debouncing_window, 
                            webhooks_from_rest_enabled: webhooks_from_rest_enabled, 
                        )
                    end

                    ##
                    # Access the sync_streams
                    # @return [sync_streams] sync_streams
                    def sync_streams
                        context.sync_streams
                    end

                    ##
                    # Access the sync_lists
                    # @return [sync_lists] sync_lists
                    def sync_lists
                        context.sync_lists
                    end

                    ##
                    # Access the sync_maps
                    # @return [sync_maps] sync_maps
                    def sync_maps
                        context.sync_maps
                    end

                    ##
                    # Access the documents
                    # @return [documents] documents
                    def documents
                        context.documents
                    end

                    ##
                    # Provide a user friendly representation
                    def to_s
                        values = @params.map{|k, v| "#{k}: #{v}"}.join(" ")
                        "<Twilio.Sync.V1.ServiceInstance #{values}>"
                    end

                    ##
                    # Provide a detailed, user friendly representation
                    def inspect
                        values = @properties.map{|k, v| "#{k}: #{v}"}.join(" ")
                        "<Twilio.Sync.V1.ServiceInstance #{values}>"
                    end
                end

            end
        end
    end
end
