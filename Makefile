.DEFAULT_GOAL := build
build:
	@pandoc \
	--to=revealjs \
	--highlight-style=monochrome \
	--template=src/default.revealjs \
	--standalone \
	--output=docs/index.html \
	src/slides.md \
	--metadata title="[api.]stadtpuls.com" \
	--metadata subtitle="/behind/the/curtain" \
	--metadata author="Lucas Vogel & Fabian Morón Zirfas" \
	--metadata date="2021-10-20" \
	--slide-level=2 \
	--variable theme=simple \
	--variable height="'100%'" \
	--variable width="'100%'" \
	--variable margin=0.2 \
	--variable minScale=1 \
	--variable maxScale=1 \
	--variable transition=fade \
	--variable revealjs-url=https://unpkg.com/reveal.js ;
	@mkdir -p docs/assets/{css,images}
	@cp -R ./src/assets/* docs/assets/ ;
	@echo "pandoc build and assets copy successful"

docker:
	docker compose up pandoc
serve:
	@npx reload -p 3000 --dir ./docs

watch:
	@npx chokidar "./src/*.md" "./src/assets/css/*.css" -c "make build"

clean:
	@rm -rf ./docs/* && touch ./docs/.gitkeep

pdf:
	npx decktape --size 1920x1080 https://technologiestiftung.github.io/stadtpuls-behind-the-curtain ./docs/slides.pdf
graph:
	dot -Tpng graphviz/stack.dot -o  out.png