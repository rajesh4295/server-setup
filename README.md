# server-setup
Simple SSH script to setup new virtual box server with required apps

### Example output: 

```
oscar@oscar-VirtualBox:~$ sudo ./setup.sh
✅ [SKIP] ssh found
✅ [SKIP] virtualbox-guest-utils found
✅ [SKIP] User oscar already present in vboxsf group
✅ [SKIP] git found. git version 2.25.1
✅ [SKIP] curl found. curl 7.68.0 (x86_64-pc-linux-gnu) libcurl/7.68.0 OpenSSL/1.1.1f zlib/1.2.11 brotli/1.0.7 libidn2/2.2.0 libpsl/0.21.0 (+libidn2/2.2.0) libssh/0.9.3/openssl/zlib nghttp2/1.40.0 librtmp/2.3
Release-Date: 2020-01-08
Protocols: dict file ftp ftps gopher http https imap imaps ldap ldaps pop3 pop3s rtmp rtsp scp sftp smb smbs smtp smtps telnet tftp
Features: AsynchDNS brotli GSS-API HTTP2 HTTPS-proxy IDN IPv6 Kerberos Largefile libz NTLM NTLM_WB PSL SPNEGO SSL TLS-SRP UnixSockets
✅ [SKIP] docker found. {"Client":{"Platform":{"Name":""},"Version":"20.10.7","ApiVersion":"1.41","DefaultAPIVersion":"1.41","GitCommit":"20.10.7-0ubuntu5~20.04.2","GoVersion":"go1.13.8","Os":"linux","Arch":"amd64","BuildTime":"Mon Nov  1 00:34:17 2021","Context":"default","Experimental":true},"Server":{"Platform":{"Name":""},"Components":[{"Name":"Engine","Version":"20.10.7","Details":{"ApiVersion":"1.41","Arch":"amd64","BuildTime":"Fri Oct 22 00:45:53 2021","Experimental":"false","GitCommit":"20.10.7-0ubuntu5~20.04.2","GoVersion":"go1.13.8","KernelVersion":"5.13.0-39-generic","MinAPIVersion":"1.12","Os":"linux"}},{"Name":"containerd","Version":"1.5.5-0ubuntu3~20.04.2","Details":{"GitCommit":""}},{"Name":"runc","Version":"1.0.1-0ubuntu2~20.04.1","Details":{"GitCommit":""}},{"Name":"docker-init","Version":"0.19.0","Details":{"GitCommit":""}}],"Version":"20.10.7","ApiVersion":"1.41","MinAPIVersion":"1.12","GitCommit":"20.10.7-0ubuntu5~20.04.2","GoVersion":"go1.13.8","Os":"linux","Arch":"amd64","KernelVersion":"5.13.0-39-generic","BuildTime":"2021-10-22T00:45:53.000000000+00:00"}}
✅ [SKIP] kubectl found. Client Version: version.Info{Major:"1", Minor:"23", GitVersion:"v1.23.5", GitCommit:"c285e781331a3785a7f436042c65c5641ce8a9e9", GitTreeState:"clean", BuildDate:"2022-03-16T15:58:47Z", GoVersion:"go1.17.8", Compiler:"gc", Platform:"linux/amd64"}
✅ [SKIP] kind found. kind v0.12.0 go1.17.8 linux/amd64
✅ [SKIP] helm found. version.BuildInfo{Version:"v3.8.1", GitCommit:"5cb9af4b1b271d11d7a97a71df3ac337dd94ad37", GitTreeState:"clean", GoVersion:"go1.17.5"}
✅ [SKIP] jq found. jq-1.6
✅ [SKIP] yq found. yq (https://github.com/mikefarah/yq/) version 4.23.1
✅ [SKIP] node found. v17.9.0
✅ [SKIP] go found. go version go1.18 linux/amd64
oscar@oscar-VirtualBox:~$
```
