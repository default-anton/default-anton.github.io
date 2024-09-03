JEKYLL := bundle exec jekyll
TAILWIND := npx tailwindcss
CSS_INPUT := ./css/tailwind.css
CSS_OUTPUT := ./css/tw.css

jekyll:
	@$(JEKYLL) serve --watch --livereload

tailwind:
	@$(TAILWIND) -i $(CSS_INPUT) -o $(CSS_OUTPUT) --watch

clean:
	@rm -rf ./_site $(CSS_OUTPUT)
	@$(JEKYLL) clean

.PHONY: all jekyll tailwind clean
