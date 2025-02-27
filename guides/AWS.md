# AWS Instance Setup Online (UI)

Command to connect to serve:
`ssh -i "onlinepuzzlehunt.pem" ubuntu@ec2-34-220-254-216.us-west-2.compute.amazonaws.com`

When creating a new instance, we can follow the default steps for all items except the security group step. Create a new security group if it is your first time. This security group can be reused when making new instances and getting other things set up. It is recommended not to make multiple security groups (unless needed) as it can cause confusion in the future. In this security group be sure to let ssh traffic in as this will be needed to access the instance from our local terminal. Be sure to also allow HTTP and HTTPS as these will be needed to display our site. There is no need to modify the Network ACLs as the default settings should work fine. Create a new pem for the server to log in via local terminal. DO NOT create new pems every time you launch a new instance unless you want a bunch of keys to those instances. 

## Troubleshooting: 
- Have you tried accessing the site on a different browser/laptop
- Make sure you are accessing http:// not https:// when first navigating to the site  
- Clear cache on your browser and try again 
- Run the [Docker Aws Setup Tutorial](https://docs.aws.amazon.com/AmazonECS/latest/developerguide/docker-basics.html) and see if it works 
- List ports and see if things are working as expected
- You may need to kill apache if it is running and blocking port 80 (https://www.cyberciti.biz/faq/star-stop-restart-apache2-webserver/)

# Run Script to Prepare Instance
`bash prepare-instance.sh`
If this script fails then manually install items

# AWS EC2 Setup for Ubuntu Instance
## Update EC2 Instance: 
- `sudo apt update` Fetches the list of available updates
- `sudo apt upgrade` Installs some updates; does not remove packages
- `sudo apt full-upgrade`  Installs updates; may also remove some packages, if needed
- `sudo apt autoremove`    Removes any old packages that are no longer needed

## Git (may not need): 
`sudo apt install git-all`

## Make:
`sudo apt-get -y install make`

## Docker: 
		
https://docs.docker.com/engine/install/ubuntu/

### Command for the correct version:

`sudo apt-get install docker-ce=5:20.10.13~3-0~ubuntu-focal docker-ce-cli=5:20.10.13~3-0~ubuntu-focal containerd.io`

## Docker Compose: 
`https://docs.docker.com/compose/install/`


# HTTPS and Route 53 Setup

Follow this guide: https://stackoverflow.com/questions/5309910/https-setup-in-amazon-ec2

Follow this guide to get https on CloudFlare: https://medium.com/@phpxpertise/free-ssl-certificate-for-godaddy-using-cloudflare-b9d8e286ff20