# Redes no Docker 

 As configurações de rede servem para esconder elementos de um container, por exemplo, esconder uma porta do banco de dados em uma rede... convém colocar o banco de dados em uma rede reservada para isso. Por padrão o modelo de container do Docker é Bridge.

<img src="./img1.jpg" height="350" width="500" alt="au" />

Nesse modelo os containers fazem conexões de rede através de suas interfaces e a Bridge é responsável por fazer a comunicação com o Host, que por sua vez faz as chamadas de rede.

No docker existem quatro tipos de rede possíveis para um container:

<ul>
    <li>Bridge: Modo padrão.</li>
    <li>None: Sem nenhum acesso a rede externa.</li>
    <li>Host: Modo que remove a camada de Bridge.</li>
    <li>Overlay: Modo que faz clusterização.</li>
</ul>

Para listar as redes possíveis no docker, basta fazer:

````powershell
docker network list	
````

A saída do comando:

`````
NETWORK ID     NAME      DRIVER    SCOPE
3345306b207b   bridge    bridge    local
063a24bfc5bf   host      host      local
d12b747d4ee7   none      null      local
`````

O tipo de rede none não contém DRIVER de rede.

Para analisar configurações de rede, usar o comando ``ifconfig`` dentro do bash do linux. Um exemplo de uso:

````
docker container run --rm alpine ash -c "ifconfig" 
````

Que tem como saída:

````shell

eth0      Link encap:Ethernet  HWaddr 02:42:AC:11:00:02  
          inet addr:172.17.0.2  Bcast:172.17.255.255  Mask:255.255.0.0
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          RX packets:2 errors:0 dropped:0 overruns:0 frame:0
          TX packets:0 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:0
          RX bytes:180 (180.0 B)  TX bytes:0 (0.0 B)

lo        Link encap:Local Loopback
          inet addr:127.0.0.1  Mask:255.0.0.0
          UP LOOPBACK RUNNING  MTU:65536  Metric:1
          RX packets:0 errors:0 dropped:0 overruns:0 frame:0
          TX packets:0 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:1000
          RX bytes:0 (0.0 B)  TX bytes:0 (0.0 B)
````

O endereço ``addr:172.17.0.2`` representa que o container tem sim acesso a internet.

 O modo de rede do tipo none não tem acesso a internet, para construir um container do tipo none basta usar:

````powershell
docker container run --rm --net none alpine ash -c "ifconfig"
````

Esse comando produz a saída:

````

lo        Link encap:Local Loopback  
          inet addr:127.0.0.1  Mask:255.0.0.0
          UP LOOPBACK RUNNING  MTU:65536  Metric:1
          RX packets:0 errors:0 dropped:0 overruns:0 frame:0
          TX packets:0 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:1000
          RX bytes:0 (0.0 B)  TX bytes:0 (0.0 B)
````

Que indica que o container não tem a interface ``eth0``, apenas a interface de loopback ``lo``, mostrando que aquele container está isolado da internet.

Ao investigar o tipo de rede bridge com o comando:

````
docker network inspect bridge
````

Nota-se que nas configurações, a Subnet ``"Subnet": "172.17.0.0/16",`` tem uma faixa de ``172.17.0.0`` até ```172.17.255.255`` para criar containers do docker.  Note que o container do tipo bridge criado anteriormente está dentro da faixa, sendo ``addr:172.17.0.2 ``.



## Teste de comunicação entre dois containers

​	Criação do primeiro container em modo bridge:

````powershell
docker container run -d --name container1 alpine sleep 1000
````

executando esse container:

````powershell
docker container exec --name container1
````

ele tem a interface ``eth0`` com ip ``addr:172.17.0.2``, criando outro container:

``````powershell
docker container run -d --name container2 alpine sleep 1000
``````

ele tem a interface ``eth0`` com ip ``addr:172.17.0.3``

Ao executar no container1 um ping sobre o container2:

````bash

docker container exec -it container1 ping 172.17.0.3 
PING 172.17.0.3 (172.17.0.3): 56 data bytes
64 bytes from 172.17.0.3: seq=0 ttl=64 time=0.095 ms
64 bytes from 172.17.0.3: seq=1 ttl=64 time=0.049 ms
64 bytes from 172.17.0.3: seq=2 ttl=64 time=0.049 ms
64 bytes from 172.17.0.3: seq=3 ttl=64 time=0.049 ms
64 bytes from 172.17.0.3: seq=4 ttl=64 time=0.066 ms
64 bytes from 172.17.0.3: seq=5 ttl=64 time=0.053 ms
^C
--- 172.17.0.3 ping statistics ---
6 packets transmitted, 6 packets received, 0% packet loss
round-trip min/avg/max = 0.049/0.060/0.095 ms

````

 o ping foi bem sucedido, significa que o container1 pode se comunicar com o container 2. O container1 também pode fazer acesso a internet, pois ao fazer:

````bash
docker container exec -it container1 ping www.google.com 
PING www.google.com (172.217.29.100): 56 data bytes
64 bytes from 172.217.29.100: seq=0 ttl=37 time=34.931 ms
64 bytes from 172.217.29.100: seq=1 ttl=37 time=32.595 ms
^C
--- www.google.com ping statistics ---
2 packets transmitted, 2 packets received, 0% packet loss
round-trip min/avg/max = 32.595/33.763/34.931 ms
````

Um ping na internet se obtem sucesso. 
