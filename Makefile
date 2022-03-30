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

# get python files 
SFILES := `find backend -name "*.py"`

# housekeeping
clean:
	-rm -f  *.tmp
	-make remove-pycache
	-rm -rf frontend/build
	-rm -rf frontend/node_modules
	-rm frontend/package-lock.json

remove-pycache:
	find . -type d -name __pycache__ -exec rm -r {} \+

clean-docker:
	-bash docker-rm.sh

# backend commands
format-backend:
	@for name in $(SFILES); do $(BLACK) $$name; done

lint-backend:
	@for name in $(SFILES); do $(PYLINT) $$name; done

# frontend commands
build-frontend:
	cd frontend && npm install && npm run build

# full run command
run-server:
	@echo "************************************************************************"
	@echo "Are you sure you pushed all changes and are ready to deploy to server??"
	@echo "************************************************************************"
	make clean
	make clean-docker
	docker-compose -f "docker-compose.yml" up -d --build

# fast run command
fast-server:
	docker-compose -f "docker-compose.yml" up -d --build

# run full stack only for developing
run-fullstack:
	make build-frontend
	cd backend && python3 main.py

# Get Container ID
containerID := `docker ps -q --filter "name=online-puzzle-hunt_web"`

# Docker execs into the right container
docker-exec:
	docker exec -it $(containerID) /bin/sh

# run api for developing 
run-api:
	@echo "************************************************************************"
	@echo "There will be a Jinja Exception on Webpages but the API will still work!"
	@echo "************************************************************************"
	cd backend && python3 main.py

# kill apache2
kill-apache: 
	sudo service apache2 stop
	make list-ports

# run backend unittests
run-backend-unittests:
	@echo "*************************"
	@echo "Running Backend Unittests"
	@echo "*************************"
	cd backend && python3 test.py


run-frontend-selenium:
	@echo "*************************"
	@echo "Running frontend selenium"
	@echo "*************************"
	docker run -ti -v $(pwd)/selenium:/root/selenium -w /root/selenium groverhood/selenium-testing python3 test.py


# before push
prepare:
	make clean
	make format-backend
	make lint-backend
	
# list ports in use 
list-ports: 
	sudo lsof -i -P -n | grep LISTEN	

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
