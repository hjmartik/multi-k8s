docker build -t hjmartik/multi-client:latest -t hjmartik/multi-client:$SHA ./client
docker build -t hjmartik/multi-server:latest -t hjmartik/multi-server:$SHA ./server
docker build -t hjmartik/multi-worker:latest -t hjmartik/multi-worker:$SHA ./worker
docker push hjmartik/multi-client:latest
docker push hjmartik/multi-client:$SHA
docker push hjmartik/multi-server:latest
docker push hjmartik/multi-server:$SHA
docker push hjmartik/multi-worker:latest
docker push hjmartik/multi-worker:$SHA
kubectl apply -f k8s
kubectl set image deployments/server-deployment server=hjmartik/multi-server:$SHA
kubectl set image deployments/client-deployment client=hjmartik/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=hjmartik/multi-server:$SHA