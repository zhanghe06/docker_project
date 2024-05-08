# 主从配置


## 主节点

查看主节点状态
```
MariaDB [test]> SHOW MASTER STATUS;
+-------------------+----------+--------------+------------------+
| File              | Position | Binlog_Do_DB | Binlog_Ignore_DB |
+-------------------+----------+--------------+------------------+
| mysqld-bin.000002 |     1539 |              |                  |
+-------------------+----------+--------------+------------------+
1 row in set (0.002 sec)
```

获取初始GTID
```
MariaDB [test]> SELECT @@global.gtid_binlog_pos;
+--------------------------+
| @@global.gtid_binlog_pos |
+--------------------------+
| 0-1-3                    |
+--------------------------+
1 row in set (0.001 sec)
```

创建一个测试数据表
```
CREATE TABLE test_table (
  id INT PRIMARY KEY,
  name VARCHAR(50),
  age INT,
  email VARCHAR(50)
);
```

插入一些测试数据
```
INSERT INTO test_table (id, name, age, email) VALUES
  (1, 'John Doe', 25, 'john.doe@example.com'),
  (2, 'Jane Smith', 30, 'jane.smith@example.com'),
  (3, 'Mike Johnson', 35, 'mike.johnson@example.com');
```

```
MariaDB [test]> show tables;
+----------------+
| Tables_in_test |
+----------------+
| test_table     |
+----------------+
1 row in set (0.003 sec)
```

锁表，防止GTID变更
```
MariaDB [test]> FLUSH TABLES WITH READ LOCK;
```

测试数据插入
```
INSERT INTO test_table (id, name, age, email) VALUES
  (4, 'Fuck', 88, 'fuck.you@example.com');
```

对于数据修改会报错
```
MariaDB [test]> INSERT INTO test_table (id, name, age, email) VALUES
    ->   (4, 'Fuck', 88, 'fuck.you@example.com');
ERROR 1223 (HY000): Can't execute the query because you have a conflicting read lock
```

获取最新GTID
```
MariaDB [test]> SELECT @@global.gtid_binlog_pos;
+--------------------------+
| @@global.gtid_binlog_pos |
+--------------------------+
| 0-1-8                    |
+--------------------------+
1 row in set (0.001 sec)
```

全量备份主节点，恢复至从节点

从节点恢复完成，解锁主节点
```
MariaDB [test]> UNLOCK TABLES;
Query OK, 0 rows affected (0.002 sec)
```

## 从节点

查看从节点状态
```
MariaDB [test]> SHOW SLAVE STATUS;
Empty set (0.001 sec)
```
最开始还没有设置从节点，所以为空

空库，空表
```
MariaDB [test]> show tables;
Empty set (0.002 sec)
```

获取GTID（从节点）
```
MariaDB [test]> SELECT @@global.gtid_binlog_pos;
+--------------------------+
| @@global.gtid_binlog_pos |
+--------------------------+
| 0-2-3                    |
+--------------------------+
1 row in set (0.001 sec)
```

开启主从同步复制
```
# 关闭slave
MariaDB [test]> STOP SLAVE;

# 设置GTID
MariaDB [test]> SET GLOBAL gtid_slave_pos='0-1-3';
Query OK, 0 rows affected (0.025 sec)

# 配置主从
MariaDB [test]> CHANGE MASTER TO MASTER_HOST='192.168.0.152', MASTER_PORT=3316, MASTER_USER='replication', MASTER_PASSWORD='password', MASTER_USE_GTID=slave_pos;
Query OK, 0 rows affected (0.022 sec)

# 开启slave
MariaDB [test]> START SLAVE;
Query OK, 0 rows affected (0.012 sec)
```

查看从节点状态
```
MariaDB [test]> SHOW SLAVE STATUS\G
*************************** 1. row ***************************
                Slave_IO_State: Waiting for master to send event
                   Master_Host: 192.168.0.152
                   Master_User: replication
                   Master_Port: 3316
                 Connect_Retry: 60
               Master_Log_File: mysqld-bin.000002
           Read_Master_Log_Pos: 1539
                Relay_Log_File: mysqld-relay-bin.000002
                 Relay_Log_Pos: 1612
         Relay_Master_Log_File: mysqld-bin.000002
              Slave_IO_Running: Yes
             Slave_SQL_Running: Yes
               Replicate_Do_DB:
           Replicate_Ignore_DB:
            Replicate_Do_Table:
        Replicate_Ignore_Table:
       Replicate_Wild_Do_Table:
   Replicate_Wild_Ignore_Table:
                    Last_Errno: 0
                    Last_Error:
                  Skip_Counter: 0
           Exec_Master_Log_Pos: 1539
               Relay_Log_Space: 1922
               Until_Condition: None
                Until_Log_File:
                 Until_Log_Pos: 0
            Master_SSL_Allowed: No
            Master_SSL_CA_File:
            Master_SSL_CA_Path:
               Master_SSL_Cert:
             Master_SSL_Cipher:
                Master_SSL_Key:
         Seconds_Behind_Master: 0
 Master_SSL_Verify_Server_Cert: No
                 Last_IO_Errno: 0
                 Last_IO_Error:
                Last_SQL_Errno: 0
                Last_SQL_Error:
   Replicate_Ignore_Server_Ids:
              Master_Server_Id: 1
                Master_SSL_Crl:
            Master_SSL_Crlpath:
                    Using_Gtid: Slave_Pos
                   Gtid_IO_Pos: 0-1-8
       Replicate_Do_Domain_Ids:
   Replicate_Ignore_Domain_Ids:
                 Parallel_Mode: optimistic
                     SQL_Delay: 0
           SQL_Remaining_Delay: NULL
       Slave_SQL_Running_State: Slave has read all relay log; waiting for more updates
              Slave_DDL_Groups: 3
Slave_Non_Transactional_Groups: 1
    Slave_Transactional_Groups: 1
1 row in set (0.003 sec)
```

验证数据
```
MariaDB [test]> show tables;
+----------------+
| Tables_in_test |
+----------------+
| test_table     |
+----------------+
1 row in set (0.004 sec)
```
