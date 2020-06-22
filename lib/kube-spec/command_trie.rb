module KubeSpec
  class CommandTrie < Trie
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
  end
end
