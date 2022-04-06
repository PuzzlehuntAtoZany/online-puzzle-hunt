# Local SSL 

In order to run the site with the correct configurations, you need local SSL certification. 
You can run the following commands to get the correct certifications:

```
brew install mkcert
mkcert -install
mkcert -cert-file cert.pem -key-file key.pem localhost 127.0.0.1
```

You can also call `make local-ssl` to utilize the make file. 

To run the server, instead of just running `./manage.py runserver` you now need to run ` ./manage.py runsslserver --certificate cert.pem --key key.pem`

You can also call `make run-local` 

For more information check this link out: https://timonweb.com/django/https-django-development-server-ssl-certificate/