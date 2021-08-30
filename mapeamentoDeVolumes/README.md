# Mapeamento de volumes



​    Para trocar arquivos entre a máquina host e o container é necessário fazer compartilhamento de volumes. para compartilhar arquivos da máquina host para o container usa-se o argumento ``-v`` que indica qual volume será mapeado.

Exemplo:

`````powershell
docker container run -p 8080:80 -v %cd%/html:/usr/share/nginx/html nginx

`````

Vai mapear no windows a pasta html do host para a pasta do servidor que busca o arquivo ``index.html`` no container.

<img src="./img1.png" height="350" width="1000" alt="au" />

Nessa prática, a pasta html no diretório atual da máquina host só pode mapear arquivos para o container nginx graças ao comando ``docker container run -p 8080:80 -v %dir%/html:/usr/share/nginx/html nginx``. Primeiro foi dito o mapeamento de portas e depois foi feito o mapeamento dos volumes, no primeiro lado dos : está o diretório do host e depois do outro lado está o diretório do container.

Na maioria das vezes precisamos executar o docker no modo daemon, esse modo é aquele em que o container roda o seu processo interno em background, para tanto usar o comando ``docker container run -d --name daemon -p 8080:80 -v %dir%/html:/usr/share/nginx/html nginx``, que vai executar o comando anterior, porém em modo background, dessa forma que ele vai para a produção na maioria das vezes.  para parar o container usar ``docker container list`` para listar os ids dos containers em execução, e ``docker container stop 212112`` para parar o container de id 212112, por exemplo.





