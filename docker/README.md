# Modified Redis Image
This Proof of Concept was created as part of a task, which requires the creation of a Dockerfile (based on Redis official Image) that allows the user to change the default port and memory limit configuration during runtime by using ENV variables.

## Requirements
The whole project was built using Docker for Mac version 17.09.0.

## How to use the files included in this repository
The structure of the directory which contains the code is shown below :


```
.
├── Dockerfile
├── README.md
├── docker-entrypoint.sh
└── redis.conf

```

## How to build the Image and create a container
In order for the user to build the Image he should invoke the following command (assuming that he is on the directory where the Dockerfile is placed):

``` docker build -t <name_of_the_image> .```

After that the user could spin up a container based on this image by using different values for the port and maxmemory limit configuration. This is done by using a modified ``` redis.conf ``` instead of the default one that allows us to pass as ENV variables the values that correspond to the port and the maxmemory. The default values of these ENV variables are defined on the Dockerfile.
In order for the user to achive this he should run the following command:

``` docker run -it -d -e REDIS_PORT_NUMBER='8000' -e MAX_MEMORY=64mb <name_of_the_image>``` 

In order to ensure that the modified ENV variables are in place the user could run the following commands: 

```docker exec -it <container_id> env ```

The output of the previous commands will look like this: 

```PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
HOSTNAME=92101d09e915
TERM=xterm
REDIS_PORT_NUMBER=8000 <---- Modified value for the port
MAX_MEMORY=64mb <---- Modified value for memory limit
GOSU_VERSION=1.10
REDIS_VERSION=4.0.6
REDIS_DOWNLOAD_URL=http://download.redis.io/releases/redis-4.0.6.tar.gz
REDIS_DOWNLOAD_SHA=769b5d69ec237c3e0481a262ff5306ce30db9b5c8ceb14d1023491ca7be5f6fa
HOME=/root ```

Also the user can also check the logs of the created container by running ```docker logs <container_id> ``` and check the number of the port show on the output.