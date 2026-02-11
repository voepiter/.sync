#конфигурация xray для обхода тспу

domain.com, domain.ru
корпоративный сайт на крупном хостинге в RU
vps hv1 EU hv2 US xray сервер
несколько клиентов в RU c xray client

hv1.domain.com cloudflare proxied full to hv1 ip
directhv1.domain.com direct to hv1 ip

hv1 xray server
inbound1
0.0.0.0:443 vless reality vision self steal servername directhv1.domain.com dest 127.0.0.1:8443
inbound2
127.0.0.1:10443 vless xhttp tls

nginx 127.0.0.1:8443 http2 ssl
cert letsencrypt *.domain.com
path /secret proxy pass 127.0.0.1:10443
path / /var/www/html/index.json api like cloack

ru xray client
outbound1
directhv1.domain.com:443 vless tcp vision reality   
outbound2
hv1.domain.com:443 vless xhttp tls 

fingerprint chrome на оба outbound

все работает
curl hv1.domain.com = index.json cf edge cert
curl directhv1.domain.com = index.json letsencrypt cert
curl --socks5 site = content  через оба outboud
