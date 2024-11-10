# Advanced Database: In-memory databases Redis vs Memcached

## Course
- **Course:** INFO-H415
- **Year:** MA2

## Description

In-memory databases project, Redis vs Memcached performances benchmark

## Softwares

**Python2** : (YCSB incompatible with python3)

```
sudo apt update
sudo apt install python2
```

**Redis**: 

``sudo apt install redis-server``

**Memcached**: 

``sudo apt install memcached``

**YCSB**:

+  ``curl -O --location https://github.com/brianfrankcooper/YCSB/releases/download/0.17.0/ycsb-0.17.0.tar.gz``
+ ``tar xfvz ycsb-0.17.0.tar.gz``
+ ``cd ycsb-0.17.0``

## Run commands

help: ``bin/ycsb``

load: ``bin/ycsb load [binding] -P workloads/[workload]``

run: ``bin/ycsb load [binding] -P workloads/[workload]``
