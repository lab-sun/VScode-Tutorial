# VScode Connects to remote Docker over SSH
This tutorial takes [RTFNet](https://github.com/yuxiangsun/RTFNet) as an example. We assume that you have successfully clone the RTFNet repo and installed Docker engine in the remote machine. You need to know the basic knowledge about docker.     
In gerenal, we first configure SSH service in docker container and then use the VScode Remote-SSH Extension to connect to the docker container.    
## Step 1 Configure SSH service in docker container:   
1. First connect to the remote machine. Replace the original Dockerfile in the RTFNet repo with the one in this repo. The provided Dockerfile will configure the SSH service in docker container automatically. Build a docker image in a termintal as follow:   
```
$ cd ~/RTNet
$ docker build -t docker_image_rtfnet:v1 .
```    
2. Then create a docker container with ```docker_image_rtfnet:v1``` and map the port 22 of this container to the other port of the remote machine with ```-p xxxx:22 ```:     
```
$ docker run -it --shm-size 8G -p 1234:6006 -p 1022:22 --ipc host --name docker_container_rtfnet --gpus all -v ~/RTFNet:/workspace docker_image_rtfnet  /bin/bash   
$ (currently, you should be in the docker container as root)
```     
3. Set a password for SSH connection, type ```passwd``` in the terminal and enter your password twice.      
![pic1](pictures/change_passwd.png)     
Now we have finished the configuration of the  SSH service in container.    

## Step 2 Connect to the docker container with VScode:     
1. Open VScode as a ```New Window```. Then, click the Extensions. Search and install extenion Remote Development. This extension set consists of the Remote-SSH and other remote extensions:    
![pic2](pictures/Remote_Development.png)    
2. Choose the the ```Remote-SSH: Open configuration file``` and open the ```/xxx/.ssh/config``` file as the following figure:    
![pic3](pictures/SSH_config.png)     
![pic4](pictures/SSH_config2.png)     
3. Edit the ```config``` file as figure:   
![pic5](pictures/SSH_config3.png)     
4. Click the left bottom icon again and select ```Remote-SSH:Connect Current Window to Host```. Then choose the Hostname that you wrote in the config file:        
![pic6](pictures/SSH_config4.png)     
![pic7](pictures/SSH_config5.png)    
5. Enter the password you set for container root:      
![pic8](pictures/SSH_config6.png)       
6. Now, enjoy your coding in remote docker.
