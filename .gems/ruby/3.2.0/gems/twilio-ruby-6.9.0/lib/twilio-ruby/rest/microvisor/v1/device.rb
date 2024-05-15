##
#    This code was generated by
#    ___ _ _ _ _ _    _ ____    ____ ____ _    ____ ____ _  _ ____ ____ ____ ___ __   __
#     |  | | | | |    | |  | __ |  | |__| | __ | __ |___ |\ | |___ |__/ |__|  | |  | |__/
#     |  |_|_| | |___ | |__|    |__| |  | |    |__] |___ | \| |___ |  \ |  |  | |__| |  \
#
#    Twilio - Microvisor
#    This is the public Twilio REST API.
#
#    NOTE: This class is auto generated by OpenAPI Generator.
#    https://openapi-generator.tech
#    Do not edit the class manually.
#


module Twilio
    module REST
        class Microvisor < MicrovisorBase
            class V1 < Version
                class DeviceList < ListResource
                    ##
                    # Initialize the DeviceList
                    # @param [Version] version Version that contains the resource
                    # @return [DeviceList] DeviceList
                    def initialize(version)
                        super(version)
                        # Path Solution
                        @solution = {  }
                        @uri = "/Devices"
                        
                    end
                
                    ##
                    # Lists DeviceInstance records from the API as a list.
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
                    # When passed a block, yields DeviceInstance records from the API.
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
                    # Retrieve a single page of DeviceInstance records from the API.
                    # Request is executed immediately.
                    # @param [String] page_token PageToken provided by the API
                    # @param [Integer] page_number Page Number, this value is simply for client state
                    # @param [Integer] page_size Number of records to return, defaults to 50
                    # @return [Page] Page of DeviceInstance
                    def page(page_token: :unset, page_number: :unset, page_size: :unset)
                        params = Twilio::Values.of({
                            'PageToken' => page_token,
                            'Page' => page_number,
                            'PageSize' => page_size,
                        })

                        response = @version.page('GET', @uri, params: params)

                        DevicePage.new(@version, response, @solution)
                    end

                    ##
                    # Retrieve a single page of DeviceInstance records from the API.
                    # Request is executed immediately.
                    # @param [String] target_url API-generated URL for the requested results page
                    # @return [Page] Page of DeviceInstance
                    def get_page(target_url)
                        response = @version.domain.request(
                            'GET',
                            target_url
                        )
                    DevicePage.new(@version, response, @solution)
                    end
                    


                    # Provide a user friendly representation
                    def to_s
                        '#<Twilio.Microvisor.V1.DeviceList>'
                    end
                end


                ##
                #PLEASE NOTE that this class contains preview products that are subject to change. Use them with caution. If you currently do not have developer preview access, please contact help@twilio.com.
                class DeviceContext < InstanceContext
                    ##
                    # Initialize the DeviceContext
                    # @param [Version] version Version that contains the resource
                    # @param [String] sid A 34-character string that uniquely identifies this Device.
                    # @return [DeviceContext] DeviceContext
                    def initialize(version, sid)
                        super(version)

                        # Path Solution
                        @solution = { sid: sid,  }
                        @uri = "/Devices/#{@solution[:sid]}"

                        # Dependents
                        @device_secrets = nil
                        @device_configs = nil
                    end
                    ##
                    # Fetch the DeviceInstance
                    # @return [DeviceInstance] Fetched DeviceInstance
                    def fetch

                        payload = @version.fetch('GET', @uri)
                        DeviceInstance.new(
                            @version,
                            payload,
                            sid: @solution[:sid],
                        )
                    end

                    ##
                    # Update the DeviceInstance
                    # @param [String] unique_name A unique and addressable name to be assigned to this Device by the developer. It may be used in place of the Device SID.
                    # @param [String] target_app The SID or unique name of the App to be targeted to the Device.
                    # @param [Boolean] logging_enabled A Boolean flag specifying whether to enable application logging. Logs will be enabled or extended for 24 hours.
                    # @param [Boolean] restart_app Set to true to restart the App running on the Device.
                    # @return [DeviceInstance] Updated DeviceInstance
                    def update(
                        unique_name: :unset, 
                        target_app: :unset, 
                        logging_enabled: :unset, 
                        restart_app: :unset
                    )

                        data = Twilio::Values.of({
                            'UniqueName' => unique_name,
                            'TargetApp' => target_app,
                            'LoggingEnabled' => logging_enabled,
                            'RestartApp' => restart_app,
                        })

                        payload = @version.update('POST', @uri, data: data)
                        DeviceInstance.new(
                            @version,
                            payload,
                            sid: @solution[:sid],
                        )
                    end

                    ##
                    # Access the device_secrets
                    # @return [DeviceSecretList]
                    # @return [DeviceSecretContext] if sid was passed.
                    def device_secrets(key=:unset)

                        raise ArgumentError, 'key cannot be nil' if key.nil?

                        if key != :unset
                            return DeviceSecretContext.new(@version, @solution[:sid],key )
                        end

                        unless @device_secrets
                            @device_secrets = DeviceSecretList.new(
                                @version, device_sid: @solution[:sid], )
                        end

                     @device_secrets
                    end
                    ##
                    # Access the device_configs
                    # @return [DeviceConfigList]
                    # @return [DeviceConfigContext] if sid was passed.
                    def device_configs(key=:unset)

                        raise ArgumentError, 'key cannot be nil' if key.nil?

                        if key != :unset
                            return DeviceConfigContext.new(@version, @solution[:sid],key )
                        end

                        unless @device_configs
                            @device_configs = DeviceConfigList.new(
                                @version, device_sid: @solution[:sid], )
                        end

                     @device_configs
                    end

                    ##
                    # Provide a user friendly representation
                    def to_s
                        context = @solution.map{|k, v| "#{k}: #{v}"}.join(',')
                        "#<Twilio.Microvisor.V1.DeviceContext #{context}>"
                    end

                    ##
                    # Provide a detailed, user friendly representation
                    def inspect
                        context = @solution.map{|k, v| "#{k}: #{v}"}.join(',')
                        "#<Twilio.Microvisor.V1.DeviceContext #{context}>"
                    end
                end

                class DevicePage < Page
                    ##
                    # Initialize the DevicePage
                    # @param [Version] version Version that contains the resource
                    # @param [Response] response Response from the API
                    # @param [Hash] solution Path solution for the resource
                    # @return [DevicePage] DevicePage
                    def initialize(version, response, solution)
                        super(version, response)

                        # Path Solution
                        @solution = solution
                    end

                    ##
                    # Build an instance of DeviceInstance
                    # @param [Hash] payload Payload response from the API
                    # @return [DeviceInstance] DeviceInstance
                    def get_instance(payload)
                        DeviceInstance.new(@version, payload)
                    end

                    ##
                    # Provide a user friendly representation
                    def to_s
                        '<Twilio.Microvisor.V1.DevicePage>'
                    end
                end
                class DeviceInstance < InstanceResource
                    ##
                    # Initialize the DeviceInstance
                    # @param [Version] version Version that contains the resource
                    # @param [Hash] payload payload that contains response from Twilio
                    # @param [String] account_sid The SID of the
                    #   {Account}[https://www.twilio.com/docs/iam/api/account] that created this Device
                    #   resource.
                    # @param [String] sid The SID of the Call resource to fetch.
                    # @return [DeviceInstance] DeviceInstance
                    def initialize(version, payload , sid: nil)
                        super(version)
                        
                        # Marshaled Properties
                        @properties = { 
                            'sid' => payload['sid'],
                            'unique_name' => payload['unique_name'],
                            'account_sid' => payload['account_sid'],
                            'app' => payload['app'],
                            'logging' => payload['logging'],
                            'date_created' => Twilio.deserialize_iso8601_datetime(payload['date_created']),
                            'date_updated' => Twilio.deserialize_iso8601_datetime(payload['date_updated']),
                            'url' => payload['url'],
                            'links' => payload['links'],
                        }

                        # Context
                        @instance_context = nil
                        @params = { 'sid' => sid  || @properties['sid']  , }
                    end

                    ##
                    # Generate an instance context for the instance, the context is capable of
                    # performing various actions.  All instance actions are proxied to the context
                    # @return [DeviceContext] CallContext for this CallInstance
                    def context
                        unless @instance_context
                            @instance_context = DeviceContext.new(@version , @params['sid'])
                        end
                        @instance_context
                    end
                    
                    ##
                    # @return [String] A 34-character string that uniquely identifies this Device.
                    def sid
                        @properties['sid']
                    end
                    
                    ##
                    # @return [String] A developer-defined string that uniquely identifies the Device. This value must be unique for all Devices on this Account. The `unique_name` value may be used as an alternative to the `sid` in the URL path to address the resource.
                    def unique_name
                        @properties['unique_name']
                    end
                    
                    ##
                    # @return [String] The unique SID identifier of the Account.
                    def account_sid
                        @properties['account_sid']
                    end
                    
                    ##
                    # @return [Hash] Information about the target App and the App reported by this Device. Contains the properties `target_sid`, `date_targeted`, `update_status` (one of `up-to-date`, `pending` and `error`), `update_error_code`, `reported_sid` and `date_reported`.
                    def app
                        @properties['app']
                    end
                    
                    ##
                    # @return [Hash] Object specifying whether application logging is enabled for this Device. Contains the properties `enabled` and `date_expires`.
                    def logging
                        @properties['logging']
                    end
                    
                    ##
                    # @return [Time] The date that this Device was created, given in [ISO 8601](https://en.wikipedia.org/wiki/ISO_8601) format.
                    def date_created
                        @properties['date_created']
                    end
                    
                    ##
                    # @return [Time] The date that this Device was last updated, given in [ISO 8601](https://en.wikipedia.org/wiki/ISO_8601) format.
                    def date_updated
                        @properties['date_updated']
                    end
                    
                    ##
                    # @return [String] The URL of this resource.
                    def url
                        @properties['url']
                    end
                    
                    ##
                    # @return [Hash] The absolute URLs of related resources.
                    def links
                        @properties['links']
                    end
                    
                    ##
                    # Fetch the DeviceInstance
                    # @return [DeviceInstance] Fetched DeviceInstance
                    def fetch

                        context.fetch
                    end

                    ##
                    # Update the DeviceInstance
                    # @param [String] unique_name A unique and addressable name to be assigned to this Device by the developer. It may be used in place of the Device SID.
                    # @param [String] target_app The SID or unique name of the App to be targeted to the Device.
                    # @param [Boolean] logging_enabled A Boolean flag specifying whether to enable application logging. Logs will be enabled or extended for 24 hours.
                    # @param [Boolean] restart_app Set to true to restart the App running on the Device.
                    # @return [DeviceInstance] Updated DeviceInstance
                    def update(
                        unique_name: :unset, 
                        target_app: :unset, 
                        logging_enabled: :unset, 
                        restart_app: :unset
                    )

                        context.update(
                            unique_name: unique_name, 
                            target_app: target_app, 
                            logging_enabled: logging_enabled, 
                            restart_app: restart_app, 
                        )
                    end

                    ##
                    # Access the device_secrets
                    # @return [device_secrets] device_secrets
                    def device_secrets
                        context.device_secrets
                    end

                    ##
                    # Access the device_configs
                    # @return [device_configs] device_configs
                    def device_configs
                        context.device_configs
                    end

                    ##
                    # Provide a user friendly representation
                    def to_s
                        values = @params.map{|k, v| "#{k}: #{v}"}.join(" ")
                        "<Twilio.Microvisor.V1.DeviceInstance #{values}>"
                    end

                    ##
                    # Provide a detailed, user friendly representation
                    def inspect
                        values = @properties.map{|k, v| "#{k}: #{v}"}.join(" ")
                        "<Twilio.Microvisor.V1.DeviceInstance #{values}>"
                    end
                end

            end
        end
    end
end