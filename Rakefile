require 'bundler'
require 'rspec/core/rake_task'
require 'rubygems/package_task'

require 'kube-spec'

Bundler::GemHelper.install_tasks

task :generate do
  FileUtils.rm_f(KubeSpec::CLI.spec_file)

  File.write(
    KubeSpec::CLI.spec_file,
    Marshal.dump({
      commands: KubeSpec::CLI.commands,
      global_options: KubeSpec::CLI.global_options
    })
  )
end
