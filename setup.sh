##########################
## INIT                 ##
##########################

rm -rf ~/.minikube/ ~/goinfre/minikube
mkdir ~/goinfre/minikube
ln -s ~/goinfre/minikube ~/.minikube/ 
minikube start --vm-driver=virtualbox --cpus=4 --memory=4096m

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

kubectl create secret tls nginx --key srcs/containers/nginx/srcs/certs/server.key --cert srcs/containers/nginx/srcs/certs/server.crt

kubectl create -f srcs/ftps.yaml

kubectl create -f srcs/nginx.yaml

kubectl create -f srcs/wordpress.yaml
kubectl create -f srcs/phpmyadmin.yaml
kubectl create -f srcs/grafana.yaml

kubectl create -f srcs/mysql.yaml
kubectl create -f srcs/influxdb.yaml

###########################
## INGRESS               ##
###########################

kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/master/deploy/static/mandatory.yaml
kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/master/deploy/static/provider/cloud-generic.yaml

minikube addons enable ingress

##########################
## PORT-FORWARD         ##
##########################

screen -dmS t1 kubectl port-forward service/ftps 6021:21
screen -dmS t2 kubectl port-forward service/nginx 6022:22
screen -dmS t3 kubectl port-forward service/wordpress 5050
screen -dmS t4 kubectl port-forward service/phpmyadmin 5000
screen -dmS t5 kubectl port-forward service/grafana 300

###########################
## DASHBOARD             ##
###########################

screen -dmS t0 minikube dashboard
