import 'package:api_todo/data/models/apitodo.dart';
import 'package:api_todo/data/repository/repository.dart';
import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

part 'api_todo_event.dart';
part 'api_todo_state.dart';

class ApiTodoBloc extends HydratedBloc<ApiTodoEvent, ApiTodoState> {
  Repository repository;

  ApiTodoBloc({required this.repository})
      : super(const ApiTodoInitial(todos: [])) {
    on<ApiFetchTodo>((event, emit) async {
      emit(FetchingApiTodo(todos: state.todos));
      try {
        final todoss = await repository.FetchingTodos();
        emit(
          FetchingApiTodoSuccessful(
            todos: todoss,
            successfulMessage: 'task fetch successfully',
          ),
        );
      } catch (e) {
        emit(
          FetchingApiTodoFailure(
            todos: state.todos,
            errorMessage: 'Failed to fetch tasks',
          ),
        );
      }
    });

    on<ApiCompletTodo>((event, emit) async {
      emit(CompletingApiTodo(todos: state.todos));
      try {
        final todos = await repository.toggleIsCompleted(event.apiTodo);
        final updatedTodos = state.todos.map((todo) {
          return todo.id == todos.id ? todos : todo;
        }).toList();
        emit(
          CompletingApiTodoSuccessful(
            todos: updatedTodos,
            successfulMessage: 'successfulMessage',
          ),
        );
      } catch (e) {
        emit(
          CompletingApiTodoFailure(
            todos: state.todos,
            errorMessage: "errorMessage",
          ),
        );
      }
    });

    on<ApiAddTodo>((event, emit) async {
      emit(AddingApiTodo(todos: state.todos));
      try {
        final todo = event.todo;
        final addedTodo = await repository.addTodo(todo);
        final updatedTodos = List<ApiTodo>.from(state.todos)..add(addedTodo);
        emit(
          AddingApiTodoSuccessful(
            todos: updatedTodos,
            successfulMessage: "Todo added successfully",
          ),
        );
      } catch (e) {
        emit(
          AddingApiTodoFailure(
            todos: state.todos,
            errorMessage: 'Failed to add todo: $e',
          ),
        );
      }
    });

    on<ApiDeletTodo>((event, emit) async {
      emit(
        DeletingApiTodo(
          todos: state.todos,
        ),
      );
      try {
        await repository.DeleteTask(event.id);
        state.todos.removeWhere((element) => element.id == event.id);
        emit(
          DeletingApiTodoSuccessful(
            todos: state.todos,
            successfulMessage: "successfulMessage",
          ),
        );
      } catch (e) {
        emit(
          DeletingApiTodoFailure(
              todos: state.todos, errorMessage: "errorMessage"),
        );
      }
    });

    on<ApiUpdateTodo>((event, emit) async {
      emit(UpdateingApiTodo(todos: state.todos));
      try {
        final updatedtodo = await repository.UpdateTodo(event.todo);
        for (var i = 0; i < state.todos.length; i++) {
          if (updatedtodo.id == state.todos[i].id) {
            state.todos[i] = updatedtodo;
            break;
          }
        }
        emit(
          UpdateingApiTodoSuccessful(
            todos: state.todos,
            successfulMessage: 'successfulMessage',
          ),
        );
      } catch (e) {
        emit(
          UpdateingApiTodoFailure(
              todos: state.todos, errorMessage: "errorMessage"),
        );
      }
    });
  }

  @override
  ApiTodoState? fromJson(Map<String, dynamic> json) {

    print('************* taking from memory****************');

    if(json['todos'] !=null){
      final todojson = json['todos'] as List<String>;
      final listOftodos = todojson.map((e) => ApiTodo.fromJson(e)).toList();
      
      print('*******');
      print(listOftodos);
      print('*******');

      return FetchingApiTodoSuccessful(todos: listOftodos, successfulMessage: 'successfulMessage');
    }
    return null;
  }

  @override
  Map<String, dynamic>? toJson(ApiTodoState state) {

    print('************* storing in memory****************');

    if (state is FetchingApiTodoSuccessful ||
        state is AddingApiTodoSuccessful ||
        state is UpdateingApiTodoSuccessful ||
        state is DeletingApiTodoSuccessful ||
        state is CompletingApiTodoSuccessful) {
      return {'todos': state.todos.map((e) => e.toJson()).toList()};
    }
    return null;
  }
}
