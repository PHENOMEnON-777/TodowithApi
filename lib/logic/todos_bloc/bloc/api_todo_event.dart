part of 'api_todo_bloc.dart';

sealed class ApiTodoEvent extends Equatable{
const  ApiTodoEvent();

  @override
  List<Object?> get props => [];
}

 class ApiFetchTodo extends ApiTodoEvent{}

 class ApiAddTodo extends ApiTodoEvent {
  final ApiTodo todo;

 const ApiAddTodo({required this.todo});
  
  @override
  List<Object?> get props => [todo];
}

 class ApiDeletTodo extends ApiTodoEvent {
  final String id;

 const ApiDeletTodo({required this.id});
  
  @override
  List<Object?> get props => [id];
}

  class ApiUpdateTodo extends ApiTodoEvent {
  final ApiTodo todo;

 const ApiUpdateTodo({required this.todo});
  
  @override
  List<Object?> get props => [todo];
}


 class ApiCompletTodo extends ApiTodoEvent {
 final ApiTodo apiTodo;
 const ApiCompletTodo({required this.apiTodo});

  @override
 
  List<Object?> get props => [apiTodo];
}