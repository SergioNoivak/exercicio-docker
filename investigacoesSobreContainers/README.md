# Investigações 

O comando ``docker container run -it`` é um comando que possibilita que seja utilizado o terminal do container, o que é muito útil para fazer investigações naquele container:

````bash
PS C:\Users\sergi\exercicio-docker> docker container run -it debian bash 

root@a8729373d6f1:/# ls
bin  boot  dev  etc  home  lib  lib64  media  mnt  opt  proc  root  run  sbin  srv  sys  tmp  usr  var
root@a8729373d6f1:/# touch teste.txt
root@a8729373d6f1:/# ls
bin  boot  dev  etc  home  lib  lib64  media  mnt  opt  proc  root  run  sbin  srv  sys  teste.txt  tmp  usr  var
````

Ao criar containers com ``docker container run`` ou com ``docker container create`` gera nomes aleatórios para o container, porém para facilitar o reuso do container, é interessante ter um nome adequado, considerando que os containers devem ter nomes únicos. O comando ``docker container run --name my_name debian bash `` cria um container com o nome `my_name`. O container deve ter um nome único.

O comando ``docker container start -ai mydeb`` serve para reutilizar um container. Exemplo:

````powershell
PS C:\Users\sergi\exercicio-docker> docker container start -ai mydebian 

root@94943b7e429e:/# touch teste.txt
root@94943b7e429e:/# ls
bin   dev  exemplo.txt  lib    media  opt   root  sbin  sys        tmp  var
boot  etc  home         lib64  mnt    proc  run   srv   teste.txt  usr
root@94943b7e429e:/# exit
exit
````



