require 'kubectl-rb'

module KubeSpec
  module Handlers
    # calling this a client handler, but it's really both
    class VersionHandler < ClientHandler
      def evaluate(statement)
        puts(<<~END)
          Client Version: version.Info{Major:"1", Minor:"18", GitVersion:"v1.18.3", GitCommit:"0000000000000000000000000000000000000000", GitTreeState:"clean", BuildDate:"2020-05-20T12:52:00Z", GoVersion:"go1.13.9", Compiler:"gc", Platform:"test/test"}
        END

        puts(<<~END)
          Server Version: version.Info{Major:"1", Minor:"18", GitVersion:"v1.18.3", GitCommit:"0000000000000000000000000000000000000000", GitTreeState:"clean", BuildDate:"2020-04-16T11:35:47Z", GoVersion:"go1.13.9", Compiler:"gc", Platform:"test/test"}
        END
      end
    end
  end
end
