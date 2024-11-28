package services

import (
	"errors"
	"sync"

	"github.com/harsimran-d/todo_app/go_backend/types"
)

type InMemoryTodoService struct {
	todos     map[int]types.Todo
	idCounter int
	mutex     sync.Mutex
}

func NewInMemoryTodoService() *InMemoryTodoService {
	return &InMemoryTodoService{
		todos:     make(map[int]types.Todo),
		idCounter: 1,
	}
}

func (s *InMemoryTodoService) GetAllTodos() ([]types.Todo, error) {
	s.mutex.Lock()
	defer s.mutex.Unlock()
	var todos []types.Todo
	todos = []types.Todo{}
	for _, todo := range s.todos {
		todos = append(todos, todo)
	}
	return todos, nil
}

func (s *InMemoryTodoService) GetTodoById(id int) (types.Todo, error) {
	s.mutex.Lock()
	defer s.mutex.Unlock()

	todo, exists := s.todos[id]
	if !exists {
		return types.Todo{}, errors.New("todo not found")
	}
	return todo, nil
}

func (s *InMemoryTodoService) CreateTodo(todo types.Todo) (types.Todo, error) {
	s.mutex.Lock()
	defer s.mutex.Unlock()

	todo.Id = s.idCounter
	s.todos[todo.Id] = todo
	s.idCounter++
	return todo, nil
}

func (s *InMemoryTodoService) UpdateTodoById(id int, todo types.Todo) (types.Todo, error) {
	s.mutex.Lock()
	defer s.mutex.Unlock()

	_, exists := s.todos[id]
	if !exists {
		return types.Todo{}, errors.New("todo not found")
	}

	s.todos[id] = todo
	return todo, nil
}

func (s *InMemoryTodoService) DeleteTodoById(id int) error {
	s.mutex.Lock()
	defer s.mutex.Unlock()

	_, exists := s.todos[id]
	if !exists {
		return errors.New("todo not found")

	}
	delete(s.todos, id)
	return nil
}
