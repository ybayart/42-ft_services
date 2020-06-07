##########################
## INIT                 ##
##########################

#rm -rf ~/.minikube/ ~/goinfre/minikube
#mkdir ~/goinfre/minikube
#ln -s ~/goinfre/minikube ~/.minikube/ 
minikube start --vm-driver=virtualbox --cpus=4 --memory=5000m

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

IP=`minikube ip`

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

echo "Attente avant démarrage de la Dashboard"
sleep 10
screen -dmS t0 minikube dashboard

###########################
## PORT-FORWARD          ##
###########################

#echo "Attente avant démarrage des redirections"
#sleep 20

#screen -dmS t1 kubectl port-forward service/ftps 6021:21
#screen -dmS t2 kubectl port-forward service/nginx 6022:22
#screen -dmS t3 kubectl port-forward service/wordpress 5050
#screen -dmS t4 kubectl port-forward service/phpmyadmin 5000
#screen -dmS t5 kubectl port-forward service/grafana 3000

#screen -dmS t10 kubectl port-forward service/ftps 10000:10000
#screen -dmS t11 kubectl port-forward service/ftps 10001:10001
#screen -dmS t12 kubectl port-forward service/ftps 10002:10002
#screen -dmS t13 kubectl port-forward service/ftps 10003:10003
#screen -dmS t14 kubectl port-forward service/ftps 10004:10004
#screen -dmS t15 kubectl port-forward service/ftps 10005:10005
#screen -dmS t16 kubectl port-forward service/ftps 10006:10006
#screen -dmS t17 kubectl port-forward service/ftps 10007:10007
#screen -dmS t18 kubectl port-forward service/ftps 10008:10008
#screen -dmS t19 kubectl port-forward service/ftps 10009:10009
#screen -dmS t20 kubectl port-forward service/ftps 10010:10010
