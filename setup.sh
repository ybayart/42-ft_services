brew install kubernetes-cli minikube
rm -rf ~/.minikube/ ~/goinfre/minikube
mkdir ~/goinfre/minikube
ln -s ~/goinfre/minikube ~/.minikube/ 
minikube start --vm-driver=virtualbox
eval $(minikube docker-env)
cd srcs/containers/ft_server/
docker build -t ft_server:v1 .
cd ../../../
kubectl create -f srcs/ft_server.yaml
kubectl create -f srcs/ft_server_svc.yaml
minikube dashboard
