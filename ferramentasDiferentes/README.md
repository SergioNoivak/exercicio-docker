<h1>Ferramentas diferentes</h1>

Ao executar o comando:

````powershell
docker container run debian bash --version
````

O comando fez o download, criação da imagem, o docker container start e depois executa o comando de maneira iterativa(``docker container exec``).

Saída do container:

````powershell
PS C:\Users\sergi\exercicio-docker> .\ferramentasDiferentes\ferramentasDiferentes.ps1

GNU bash, version 5.0.3(1)-release (x86_64-pc-linux-gnu)
Copyright (C) 2019 Free Software Foundation, Inc.
License GPLv3+: GNU GPL version 3 or later <http://gnu.org/licenses/gpl.html>

This is free software; you are free to change and redistribute it.
There is NO WARRANTY, to the extent permitted by law.
````



Para verificar os containers em execução basta usar

````powershell

docker container ps
````

Quando um container é parado ele não some do histórico do docker, se o comando ``docker container ps -a`` for executado esse container estará lá parado, para executar esse container e logo depois descarta-lo deve-se usar ```docker container run --rm debian bash --version``` , por exemplo.

