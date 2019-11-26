##########################
## INIT                 ##
##########################

#brew update
#brew install kubernetes-cli minikube
#rm -rf ~/.minikube/ ~/goinfre/minikube
#mkdir ~/goinfre/minikube
#ln -s ~/goinfre/minikube ~/.minikube/ 
minikube start --vm-driver=virtualbox --cpus=4 --memory=8192m

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
## DEPLOY                ##
###########################

sudo kubectl create secret tls nginx --key srcs/containers/nginx/srcs/certs/server.key --cert srcs/containers/nginx/srcs/certs/server.crt

sudo kubectl create -f srcs/ftps.yaml

sudo kubectl create -f srcs/nginx.yaml

sudo kubectl create -f srcs/wordpress.yaml
sudo kubectl create -f srcs/phpmyadmin.yaml
sudo kubectl create -f srcs/grafana.yaml

sudo kubectl create -f srcs/mysql.yaml
sudo kubectl create -f srcs/influxdb.yaml

###########################
## INGRESS               ##
###########################

sudo kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/master/deploy/static/mandatory.yaml
sudo kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/master/deploy/static/provider/cloud-generic.yaml

minikube addons enable ingress

##########################
## PORT-FORWARD         ##
##########################

screen -dmS t1 sudo kubectl port-forward service/ftps 6021:21
screen -dmS t2 sudo kubectl port-forward service/nginx 6022:22
screen -dmS t3 sudo kubectl port-forward service/wordpress 5050
screen -dmS t4 sudo kubectl port-forward service/phpmyadmin 5000
screen -dmS t5 sudo kubectl port-forward service/grafana 3000

###########################
## DASHBOARD             ##
###########################

screen -dmS t0 minikube dashboard
