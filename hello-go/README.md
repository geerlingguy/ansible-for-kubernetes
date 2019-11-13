# Hello World HTTP Go app

## How to run

  1. [Install Go](https://golang.org/doc/install) on your computer.
  2. On the command line, in this directory, run `go build cmd/hello/hello.go`

Go should generate a binary named `hello`. Run that binary with the command:

    ./hello

This will start a webserver on port 8180. In a web browser, access `http://localhost:8180/testing`. If everything's working, you should receive a 200 OK response, and the content:

    Hello, you've requested: /testing

When you're finished testing, press "Control + C" on the command line to exit the app.

## About the HTTP Server example

The `hello.go` example was originally derived from [Go Web Examples](https://gowebexamples.com).

## About the Author

This project was created by [Jeff Geerling](https://www.jeffgeerling.com/) as an example for [Ansible for Kubernetes](https://www.ansibleforkubernetes.com/).
