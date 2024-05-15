##
#    This code was generated by
#    ___ _ _ _ _ _    _ ____    ____ ____ _    ____ ____ _  _ ____ ____ ____ ___ __   __
#     |  | | | | |    | |  | __ |  | |__| | __ | __ |___ |\ | |___ |__/ |__|  | |  | |__/
#     |  |_|_| | |___ | |__|    |__| |  | |    |__] |___ | \| |___ |  \ |  |  | |__| |  \
#
#    Twilio - Insights
#    This is the public Twilio REST API.
#
#    NOTE: This class is auto generated by OpenAPI Generator.
#    https://openapi-generator.tech
#    Do not edit the class manually.
#


module Twilio
    module REST
        class Insights < InsightsBase
            class V1 < Version
                class RoomContext < InstanceContext

                     class ParticipantList < ListResource
                    ##
                    # Initialize the ParticipantList
                    # @param [Version] version Version that contains the resource
                    # @return [ParticipantList] ParticipantList
                    def initialize(version, room_sid: nil)
                        super(version)
                        # Path Solution
                        @solution = { room_sid: room_sid }
                        @uri = "/Video/Rooms/#{@solution[:room_sid]}/Participants"
                        
                    end
                
                    ##
                    # Lists ParticipantInstance records from the API as a list.
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
                    # When passed a block, yields ParticipantInstance records from the API.
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
                    # Retrieve a single page of ParticipantInstance records from the API.
                    # Request is executed immediately.
                    # @param [String] page_token PageToken provided by the API
                    # @param [Integer] page_number Page Number, this value is simply for client state
                    # @param [Integer] page_size Number of records to return, defaults to 50
                    # @return [Page] Page of ParticipantInstance
                    def page(page_token: :unset, page_number: :unset, page_size: :unset)
                        params = Twilio::Values.of({
                            'PageToken' => page_token,
                            'Page' => page_number,
                            'PageSize' => page_size,
                        })

                        response = @version.page('GET', @uri, params: params)

                        ParticipantPage.new(@version, response, @solution)
                    end

                    ##
                    # Retrieve a single page of ParticipantInstance records from the API.
                    # Request is executed immediately.
                    # @param [String] target_url API-generated URL for the requested results page
                    # @return [Page] Page of ParticipantInstance
                    def get_page(target_url)
                        response = @version.domain.request(
                            'GET',
                            target_url
                        )
                    ParticipantPage.new(@version, response, @solution)
                    end
                    


                    # Provide a user friendly representation
                    def to_s
                        '#<Twilio.Insights.V1.ParticipantList>'
                    end
                end


                ##
                #PLEASE NOTE that this class contains beta products that are subject to change. Use them with caution.
                class ParticipantContext < InstanceContext
                    ##
                    # Initialize the ParticipantContext
                    # @param [Version] version Version that contains the resource
                    # @param [String] room_sid The SID of the Room resource.
                    # @param [String] participant_sid The SID of the Participant resource.
                    # @return [ParticipantContext] ParticipantContext
                    def initialize(version, room_sid, participant_sid)
                        super(version)

                        # Path Solution
                        @solution = { room_sid: room_sid, participant_sid: participant_sid,  }
                        @uri = "/Video/Rooms/#{@solution[:room_sid]}/Participants/#{@solution[:participant_sid]}"

                        
                    end
                    ##
                    # Fetch the ParticipantInstance
                    # @return [ParticipantInstance] Fetched ParticipantInstance
                    def fetch

                        payload = @version.fetch('GET', @uri)
                        ParticipantInstance.new(
                            @version,
                            payload,
                            room_sid: @solution[:room_sid],
                            participant_sid: @solution[:participant_sid],
                        )
                    end


                    ##
                    # Provide a user friendly representation
                    def to_s
                        context = @solution.map{|k, v| "#{k}: #{v}"}.join(',')
                        "#<Twilio.Insights.V1.ParticipantContext #{context}>"
                    end

                    ##
                    # Provide a detailed, user friendly representation
                    def inspect
                        context = @solution.map{|k, v| "#{k}: #{v}"}.join(',')
                        "#<Twilio.Insights.V1.ParticipantContext #{context}>"
                    end
                end

                class ParticipantPage < Page
                    ##
                    # Initialize the ParticipantPage
                    # @param [Version] version Version that contains the resource
                    # @param [Response] response Response from the API
                    # @param [Hash] solution Path solution for the resource
                    # @return [ParticipantPage] ParticipantPage
                    def initialize(version, response, solution)
                        super(version, response)

                        # Path Solution
                        @solution = solution
                    end

                    ##
                    # Build an instance of ParticipantInstance
                    # @param [Hash] payload Payload response from the API
                    # @return [ParticipantInstance] ParticipantInstance
                    def get_instance(payload)
                        ParticipantInstance.new(@version, payload, room_sid: @solution[:room_sid])
                    end

                    ##
                    # Provide a user friendly representation
                    def to_s
                        '<Twilio.Insights.V1.ParticipantPage>'
                    end
                end
                class ParticipantInstance < InstanceResource
                    ##
                    # Initialize the ParticipantInstance
                    # @param [Version] version Version that contains the resource
                    # @param [Hash] payload payload that contains response from Twilio
                    # @param [String] account_sid The SID of the
                    #   {Account}[https://www.twilio.com/docs/iam/api/account] that created this Participant
                    #   resource.
                    # @param [String] sid The SID of the Call resource to fetch.
                    # @return [ParticipantInstance] ParticipantInstance
                    def initialize(version, payload , room_sid: nil, participant_sid: nil)
                        super(version)
                        
                        # Marshaled Properties
                        @properties = { 
                            'participant_sid' => payload['participant_sid'],
                            'participant_identity' => payload['participant_identity'],
                            'join_time' => Twilio.deserialize_iso8601_datetime(payload['join_time']),
                            'leave_time' => Twilio.deserialize_iso8601_datetime(payload['leave_time']),
                            'duration_sec' => payload['duration_sec'],
                            'account_sid' => payload['account_sid'],
                            'room_sid' => payload['room_sid'],
                            'status' => payload['status'],
                            'codecs' => payload['codecs'],
                            'end_reason' => payload['end_reason'],
                            'error_code' => payload['error_code'] == nil ? payload['error_code'] : payload['error_code'].to_i,
                            'error_code_url' => payload['error_code_url'],
                            'media_region' => payload['media_region'],
                            'properties' => payload['properties'],
                            'edge_location' => payload['edge_location'],
                            'publisher_info' => payload['publisher_info'],
                            'url' => payload['url'],
                        }

                        # Context
                        @instance_context = nil
                        @params = { 'room_sid' => room_sid  || @properties['room_sid']  ,'participant_sid' => participant_sid  || @properties['participant_sid']  , }
                    end

                    ##
                    # Generate an instance context for the instance, the context is capable of
                    # performing various actions.  All instance actions are proxied to the context
                    # @return [ParticipantContext] CallContext for this CallInstance
                    def context
                        unless @instance_context
                            @instance_context = ParticipantContext.new(@version , @params['room_sid'], @params['participant_sid'])
                        end
                        @instance_context
                    end
                    
                    ##
                    # @return [String] Unique identifier for the participant.
                    def participant_sid
                        @properties['participant_sid']
                    end
                    
                    ##
                    # @return [String] The application-defined string that uniquely identifies the participant within a Room.
                    def participant_identity
                        @properties['participant_identity']
                    end
                    
                    ##
                    # @return [Time] When the participant joined the room.
                    def join_time
                        @properties['join_time']
                    end
                    
                    ##
                    # @return [Time] When the participant left the room.
                    def leave_time
                        @properties['leave_time']
                    end
                    
                    ##
                    # @return [String] Amount of time in seconds the participant was in the room.
                    def duration_sec
                        @properties['duration_sec']
                    end
                    
                    ##
                    # @return [String] Account SID associated with the room.
                    def account_sid
                        @properties['account_sid']
                    end
                    
                    ##
                    # @return [String] Unique identifier for the room.
                    def room_sid
                        @properties['room_sid']
                    end
                    
                    ##
                    # @return [RoomStatus] 
                    def status
                        @properties['status']
                    end
                    
                    ##
                    # @return [Array<Codec>] Codecs detected from the participant. Can be `VP8`, `H264`, or `VP9`.
                    def codecs
                        @properties['codecs']
                    end
                    
                    ##
                    # @return [String] Reason the participant left the room. See [the list of possible values here](https://www.twilio.com/docs/video/troubleshooting/video-log-analyzer-api#end_reason).
                    def end_reason
                        @properties['end_reason']
                    end
                    
                    ##
                    # @return [String] Errors encountered by the participant.
                    def error_code
                        @properties['error_code']
                    end
                    
                    ##
                    # @return [String] Twilio error code dictionary link.
                    def error_code_url
                        @properties['error_code_url']
                    end
                    
                    ##
                    # @return [TwilioRealm] 
                    def media_region
                        @properties['media_region']
                    end
                    
                    ##
                    # @return [Hash] Object containing information about the participant's data from the room. See [below](https://www.twilio.com/docs/video/troubleshooting/video-log-analyzer-api#properties) for more information.
                    def properties
                        @properties['properties']
                    end
                    
                    ##
                    # @return [EdgeLocation] 
                    def edge_location
                        @properties['edge_location']
                    end
                    
                    ##
                    # @return [Hash] Object containing information about the SDK name and version. See [below](https://www.twilio.com/docs/video/troubleshooting/video-log-analyzer-api#publisher_info) for more information.
                    def publisher_info
                        @properties['publisher_info']
                    end
                    
                    ##
                    # @return [String] URL of the participant resource.
                    def url
                        @properties['url']
                    end
                    
                    ##
                    # Fetch the ParticipantInstance
                    # @return [ParticipantInstance] Fetched ParticipantInstance
                    def fetch

                        context.fetch
                    end

                    ##
                    # Provide a user friendly representation
                    def to_s
                        values = @params.map{|k, v| "#{k}: #{v}"}.join(" ")
                        "<Twilio.Insights.V1.ParticipantInstance #{values}>"
                    end

                    ##
                    # Provide a detailed, user friendly representation
                    def inspect
                        values = @properties.map{|k, v| "#{k}: #{v}"}.join(" ")
                        "<Twilio.Insights.V1.ParticipantInstance #{values}>"
                    end
                end

             end
            end
        end
    end
end

