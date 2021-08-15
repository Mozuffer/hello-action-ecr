FROM golang:1.15-alpine As builder 

RUN  adduser -D -g '' user

WORKDIR /home/user 

COPY *.go /home/user
COPY go.sum /home/user 
COPY go.sum /home/user


ARG VERSION

RUN CGO_ENABLED=0 go build -a -tags netgo,osusergo \
    -ldflags "-extldflags '-static -s -w'" \
    -ldflags="-X 'main.version=${VERSION}'" -o app

FROM scratch
COPY --from=builder /home/user/app /bin/app

EXPOSE 8080

ENTRYPOINT ["/bin/app"]