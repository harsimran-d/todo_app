package types

type Todo struct {
	Id     int    `json:"id"`
	Title  string `json:"title"`
	Status bool   `json:"status"`
}

type TodoService interface {
	GetAllTodos() ([]Todo, error)
	GetTodoById(id int) (Todo, error)
	CreateTodo(todo Todo) (Todo, error)
	UpdateTodoById(id int, todo Todo) (Todo, error)
	DeleteTodoById(id int) error
}
