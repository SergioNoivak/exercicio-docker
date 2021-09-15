# Primeiro Build

O arquivo Dockerfile é um descritor do docker para a construção de uma imagem

````dockerfile

FROM nginx:latest
RUN echo '<h1>Hello World</h1>' > /usr/share/nginx/html/index.html
	
````

Por exemplo, o arquivo DockerFile descreve que a imagem deverá criar um servidor mais novo do nginx e escrever no index.html o texto em html. 

Já no comando:

````bash
docker image build -t ex-simple-build .	
````

É gerado uma imagem com a tag  ``ex-simple-build``, que é como se fosse o nome da imagem.

 