module KubeSpec
  class CommandTrie
    class Node
      attr_accessor :value, :children

      def initialize
        @children = {}
      end

      def add(path, value)
        path = Array(path)
        current = self

        path.each do |seg|
          unless current.children.include?(seg)
            current.children[seg] = Node.new
          end

          current = current.children[seg]
        end

        current.value = value
      end

      def traverse(path)
        path = Array(path)
        current = self

        path.each do |seg|
          current = current.children[seg]
          break unless current
        end

        current
      end
    end

    class << self
      def from_list(command_list)
        new.tap do |trie|
          add_to(trie, command_list)
        end
      end

      private

      def add_to(trie, command_list)
        command_list.each do |command|
          trie.add(command.cmd, command)
          add_to(trie, command.subcommands)
        end
      end
    end

    attr_reader :root

    def initialize
      @root = Node.new
    end

    def add(*args)
      root.add(*args)
    end

    def traverse(*args)
      root.traverse(*args)
    end
  end
end
