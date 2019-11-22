brew install kubernetes-cli minikube
rm -rf ~/.minikube/ ~/goinfre/minikube
mkdir ~/goinfre/minikube
ln -s ~/goinfre/minikube ~/.minikube/ 
minikube start --vm-driver=virtualbox
eval $(minikube docker-env)
docker build -t nginx:v1 srcs/containers/nginx/
docker build -t wordpress:v1 srcs/containers/wordpress
docker build -t phpmyadmin:v1 srcs/containers/phpmyadmin
docker build -t grafana:v1 srcs/containers/grafana
kubectl create -f srcs/nginx.yaml
kubectl create -f srcs/wordpress.yaml
kubectl create -f srcs/phpmyadmin.yaml
kubectl create -f srcs/grafana.yaml
kubectl create -f srcs/ingress.yaml
minikube dashboard
