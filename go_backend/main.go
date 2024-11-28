package main

import (
	"log"
	"os"

	"github.com/gin-gonic/gin"
	"github.com/harsimran-d/todo_app/go_backend/routes"
	"github.com/harsimran-d/todo_app/go_backend/services"
)

func main() {
	port := os.Getenv("PORT")
	if port == "" {
		port = "3000"
	}
	listenAddr := ":" + port

	r := gin.Default()
	service := services.NewInMemoryTodoService()
	routes.RegisterRoutes(r, service)
	log.Println("Server running on port: ", listenAddr)
	log.Fatal(r.Run(listenAddr))
}
