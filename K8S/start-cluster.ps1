kubectl apply -f .\platforms-depl.yaml
kubectl apply -f .\commands-depl.yaml
kubectl apply -f .\platforms-nodeport-srv.yaml
kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/controller-v1.12.1/deploy/static/provider/cloud/deploy.yaml
kubectl apply -f .\ingress-srv.yaml