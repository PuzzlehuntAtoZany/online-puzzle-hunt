# set appname
appname := online-puzzle-hunt_web
.DEFAULT_GOAL := format
MAKEFLAGS += --no-builtin-rules
SHELL         := bash

ifeq ($(shell uname -s), Darwin)
	BLACK         := python3 -m black
	PYLINT        := python3 -m pylint
	PYTHON        := python3
else ifeq ($(shell uname -p), unknown)
	BLACK         := python -m black
	PYLINT        := python -m pylint
	PYTHON        := python
else
	BLACK         := python3 -m black
	PYLINT        := python3 -m  pylint3
	PYTHON        := python3
endif 

# Run PGadmin 
start-pgadmin:
	docker pull dpage/pgadmin4
	docker run -p 80:80 \
    -e 'PGADMIN_DEFAULT_EMAIL=user@domain.com' \
    -e 'PGADMIN_DEFAULT_PASSWORD=SuperSecret' \
    -d dpage/pgadmin4

# housekeeping
clean:
	-rm -f  *.tmp
	-make remove-pycache

remove-pycache:
	find . -type d -name __pycache__ -exec rm -r {} \+

clean-docker:
	-bash docker-rm.sh

# get python files 
GPHFILES := `find gph -name "*.py"`
PFILES := `find puzzles -name "*.py"`

# backend commands
format-backend:
	@for name in $(GPHFILES); do $(BLACK) $$name; done
	@for name in $(PFILES); do $(BLACK) $$name; done

lint-backend:
	@for name in $(GPHFILES); do $(PYLINT) $$name; done
	@for name in $(PFILES); do $(PYLINT) $$name; done

# full run command
run-server:
	@echo "***********************************************"
	@echo "Are you sure you are ready to deploy to server?"
	@echo "***********************************************"
	make clean
	make clean-docker
	docker-compose -f "docker-compose.yml" up -d --build

# fast run command
fast-server:
	docker-compose -f "docker-compose.yml" up -d --build

# Get Container ID
containerID := `docker ps -q --filter "name=online-puzzle-hunt_web"`

# Docker execs into the right container
docker-exec:
	docker exec -it $(containerID) /bin/sh

# kill apache2
kill-apache: 
	sudo service apache2 stop
	make list-ports

# before push
prepare:
	make clean
	make format-backend
	make lint-backend
	
# list ports in use 
list-ports: 
	sudo lsof -i -P -n | grep LISTEN

# get local SSL Files 
local-ssl:
	brew install mkcert
	mkcert -install
	mkcert -cert-file cert.pem -key-file key.pem localhost 127.0.0.1

# run locally with ssl
run-local:
	python manage.py runsslserver --certificate cert.pem --key key.pem

# output versions of all tools
versions:
	@echo  'shell uname -p'
	@echo $(shell uname -p)
	@echo
	@echo  'shell uname -s'
	@echo $(shell uname -s)
	@echo
	@echo "% which $(BLACK)"
	@which $(BLACK)
	@echo
	@echo "% $(BLACK) --version"
	@$(BLACK) --version
	@echo
	@echo "% which $(PYLINT)"
	@which $(PYLINT)
	@echo
	@echo "% $(PYLINT) --version"
	@$(PYLINT) --version
	@echo
	@echo "% which $(PYTHON)"
	@which $(PYTHON)
	@echo
	@echo "% $(PYTHON) --version"
	@$(PYTHON) --version

# end
