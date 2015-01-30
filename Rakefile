require "bundler/gem_tasks"

require "rspec/core/rake_task"
RSpec::Core::RakeTask.new(:spec) do |t|
  t.rspec_opts = [
    "--format doc",
    "--color",
  ]
end

require "rspec/core/rake_task"
RSpec::Core::RakeTask.new(:spec_current) do |t|
  t.rspec_opts = [
    "--format doc",
    "--color",
    "--tag current",
  ]
end

