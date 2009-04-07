module Distribunaut
  module Distributed # :nodoc:
    module Errors # :nodoc:
      
      # Raised when an unknown distributed application is referenced.
      class UnknownApplication < StandardError
        # Takes the application name.
        def initialize(app_name)
          super("APPLICATION: #{app_name} is not a known/registered distributed application.")
        end
      end
      
      # Raised when an application doesn't declare it's application name for use in a distributed system.
      class ApplicationNameUndefined < StandardError
      end
      
      # Raised when the distributed path is not a well formed addressable format
      class InvalidAddressableURIFormat < StandardError
        def inititalize(msg)
          super("Invalid addressable format: #{msg}")
        end
      end
      
    end # Errors
  end # Distributed
end # Distribunaut