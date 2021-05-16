VNC
===

OSX ships with a vnc browser which you can open using the `vnc` url scheme. Ex `vnc://abcdef`


### Security

VNC is unencrypted so I setup all my VNC servers to disallow remote connections and only allow connection from locahost
 
I add these two lines to my `/etc/pf`, following this [blog](https://blog.neilsabol.site/post/quickly-easily-adding-pf-packet-filter-firewall-rules-macos-osx/) [archive](https://web.archive.org/web/20210507002503/https://blog.neilsabol.site/post/quickly-easily-adding-pf-packet-filter-firewall-rules-macos-osx/)


```
block return in proto tcp from any to any port 5900
pass in inet proto tcp from "127.0.0.1" to any port 5900 no state
```

```
pfctl -f /etc/pf.conf # Checks config
pfctl -E # Enables new config
```


