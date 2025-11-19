JEKYLL := bundle exec jekyll

jekyll:
	@$(JEKYLL) serve --watch --livereload

clean:
	@rm -rf ./_site
	@$(JEKYLL) clean

.PHONY: jekyll clean
