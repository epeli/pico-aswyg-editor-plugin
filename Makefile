export PATH := aswyg-editor/node_modules/.bin:$(PATH)

PORT = 8080
NAME = aswyg
IMAGE_NAME = aswygdev

all: git-deps browserify scss


git-deps:
	git clone https://github.com/epeli/aswyg-editor
	$(MAKE) -C aswyg-editor

commit-assets: browserify scss
	git add aswyg.css aswyg.js
	git commit aswyg.css aswyg.js -m "Update assets"

browserify:
	browserify -t hbsfy aswyg-editor/index.js > aswyg.js

watch-browserify:
	watchify -v -d -t hbsfy aswyg-editor/index.js -o aswyg.js

scss:
	node-sass -o aswyg.css aswyg-editor/scss/app.scss

watch-scss:
	node-sass --watch --source-comments map  --source-map -o aswyg.css aswyg-editor/scss/app.scss

build-image:
	docker build --tag $(IMAGE_NAME) .

run-container:
	docker run \
		--detach \
		--publish $(PORT):8080 \
		--volume $(CURDIR)/log:/var/log/apache2 \
		--volume $(CURDIR)/content:/var/pico/content:rw \
		--volume $(CURDIR):/var/pico/plugins/pico-aswyg-editor-plugin \
		$(IMAGE_NAME)

stop-container:
	docker stop $(NAME) || true
	docker rm $(NAME)

clean:
	rm -rf aswyg-editor
