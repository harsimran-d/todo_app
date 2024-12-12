package services

import (
	"github.com/harsimran-d/todo_app/go_backend/types"
	"gorm.io/gorm"
)

type PostgresService struct {
	DB *gorm.DB
}

func NewPostgresService(db *gorm.DB) *PostgresService {
	return &PostgresService{
		DB: db,
	}
}

func (s *PostgresService) GetAllTodos() ([]types.Todo, error) {
	var todos []types.Todo
	if err := s.DB.Find(&todos).Error; err != nil {
		return nil, err
	}
	return todos, nil
}
func (s *PostgresService) GetTodoById(id uint) (types.Todo, error) {
	var todo types.Todo
	if err := s.DB.First(&todo, id).Error; err != nil {
		return todo, err
	}
	return todo, nil
}
func (s *PostgresService) CreateTodo(title string) (types.Todo, error) {
	todo := types.Todo{Title: title}
	if err := s.DB.Create(&todo).Error; err != nil {
		return todo, err
	}
	return todo, nil

}
func (s *PostgresService) UpdateTodoById(todo types.Todo) (types.Todo, error) {
	if err := s.DB.Save(&todo).Error; err != nil {
		return types.Todo{}, err
	}
	return todo, nil

}
func (s *PostgresService) DeleteTodoById(id uint) error {
	return s.DB.Delete(&types.Todo{}, id).Error
}
