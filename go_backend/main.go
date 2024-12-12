package main

import (
	"fmt"
	"log"
	"os"

	"github.com/gin-gonic/gin"
	"github.com/harsimran-d/todo_app/go_backend/routes"
	"github.com/harsimran-d/todo_app/go_backend/services"
	"github.com/harsimran-d/todo_app/go_backend/types"
	"github.com/joho/godotenv"
	"gorm.io/driver/postgres"
	"gorm.io/gorm"
)

func main() {
	port := os.Getenv("PORT")
	if port == "" {
		port = "3000"
	}
	listenAddr := ":" + port

	err := godotenv.Load()
	if err != nil {
		log.Fatalf("Error loading .env file: %v", err)
	}
	dbUser := os.Getenv("DB_USER")
	dbPassword := os.Getenv("DB_PASSWORD")
	dbName := os.Getenv("DB_NAME")
	dbHost := os.Getenv("DB_HOST")
	dbPort := os.Getenv("DB_PORT")
	dsn := fmt.Sprintf(
		"user=%s password=%s dbname=%s host=%s port=%s",
		dbUser, dbPassword, dbName, dbHost, dbPort,
	)
	db, err := gorm.Open(postgres.Open(dsn), &gorm.Config{})
	if err != nil {
		log.Fatal("Failed to connect with database: ", err)
	}
	if err := db.AutoMigrate(&types.Todo{}); err != nil {
		log.Fatal("Migration error: ", err)
	}

	router := gin.Default()
	service := services.NewPostgresService(db)
	routes.RegisterRoutes(router, service)
	log.Println("Server running on port: ", listenAddr)
	log.Fatal(router.Run(listenAddr))
}
