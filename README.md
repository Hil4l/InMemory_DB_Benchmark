# Advanced Database: In-memory databases Redis vs Memcached

## Course
- **Course:** INFO-H415
- **Year:** MA2

## Description

In-memory databases project, Redis vs Memcached performances benchmark

## Softwares

**Python2** : (dont support python3 - modify bin/yscb shebang!)

```
sudo apt update
sudo apt install python2
```

**Redis**: 

``sudo apt install redis-server``

**Memcached**: 

``sudo apt install memcached``

**PostgreSQL**:

``sudo apt install postgresql``

**PostgreSql JDBC driver**: 

https://jdbc.postgresql.org/download/ (place in [lib])

**YCSB**:

+  ``curl -O --location https://github.com/brianfrankcooper/YCSB/releases/download/0.17.0/ycsb-0.17.0.tar.gz``
+ ``tar xfvz ycsb-0.17.0.tar.gz``

## Benchmark

**Set up PostgreSQL with JDBC driver**:

+ Place jdbc driver in 'jdbc-binding/lib' (or use -cp path_to_driver in command)

+ Create table (default fieldcount=10)

```
sudo -u postgres psql

CREATE DATABASE ycsb_db;
CREATE USER ycsb_user WITH ENCRYPTED PASSWORD 'ycsb_user';
GRANT ALL PRIVILEGES ON DATABASE ycsb_db TO ycsb_user;
GRANT ALL PRIVILEGES ON TABLE usertable TO ycsb_user;

\c ycsb_db

CREATE TABLE usertable (
    YCSB_KEY VARCHAR(255) PRIMARY KEY,
    FIELD0 TEXT,
    FIELD1 TEXT,
    FIELD2 TEXT,
    FIELD3 TEXT,
    FIELD4 TEXT,
    FIELD5 TEXT,
    FIELD6 TEXT,
    FIELD7 TEXT,
    FIELD8 TEXT,
    FIELD9 TEXT
);
```

**Run scripts**:

```
./benchmark.sh
```

<!-- TODO: see db properties postgre Optimization (btachsize) -->


<!-- bin/ycsb load jdbc -P jdbc-binding/conf/db.properties -P workloads/workloada -p recordcount=1000
bin/ycsb run jdbc -P jdbc-binding/conf/db.properties -P workloads/workloada -p recordcount=1000


bin/ycsb load memcached -P workloads/workloada -p memcached.hosts=localhost -p recordcount=1000
bin/ycsb run memcached -P workloads/workloada -p memcached.hosts=localhost -p recordcount=1000

bin/ycsb load redis -P workloads/workloada -p redis.host=localhost -p recordcount=1000
bin/ycsb run redis -P workloads/workloada -p redis.host=localhost -p recordcount=1000 -->


<!-- this si the YCSB redis cllient class insert method:

 @Override
  public Status insert(String table, String key,
      Map<String, ByteIterator> values) {
    if (jedis.hmset(key, StringByteIterator.getStringMap(values))
        .equals("OK")) {
      jedis.zadd(INDEX_KEY, hash(key), key);
      return Status.OK;
    }
    return Status.ERROR;
  }

can you explain what it does (it isnt a simple insert, it uses redis hashmap?) and confirm that an insert on an already existing key results in an overwrite ? because with memcached i get an insertion error whith duplicate keys,so i have to use service restart to clean the db-->