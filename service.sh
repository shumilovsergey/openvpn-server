# autossh + service example 
# from client to server (reverse)


# sudo apt update
# sudo apt install autossh
# sudo nano /etc/systemd/system/autossh-tunnel.service


[Unit]
Description=AutoSSH Reverse Tunnel from Client to Server
After=network-online.target

[Service]
Type=forking
User=wmr_ssh

ExecStart=/usr/bin/autossh -M 0 -N -f -q -i /home/ssh_tunnel_user/.ssh/id_rsa -o "ExitOnForwardFailure=yes" -o "ServerAliveInterval=30" -o "ServerAliveCountMax=3" -R 1195:localhost:1195 wmr_ssh@<server_ip>

ExecStop=/usr/bin/pkill -9 -u wmr_ssh

RestartSec=5
Restart=always

[Install]
WantedBy=multi-user.target


# sudo systemctl daemon-reload
# sudo systemctl start autossh-tunnel.service
# sudo systemctl enable autossh-tunnel.service
# sudo systemctl status autossh-tunnel.service