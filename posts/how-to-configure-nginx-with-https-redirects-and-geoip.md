---
title: How to configure nginx with HTTPS redirects and geoip
tags:
  - dev-ops
  - digital ocean
  - nginx
permalink: how-to-configure-nginx-with-https-redirects-and-geoip
id: 5
updated: '2017-04-20 04:55:45'
date: 2017-03-10 19:21:00
category: Technology
---

This is mostly for self reference but might help somebody out there.

### Background
I run a couple of sites on [Digital Ocean](https://www.digitalocean.com/) and thought it would be a good idea to have them use HTTPS as it is 2017 and google is [pushing](https://motherboard.vice.com/en_us/article/google-will-soon-shame-all-websites-that-are-unencrypted-chrome-https) for a HTTPS-only web in the future.

My sites are standard node+express and emberjs apps. Running inside their Docker containers with nginx webserver on the front. I wanted to achieve the following - 

1. www requests to be rediected to non-www site.
2. HTTP requests to be redirected to HTTPS
3. Geo-ip info to be passed to the apps with all requests
4. Handle all of the above for two separate sites I am hosting on the same server. 

The first requirement redirects people typing `www.mysite.com` to `mysite.com`. This is preferabe because google treats www and non-www as two separate domains.
The second requirement forces all connections to use HTTPS. Because what Is the point of having HTTPS configured if you aren't going to enforce it?
I am using geoip info in some of my apps and don't want to depend on external APIs or run a separate local instance to do the lookups. Much easier to just have the database sitting locally and webserver getting the info even before the request reaches the app.

### How-to

#### Prerequisites
1. The following config assumes you have your apps running inside their docker containers which either share the docker network with a container running nginx or nginx is running on the host system and is able to communicate to the apps through [exposed ports](https://docs.docker.com/engine/reference/builder/#expose).
- You need to have your SSL certificates in place before running nginx or it will crash. The SSL certificates need to be valid for both www and non-www domains otherwise redirects will throw up errors. [Letsencrypt](https://letsencrypt.org/) is a good place to start when looking for certificates.
- Make sure your instalation of nginx has the geoip module by running `nginx -V` and looking for `--with-http_geoip_module`
- Download and save Maxmind's city and country [Geo-ip databases](http://dev.maxmind.com/geoip/geoip2/geolite2/).
 
#### nginx.conf
After going through DO's tutorial and a few threads on Stack-overflow this is what I ended up with in my nginx.conf. Look for comments which explain things further  --

```nginx
user  nginx;
worker_processes  1;

error_log  /var/log/nginx/error.log warn;
pid        /var/run/nginx.pid;

# Required for Geo-ip to work
load_module "modules/ngx_http_geoip_module.so";

events {
    worker_connections  1024;
}

http {

    # maxmind's country and city IP database
    geoip_country /etc/nginx/geoip/GeoIP.dat; 
    geoip_city /etc/nginx/geoip/GeoLiteCity.dat;

    include       /etc/nginx/mime.types;
    default_type  application/octet-stream;

    log_format  main  '$remote_addr - $remote_user [$time_local] "$request" '
                      '$status $body_bytes_sent "$http_referer" '
                      '"$http_user_agent" "$http_x_forwarded_for"';

    access_log  /dev/stdout  main;
    sendfile        on;
    keepalive_timeout  65;
	
    # Listen for non-HTTPS requests and redirect them to HTTPS
    server {
        server_name www.site1.com site1.com;
        return 301 https://site1.com$request_uri;
    }

    # Listen for www requests with HTTPS and redirect them to non www site 
    server {
        listen              443 ssl;
        server_name         www.site1.com;
        # path to SSL certificates
        ssl_certificate     /etc/letsencrypt/live/www.site1.com/fullchain.pem;
        ssl_certificate_key /etc/letsencrypt/live/www.site1.com/privkey.pem;
        ssl_protocols       TLSv1 TLSv1.1 TLSv1.2;
        ssl_ciphers         HIGH:!aNULL:!MD5;
        return 301 https://site1.com$request_uri;
    }
    
    # Listen for non-www HTTPS requests and serve the app
    server {
        listen              443 ssl;
        server_name         site1.com;
        # path to SSL certificates
        ssl_certificate     /etc/letsencrypt/live/www.site1.com/fullchain.pem;
        ssl_certificate_key /etc/letsencrypt/live/www.site1.com/privkey.pem;
        ssl_protocols       TLSv1 TLSv1.1 TLSv1.2;
        ssl_ciphers         HIGH:!aNULL:!MD5;

        location ^~ /.well-known/ {
            root   /usr/share/nginx/html;
            allow all;
        }

        location / {
            proxy_set_header Host $host;
            proxy_set_header X-Real-IP $remote_addr;
            # Set geo-ip headers
            proxy_set_header geoip_country_code $geoip_country_code;
            proxy_set_header geoip_city $geoip_city;
            proxy_set_header geoip_latitude $geoip_latitude;
            proxy_set_header geoip_longitude $geoip_longitude;
            proxy_pass http://app1:3000;    # replace 'app1' with 'localhost' if ngix is not running within docker network 
        }
    }
    
    # Listen for non-HTTPS requests and redirect them to HTTPS
    server {
        server_name www.site2.com site2.com;
        return 301 https://site2.com$request_uri;
    }

    # Listen for www requests with HTTPS and redirect them to non www site
    server {
        listen              443 ssl;
        server_name         www.site2.com;
        ssl_certificate     /etc/letsencrypt/live/www.site2.com/fullchain.pem;
        ssl_certificate_key /etc/letsencrypt/live/www.site2.com/privkey.pem;
        ssl_protocols       TLSv1 TLSv1.1 TLSv1.2;
        ssl_ciphers         HIGH:!aNULL:!MD5;
        return 301 https://site2.com$request_uri;
    }

    # Listen for non-www HTTPS requests and serve the app
    server {
        listen              443 ssl;
        server_name         site2.com;
        ssl_certificate     /etc/letsencrypt/live/www.site2.com/fullchain.pem;
        ssl_certificate_key /etc/letsencrypt/live/www.site2.com/privkey.pem;
        ssl_protocols       TLSv1 TLSv1.1 TLSv1.2;
        ssl_ciphers         HIGH:!aNULL:!MD5;

        location ^~ /.well-known/ {
            root   /usr/share/nginx/html;
            allow all;
        }

        location / {
            proxy_set_header Host $host;
            proxy_set_header X-Real-IP $remote_addr;
            # Set geo-ip headers
            proxy_set_header geoip_country_code $geoip_country_code;
            proxy_set_header geoip_city $geoip_city;
            proxy_set_header geoip_latitude $geoip_latitude;
            proxy_set_header geoip_longitude $geoip_longitude;
            proxy_pass http://app2:4200;  # replace 'app2' with 'localhost' if ngix is not running within docker network   
        }
    }
}
```