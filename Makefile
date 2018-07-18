default: tensor

.PHONY: tensor

CONTAINER_NAME=tensor

## Network setting
IP=140.123.102.161
PORT_JUPYTER=8888
PORT_TENSORBOARD=6006
PORT_SSH=52022
PASSWD=12345

## Mount path
MOUNT_PATH_HOST=/home/${USER}/dockerData



tensor:
		sudo docker build -t tensorimg .

#Nvidia docker 1		
container_nvd1:
		sudo nvidia-docker run --restart=always -d --name ${CONTAINER_NAME} -e PASSWORD=${PASSWD} -p ${IP}:${PORT_JUPYTER}:8888 -p ${IP}:${PORT_TENSORBOARD}:6006 -p ${IP}:${PORT_SSH}:22 -v ${MOUNT_PATH_HOST}:/notebooks/data:z tensorimg

#Nvidia docker 2
container_nvd2:
		sudo docker run --runtime=nvidia --restart=always -d --name ${CONTAINER_NAME} -e PASSWORD=${PASSWD} -p ${IP}:${PORT_JUPYTER}:8888 -p ${IP}:${PORT_TENSORBOARD}:6006 -p ${IP}:${PORT_SSH}:22 -v ${MOUNT_PATH_HOST}:/notebooks/data:z tensorimg
login:
		sudo docker exec -it ${CONTAINER_NAME} bash
		
rm:
		sudo docker container stop ${CONTAINER_NAME}
		sudo docker container rm ${CONTAINER_NAME}
		
rmi:
		sudo docker image rm tensorimg
