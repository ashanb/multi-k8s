docker build -t ashanb/multi-client:latest -t ashanb/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t ashanb/multi-server:latest -t ashanb/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t ashanb/multi-worker:latest -t ashanb/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push ashanb/multi-client:latest
docker push ashanb/multi-server:latest
docker push ashanb/multi-worker:latest

docker push ashanb/multi-client:$SHA
docker push ashanb/multi-server:$SHA
docker push ashanb/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=ashanb/multi-server:$SHA
kubectl set image deployments/client-deployment client=ashanb/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=ashanb/multi-worker:$SHA
