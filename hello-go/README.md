# Hello World HTTP Go app

This application is meant to teach the very basics of Go programming.

## How to build and run the app

  1. [Install Go](https://golang.org/doc/install) on your computer.
  2. On the command line, in this directory, run `go build cmd/hello/hello.go`

Go should generate a binary named `hello`. Run that binary with the command:

    ./hello

This will start a webserver on port 8180. In a web browser, access `http://localhost:8180/testing`. If everything's working, you should receive a 200 OK response, and the content:

    Hello, you've requested: /testing

When you're finished testing, press "Control + C" on the command line to exit the app.

## How to build and run the app inside a container

  1. [Install Docker CE](https://docs.docker.com/v17.09/engine/installation/#desktop) on your computer.
  2. On the command line, in this directory, run `docker build -t hello-go .`
  3. Run the container, bound to port `8180`: `docker run --name hello-go --rm -p 8180:8180 hello-go`

This will start a webserver on port 8180. In a web browser, access `http://localhost:8180/testing`. If everything's working, you should receive a 200 OK response, and the content:

    Hello, you've requested: /testing

When you're finished testing, press "Control + C" on the command line to exit the app.

## About the HTTP Server example

The `hello.go` example was originally derived from [Go Web Examples](https://gowebexamples.com).

## About the Author

This project was created by [Jeff Geerling](https://www.jeffgeerling.com/) as an example for [Ansible for Kubernetes](https://www.ansibleforkubernetes.com/).
