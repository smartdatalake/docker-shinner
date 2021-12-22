# Commands for building and running the docker container for sHINNER

This docker was built based on the docker project provided by https://github.com/jsatch/spark-docker. 
The only prequesite for this container is to have docker and docker-compose available in your environment.

### Download all sources

(1) Download this project

(2) Download and build the gcore-spark-ggd project into the folder spark-submit of this project.

(3) Download Spark version 2.4.7 from the Apache Spark website (https://spark.apache.org/) decompress, and rename its folder to spark. Move the spark folder to the base folder of this project.

(4) Download the guice-4.0.jar file from the Guice repository (https://github.com/google/guice/releases/tag/4.0) and place it in the spark-submit folder of this project

### Build docker images

The first step is to build the docker images according to what was configured.
Execute from the shell the script build-images.sh

```
$ sudo ./build-images.sh
```

### Edit the available volumes and desired ports in docker-compose.yml

Edit the volumes path for all services at:
```    
    volumes:
       - /your_path/DemoGraphs:/DemoGraphs
       - /your_path/configuration:/Config
```

Edit the desired exposed ports for all services at:
```
    ports:
      - "6080:6080"
```
In which the first port number is the port exposed from the docker and the second one is the port number used inside the docker container. The second port number should be kept the same as in the docker-compose.yml. If you do not have any conflicting ports it is recommended to keep the default values in the docker-composer.yml

### Create the images 

Run the following command:

```
$ docker-compose create
```

Or if you are interested in running the REST API application:

```
$ docker-compose up
```

### Run spark-submit according to the running mode of sHINNER:

To run the command line application run:
```
$ docker-compose run spark-submit /bin/bash /start-submit-commandline.sh
```

To run the command line application with the entity resolution evaluation:
```
$ docker-compose run spark-submit /bin/bash /start-submit-ercommandline.sh
```

To run the REST API:
```
$ docker-compose run spark-submit /bin/bash /start-submit-webserver.sh
```

Observe that the command line with er evaluation mode receives two json files s arguments, by default it will bind to the folder /Config (specifically the files /Config/config.json and /Config/comparison.json, for more information about the condiguration files check the sHINNER Manual.pdf) inside the docker, do not forget to edit the folder path in docker-compose.yml.
The same occurs for the REST API, it receives as default database the folder /DemoGraphs inside the docker container. 
