1.  
Routing entry for 185.189.16.0/22
Known via "bgp 6447", distance 20, metric 0
Tag 3356, type external
Last update from 4.68.4.46 5d19h ago
Routing Descriptor Blocks:
* 4.68.4.46, from 4.68.4.46, 5d19h ago
    Route metric is 0, traffic share count is 1
    AS Hops 3
    Route tag 3356
    MPLS label: none\

2.
default via 192.168.253.1 dev ens160 proto static
192.168.22.0/24 via 192.168.253.1 dev ens160 proto static
192.168.150.0/24 via 192.168.253.1 dev ens160 proto static
192.168.253.0/24 dev ens160 proto kernel scope link src 192.168.253.8

3. ss -tp
ESTAB    0          0             192.168.253.8:ssh                                                           172.31.2.13:63609
ESTAB    0          48            192.168.253.8:ssh                                                           172.31.2.13:63608
По TCP используется только порт SSH (по умолчанию 22). Используется моим MobaXterm
ss -tl
LISTEN   0          4096          0.0.0.0:sunrpc                                                            0.0.0.0:*
LISTEN   0          64            0.0.0.0:39701                                                             0.0.0.0:*
LISTEN   0          4096          127.0.0.53%lo:domain                                                      0.0.0.0:*
LISTEN   0          128           0.0.0.0:ssh                                                               0.0.0.0:*
LISTEN   0          4096          0.0.0.0:42647                                                             0.0.0.0:*
LISTEN   0          128           127.0.0.1:6010                                                            0.0.0.0:*
LISTEN   0          4096          127.0.0.1:8125                                                            0.0.0.0:*
LISTEN   0          4096          0.0.0.0:19999                                                             0.0.0.0:*
LISTEN   0          64            0.0.0.0:nfs                                                               0.0.0.0:*
LISTEN   0          4096          0.0.0.0:40873                                                             0.0.0.0:*
LISTEN   0          4096          0.0.0.0:38761                                                             0.0.0.0:*
LISTEN   0          4096          *:9100                                                                    *:*
LISTEN   0          4096          [::]:sunrpc                                                               [::]:*
LISTEN   0          128           [::]:ssh                                                                  [::]:*
LISTEN   0          128           [::1]:6010                                                                [::]:*
LISTEN   0          64            [::]:nfs                                                                  [::]:*
LISTEN   0          4096          [::]:55777                                                                [::]:*
LISTEN   0          4096          [::]:38017                                                                [::]:*
LISTEN   0          64            [::]:43237                                                                [::]:*
LISTEN   0          4096          [::]:39241                                                                [::]:*
"Слушаются" несколько портов. 6010 - используется для X11, например.

4. ss -ul
State      Recv-Q    end-Q        Local Address:Port                                                        Peer Address:Port                            Process
UNCONN     0         0            127.0.0.53%lo:domain                                                      0.0.0.0:*
UNCONN     0         0            0.0.0.0:sunrpc                                                            0.0.0.0:*
UNCONN     0         0            0.0.0.0:34727                                                             0.0.0.0:*
UNCONN     0         0            0.0.0.0:nfs                                                               0.0.0.0:*
UNCONN     0         0            0.0.0.0:53644                                                             0.0.0.0:*
UNCONN     0         0            127.0.0.1:8125                                                            0.0.0.0:*
UNCONN     0         0            0.0.0.0:58719                                                             0.0.0.0:*
UNCONN     0         0            0.0.0.0:42395                                                             0.0.0.0:*
UNCONN     0         0            [::]:sunrpc                                                               [::]:*
UNCONN     0         0            [::]:nfs                                                                  [::]:*
UNCONN     0         0            [::]:35406                                                                [::]:*
UNCONN     0         0            [::]:35796                                                                [::]:*
UNCONN     0         0            [::]:42520                                                                [::]:*
UNCONN     0         0            [::]:44933                                                                [::]:*
"Слушаются" так же несколько портов. 53 - DNS. 2049 - NFS

5.
![Пример сети](https://user-images.githubusercontent.com/100866321/204226240-40b8c4d0-60c2-4d91-93a5-b3e2324c0916.png)
