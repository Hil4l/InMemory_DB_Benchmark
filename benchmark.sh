#!/bin/bash

# databases=("redis" "memcached" "PostgreSQL")
databases=("PostgreSQL")
workloads=("a" "b" "c" "f")
recordcounts=(1000 10000 100000 500000)

for db in "${databases[@]}"; do
  for recordcount in "${recordcounts[@]}"; do
    echo "Loading $db with recordcount $recordcount"
    
    #  ------------------ Load ------------------
    if [[ $db == "PostgreSQL" ]]; then
      PGPASSWORD=ycsb_user psql -U ycsb_user -h localhost -d ycsb_db -c "TRUNCATE TABLE usertable" # Truncate PostgreSQL table before loading
      bin/ycsb load jdbc -P jdbc-binding/conf/db.properties -P workloads/workloada -p recordcount=$recordcount > "results/load/load_PostgreSQL_${recordcount}.txt"
    elif [[ $db == "memcached" ]]; then
      sudo service memcached restart # Restart Memcached to clear database
      bin/ycsb load memcached -s -P workloads/workloada -p memcached.hosts=localhost -p recordcount=$recordcount > "results/load/load_memcached_${recordcount}.txt"
    else
      # dont need truncate (overwrite) ???????
      bin/ycsb load redis -s -P workloads/workloada -p redis.host=localhost -p recordcount=$recordcount > "results/load/load_redis_${recordcount}.txt"
    fi

    #  ------------------ Run ------------------
    for workload in "${workloads[@]}"; do
      echo "Running $db workload $workload with recordcount $recordcount"
      
      if [[ $db == "PostgreSQL" ]]; then
        bin/ycsb run jdbc -P jdbc-binding/conf/db.properties -P workloads/workload$workload -p recordcount=$recordcount > "results/run/run_${db}_${recordcount}_workload${workload}.txt"
      elif [[ $db == "memcached" ]]; then
        bin/ycsb run memcached -s -P workloads/workload$workload -p memcached.hosts=localhost -p recordcount=$recordcount > "results/run/run_memcached_${recordcount}_workload${workload}.txt"
      else
        bin/ycsb run redis -s -P workloads/workload$workload -p redis.host=localhost -p recordcount=$recordcount > "results/run/run_redis_${recordcount}_workload${workload}.txt"
      fi
    done
  done
done


