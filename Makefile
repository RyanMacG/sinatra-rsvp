build:
	$(MAKE) stop
	docker-compose build

serve:
	$(MAKE) build
	docker-compose up -d db
	./bin/wait_for_postgres
	docker-compose up -d web

test:
	$(MAKE) serve
	docker-compose run --rm web bundle exec rspec
	$(MAKE) stop

stop:
	docker-compose kill
	docker-compose rm -f

.PHONY: test serve stop build
