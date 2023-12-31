##
#    This code was generated by
#    ___ _ _ _ _ _    _ ____    ____ ____ _    ____ ____ _  _ ____ ____ ____ ___ __   __
#     |  | | | | |    | |  | __ |  | |__| | __ | __ |___ |\ | |___ |__/ |__|  | |  | |__/
#     |  |_|_| | |___ | |__|    |__| |  | |    |__] |___ | \| |___ |  \ |  |  | |__| |  \
#
#    Twilio - Studio
#    This is the public Twilio REST API.
#
#    NOTE: This class is auto generated by OpenAPI Generator.
#    https://openapi-generator.tech
#    Do not edit the class manually.
#

module Twilio
    module REST
        class Studio
            class V2 < Version
                ##
                # Initialize the V2 version of Studio
                def initialize(domain)
                    super
                    @version = 'v2'
                    @flows = nil
                    @flow_validate = nil
                end

                ##
                # @param [String] sid The SID of the Flow resource to fetch.
                # @return [Twilio::REST::Studio::V2::FlowContext] if sid was passed.
                # @return [Twilio::REST::Studio::V2::FlowList]
                def flows(sid=:unset)
                    if sid.nil?
                        raise ArgumentError, 'sid cannot be nil'
                    end
                    if sid == :unset
                        @flows ||= FlowList.new self
                    else
                        FlowContext.new(self, sid)
                    end
                end
                ##
                # @return [Twilio::REST::Studio::V2::FlowValidateList]
                def flow_validate
                    @flow_validate ||= FlowValidateList.new self
                end
                ##
                # Provide a user friendly representation
                def to_s
                    '<Twilio::REST::Studio::V2>';
                end
            end
        end
    end
end
