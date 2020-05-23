# Build and tag images

docker build -t lewismclennan/multi-client:latest -t lewismclennan/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t lewismclennan/multi-server:latest -t lewismclennan/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t lewismclennan/multi-worker:latest -t lewismclennan/multi-worker:$SHA -f ./worker/Dockerfile ./worker

# Push images to docker hub
docker push lewismclennan/multi-client:latest
docker push lewismclennan/multi-server:latest
docker push lewismclennan/multi-worker:latest

docker push lewismclennan/multi-client:$SHA
docker push lewismclennan/multi-server:$SHA
docker push lewismclennan/multi-worker:$SHA

# Apply configuration files
kubectl apply -f k8s

# Deploy images
kubectl set image deployments/client-deployment client=lewismclennan/multi-client:$SHA
kubectl set image deployments/server-deployment server=lewismclennan/multi-server:$SHA
kubectl set image deployments/worker-deployment worker=lewismclennan/multi-worker:$SHA