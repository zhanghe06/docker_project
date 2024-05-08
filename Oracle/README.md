# Oracle

Oracle Database 19c 是当下最新的长期支持版本

- [Oracle Database 技术](https://www.oracle.com/cn/database/technologies/)
- [Oracle Database 19c com Docker](https://www.oracle.com/br/technical-resources/articles/database-performance/oracle-db19c-com-docker.html)
- [Oracle Database 19c for Linux x86-64 ZIP](https://www.oracle.com/cn/database/technologies/oracle-database-software-downloads.html#db_ee)

## 安装

下载对应的版本(2.8G左右)，需要登录

```
git clone https://github.com/oracle/docker-images.git
cd docker-images
cd OracleDatabase/SingleInstance/dockerfiles/19.3.0
mv ~/Downloads/LINUX.X64_193000_db_home.zip .

# 构建镜像，需要18G的空间
cd ..
./buildContainerImage.sh -v 19.3.0 -e
```

## 连接

DataGrip（或JB系列编辑器的数据库插件）连接Oracle数据库的连接配置：

连接方式CDB（Connection type）: SID
```
Host: 127.0.0.1
Port: 1521
SID: ORCLCDB
Driver: Thin
Authentication: User & Password
User: sys as sysdba
Password: password
```

连接方式PDB（Connection type）: Service Name
```
Host: 127.0.0.1
Port: 1521
Service: orcl
Driver: Thin
Authentication: User & Password
User: test
Password: 123456
```

```
sqlplus sys/password@orcl as sysdba
```

## 概念

在逻辑结构中，Oracle从大到下，分别是如下的结构：数据库实例 -> 表空间 -> 数据段（表） -> 区 -> 块。

Oracle 12C开始引入了CDB与PDB的新特性。

sqlplus / as sysdba命令默认登陆的是CDB数据库，而CDB数据库中要求所有新建用户用户名必须以c##开头，否则就会报以上错误，在PDB内创建用户则没有此要求

## 操作

```
root@ubuntu:~# docker exec -it oracle19c bash
bash-4.2$ sqlplus

-- 查询当前容器
SQL> show con_name

CON_NAME
------------------------------
CDB$ROOT

-- 查看PDB清单
SQL> show pdbs;

    CON_ID CON_NAME			  OPEN MODE  RESTRICTED
---------- ------------------------------ ---------- ----------
	 2 PDB$SEED			  READ ONLY  NO
	 3 ORCL 			  READ WRITE NO

-- 查询容器是否CDB
SQL> select name,cdb,open_mode,con_id from v$database;

NAME	  CDB OPEN_MODE 	       CON_ID
--------- --- -------------------- ----------
ORCLCDB   YES READ WRITE		    0

SQL>
```


-- 创建表空间
create tablespace test logging datafile '/opt/oracle/oradata/ORCLCDB/test.dbf' size 200m autoextend on next 20m maxsize 20480m;
-- 创建用户
create user c##test identified by 123456 default tablespace test;
create user TEST identified by 123456 default tablespace test;

操作示例：https://www.cnblogs.com/zouhong/p/16272406.html


```
@张和 我建了一个，里面我加了一个表ZB_MZZB，c##BSHIP/BSOFT
-- 新建库
CREATE USER c##BSHIP IDENTIFIED BY BSOFT;
grant connect, resource to c##BSHIP;
```

## 备注

准备修改脚本来支持交叉编译，失败了
```
# 交叉编译（非必需，这一步mac还是失败）
cp buildContainerImage.sh{,.bak}
s_content='"${CONTAINER_RUNTIME}" build'
t_content='"${CONTAINER_RUNTIME}" buildx build --platform linux\/amd64'
sed "s/$s_content/$t_content/g" buildContainerImage.sh.bak > buildContainerImage.sh
diff buildContainerImage.sh{,.bak}
```
