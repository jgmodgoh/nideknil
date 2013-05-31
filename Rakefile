require "bundler/gem_tasks"

$LOAD_PATH.unshift('lib', 'test')

desc "Run test suite"
task :test  do
  Dir.glob('./test/**/*.rb').each {|file| require file}
end

desc "Run tests for Nideknil::Client"
task :test_client do
  require 'spec_client'
end

desc "Run tests for Nideknil::Query"
task :test_query do 
  require 'spec_query'
end


desc "Run tests for Nideknil::JobPosts"
task :test_jobposts do
  require 'spec_jobposts'
end