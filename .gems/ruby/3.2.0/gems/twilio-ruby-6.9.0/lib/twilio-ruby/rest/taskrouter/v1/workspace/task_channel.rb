##
#    This code was generated by
#    ___ _ _ _ _ _    _ ____    ____ ____ _    ____ ____ _  _ ____ ____ ____ ___ __   __
#     |  | | | | |    | |  | __ |  | |__| | __ | __ |___ |\ | |___ |__/ |__|  | |  | |__/
#     |  |_|_| | |___ | |__|    |__| |  | |    |__] |___ | \| |___ |  \ |  |  | |__| |  \
#
#    Twilio - Taskrouter
#    This is the public Twilio REST API.
#
#    NOTE: This class is auto generated by OpenAPI Generator.
#    https://openapi-generator.tech
#    Do not edit the class manually.
#


module Twilio
    module REST
        class Taskrouter < TaskrouterBase
            class V1 < Version
                class WorkspaceContext < InstanceContext

                     class TaskChannelList < ListResource
                    ##
                    # Initialize the TaskChannelList
                    # @param [Version] version Version that contains the resource
                    # @return [TaskChannelList] TaskChannelList
                    def initialize(version, workspace_sid: nil)
                        super(version)
                        # Path Solution
                        @solution = { workspace_sid: workspace_sid }
                        @uri = "/Workspaces/#{@solution[:workspace_sid]}/TaskChannels"
                        
                    end
                    ##
                    # Create the TaskChannelInstance
                    # @param [String] friendly_name A descriptive string that you create to describe the Task Channel. It can be up to 64 characters long.
                    # @param [String] unique_name An application-defined string that uniquely identifies the Task Channel, such as `voice` or `sms`.
                    # @param [Boolean] channel_optimized_routing Whether the Task Channel should prioritize Workers that have been idle. If `true`, Workers that have been idle the longest are prioritized.
                    # @return [TaskChannelInstance] Created TaskChannelInstance
                    def create(
                        friendly_name: nil, 
                        unique_name: nil, 
                        channel_optimized_routing: :unset
                    )

                        data = Twilio::Values.of({
                            'FriendlyName' => friendly_name,
                            'UniqueName' => unique_name,
                            'ChannelOptimizedRouting' => channel_optimized_routing,
                        })

                        payload = @version.create('POST', @uri, data: data)
                        TaskChannelInstance.new(
                            @version,
                            payload,
                            workspace_sid: @solution[:workspace_sid],
                        )
                    end

                
                    ##
                    # Lists TaskChannelInstance records from the API as a list.
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
                    # When passed a block, yields TaskChannelInstance records from the API.
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
                    # Retrieve a single page of TaskChannelInstance records from the API.
                    # Request is executed immediately.
                    # @param [String] page_token PageToken provided by the API
                    # @param [Integer] page_number Page Number, this value is simply for client state
                    # @param [Integer] page_size Number of records to return, defaults to 50
                    # @return [Page] Page of TaskChannelInstance
                    def page(page_token: :unset, page_number: :unset, page_size: :unset)
                        params = Twilio::Values.of({
                            'PageToken' => page_token,
                            'Page' => page_number,
                            'PageSize' => page_size,
                        })

                        response = @version.page('GET', @uri, params: params)

                        TaskChannelPage.new(@version, response, @solution)
                    end

                    ##
                    # Retrieve a single page of TaskChannelInstance records from the API.
                    # Request is executed immediately.
                    # @param [String] target_url API-generated URL for the requested results page
                    # @return [Page] Page of TaskChannelInstance
                    def get_page(target_url)
                        response = @version.domain.request(
                            'GET',
                            target_url
                        )
                    TaskChannelPage.new(@version, response, @solution)
                    end
                    


                    # Provide a user friendly representation
                    def to_s
                        '#<Twilio.Taskrouter.V1.TaskChannelList>'
                    end
                end


                class TaskChannelContext < InstanceContext
                    ##
                    # Initialize the TaskChannelContext
                    # @param [Version] version Version that contains the resource
                    # @param [String] workspace_sid The SID of the Workspace with the Task Channel to update.
                    # @param [String] sid The SID of the Task Channel resource to update.
                    # @return [TaskChannelContext] TaskChannelContext
                    def initialize(version, workspace_sid, sid)
                        super(version)

                        # Path Solution
                        @solution = { workspace_sid: workspace_sid, sid: sid,  }
                        @uri = "/Workspaces/#{@solution[:workspace_sid]}/TaskChannels/#{@solution[:sid]}"

                        
                    end
                    ##
                    # Delete the TaskChannelInstance
                    # @return [Boolean] True if delete succeeds, false otherwise
                    def delete

                        @version.delete('DELETE', @uri)
                    end

                    ##
                    # Fetch the TaskChannelInstance
                    # @return [TaskChannelInstance] Fetched TaskChannelInstance
                    def fetch

                        payload = @version.fetch('GET', @uri)
                        TaskChannelInstance.new(
                            @version,
                            payload,
                            workspace_sid: @solution[:workspace_sid],
                            sid: @solution[:sid],
                        )
                    end

                    ##
                    # Update the TaskChannelInstance
                    # @param [String] friendly_name A descriptive string that you create to describe the Task Channel. It can be up to 64 characters long.
                    # @param [Boolean] channel_optimized_routing Whether the TaskChannel should prioritize Workers that have been idle. If `true`, Workers that have been idle the longest are prioritized.
                    # @return [TaskChannelInstance] Updated TaskChannelInstance
                    def update(
                        friendly_name: :unset, 
                        channel_optimized_routing: :unset
                    )

                        data = Twilio::Values.of({
                            'FriendlyName' => friendly_name,
                            'ChannelOptimizedRouting' => channel_optimized_routing,
                        })

                        payload = @version.update('POST', @uri, data: data)
                        TaskChannelInstance.new(
                            @version,
                            payload,
                            workspace_sid: @solution[:workspace_sid],
                            sid: @solution[:sid],
                        )
                    end


                    ##
                    # Provide a user friendly representation
                    def to_s
                        context = @solution.map{|k, v| "#{k}: #{v}"}.join(',')
                        "#<Twilio.Taskrouter.V1.TaskChannelContext #{context}>"
                    end

                    ##
                    # Provide a detailed, user friendly representation
                    def inspect
                        context = @solution.map{|k, v| "#{k}: #{v}"}.join(',')
                        "#<Twilio.Taskrouter.V1.TaskChannelContext #{context}>"
                    end
                end

                class TaskChannelPage < Page
                    ##
                    # Initialize the TaskChannelPage
                    # @param [Version] version Version that contains the resource
                    # @param [Response] response Response from the API
                    # @param [Hash] solution Path solution for the resource
                    # @return [TaskChannelPage] TaskChannelPage
                    def initialize(version, response, solution)
                        super(version, response)

                        # Path Solution
                        @solution = solution
                    end

                    ##
                    # Build an instance of TaskChannelInstance
                    # @param [Hash] payload Payload response from the API
                    # @return [TaskChannelInstance] TaskChannelInstance
                    def get_instance(payload)
                        TaskChannelInstance.new(@version, payload, workspace_sid: @solution[:workspace_sid])
                    end

                    ##
                    # Provide a user friendly representation
                    def to_s
                        '<Twilio.Taskrouter.V1.TaskChannelPage>'
                    end
                end
                class TaskChannelInstance < InstanceResource
                    ##
                    # Initialize the TaskChannelInstance
                    # @param [Version] version Version that contains the resource
                    # @param [Hash] payload payload that contains response from Twilio
                    # @param [String] account_sid The SID of the
                    #   {Account}[https://www.twilio.com/docs/iam/api/account] that created this TaskChannel
                    #   resource.
                    # @param [String] sid The SID of the Call resource to fetch.
                    # @return [TaskChannelInstance] TaskChannelInstance
                    def initialize(version, payload , workspace_sid: nil, sid: nil)
                        super(version)
                        
                        # Marshaled Properties
                        @properties = { 
                            'account_sid' => payload['account_sid'],
                            'date_created' => Twilio.deserialize_iso8601_datetime(payload['date_created']),
                            'date_updated' => Twilio.deserialize_iso8601_datetime(payload['date_updated']),
                            'friendly_name' => payload['friendly_name'],
                            'sid' => payload['sid'],
                            'unique_name' => payload['unique_name'],
                            'workspace_sid' => payload['workspace_sid'],
                            'channel_optimized_routing' => payload['channel_optimized_routing'],
                            'url' => payload['url'],
                            'links' => payload['links'],
                        }

                        # Context
                        @instance_context = nil
                        @params = { 'workspace_sid' => workspace_sid  || @properties['workspace_sid']  ,'sid' => sid  || @properties['sid']  , }
                    end

                    ##
                    # Generate an instance context for the instance, the context is capable of
                    # performing various actions.  All instance actions are proxied to the context
                    # @return [TaskChannelContext] CallContext for this CallInstance
                    def context
                        unless @instance_context
                            @instance_context = TaskChannelContext.new(@version , @params['workspace_sid'], @params['sid'])
                        end
                        @instance_context
                    end
                    
                    ##
                    # @return [String] The SID of the [Account](https://www.twilio.com/docs/iam/api/account) that created the Task Channel resource.
                    def account_sid
                        @properties['account_sid']
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
                    # @return [String] The string that you assigned to describe the resource.
                    def friendly_name
                        @properties['friendly_name']
                    end
                    
                    ##
                    # @return [String] The unique string that we created to identify the Task Channel resource.
                    def sid
                        @properties['sid']
                    end
                    
                    ##
                    # @return [String] An application-defined string that uniquely identifies the Task Channel, such as `voice` or `sms`.
                    def unique_name
                        @properties['unique_name']
                    end
                    
                    ##
                    # @return [String] The SID of the Workspace that contains the Task Channel.
                    def workspace_sid
                        @properties['workspace_sid']
                    end
                    
                    ##
                    # @return [Boolean] Whether the Task Channel will prioritize Workers that have been idle. When `true`, Workers that have been idle the longest are prioritized.
                    def channel_optimized_routing
                        @properties['channel_optimized_routing']
                    end
                    
                    ##
                    # @return [String] The absolute URL of the Task Channel resource.
                    def url
                        @properties['url']
                    end
                    
                    ##
                    # @return [Hash] The URLs of related resources.
                    def links
                        @properties['links']
                    end
                    
                    ##
                    # Delete the TaskChannelInstance
                    # @return [Boolean] True if delete succeeds, false otherwise
                    def delete

                        context.delete
                    end

                    ##
                    # Fetch the TaskChannelInstance
                    # @return [TaskChannelInstance] Fetched TaskChannelInstance
                    def fetch

                        context.fetch
                    end

                    ##
                    # Update the TaskChannelInstance
                    # @param [String] friendly_name A descriptive string that you create to describe the Task Channel. It can be up to 64 characters long.
                    # @param [Boolean] channel_optimized_routing Whether the TaskChannel should prioritize Workers that have been idle. If `true`, Workers that have been idle the longest are prioritized.
                    # @return [TaskChannelInstance] Updated TaskChannelInstance
                    def update(
                        friendly_name: :unset, 
                        channel_optimized_routing: :unset
                    )

                        context.update(
                            friendly_name: friendly_name, 
                            channel_optimized_routing: channel_optimized_routing, 
                        )
                    end

                    ##
                    # Provide a user friendly representation
                    def to_s
                        values = @params.map{|k, v| "#{k}: #{v}"}.join(" ")
                        "<Twilio.Taskrouter.V1.TaskChannelInstance #{values}>"
                    end

                    ##
                    # Provide a detailed, user friendly representation
                    def inspect
                        values = @properties.map{|k, v| "#{k}: #{v}"}.join(" ")
                        "<Twilio.Taskrouter.V1.TaskChannelInstance #{values}>"
                    end
                end

             end
            end
        end
    end
end


