FROM golang:1.20.2
ENV PACKAGES jq curl wget jq file make git



WORKDIR /apps
COPY . .
RUN  apt install apt-transport-https ca-certificates

RUN cp sources.list /etc/apt/sources.list
RUN apt update
RUN apt install vim -y
#RUN apt-get update
#RUN  apt install -y apt-transport-https ca-certificates
#RUN cp sources.list /etc/apt/sources.list
#RUN apt-get install -y jq
#RUN apt-get install -y  curl   make git
RUN ls -a
RUN go version
RUN go env -w GOPROXY=https://goproxy.cn,direct
#RUN go mod tidy
env GO111MODULE=on
RUN go env -w GOPRIVATE="git.everylink.ai"
RUN go env -w GOINSECURE=git.everylink.ai/public
RUN #git config --global url."http://git.everylink.ai/".insteadof "https://git.everylink.ai/"

#RUN go get git.everylink.ai/public/go-ethereum
RUN make install
RUN  #apt-get install nginx -y
RUN #sh init.sh
RUN mkdir ~/.sequncerd
WORKDIR /apps/data
RUN ls -a
WORKDIR /apps
COPY data/ /root/.sequncerd/
WORKDIR /root/.sequncerd/
RUN ls -a

#RUN ./target/release/dtx-chain build-spec --disable-default-bootnode --chain local > customSpec.json
#RUN ./target/release/dtx-chain build-spec --chain=customSpec.json --raw --disable-default-bootnode > config/customSpecRaw.json
#COPY nginx/nginx.conf /etc/nginx/nginx.conf
#EXPOSE 9900