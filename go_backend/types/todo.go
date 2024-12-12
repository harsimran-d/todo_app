package types

import "time"

type Todo struct {
	ID        uint      `json:"id"`
	Title     string    `json:"title"`
	Status    bool      `json:"status"`
	CreatedAt time.Time `json:"createdAt"`
	UpdatedAt time.Time `json:"updatedAt"`
}

type TodoService interface {
	GetAllTodos() ([]Todo, error)
	GetTodoById(id uint) (Todo, error)
	CreateTodo(title string) (Todo, error)
	UpdateTodoById(todo Todo) (Todo, error)
	DeleteTodoById(id uint) error
}
