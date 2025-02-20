# Astra Migration Demo

This repository contains content related to building a **zero-downtime Astra migration demo** from **Apache Cassandra® (C*) & DataStax Enterprise (DSE)**.

## Software Pre-reqs

- Docker


## Build the Container
This container includes a C* instance as well as a Langflow instance.

- Clone this repository.
- Build the container:
  ```sh
  docker buildx build -t migration-demo:v1 .
  ```
- Run the container:
  ```sh
  docker run -p 7860:7860 -d migration-demo:v1
  ```

---

## Create the Schema in Cassandra
Populate your local C* instance.  This will serve as the data source for the migration demo.
1. Execute the following in a terminal:
   (It may take a few moments for C* to start - retry if you get a connection refused message)
   ```sh
   docker exec -it `docker ps | grep migration-demo | awk '{print $1}'` cqlsh
   ```
2. Create the keyspace and table:
   ```cql
   CREATE KEYSPACE IF NOT EXISTS test 
   WITH replication = {'class': 'SimpleStrategy', 'replication_factor': 1};

   USE test;

   CREATE TABLE IF NOT EXISTS movies (
       id text PRIMARY KEY,
       content text
   );
   ```

---

## Create the Schema in Astra DB
1. **Create a serverless database instance** (non-vector).
2. **Create the keyspace** `test`.
3. Navigate to the **CQL Console** within Astra.
4. Execute the following:
   ```cql
   USE test;

   CREATE TABLE IF NOT EXISTS movies (
       id text PRIMARY KEY,
       content text
   );
   ```

---

## Log into Langflow
- Open [http://127.0.0.1:7860/](http://127.0.0.1:7860/).
- Navigate to the **MigrationDemo** folder


---

### Load Historical Data
1. Select the **"Load Historical Data"** flow.
2. Execute in **Cassandra cqlsh**:
   ```cql
   SELECT * FROM test.movies;
   ```
   See how there is not yet any data in the keyspace.
3. Execute the flow to populate data in the source C* datastore
4. Run the query again:
   ```cql
   SELECT * FROM test.movies;
   ```
   Data is now populated **only in Cassandra**.

---

### Setup Zero Downtime Proxy
1. Select the **"Setup Zero Downtime Proxy"** flow.
2. Fill in the necessary details. Only Astra credentials need to be filled in.
3. Execute the flow.
4. You have now started **ZDM** and configured **all writes and reads** to go through **ZDM to Astra DB and Cassandra simultaneously**.

---

### Application Live Data via Zero Downtime Proxy
1. Let's verify if **ZDM** is working by sending data through it. It should appear in **Cassandra and Astra DB**.
2. Select the **"Application Live Data via Zero Downtime Proxy"** flow.
3. Fill in the necessary details. Only Astra credentials need to be filled in.
4. Execute the flow.
5. Verify the data in **both Cassandra and Astra**:
   ```cql
   SELECT * FROM test.movies WHERE id='Sample Sports Movie';
   ```

---

### Migrate Historical Data
1. Select the **"Migrate Historical Data"** flow.
2. Fill in the required details. Only Astra credentials need to be filled in.
3. Execute the flow.
4. Verify that data is now migrated to Astra:
   ```cql
   SELECT * FROM test.movies;
   ```

---

## Helpful Docker Commands
- **Get the running container ID:**
  ```sh
  docker ps
  ```
- **Access the container shell:**
  ```sh
  docker exec -it <pod_id> bash
  ```
- **View container logs:**
  ```sh
  docker logs <pod_id>
  ```