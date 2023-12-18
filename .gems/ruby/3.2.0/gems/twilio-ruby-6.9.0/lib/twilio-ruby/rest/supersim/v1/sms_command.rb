##
#    This code was generated by
#    ___ _ _ _ _ _    _ ____    ____ ____ _    ____ ____ _  _ ____ ____ ____ ___ __   __
#     |  | | | | |    | |  | __ |  | |__| | __ | __ |___ |\ | |___ |__/ |__|  | |  | |__/
#     |  |_|_| | |___ | |__|    |__| |  | |    |__] |___ | \| |___ |  \ |  |  | |__| |  \
#
#    Twilio - Supersim
#    This is the public Twilio REST API.
#
#    NOTE: This class is auto generated by OpenAPI Generator.
#    https://openapi-generator.tech
#    Do not edit the class manually.
#


module Twilio
    module REST
        class Supersim < SupersimBase
            class V1 < Version
                class SmsCommandList < ListResource
                    ##
                    # Initialize the SmsCommandList
                    # @param [Version] version Version that contains the resource
                    # @return [SmsCommandList] SmsCommandList
                    def initialize(version)
                        super(version)
                        # Path Solution
                        @solution = {  }
                        @uri = "/SmsCommands"
                        
                    end
                    ##
                    # Create the SmsCommandInstance
                    # @param [String] sim The `sid` or `unique_name` of the [SIM](https://www.twilio.com/docs/iot/supersim/api/sim-resource) to send the SMS Command to.
                    # @param [String] payload The message body of the SMS Command.
                    # @param [String] callback_method The HTTP method we should use to call `callback_url`. Can be: `GET` or `POST` and the default is POST.
                    # @param [String] callback_url The URL we should call using the `callback_method` after we have sent the command.
                    # @return [SmsCommandInstance] Created SmsCommandInstance
                    def create(
                        sim: nil, 
                        payload: nil, 
                        callback_method: :unset, 
                        callback_url: :unset
                    )

                        data = Twilio::Values.of({
                            'Sim' => sim,
                            'Payload' => payload,
                            'CallbackMethod' => callback_method,
                            'CallbackUrl' => callback_url,
                        })

                        payload = @version.create('POST', @uri, data: data)
                        SmsCommandInstance.new(
                            @version,
                            payload,
                        )
                    end

                
                    ##
                    # Lists SmsCommandInstance records from the API as a list.
                    # Unlike stream(), this operation is eager and will load `limit` records into
                    # memory before returning.
                    # @param [String] sim The SID or unique name of the Sim resource that SMS Command was sent to or from.
                    # @param [Status] status The status of the SMS Command. Can be: `queued`, `sent`, `delivered`, `received` or `failed`. See the [SMS Command Status Values](https://www.twilio.com/docs/iot/supersim/api/smscommand-resource#status-values) for a description of each.
                    # @param [Direction] direction The direction of the SMS Command. Can be `to_sim` or `from_sim`. The value of `to_sim` is synonymous with the term `mobile terminated`, and `from_sim` is synonymous with the term `mobile originated`.
                    # @param [Integer] limit Upper limit for the number of records to return. stream()
                    #    guarantees to never return more than limit.  Default is no limit
                    # @param [Integer] page_size Number of records to fetch per request, when
                    #    not set will use the default value of 50 records.  If no page_size is defined
                    #    but a limit is defined, stream() will attempt to read the limit with the most
                    #    efficient page size, i.e. min(limit, 1000)
                    # @return [Array] Array of up to limit results
                    def list(sim: :unset, status: :unset, direction: :unset, limit: nil, page_size: nil)
                        self.stream(
                            sim: sim,
                            status: status,
                            direction: direction,
                            limit: limit,
                            page_size: page_size
                        ).entries
                    end

                    ##
                    # Streams Instance records from the API as an Enumerable.
                    # This operation lazily loads records as efficiently as possible until the limit
                    # is reached.
                    # @param [String] sim The SID or unique name of the Sim resource that SMS Command was sent to or from.
                    # @param [Status] status The status of the SMS Command. Can be: `queued`, `sent`, `delivered`, `received` or `failed`. See the [SMS Command Status Values](https://www.twilio.com/docs/iot/supersim/api/smscommand-resource#status-values) for a description of each.
                    # @param [Direction] direction The direction of the SMS Command. Can be `to_sim` or `from_sim`. The value of `to_sim` is synonymous with the term `mobile terminated`, and `from_sim` is synonymous with the term `mobile originated`.
                    # @param [Integer] limit Upper limit for the number of records to return. stream()
                    #    guarantees to never return more than limit.  Default is no limit
                    # @param [Integer] page_size Number of records to fetch per request, when
                    #    not set will use the default value of 50 records.  If no page_size is defined
                    #    but a limit is defined, stream() will attempt to read the limit with the most
                    #    efficient page size, i.e. min(limit, 1000)
                    # @return [Enumerable] Enumerable that will yield up to limit results
                    def stream(sim: :unset, status: :unset, direction: :unset, limit: nil, page_size: nil)
                        limits = @version.read_limits(limit, page_size)

                        page = self.page(
                            sim: sim,
                            status: status,
                            direction: direction,
                            page_size: limits[:page_size], )

                        @version.stream(page, limit: limits[:limit], page_limit: limits[:page_limit])
                    end

                    ##
                    # When passed a block, yields SmsCommandInstance records from the API.
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
                    # Retrieve a single page of SmsCommandInstance records from the API.
                    # Request is executed immediately.
                    # @param [String] sim The SID or unique name of the Sim resource that SMS Command was sent to or from.
                    # @param [Status] status The status of the SMS Command. Can be: `queued`, `sent`, `delivered`, `received` or `failed`. See the [SMS Command Status Values](https://www.twilio.com/docs/iot/supersim/api/smscommand-resource#status-values) for a description of each.
                    # @param [Direction] direction The direction of the SMS Command. Can be `to_sim` or `from_sim`. The value of `to_sim` is synonymous with the term `mobile terminated`, and `from_sim` is synonymous with the term `mobile originated`.
                    # @param [String] page_token PageToken provided by the API
                    # @param [Integer] page_number Page Number, this value is simply for client state
                    # @param [Integer] page_size Number of records to return, defaults to 50
                    # @return [Page] Page of SmsCommandInstance
                    def page(sim: :unset, status: :unset, direction: :unset, page_token: :unset, page_number: :unset, page_size: :unset)
                        params = Twilio::Values.of({
                            'Sim' => sim,
                            'Status' => status,
                            'Direction' => direction,
                            'PageToken' => page_token,
                            'Page' => page_number,
                            'PageSize' => page_size,
                        })

                        response = @version.page('GET', @uri, params: params)

                        SmsCommandPage.new(@version, response, @solution)
                    end

                    ##
                    # Retrieve a single page of SmsCommandInstance records from the API.
                    # Request is executed immediately.
                    # @param [String] target_url API-generated URL for the requested results page
                    # @return [Page] Page of SmsCommandInstance
                    def get_page(target_url)
                        response = @version.domain.request(
                            'GET',
                            target_url
                        )
                    SmsCommandPage.new(@version, response, @solution)
                    end
                    


                    # Provide a user friendly representation
                    def to_s
                        '#<Twilio.Supersim.V1.SmsCommandList>'
                    end
                end


                ##
                #PLEASE NOTE that this class contains beta products that are subject to change. Use them with caution.
                class SmsCommandContext < InstanceContext
                    ##
                    # Initialize the SmsCommandContext
                    # @param [Version] version Version that contains the resource
                    # @param [String] sid The SID of the SMS Command resource to fetch.
                    # @return [SmsCommandContext] SmsCommandContext
                    def initialize(version, sid)
                        super(version)

                        # Path Solution
                        @solution = { sid: sid,  }
                        @uri = "/SmsCommands/#{@solution[:sid]}"

                        
                    end
                    ##
                    # Fetch the SmsCommandInstance
                    # @return [SmsCommandInstance] Fetched SmsCommandInstance
                    def fetch

                        payload = @version.fetch('GET', @uri)
                        SmsCommandInstance.new(
                            @version,
                            payload,
                            sid: @solution[:sid],
                        )
                    end


                    ##
                    # Provide a user friendly representation
                    def to_s
                        context = @solution.map{|k, v| "#{k}: #{v}"}.join(',')
                        "#<Twilio.Supersim.V1.SmsCommandContext #{context}>"
                    end

                    ##
                    # Provide a detailed, user friendly representation
                    def inspect
                        context = @solution.map{|k, v| "#{k}: #{v}"}.join(',')
                        "#<Twilio.Supersim.V1.SmsCommandContext #{context}>"
                    end
                end

                class SmsCommandPage < Page
                    ##
                    # Initialize the SmsCommandPage
                    # @param [Version] version Version that contains the resource
                    # @param [Response] response Response from the API
                    # @param [Hash] solution Path solution for the resource
                    # @return [SmsCommandPage] SmsCommandPage
                    def initialize(version, response, solution)
                        super(version, response)

                        # Path Solution
                        @solution = solution
                    end

                    ##
                    # Build an instance of SmsCommandInstance
                    # @param [Hash] payload Payload response from the API
                    # @return [SmsCommandInstance] SmsCommandInstance
                    def get_instance(payload)
                        SmsCommandInstance.new(@version, payload)
                    end

                    ##
                    # Provide a user friendly representation
                    def to_s
                        '<Twilio.Supersim.V1.SmsCommandPage>'
                    end
                end
                class SmsCommandInstance < InstanceResource
                    ##
                    # Initialize the SmsCommandInstance
                    # @param [Version] version Version that contains the resource
                    # @param [Hash] payload payload that contains response from Twilio
                    # @param [String] account_sid The SID of the
                    #   {Account}[https://www.twilio.com/docs/iam/api/account] that created this SmsCommand
                    #   resource.
                    # @param [String] sid The SID of the Call resource to fetch.
                    # @return [SmsCommandInstance] SmsCommandInstance
                    def initialize(version, payload , sid: nil)
                        super(version)
                        
                        # Marshaled Properties
                        @properties = { 
                            'sid' => payload['sid'],
                            'account_sid' => payload['account_sid'],
                            'sim_sid' => payload['sim_sid'],
                            'payload' => payload['payload'],
                            'status' => payload['status'],
                            'direction' => payload['direction'],
                            'date_created' => Twilio.deserialize_iso8601_datetime(payload['date_created']),
                            'date_updated' => Twilio.deserialize_iso8601_datetime(payload['date_updated']),
                            'url' => payload['url'],
                        }

                        # Context
                        @instance_context = nil
                        @params = { 'sid' => sid  || @properties['sid']  , }
                    end

                    ##
                    # Generate an instance context for the instance, the context is capable of
                    # performing various actions.  All instance actions are proxied to the context
                    # @return [SmsCommandContext] CallContext for this CallInstance
                    def context
                        unless @instance_context
                            @instance_context = SmsCommandContext.new(@version , @params['sid'])
                        end
                        @instance_context
                    end
                    
                    ##
                    # @return [String] The unique string that we created to identify the SMS Command resource.
                    def sid
                        @properties['sid']
                    end
                    
                    ##
                    # @return [String] The SID of the [Account](https://www.twilio.com/docs/iam/api/account) that created the SMS Command resource.
                    def account_sid
                        @properties['account_sid']
                    end
                    
                    ##
                    # @return [String] The SID of the [SIM](https://www.twilio.com/docs/iot/supersim/api/sim-resource) that this SMS Command was sent to or from.
                    def sim_sid
                        @properties['sim_sid']
                    end
                    
                    ##
                    # @return [String] The message body of the SMS Command sent to or from the SIM. For text mode messages, this can be up to 160 characters.
                    def payload
                        @properties['payload']
                    end
                    
                    ##
                    # @return [Status] 
                    def status
                        @properties['status']
                    end
                    
                    ##
                    # @return [Direction] 
                    def direction
                        @properties['direction']
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
                    # @return [String] The absolute URL of the SMS Command resource.
                    def url
                        @properties['url']
                    end
                    
                    ##
                    # Fetch the SmsCommandInstance
                    # @return [SmsCommandInstance] Fetched SmsCommandInstance
                    def fetch

                        context.fetch
                    end

                    ##
                    # Provide a user friendly representation
                    def to_s
                        values = @params.map{|k, v| "#{k}: #{v}"}.join(" ")
                        "<Twilio.Supersim.V1.SmsCommandInstance #{values}>"
                    end

                    ##
                    # Provide a detailed, user friendly representation
                    def inspect
                        values = @properties.map{|k, v| "#{k}: #{v}"}.join(" ")
                        "<Twilio.Supersim.V1.SmsCommandInstance #{values}>"
                    end
                end

            end
        end
    end
end
