# Pimcore Docker container for development

This is a development ready version of the latest nightly pimcore build, as a docker image
It fulfills all system requirements as well as all best practices (such as caching, ...) - minus office-libre

##Instructions show how the container can be mounted as a local volume

## Building locally 
Run the following commands, replace the //path/to/your/dev/workspace with the folder path to where you're coding from
```
mkdir pimcore-demo
git clone https://github.com/cleggypdc/pimcore-docker-dev.git ./pimcore-docker-dev/
cd pimcore-docker-dev
docker build -t cleggypdc/pimcore-dev .
docker run -d -p 80:80 --name=pimcore_dev -v //path/to/your/dev/workspace:/var/www cleggypdc/pimcore-dev
``` 

## Using Docker Hub
```
docker pull pimcore/docker-pimcore-demo-standalone
docker run -d -p 80:80 --name=pimcore_dev -v //path/to/your/dev/workspace:/var/www cleggypdc/pimcore-dev
``` 

## Running pimcore
After starting the container it'll take some time until your pimcore installation is ready. This depends on your internet connection as well as on the available ressources on the host. 

You can check the status of your image at any time by using the following command: 
```
docker logs -f pimcore_dev
```

This image automatically exposes port 80 to the host, so after running the image you should be able to access the demo site via: 
```
http://IP-OR-HOSTNAME-OF-DOCKER-HOST/
http://IP-OR-HOSTNAME-OF-DOCKER-HOST/admin/
```

### Admin user / password
```
Username: admin
Password: Dev_password123
```

### References
* [cleggypdc Docker Hub Page](https://registry.hub.docker.com/u/cleggypdc/pimcore-dev/) 
* [cleggypdc Pimcore Docker GitHub Repository](https://github.com/cleggypdc/pimcore-docker-dev)

#### Based on
* [pimcore Demo Docker Hub Page](https://registry.hub.docker.com/u/pimcore/docker-pimcore-demo-standalone/) 
* [pimcore Demo Docker GitHub Repository](https://github.com/pimcore/docker-pimcore-demo-standalone/)

