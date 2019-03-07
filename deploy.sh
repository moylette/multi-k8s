docker build -t moylette/multi-client:latest -t moylette/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t moylette/multi-server:latest -t moylette/multi-server:$SHA  -f ./server/Dockerfile ./server
docker build -t moylette/multi-worker:latest -t moylette/multi-worker:$SHA  -f ./worker/Dockerfile ./worker
docker push moylette/multi-client:latest
docker push moylette/multi-client:$SHA
docker push moylette/multi-server:latest
docker push moylette/multi-server:$SHA
docker push moylette/multi-worker:latest
docker push moylette/multi-worker:$SHA
kubectl apply -f k8s
kubectl set image deployments/client-deployment server=moylette/multi-client:$SHA
kubectl set image deployments/server-deployment server=moylette/multi-server:$SHA
kubectl set image deployments/worker-deployment server=moylette/multi-worker:$SHA