module KubeSpec
  module Handlers
    class Handler
      attr_reader :cluster

      def initialize(cluster)
        @cluster = cluster
      end

      def evaluate(statement)
        raise NotImplementedError, "#{__method__} must be defined in derived classes"
      end
    end
  end
end
