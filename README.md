# Docker demo container for pimcore

This is a full featured demo installation as a docker image. 
It fulfills all system requirements as well as all best practices (such as caching, ...). 
So this configuration can also be seen as a reference how to set up a suitable server for pimcore following best practices. 

## Building locally 
```
mkdir pimcore-demo
git clone https://github.com/pimcore/docker-pimcore-demo-standalone.git ./pimcore-demo/
cd pimcore-demo
docker build -t pimcore/demo .
docker run -d -p 80:80 --name=pimcore_demo pimcore/demo
``` 

## Using Docker Hub
```
docker pull pimcore/docker-pimcore-demo-standalone
docker run -d -p 80:80 --name=pimcore_demo pimcore/docker-pimcore-demo-standalone
``` 

## Running pimcore
After starting the container it'll take some time until your pimcore installation is ready. This depends on your internet connection as well as on the available ressources on the host. 

You can check the status of your image at any time by using the following command: 
```
docker logs -f pimcore_demo
```

This image automatically exposes port 80 to the host, so after running the image you should be able to access the demo site via: 
```
http://IP-OR-HOSTNAME-OF-DOCKER-HOST/
http://IP-OR-HOSTNAME-OF-DOCKER-HOST/admin/
```

### Admin user / password
```
Username: admin
Password: demo
```

### References

* [pimcore Demo Docker Hub Page](https://registry.hub.docker.com/u/pimcore/docker-pimcore-demo-standalone/) 
* [pimcore Demo Docker GitHub Repository](https://github.com/pimcore/docker-pimcore-demo-standalone/)

