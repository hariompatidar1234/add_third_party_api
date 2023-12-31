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
            class Wireless < Version
                ##
                # Initialize the Wireless version of Preview
                def initialize(domain)
                    super
                    @version = 'wireless'
                    @commands = nil
                    @rate_plans = nil
                    @sims = nil
                end

                ##
                # @param [String] sid 
                # @return [Twilio::REST::Preview::Wireless::CommandContext] if sid was passed.
                # @return [Twilio::REST::Preview::Wireless::CommandList]
                def commands(sid=:unset)
                    if sid.nil?
                        raise ArgumentError, 'sid cannot be nil'
                    end
                    if sid == :unset
                        @commands ||= CommandList.new self
                    else
                        CommandContext.new(self, sid)
                    end
                end
                ##
                # @param [String] sid 
                # @return [Twilio::REST::Preview::Wireless::RatePlanContext] if sid was passed.
                # @return [Twilio::REST::Preview::Wireless::RatePlanList]
                def rate_plans(sid=:unset)
                    if sid.nil?
                        raise ArgumentError, 'sid cannot be nil'
                    end
                    if sid == :unset
                        @rate_plans ||= RatePlanList.new self
                    else
                        RatePlanContext.new(self, sid)
                    end
                end
                ##
                # @param [String] sid 
                # @return [Twilio::REST::Preview::Wireless::SimContext] if sid was passed.
                # @return [Twilio::REST::Preview::Wireless::SimList]
                def sims(sid=:unset)
                    if sid.nil?
                        raise ArgumentError, 'sid cannot be nil'
                    end
                    if sid == :unset
                        @sims ||= SimList.new self
                    else
                        SimContext.new(self, sid)
                    end
                end
                ##
                # Provide a user friendly representation
                def to_s
                    '<Twilio::REST::Preview::Wireless>';
                end
            end
        end
    end
end
