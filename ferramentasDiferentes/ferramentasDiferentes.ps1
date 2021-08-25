# Cria um container e logo depois fecha ele
# uma vez que o comando termina quando o processo acaba ele finaliza o container
docker container run debian bash --version;
# mostra todos os containers em execução
docker container ps;
#mostra os containers que foram executados independente do estado, podendo ser containers parados
docker container ps -a;
