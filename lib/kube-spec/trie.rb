module KubeSpec
  class Trie
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

      def get(path)
        traverse(Array(path))&.value
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

    attr_reader :root

    def initialize
      @root = Node.new
    end

    def add(*args)
      root.add(*args)
    end

    def get(*args)
      root.get(*args)
    end

    def traverse(*args)
      root.traverse(*args)
    end
  end
end
