docker image build -t ex-build-com-args .
docker container run ex-build-com-args bash -c 'echo $S3_BUCKET'
