SSH Cheatsheet
===


##Local Forwarding/Remote Forwarding/Dynamic Tunneling

###Local Forwarding
To bind a local port `1234` to a remote port `5000` on the remote machine. This is useful to expose services runing on the remote host to the local/source machine. For example, I could have a database running on `5000` of the remote host and I could allow a client on the source machine to connect to that database by connection to `1234` on the source machine.

    ssh -L 1234:localhost:5000 user@example.com

###Remote Forwarding
To bind a remote port `2222` to the local port `22`. This can be used in the setup of a bastion or remote host. For example, if I have a macbook behind a NAT router, I can use remote port forwarding to ssh into the macbook behind the nat. 

    ssh -R 2222:localhost:22 user@example.com

    ssh user@domain.com ssh -p 2222 mbuser@localhost

###Dynamic Tunneling
Dynamic tunneling is the poor mans's vpn. By ssh-ing into a remote host we can setup a SOCKS5 Proxy for use in a web browser. 

    ssh -C -D 1080 user@example.com

    SOCKS5 Host `127.0.0.1`
    Socks5 Port `1080`


Largely paraphrased from this article.
https://help.ubuntu.com/community/SSH/OpenSSH/PortForwarding
