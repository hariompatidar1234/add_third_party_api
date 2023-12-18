##
#    This code was generated by
#    ___ _ _ _ _ _    _ ____    ____ ____ _    ____ ____ _  _ ____ ____ ____ ___ __   __
#     |  | | | | |    | |  | __ |  | |__| | __ | __ |___ |\ | |___ |__/ |__|  | |  | |__/
#     |  |_|_| | |___ | |__|    |__| |  | |    |__] |___ | \| |___ |  \ |  |  | |__| |  \
#
#    Twilio - Flex
#    This is the public Twilio REST API.
#
#    NOTE: This class is auto generated by OpenAPI Generator.
#    https://openapi-generator.tech
#    Do not edit the class manually.
#


module Twilio
    module REST
        class FlexApi < FlexApiBase
            class V1 < Version
                class InsightsSettingsCommentList < ListResource
                    ##
                    # Initialize the InsightsSettingsCommentList
                    # @param [Version] version Version that contains the resource
                    # @return [InsightsSettingsCommentList] InsightsSettingsCommentList
                    def initialize(version)
                        super(version)
                        # Path Solution
                        @solution = {  }
                        @uri = "/Insights/QualityManagement/Settings/CommentTags"
                        
                    end
                    ##
                    # Fetch the InsightsSettingsCommentInstance
                    # @param [String] authorization The Authorization HTTP request header
                    # @return [InsightsSettingsCommentInstance] Fetched InsightsSettingsCommentInstance
                    def fetch(
                        authorization: :unset
                    )

                        headers = Twilio::Values.of({ 'Authorization' => authorization, })
                        payload = @version.fetch('GET', @uri, headers: headers)
                        InsightsSettingsCommentInstance.new(
                            @version,
                            payload,
                        )
                    end

                


                    # Provide a user friendly representation
                    def to_s
                        '#<Twilio.FlexApi.V1.InsightsSettingsCommentList>'
                    end
                end

                class InsightsSettingsCommentPage < Page
                    ##
                    # Initialize the InsightsSettingsCommentPage
                    # @param [Version] version Version that contains the resource
                    # @param [Response] response Response from the API
                    # @param [Hash] solution Path solution for the resource
                    # @return [InsightsSettingsCommentPage] InsightsSettingsCommentPage
                    def initialize(version, response, solution)
                        super(version, response)

                        # Path Solution
                        @solution = solution
                    end

                    ##
                    # Build an instance of InsightsSettingsCommentInstance
                    # @param [Hash] payload Payload response from the API
                    # @return [InsightsSettingsCommentInstance] InsightsSettingsCommentInstance
                    def get_instance(payload)
                        InsightsSettingsCommentInstance.new(@version, payload)
                    end

                    ##
                    # Provide a user friendly representation
                    def to_s
                        '<Twilio.FlexApi.V1.InsightsSettingsCommentPage>'
                    end
                end
                class InsightsSettingsCommentInstance < InstanceResource
                    ##
                    # Initialize the InsightsSettingsCommentInstance
                    # @param [Version] version Version that contains the resource
                    # @param [Hash] payload payload that contains response from Twilio
                    # @param [String] account_sid The SID of the
                    #   {Account}[https://www.twilio.com/docs/iam/api/account] that created this InsightsSettingsComment
                    #   resource.
                    # @param [String] sid The SID of the Call resource to fetch.
                    # @return [InsightsSettingsCommentInstance] InsightsSettingsCommentInstance
                    def initialize(version, payload )
                        super(version)
                        
                        # Marshaled Properties
                        @properties = { 
                            'account_sid' => payload['account_sid'],
                            'comments' => payload['comments'],
                            'url' => payload['url'],
                        }
                    end

                    
                    ##
                    # @return [String] The SID of the [Account](https://www.twilio.com/docs/iam/api/account) that created the Flex Insights resource and owns this resource.
                    def account_sid
                        @properties['account_sid']
                    end
                    
                    ##
                    # @return [Hash] 
                    def comments
                        @properties['comments']
                    end
                    
                    ##
                    # @return [String] 
                    def url
                        @properties['url']
                    end
                    
                    ##
                    # Provide a user friendly representation
                    def to_s
                        "<Twilio.FlexApi.V1.InsightsSettingsCommentInstance>"
                    end

                    ##
                    # Provide a detailed, user friendly representation
                    def inspect
                        "<Twilio.FlexApi.V1.InsightsSettingsCommentInstance>"
                    end
                end

            end
        end
    end
end
