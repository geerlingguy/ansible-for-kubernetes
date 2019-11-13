package main

import (
    "net/http"
    "net/http/httptest"
    "testing"
)

func TestGetHello(t *testing.T) {
    t.Run("Returns current path", func(t *testing.T) {
        request, _ := http.NewRequest(http.MethodGet, "/testing", nil)
        response := httptest.NewRecorder()

        HelloServer(response, request)

        got := response.Body.String()
        want := "Hello, you requested: /testing"

        if got != want {
            t.Errorf("got %q, want %q", got, want)
        }
    })
}
