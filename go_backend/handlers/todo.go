package handlers

import (
	"net/http"
	"strconv"

	"github.com/gin-gonic/gin"
	"github.com/harsimran-d/todo_app/go_backend/types"
)

type TodoHandler struct {
	Service types.TodoService
}

func NewTodoHandler(service types.TodoService) *TodoHandler {
	return &TodoHandler{
		Service: service,
	}
}

func (h *TodoHandler) GetAllTodos(c *gin.Context) {
	todos, err := h.Service.GetAllTodos()
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": err.Error()})
		return
	}
	c.JSON(http.StatusOK, todos)

}
func (h *TodoHandler) GetTodoById(c *gin.Context) {
	idStr := c.Param("id")
	id, err := strconv.Atoi(idStr)
	if err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": "Invalid ID"})
		return
	}

	todo, err := h.Service.GetTodoById(id)

	if err != nil {
		c.JSON(http.StatusNotFound, err.Error())
		return
	}
	c.JSON(http.StatusOK, todo)
}
func (h *TodoHandler) CreateTodo(c *gin.Context) {
	var todo types.Todo
	if err := c.ShouldBindJSON(&todo); err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": err.Error()})
		return
	}
	createdTodo, err := h.Service.CreateTodo(todo)
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": err.Error()})
		return
	}
	c.JSON(http.StatusCreated, createdTodo)
}

func (h *TodoHandler) UpdateTodoById(c *gin.Context) {
	idStr := c.Param("id")
	id, err := strconv.Atoi(idStr)

	if err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": "Not a valid id"})
		return
	}
	var todo types.Todo

	if err := c.ShouldBindJSON(&todo); err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": err.Error()})
		return
	}
	todo.Id = id
	updatedItem, err := h.Service.UpdateTodoById(id, todo)

	if err != nil {
		c.JSON(http.StatusNotFound, gin.H{"error": err.Error()})
	}
	c.JSON(http.StatusOK, updatedItem)
}

func (h *TodoHandler) DeleteTodoById(c *gin.Context) {
	idStr := c.Param("id")
	id, err := strconv.Atoi(idStr)
	if err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": "not a valid id"})
		return
	}
	err = h.Service.DeleteTodoById(id)
	if err != nil {
		c.JSON(http.StatusInternalServerError, err.Error())
		return
	}
	c.JSON(http.StatusNoContent, nil)
}
