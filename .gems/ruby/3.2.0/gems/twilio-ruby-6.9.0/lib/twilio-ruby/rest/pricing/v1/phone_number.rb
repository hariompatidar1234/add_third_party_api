##
#    This code was generated by
#    ___ _ _ _ _ _    _ ____    ____ ____ _    ____ ____ _  _ ____ ____ ____ ___ __   __
#     |  | | | | |    | |  | __ |  | |__| | __ | __ |___ |\ | |___ |__/ |__|  | |  | |__/
#     |  |_|_| | |___ | |__|    |__| |  | |    |__] |___ | \| |___ |  \ |  |  | |__| |  \
#
#    Twilio - Pricing
#    This is the public Twilio REST API.
#
#    NOTE: This class is auto generated by OpenAPI Generator.
#    https://openapi-generator.tech
#    Do not edit the class manually.
#


module Twilio
    module REST
        class Pricing < PricingBase
            class V1 < Version
                class PhoneNumberList < ListResource
                    ##
                    # Initialize the PhoneNumberList
                    # @param [Version] version Version that contains the resource
                    # @return [PhoneNumberList] PhoneNumberList
                    def initialize(version)
                        super(version)
                        # Path Solution
                        @solution = {  }
                        @uri = "/PhoneNumbers"
                        # Components
                        @countries = nil
                    end
                

                ##
                # Access the countries
                # @return [CountryList]
                # @return [CountryContext] if sid was passed.
                def countries(iso_country=:unset)
                    raise ArgumentError, 'iso_country cannot be nil' if iso_country.nil?

                    if iso_country != :unset
                        return CountryContext.new(@version,iso_country )
                    end

                    @countries ||= CountryList.new(@version )
                end

                    # Provide a user friendly representation
                    def to_s
                        '#<Twilio.Pricing.V1.PhoneNumberList>'
                    end
                end

                class PhoneNumberPage < Page
                    ##
                    # Initialize the PhoneNumberPage
                    # @param [Version] version Version that contains the resource
                    # @param [Response] response Response from the API
                    # @param [Hash] solution Path solution for the resource
                    # @return [PhoneNumberPage] PhoneNumberPage
                    def initialize(version, response, solution)
                        super(version, response)

                        # Path Solution
                        @solution = solution
                    end

                    ##
                    # Build an instance of PhoneNumberInstance
                    # @param [Hash] payload Payload response from the API
                    # @return [PhoneNumberInstance] PhoneNumberInstance
                    def get_instance(payload)
                        PhoneNumberInstance.new(@version, payload)
                    end

                    ##
                    # Provide a user friendly representation
                    def to_s
                        '<Twilio.Pricing.V1.PhoneNumberPage>'
                    end
                end
                class PhoneNumberInstance < InstanceResource
                    ##
                    # Initialize the PhoneNumberInstance
                    # @param [Version] version Version that contains the resource
                    # @param [Hash] payload payload that contains response from Twilio
                    # @param [String] account_sid The SID of the
                    #   {Account}[https://www.twilio.com/docs/iam/api/account] that created this PhoneNumber
                    #   resource.
                    # @param [String] sid The SID of the Call resource to fetch.
                    # @return [PhoneNumberInstance] PhoneNumberInstance
                    def initialize(version )
                        super(version)
                        
                    end

                    
                    ##
                    # Provide a user friendly representation
                    def to_s
                        "<Twilio.Pricing.V1.PhoneNumberInstance>"
                    end

                    ##
                    # Provide a detailed, user friendly representation
                    def inspect
                        "<Twilio.Pricing.V1.PhoneNumberInstance>"
                    end
                end

            end
        end
    end
end