require "bundler/gem_tasks"

desc "Run test suite"
task :test  do
	$LOAD_PATH.unshift('lib', 'test')
	Dir.glob('./test/**/*.rb').each {|file| require file}
end