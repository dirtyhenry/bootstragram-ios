desc "Clean all built files and objects"
task :clean => ['remove-documentation']

desc "Remove the documentation"
task :'remove-documentation' do |t|
  sh "rm -rf doc"
end

desc "Install pods"
task :'install-pods' do |t|
  sh "pod install"
end

desc "Open"
task :open do |t|
  sh "open itooch.xcworkspace"
end