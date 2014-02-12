export PATH := aswyg-editor/node_modules/.bin:$(PATH)

PORT = 8080
NAME = aswyg
IMAGE_NAME = aswygdev


git-deps:
	git clone https://github.com/epeli/aswyg-editor
	$(MAKE) -C aswyg-editor

watch:
	watchify -d -t sassify -t hbsfy aswyg-editor/index.js -o aswyg.js

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
