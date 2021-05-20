docker build -t shidlovsky/multi-client:latest -t shidlovsky/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t shidlovsky/multi-worker:latest -t shidlovsky/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker build -t shidlovsky/multi-server:latest -t shidlovsky/multi-server:$SHA -f ./server/Dockerfile ./server
docker push shidlovsky/multi-client:latest
docker push shidlovsky/multi-worker:latest
docker push shidlovsky/multi-server:latest
docker push shidlovsky/multi-client:$SHA
docker push shidlovsky/multi-worker:$SHA
docker push shidlovsky/multi-server:$SHA
kubectl apply -f k8s
kubectl set image deployments/client-deployment client=shidlovsky/multi-client:$SHA
kubectl set image deployments/server-deployment server=shidlovsky/multi-server:$SHA
kubectl set image deployments/worker-deployment worker=shidlovsky/multi-worker:$SHA