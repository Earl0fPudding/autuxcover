# Autuxcover
Outlook's autodiscover and Thunderbird's autoconfig implemented with the Python webframework Bottle.

## Requirements
Just plain ol' Python.

## DNS records
Create the following DNS records (instead of example.com use your own domain):
```
Essential records:
  autoconfig.example.com                A       <ip of your server>
  _autodiscover._tcp.example.com        SRV 10  10 443 autoconfig.example.com.

Optional recommended records:
  _imaps._tcp.example.com               SRV 0   1 993 <your mailserver's subdomain>
  _submission._tcp.example.com          SRV 0   1 587 <your mailserver's subdomain>
```

## Installation
1. Clone this repository
2. Edit the `config.xml` file so it fits your mailserver
3. Create a new user with limited rights: (e.g. `useradd -s /usr/sbin/nologin --system autuxcover`)
4. Give this user persmissions for the directory: `chown autuxcover:autuxcover /path/to/the/repo -R`
5. Copy the `autuxcover.service` file into the `/etc/systemd/system/` directory on your system (if your system has systemd)
6. Edit the execution path in the newly copied file and maybe user and group if your's have different names
7. Start the service `systemctl start autuxcover.service`
8. Create a new NGINX virtual host (edit certificate paths and server_name):
```
server {
        listen 443 ssl http2;
        listen [::]:443;

        server_name autoconfig.example.com;

        ssl_certificate /path/to/your/certificate.crt;
        ssl_certificate_key /path/to/your/key.key;

        location / {
            proxy_pass http://127.0.0.1:8089;
            proxy_redirect     default;
        }
}
```
9. Reload NGINX: `nginx -s reload`
10. Done!

## Testing
### Outlook autodiscover
You can check if everything is correct [here](https://testconnectivity.microsoft.com) or by doing a right click while holding CTRL on the Outlook icon in the taskbar and selecting "Email-Autodiscover test".
### Thunderbird autoconfig
Simply try to add a new email account in your Thunderbird client and make sure you don't have to enter your server settings manually.

## Other
You may have to change the port from 8089 to something else if some service already uses that port on your system.

It is also recommended to change the `debug=True` into `debug=False` if you are planning to use this on production scale.

Some older versions of Outlook may use the so-called Guesssmart which basically tries every possible POP3, IMAP and SMTP combination to find the correct settings.
This creates a lot of requests to the server, so please beware that you might have to adjust some anti-spam or anti-brute-force mechanisms on your server (e.g. fail2ban, ...).

## License
This project is licensed under the GNU General Public License Version 3 - see the LICENSE file for details.
