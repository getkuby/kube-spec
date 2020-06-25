module KubeSpec
  module Handlers
    class ClientHandler
      def self.server?
        false
      end

      attr_reader :client

      def initialize(client)
        @client = client
      end

      def evaluate(statement)
        raise NotImplementedError, "#{__method__} must be defined in derived classes"
      end
    end
  end
end
