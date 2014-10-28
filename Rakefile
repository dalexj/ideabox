desc 'Run unit tests'
task :test do
  test_files = Dir["test/**/*_test.rb"]
  require_tests = test_files.map { |filename| "-r ./#{filename}"}.join(" ")
  sh "ruby -e '' #{require_tests}"
end
task default: :test
