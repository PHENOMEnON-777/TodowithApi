part of 'api_todo_bloc.dart';

sealed class ApiTodoState  extends Equatable{
   final List<ApiTodo> todos;
  const ApiTodoState({required this.todos});
  @override
  List<Object?> get props => [todos];
}

 class ApiTodoInitial extends ApiTodoState {
  const ApiTodoInitial({required super.todos});

  @override
  List<Object?> get props => [todos];
}

 class FetchingApiTodo extends ApiTodoState {
  const FetchingApiTodo({required super.todos});
  @override
  List<Object?> get props => [todos];
}
 class FetchingApiTodoSuccessful extends ApiTodoState {
  final String successfulMessage;
  const FetchingApiTodoSuccessful({required super.todos,required this.successfulMessage});
  
  @override
  List<Object?> get props => [successfulMessage,...super.todos];
}
 class FetchingApiTodoFailure extends ApiTodoState {
  final String errorMessage;
  const FetchingApiTodoFailure({required super.todos, required this.errorMessage});
  
  @override
  List<Object?> get props => [errorMessage,...super.todos];
  
}

 class AddingApiTodo extends ApiTodoState {
  const AddingApiTodo({required super.todos});
  @override
  List<Object?> get props => [todos];
}
 class AddingApiTodoSuccessful extends ApiTodoState {
  final String successfulMessage;
   const AddingApiTodoSuccessful({required super.todos,required this.successfulMessage});
  
  @override
  List<Object?> get props => [successfulMessage,...super.todos];
  
}
 class AddingApiTodoFailure extends ApiTodoState {
  final String errorMessage;
  const AddingApiTodoFailure({required super.todos, required this.errorMessage});
  
  @override
  List<Object?> get props => [errorMessage,...super.todos];
  
}

 class DeletingApiTodo extends ApiTodoState {
  const DeletingApiTodo({required super.todos});
  @override
  List<Object?> get props => [todos];
}
 class DeletingApiTodoSuccessful extends ApiTodoState {
  final String successfulMessage;
  const DeletingApiTodoSuccessful({required super.todos,required this.successfulMessage});
  
  @override
  List<Object?> get props => [successfulMessage,...super.todos];
}
 class DeletingApiTodoFailure extends ApiTodoState {
  final String errorMessage;
  const DeletingApiTodoFailure({required super.todos, required this.errorMessage});
  
  @override
  List<Object?> get props => [errorMessage,...super.todos];
  
}

 class UpdateingApiTodo extends ApiTodoState {
  const UpdateingApiTodo({required super.todos});

}
 class UpdateingApiTodoSuccessful extends ApiTodoState {
  final String successfulMessage;
  const UpdateingApiTodoSuccessful({required List<ApiTodo> todos,required this.successfulMessage}) :super(todos: todos);
  
  @override
  List<Object?> get props => [successfulMessage,...super.todos];
  
}
 class UpdateingApiTodoFailure extends ApiTodoState {
  final String errorMessage;
  const UpdateingApiTodoFailure({required super.todos, required this.errorMessage});
  
  @override
  List<Object?> get props => [errorMessage,...super.todos];
  
}


 class CompletingApiTodo extends ApiTodoState {
  const CompletingApiTodo({required super.todos});
  @override
  List<Object?> get props => [todos];
}
 class CompletingApiTodoSuccessful extends ApiTodoState {
  final String successfulMessage;
  const CompletingApiTodoSuccessful({required super.todos,required this.successfulMessage});
  
  @override
  List<Object?> get props => [successfulMessage,...super.todos];
  
}
 class CompletingApiTodoFailure extends ApiTodoState {
  final String errorMessage;
  const CompletingApiTodoFailure({required super.todos, required this.errorMessage});
  
  @override
  List<Object?> get props => [errorMessage,...super.todos];
  
}