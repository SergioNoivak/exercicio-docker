# Personalização de imagens via argumentos

No Dockerfile é possível personalizar as imagens passando via terminal, por exemplo, os valores de uma variável de ambiente específica. Exemplo:

````dockerfile
FROM debian
LABEL mantainer 'Sergio Souza Novak'

ARG S3_BUCKET=files
ENV S3_BUCKET=${S3_BUCKET}

````

Ao criar essas camadas podemos dizer, por exemplo que  S3_BUCKET recebe o valor de argumento via terminal ``docker image build -t ex-build-com-args2 . --build-arg S3_BUCKET=myapp`` de forma que S3_BUCKET é myapp, mas se não for passado nenhum argumento assume files, que é o valor padrão.



