##########################
## INIT                 ##
##########################

#rm -rf ~/.minikube/ ~/goinfre/minikube
#mkdir ~/goinfre/minikube
#ln -s ~/goinfre/minikube ~/.minikube/ 
if [ `uname -s` = 'Linux' ]
then
	VMDRIVER="docker"
	VMCORE=2
else
	VMDRIVER="virtualbox"
	VMCORE=4
fi
minikube start --vm-driver=$VMDRIVER --cpus=$VMCORE --memory=5000m

###########################
## DOCKER                ##
###########################

eval $(minikube docker-env)

docker build -t telegraf:v1 srcs/containers/telegraf/
docker build -t ftps:v1 srcs/containers/ftps/
docker build -t nginx:v1 srcs/containers/nginx/
docker build -t wordpress:v1 srcs/containers/wordpress/
docker build -t phpmyadmin:v1 srcs/containers/phpmyadmin/
docker build -t grafana:v1 srcs/containers/grafana/
docker build -t mysql:v1 srcs/containers/mysql/
docker build -t influxdb:v1 srcs/containers/influxdb/

###########################
## LOADBALANCER          ##
###########################

kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.9.3/manifests/namespace.yaml
kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.9.3/manifests/metallb.yaml
kubectl create secret generic -n metallb-system memberlist --from-literal=secretkey="$(openssl rand -base64 128)"

if [ $VMDRIVER = 'docker' ]
then
	IP=`docker inspect minikube --format="{{range .NetworkSettings.Networks}}{{.Gateway}}{{end}}"`
else
	IP=`minikube ip`
fi

IP=`echo $IP|awk -F '.' '{print $1"."$2"."$3"."128}'`
cp srcs/metallb_base.yaml srcs/metallb.yaml
sed -ie "s/IPTMP/$IP/g" srcs/metallb.yaml

###########################
## DEPLOY                ##
###########################

kubectl create secret tls nginx --key srcs/containers/nginx/srcs/certs/server.key --cert srcs/containers/nginx/srcs/certs/server.crt

kubectl create -f srcs/metallb.yaml

kubectl create -f srcs/ftps.yaml

kubectl create -f srcs/nginx.yaml

kubectl create -f srcs/wordpress.yaml
kubectl create -f srcs/phpmyadmin.yaml
kubectl create -f srcs/grafana.yaml

kubectl create -f srcs/mysql.yaml
kubectl create -f srcs/influxdb.yaml

###########################
## DASHBOARD             ##
###########################

echo "Waiting until Dashboard launch"
sleep 10
screen -dmS t0 minikube dashboard

###########################
## FTPS PASV_ADDRESS     ##
###########################

screen -dmS t1 ./srcs/setup_ftps.sh
