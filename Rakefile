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
  sh "open bootstragram.xcworkspace"
end

desc "Generate the documentation"
task :appledoc do |t|
  sh "/usr/local/bin/appledoc --verbose 2 --output ./doc --include doc-resources --ignore Pods --ignore .m --project-name \"Bootstragram iOS Demo\" --project-version develop --keep-undocumented-objects --keep-undocumented-members --project-company Bootstragram --company-id com.bootstragram --no-repeat-first-par --no-create-docset --create-html --index-desc README.md ."
end