clean: ## Clean all built files and objects
	rm -rf doc/

install: ## Install deps
	bundle install 
	bundle exec pod install

open:
	open bootstragram.xcworkspace

docs: ## Generate the documentation
	/usr/local/bin/appledoc \
	--verbose 2 \
	--output ./doc \
	--include doc-resources \
	--ignore Pods \
	--ignore .m \
	--project-name \"Bootstragram iOS Demo\" \
	--project-version develop \
	--keep-undocumented-objects \
	--keep-undocumented-members \
	--project-company Bootstragram \
	--company-id com.bootstragram \
	--no-repeat-first-par \
	--no-create-docset \
	--create-html \ 
	--index-desc README.md \
	.
