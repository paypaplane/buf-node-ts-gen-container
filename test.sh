docker build . -f Dockerfile.test -t "buf-test"
docker run -it "buf-test"