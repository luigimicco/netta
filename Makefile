# Function: Docker Rebuild
# [execute: down, remove, pull, build, up]
# $(call docker_rebuild,"stack_name")
define docker_rebuild
	$(call docker_remove,$(1))
	docker compose -p $(1) -f docker/$(1)/docker-compose.yml pull && \
	docker compose -p $(1) -f docker/$(1)/docker-compose.yml build --no-cache && \
	docker compose -p $(1) -f docker/$(1)/docker-compose.yml up -d
endef

# Function: Docker Remove
# [execute: down, remove]
# $(call docker_remove,"stack_name")
define docker_remove
	docker compose -p $(1) -f docker/$(1)/docker-compose.yml down --remove-orphans && \
	docker compose -p $(1) -f docker/$(1)/docker-compose.yml rm -f
endef

netta:
	docker volume create netta_storage
	docker volume create postgresnetta_storage
	$(call docker_rebuild,"netta")	