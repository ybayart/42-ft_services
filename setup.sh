##########################
## INIT                 ##
##########################

brew update
brew install kubernetes-cli minikube
rm -rf ~/.minikube/ ~/goinfre/minikube
mkdir ~/goinfre/minikube
ln -s ~/goinfre/minikube ~/.minikube/ 
minikube start --vm-driver=virtualbox

###########################
## DOCKER                ##
###########################

eval $(minikube docker-env)

docker build -t nginx:v1 srcs/containers/nginx/
docker build -t wordpress:v1 srcs/containers/wordpress
docker build -t phpmyadmin:v1 srcs/containers/phpmyadmin
docker build -t grafana:v1 srcs/containers/grafana
docker build -t mysql:v1 srcs/containers/mysql

###########################
## DEPLOY                ##
###########################

kubectl create -f srcs/nginx.yaml

kubectl create -f srcs/mysql.yaml

kubectl create -f srcs/wordpress.yaml
kubectl create -f srcs/phpmyadmin.yaml
kubectl create -f srcs/grafana.yaml

###########################
## SERVICE               ##
###########################

kubectl create -f srcs/nginx-svc.yaml

kubectl create -f srcs/mysql-svc.yaml

kubectl create -f srcs/wordpress-svc.yaml
kubectl create -f srcs/phpmyadmin-svc.yaml
kubectl create -f srcs/grafana-svc.yaml

kubectl create -f srcs/mysql-link.yaml

###########################
## INGRESS               ##
###########################

kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/master/deploy/static/mandatory.yaml
kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/master/deploy/static/provider/cloud-generic.yaml

minikube addons enable ingress

kubectl create -f srcs/nginx-ingress.yaml

##########################
## PORT-FORWARD         ##
##########################

screen -dmS t0 minikube dashboard
screen -dmS t1 kubectl port-forward service/nginx-svc 6022:22
screen -dmS t2 kubectl port-forward service/wordpress-svc 5050
screen -dmS t3 kubectl port-forward service/phpmyadmin-svc 5000
screen -dmS t4 kubectl port-forward service/grafana-svc 3000

###########################
## DASHBOARD             ##
###########################

