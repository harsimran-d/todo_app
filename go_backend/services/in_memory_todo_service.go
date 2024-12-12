package services

import (
	"errors"
	"sync"

	"github.com/harsimran-d/todo_app/go_backend/types"
)

type InMemoryTodoService struct {
	todos     map[uint]types.Todo
	idCounter uint
	mutex     sync.Mutex
}

func NewInMemoryTodoService() *InMemoryTodoService {
	return &InMemoryTodoService{
		todos:     make(map[uint]types.Todo),
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

func (s *InMemoryTodoService) GetTodoById(id uint) (types.Todo, error) {
	s.mutex.Lock()
	defer s.mutex.Unlock()

	todo, exists := s.todos[id]
	if !exists {
		return types.Todo{}, errors.New("todo not found")
	}
	return todo, nil
}

func (s *InMemoryTodoService) CreateTodo(title string) (types.Todo, error) {
	s.mutex.Lock()
	defer s.mutex.Unlock()
	var todo types.Todo
	todo.ID = s.idCounter
	todo.Title = title
	s.todos[todo.ID] = todo
	s.idCounter++
	return todo, nil
}

func (s *InMemoryTodoService) UpdateTodoById(todo types.Todo) (types.Todo, error) {
	s.mutex.Lock()
	defer s.mutex.Unlock()

	_, exists := s.todos[todo.ID]
	if !exists {
		return types.Todo{}, errors.New("todo not found")
	}

	s.todos[todo.ID] = todo
	return todo, nil
}

func (s *InMemoryTodoService) DeleteTodoById(id uint) error {
	s.mutex.Lock()
	defer s.mutex.Unlock()

	_, exists := s.todos[id]
	if !exists {
		return errors.New("todo not found")

	}
	delete(s.todos, id)
	return nil
}
