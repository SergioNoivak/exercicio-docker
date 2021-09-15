#criação da imagem ex-simple-build 
docker image build -t ex-simple-build .
#criação de um container a apartir da imagem
docker container run -p 80:80 ex-simple-build