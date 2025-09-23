# Convenience Makefile for local development & testing of the site
# Usage: make <target>

# Default port mapping used by docker-compose.yml (site on http://localhost:8080)
DOCKER_COMPOSE?=docker compose
BUNDLE?=bundle
JEKYLL?=$(BUNDLE) exec jekyll

.PHONY: help serve build clean docker-up docker-build docker-slim lint purgecss check-wellknown curl-fpr

help:
	@echo "Common targets:"
	@echo "  make serve        # Serve with local Ruby environment (http://localhost:4000)"
	@echo "  make build        # Build static site into _site/"
	@echo "  make clean        # Remove _site/ and .jekyll-cache/"
	@echo "  make docker-up    # Run site with full Docker image (http://localhost:8080)"
	@echo "  make docker-slim  # Run site with slim Docker image"
	@echo "  make docker-build # Force rebuild docker image (context from docker-compose.yml)"
	@echo "  make purgecss     # Purge unused CSS into _site/ (run after build)"
	@echo "  make lint         # Run prettier on Liquid/Markdown/JSON/YAML (requires npm deps)"
	@echo "  make check-wellknown # List files served from .well-known/"

serve:
	$(BUNDLE) install
	JEKYLL_ENV=development $(JEKYLL) serve --livereload

build:
	$(BUNDLE) install
	JEKYLL_ENV=production $(JEKYLL) build

clean:
	rm -rf _site .jekyll-cache .sass-cache

# Pull & run latest pre-built image
docker-up:
	$(DOCKER_COMPOSE) pull
	$(DOCKER_COMPOSE) up

# Use slim image variant
docker-slim:
	$(DOCKER_COMPOSE) -f docker-compose-slim.yml pull
	$(DOCKER_COMPOSE) -f docker-compose-slim.yml up

# Force local build of docker image
docker-build:
	$(DOCKER_COMPOSE) up --build --force-recreate

lint:
	npm install
	npx prettier --write .

purgecss:
	@echo "Building site first (production mode)..."
	JEKYLL_ENV=production $(JEKYLL) build
	@echo "Running PurgeCSS (ensure purgecss CLI is installed: npm i -g purgecss OR npx purgecss)..."
	purgecss -c purgecss.config.js || npx purgecss -c purgecss.config.js

check-wellknown:
	@echo "Files in .well-known/:" && ls -1 .well-known || echo ".well-known directory missing"
