# How to Update Code in Server

1. Update the code locally and push to master. 
2. Go to Ubuntu Server and login with `ssh -i "onlinepuzzlehunt.pem" ubuntu@ec2-34-220-254-216.us-west-2.compute.amazonaws.com`
3. Pull master to server 
4. Run `sudo make run-server` to clean old docker images and run your new code



