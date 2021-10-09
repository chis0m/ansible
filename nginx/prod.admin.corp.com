server {
    
    listen 80;

    root /var/www/admin-corp/public;

    index index.php index.html index.htm index.nginx-debian.html;

    server_name api.prod.admin.corp.com www.api.prod.admin.corp.com;

    location / {
        try_files $uri $uri/ /index.php$is_args$args;
    }


    location ~ \.php$ {
        include snippets/fastcgi-php.conf;
        fastcgi_pass unix:/run/php/php7.4-fpm.sock;
    }

    location ~ /\.ht {
            deny all;
    }

}


