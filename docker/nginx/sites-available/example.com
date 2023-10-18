server {
  listen [::]:80 default_server;

  server_name example.com;

  root /app/public/example;

  error_log /var/log/nginx/example.com.log;
  access_log /dev/null;

  location / {
    try_files $uri $uri/ /index.php?/$request_uri;
    index index.php;
    
    location ~ \.php$ {
      fastcgi_param SCRIPT_FILENAME $document_root$fastcgi_script_name;
    
      if (!-f $document_root$fastcgi_script_name) {
        return 404;
      }

      fastcgi_pass unix:/var/run/php-fpm.sock;
      fastcgi_index index.php;
      fastcgi_read_timeout 300;
      fastcgi_buffers 16 16k;
      fastcgi_buffer_size 32k;
      include fastcgi_params;
    }
  }
}
