package routes

import (
	"github.com/gin-gonic/gin"
	"github.com/harsimran-d/todo_app/go_backend/handlers"
	"github.com/harsimran-d/todo_app/go_backend/types"
)

func RegisterRoutes(r *gin.Engine, service types.TodoService) {
	handler := handlers.NewTodoHandler(service)
	api := r.Group("/api/v1")
	{
		api.GET("/todo", handler.GetAllTodos)
		api.GET("/todo/:id", handler.GetTodoById)
		api.POST("/todo", handler.CreateTodo)
		api.PUT("/todo/:id", handler.UpdateTodoById)
		api.DELETE("/todo/:id", handler.DeleteTodoById)
	}
}
