# kafka

[https://kafka.apache.org](https://kafka.apache.org)

[https://hub.docker.com/r/bitnami/kafka](https://hub.docker.com/r/bitnami/kafka)

[https://hub.docker.com/r/obsidiandynamics/kafdrop](https://hub.docker.com/r/obsidiandynamics/kafdrop)

```
docker pull bitnami/kafka:3.4
```

Install
```
# Step 1: Create a network
docker network create app-tier --driver bridge

# Step 2: Launch the Zookeeper server instance
docker run -d --name zookeeper-server \
    --network app-tier \
    -e ALLOW_ANONYMOUS_LOGIN=yes \
    bitnami/zookeeper:3.8

# Step 3: Launch the Apache Kafka server instance
docker run -d --name kafka-server \
    --network app-tier \
    -e ALLOW_PLAINTEXT_LISTENER=yes \
    -e KAFKA_CFG_ZOOKEEPER_CONNECT=zookeeper-server:2181 \
    -e KAFKA_CFG_LISTENER_SECURITY_PROTOCOL_MAP=CLIENT:PLAINTEXT,EXTERNAL:PLAINTEXT \
    -e KAFKA_CFG_LISTENERS=CLIENT://:9092,EXTERNAL://:9093 \
    -e KAFKA_CFG_ADVERTISED_LISTENERS=CLIENT://kafka-server:9092,EXTERNAL://localhost:9093 \
    -e KAFKA_CFG_INTER_BROKER_LISTENER_NAME=CLIENT \
    -p 9093:9093 \
    bitnami/kafka:3.4

# Step 4（Option）: Launch a web UI for monitoring Apache Kafka clusters
docker run -d --name kafka-admin-ui \
    --network app-tier \
    -e KAFKA_BROKERCONNECT=kafka-server:9092 \
    -e JVM_OPTS="-Xms32M -Xmx64M" \
    -e SERVER_SERVLET_CONTEXTPATH="/" \
    -p 9000:9000 \
    obsidiandynamics/kafdrop:latest
```

管理界面：[http://0.0.0.0:9000](http://0.0.0.0:9000)

- 内部端口：9092
- 外部端口：9093

环境变量
```
# 查看变量
docker run -it --rm \
    --network app-tier \
    -e KAFKA_CFG_ZOOKEEPER_CONNECT=zookeeper-server:2181 \
    bitnami/kafka:3.4 sh -c "env"
```

变量内容
```
BITNAMI_VOLUME_DIR=/bitnami
KAFKA_ZOOKEEPER_TLS_VERIFY_HOSTNAME=true
KAFKA_CFG_SASL_MECHANISM_INTER_BROKER_PROTOCOL=
HOSTNAME=971bccb531f9
KAFKA_TLS_TYPE=JKS
KAFKA_ENABLE_KRAFT=no
SHLVL=0
KAFKA_LOG_DIR=/opt/bitnami/kafka/logs
KAFKA_MOUNTED_CONF_DIR=/bitnami/kafka/config
HOME=/
BITNAMI_ROOT_DIR=/opt/bitnami
KAFKA_CERTS_DIR=/opt/bitnami/kafka/config/certs
MODULE=kafka
KAFKA_CFG_AUTO_CREATE_TOPICS_ENABLE=true
KAFKA_ZOOKEEPER_TLS_TYPE=JKS
KAFKA_CLIENT_PASSWORDS=bitnami
KAFKA_CERTIFICATE_PASSWORD=
KAFKA_KRAFT_CLUSTER_ID=
KAFKA_HEAP_OPTS=-Xmx1024m -Xms1024m
OS_ARCH=amd64
KAFKA_CFG_SASL_ENABLED_MECHANISMS=PLAIN,SCRAM-SHA-256,SCRAM-SHA-512
BITNAMI_APP_NAME=kafka
KAFKA_CFG_MAX_PARTITION_FETCH_BYTES=1048576
KAFKA_INITSCRIPTS_DIR=/docker-entrypoint-initdb.d
KAFKA_CLIENT_USERS=user
KAFKA_ZOOKEEPER_PROTOCOL=PLAINTEXT
KAFKA_CFG_ADVERTISED_LISTENERS=PLAINTEXT://:9092
OS_NAME=linux
KAFKA_ZOOKEEPER_PASSWORD=
KAFKA_ZOOKEEPER_TLS_TRUSTSTORE_PASSWORD=
KAFKA_VOLUME_DIR=/bitnami/kafka
TERM=xterm
KAFKA_CFG_ZOOKEEPER_CONNECT=zookeeper-server:2181
PATH=/opt/bitnami/kafka/bin:/opt/bitnami/java/bin:/opt/bitnami/java/bin:/opt/bitnami/common/bin:/opt/bitnami/kafka/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
KAFKA_CONF_FILE=/opt/bitnami/kafka/config/server.properties
KAFKA_ZOOKEEPER_USER=
KAFKA_OPTS=
KAFKA_TLS_TRUSTSTORE_FILE=
KAFKA_DATA_DIR=/bitnami/kafka/data
KAFKA_BASE_DIR=/opt/bitnami/kafka
KAFKA_TLS_CLIENT_AUTH=required
KAFKA_INTER_BROKER_PASSWORD=bitnami
KAFKA_ZOOKEEPER_TLS_KEYSTORE_PASSWORD=
KAFKA_INTER_BROKER_USER=user
KAFKA_ZOOKEEPER_TLS_TRUSTSTORE_FILE=
KAFKA_HOME=/opt/bitnami/kafka
KAFKA_CFG_LISTENERS=PLAINTEXT://:9092
JAVA_HOME=/opt/bitnami/java
PWD=/
KAFKA_CONF_DIR=/opt/bitnami/kafka/config
OS_FLAVOUR=debian-11
BITNAMI_DEBUG=false
KAFKA_CFG_MAX_REQUEST_SIZE=1048576
KAFKA_DAEMON_USER=kafka
APP_VERSION=3.4.0
KAFKA_DAEMON_GROUP=kafka
ALLOW_PLAINTEXT_LISTENER=no
```

测试用例
```
# 主题列表
docker run -it --rm \
    --network app-tier \
    -e KAFKA_CFG_ZOOKEEPER_CONNECT=zookeeper-server:2181 \
    bitnami/kafka:3.4 kafka-topics.sh --list --bootstrap-server kafka-server:9092

# 创建主题
docker run -it --rm \
    --network app-tier \
    -e KAFKA_CFG_ZOOKEEPER_CONNECT=zookeeper-server:2181 \
    bitnami/kafka:3.4 kafka-topics.sh --create --topic t_cdr --bootstrap-server kafka-server:9092

# 查看主题
docker run -it --rm \
    --network app-tier \
    -e KAFKA_CFG_ZOOKEEPER_CONNECT=zookeeper-server:2181 \
    bitnami/kafka:3.4 kafka-topics.sh --describe --topic t_cdr --bootstrap-server kafka-server:9092

# 生产消息（终端）
docker run -it --rm \
    --network app-tier \
    -e KAFKA_CFG_ZOOKEEPER_CONNECT=zookeeper-server:2181 \
    bitnami/kafka:3.4 kafka-console-producer.sh --topic t_cdr --broker-list kafka-server:9092

# 消费消息（终端）
docker run -it --rm \
    --network app-tier \
    -e KAFKA_CFG_ZOOKEEPER_CONNECT=zookeeper-server:2181 \
    bitnami/kafka:3.4 kafka-console-consumer.sh --topic t_cdr --from-beginning --bootstrap-server kafka-server:9092
```

## 组件描述

- topic
  - partition
    - leader replica
    - follower replica ...
- producer
- consumer
  - consumer group
- zookeeper

## kafka nsq 对比

kafka 具有和 nsq 类似的工作方式：

1. kafka 中多个 Consumer 不在同一个 Consumer Group，相当于 nsq 中使用不同的 channel 的场景 —— 发布-订阅模型
2. kafka 中多个 Consumer 在同一个 Consumer Group 中时，相当于 nsq 中使用相同的 channel 的场景 —— 队列订阅模型
3. kafka 和 nsq 其实都不保证消息有序的，所以使用替代上没有问题，如果需要消息有序，可将消息发送到同一个 partition 即可

## Go 客户端

社区推荐：[https://github.com/segmentio/kafka-go](https://github.com/segmentio/kafka-go)

## 代码示例

kafka_producer.go（消息生产）
```
package main

import (
	"context"
	"log"

	"github.com/segmentio/kafka-go"
)

func main() {

	ctx := context.Background()

	endpoints := []string{
		//"localhost:9092",
		"localhost:9093",
		//"localhost:9094",
	}

	// Creation of a missing topic before publishing a message.
	// Note! it was the default behaviour up to the version v0.4.30.

	w := &kafka.Writer{
		Addr: kafka.TCP(endpoints...),
		// NOTE: When Topic is not defined here, each Message must define it instead.
		Balancer:               &kafka.LeastBytes{},
		AllowAutoTopicCreation: true, // v0.4.30以上版本支持此参数
	}

	err := w.WriteMessages(
		ctx,
		// NOTE: Each Message has Topic defined, otherwise an error is returned.
		kafka.Message{
			Topic: "topic-A",
			Key:   []byte("Key-A"),
			Value: []byte("Hello World!"),
		},
		kafka.Message{
			Topic: "topic-B",
			Key:   []byte("Key-B"),
			Value: []byte("One!"),
		},
		kafka.Message{
			Topic: "topic-C",
			Key:   []byte("Key-C"),
			Value: []byte("Two!"),
		},
	)
	if err != nil {
		log.Fatal("failed to write messages:", err)
	}

	if err = w.Close(); err != nil {
		log.Fatal("failed to close writer:", err)
	}

}
```

kafka_consumer.go（消息消费）
```
package main

import (
	"context"
	"fmt"
	"log"

	"github.com/segmentio/kafka-go"
)

func main() {

	ctx := context.Background()

	endpoints := []string{
		//"localhost:9092",
		"localhost:9093",
		//"localhost:9094",
	}

	groupId := "consumer-group-id"
	topic := "topic-A"

	// make a new reader that consumes from topic-A
	r := kafka.NewReader(kafka.ReaderConfig{
		Brokers:  endpoints,
		GroupID:  groupId,
		Topic:    topic,
		MinBytes: 10e3, // 10KB
		MaxBytes: 10e6, // 10MB
	})

	for {
		m, err := r.ReadMessage(ctx)
		if err != nil {
			fmt.Printf("failed to read messages: %v", err)
			break
		}
		fmt.Printf("message at topic/partition/offset %v/%v/%v: %s = %s\n", m.Topic, m.Partition, m.Offset, string(m.Key), string(m.Value))
	}

	if err := r.Close(); err != nil {
		log.Fatal("failed to close reader:", err)
	}

}
```
