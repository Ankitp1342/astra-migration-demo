# astra-migration-demo

This repo has the content related to building a zero downtime astra migration demo from C* & DSE

> [!IMPORTANT]
> Please note this job has been tested with spark version [3.5.4](https://archive.apache.org/dist/spark/spark-3.5.4/)

## 1. Build the container
- Download the Repo
- Build Step: sudo docker buildx build -t migration-demo:v1 .
- Run Step: sudo docker run -p 7860:7860 -d migration-demo:v1

## 2. Helpful docker commands
- To get the pod id "docker ps"
- Shell: docker exec -it <pod_id> bash
- Logs: docker logs <pod_id>

## 3. Log into Langflow
- http://127.0.0.1:7860/
