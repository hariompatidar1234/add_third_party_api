##
#    This code was generated by
#    ___ _ _ _ _ _    _ ____    ____ ____ _    ____ ____ _  _ ____ ____ ____ ___ __   __
#     |  | | | | |    | |  | __ |  | |__| | __ | __ |___ |\ | |___ |__/ |__|  | |  | |__/
#     |  |_|_| | |___ | |__|    |__| |  | |    |__] |___ | \| |___ |  \ |  |  | |__| |  \
#
#    Twilio - Preview
#    This is the public Twilio REST API.
#
#    NOTE: This class is auto generated by OpenAPI Generator.
#    https://openapi-generator.tech
#    Do not edit the class manually.
#

module Twilio
    module REST
        class Preview
            class DeployedDevices < Version
                ##
                # Initialize the DeployedDevices version of Preview
                def initialize(domain)
                    super
                    @version = 'DeployedDevices'
                    @fleets = nil
                end

                ##
                # @param [String] sid Provides a 34 character string that uniquely identifies the requested Fleet resource.
                # @return [Twilio::REST::Preview::DeployedDevices::FleetContext] if sid was passed.
                # @return [Twilio::REST::Preview::DeployedDevices::FleetList]
                def fleets(sid=:unset)
                    if sid.nil?
                        raise ArgumentError, 'sid cannot be nil'
                    end
                    if sid == :unset
                        @fleets ||= FleetList.new self
                    else
                        FleetContext.new(self, sid)
                    end
                end
                ##
                # Provide a user friendly representation
                def to_s
                    '<Twilio::REST::Preview::DeployedDevices>';
                end
            end
        end
    end
end