require 'kubectl-rb'

module KubeSpec
  module Handlers
    class VersionHandler < Handler
      def evaluate(statement)
        # delegate to real kubectl executable
        puts `#{KubectlRb.executable} #{statement.arglist.join(' ')}`
      end
    end
  end
end
