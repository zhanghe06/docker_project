# 主从配置

## 主节点

查看主节点状态
```
mysql> SHOW MASTER STATUS;
+-------------------------+----------+--------------+------------------+------------------------------------------+
| File                    | Position | Binlog_Do_DB | Binlog_Ignore_DB | Executed_Gtid_Set                        |
+-------------------------+----------+--------------+------------------+------------------------------------------+
| mysql_master-bin.000003 |      194 |              |                  | 4389be2f-0d34-11ef-b847-0242ac110016:1-8 |
+-------------------------+----------+--------------+------------------+------------------------------------------+
1 row in set (0.00 sec)

mysql> SHOW SLAVE STATUS;
Empty set (0.00 sec)

mysql> show databases;
+--------------------+
| Database           |
+--------------------+
| information_schema |
| mysql              |
| performance_schema |
| sys                |
| test               |
+--------------------+
5 rows in set (0.00 sec)

mysql> use test;
Database changed
mysql> CREATE TABLE test_table (
    ->   id INT PRIMARY KEY,
    ->   name VARCHAR(50),
    ->   age INT,
    ->   email VARCHAR(50)
    -> );
Query OK, 0 rows affected (0.01 sec)

mysql> INSERT INTO test_table (id, name, age, email) VALUES
    ->   (1, 'John Doe', 25, 'john.doe@example.com'),
    ->   (2, 'Jane Smith', 30, 'jane.smith@example.com'),
    ->   (3, 'Mike Johnson', 35, 'mike.johnson@example.com');
Query OK, 3 rows affected (0.00 sec)
Records: 3  Duplicates: 0  Warnings: 0

mysql> show tables;
+----------------+
| Tables_in_test |
+----------------+
| test_table     |
+----------------+
1 row in set (0.00 sec)

mysql> SELECT @@GLOBAL.GTID_EXECUTED;
+-------------------------------------------+
| @@GLOBAL.GTID_EXECUTED                    |
+-------------------------------------------+
| 4389be2f-0d34-11ef-b847-0242ac110016:1-13 |
+-------------------------------------------+
1 row in set (0.00 sec)
```

## 从节点

查看从节点状态

```
mysql> SHOW MASTER STATUS;
+------------------------+----------+--------------+------------------+------------------------------------------+
| File                   | Position | Binlog_Do_DB | Binlog_Ignore_DB | Executed_Gtid_Set                        |
+------------------------+----------+--------------+------------------+------------------------------------------+
| mysql_slave-bin.000003 |      194 |              |                  | 45d62c83-0d34-11ef-b931-0242ac110017:1-8 |
+------------------------+----------+--------------+------------------+------------------------------------------+
1 row in set (0.00 sec)

mysql> SHOW SLAVE STATUS;
Empty set (0.00 sec)

mysql> show tables;
Empty set (0.00 sec)

mysql> SELECT @@GLOBAL.GTID_EXECUTED;
+------------------------------------------+
| @@GLOBAL.GTID_EXECUTED                   |
+------------------------------------------+
| 45d62c83-0d34-11ef-b931-0242ac110017:1-8 |
+------------------------------------------+
1 row in set (0.00 sec)

mysql> CHANGE MASTER TO MASTER_HOST='192.168.0.159', MASTER_PORT=3316, MASTER_USER='replication', MASTER_PASSWORD='password', MASTER_AUTO_POSITION=1;
Query OK, 0 rows affected, 1 warning (0.01 sec)

mysql> START SLAVE;
Query OK, 0 rows affected (0.00 sec)

mysql> SHOW SLAVE STATUS\G
*************************** 1. row ***************************
               Slave_IO_State: Waiting for master to send event
                  Master_Host: 192.168.0.159
                  Master_User: replication
                  Master_Port: 3316
                Connect_Retry: 60
              Master_Log_File: mysql_master-bin.000003
          Read_Master_Log_Pos: 1436
               Relay_Log_File: mysql_slave-relay-bin.000002
                Relay_Log_Pos: 2948173
        Relay_Master_Log_File: mysql_master-bin.000002
             Slave_IO_Running: Yes
            Slave_SQL_Running: No
              Replicate_Do_DB:
          Replicate_Ignore_DB:
           Replicate_Do_Table:
       Replicate_Ignore_Table:
      Replicate_Wild_Do_Table:
  Replicate_Wild_Ignore_Table:
                   Last_Errno: 1396
                   Last_Error: Error 'Operation CREATE USER failed for 'www'@'%'' on query. Default database: 'mysql'. Query: 'CREATE USER 'www'@'%' IDENTIFIED WITH 'mysql_native_password' AS '*6BB4837EB74329105EE4568DDA7DC67ED2CA2AD9''
                 Skip_Counter: 0
          Exec_Master_Log_Pos: 2947946
              Relay_Log_Space: 2950564
              Until_Condition: None
               Until_Log_File:
                Until_Log_Pos: 0
           Master_SSL_Allowed: No
           Master_SSL_CA_File:
           Master_SSL_CA_Path:
              Master_SSL_Cert:
            Master_SSL_Cipher:
               Master_SSL_Key:
        Seconds_Behind_Master: NULL
Master_SSL_Verify_Server_Cert: No
                Last_IO_Errno: 0
                Last_IO_Error:
               Last_SQL_Errno: 1396
               Last_SQL_Error: Error 'Operation CREATE USER failed for 'www'@'%'' on query. Default database: 'mysql'. Query: 'CREATE USER 'www'@'%' IDENTIFIED WITH 'mysql_native_password' AS '*6BB4837EB74329105EE4568DDA7DC67ED2CA2AD9''
  Replicate_Ignore_Server_Ids:
             Master_Server_Id: 1
                  Master_UUID: 4389be2f-0d34-11ef-b847-0242ac110016
             Master_Info_File: /var/lib/mysql/master.info
                    SQL_Delay: 0
          SQL_Remaining_Delay: NULL
      Slave_SQL_Running_State:
           Master_Retry_Count: 86400
                  Master_Bind:
      Last_IO_Error_Timestamp:
     Last_SQL_Error_Timestamp: 240508 20:27:39
               Master_SSL_Crl:
           Master_SSL_Crlpath:
           Retrieved_Gtid_Set: 4389be2f-0d34-11ef-b847-0242ac110016:1-13
            Executed_Gtid_Set: 4389be2f-0d34-11ef-b847-0242ac110016:1-6,
45d62c83-0d34-11ef-b931-0242ac110017:1-8
                Auto_Position: 1
         Replicate_Rewrite_DB:
                 Channel_Name:
           Master_TLS_Version:
1 row in set (0.00 sec)

mysql> show tables;
+----------------+
| Tables_in_test |
+----------------+
| test_table     |
+----------------+
1 row in set (0.00 sec)
```
