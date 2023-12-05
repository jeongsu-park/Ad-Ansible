#!/bin/bash

echo "Welcome Bro..."

docker_init(){
	docker stop $(docker ps -a -q)

	for i in $(docker ps -a -q)
	do
        	docker rmi -f $i
	done

	docker system prune -a -f 
	docker volume prune -f 
	docker network prune -f
	cd ~/awx
	make clean
}


docker_start(){
	cd ~
	/bin/cp -f ~/files/inventory $HOME/awx/tools/docker-compose
	cd ~/awx
	docker stop $(docker ps -a -q)
	make docker-compose-build
	make docker-compose COMPOSE_UP_OPTS=-d
	docker exec tools_awx_1 make clean-ui ui-devel
}


docker_start_with_external_postgresql(){
	cd ~
	/bin/cp -f ~/files/inventory $HOME/awx/tools/docker-compose
	cd ~/awx
	docker stop $(docker ps -a -q)
	make docker-compose-build
	make docker-compose COMPOSE_UP_OPTS=-d
	docker exec tools_awx_1 make clean-ui ui-devel
}


admin_password(){
	docker exec -it tools_awx_1 awx-manage changepassword admin
}	


case $1 in
	init) 
		docker_init;;

	start)
		docker_start;;

	create)
		admin_password;;

	all)
		docker_init
		docker_start;;

	*)
		echo $"Usage: $0 {init|start|all}"
		echo "	STEP 1 ./prontoa.sh all and then ./prontoa.sh create"
		echo "		becuase first of all You need change admin password when you have log in"
		echo "	STEP 2 ./prontoa.sh start"
		echo "		This script will do recompile... so Usually You used to start argument"
		exit 2
		
esac
