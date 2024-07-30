import 'package:api_todo/data/models/apitodo.dart';
import 'package:api_todo/data/repository/networkservices.dart';
import 'package:http/src/response.dart';

class Repository {
  Networkservices networkservices;
  Repository({required this.networkservices, });

  Future<List<ApiTodo>> FetchingTodos() async {
    final todos = await networkservices.fetchTodosfromApi() ;
     return todos.map((element) => ApiTodo.fromMap(element)).toList();
  }

  Future<ApiTodo> toggleIsCompleted( ApiTodo apiTodo) async{
try {
  final tododobject = await networkservices.toggleIsCompleted(apiTodo);
  return tododobject;
} catch (e) {
  rethrow;
}
  } 

  Future<ApiTodo> addTodo(ApiTodo todoObj)async{
    try {
      final todo = await networkservices.addTodpToApiServer(todoObj);
      return ApiTodo.fromMap(todo);
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> DeleteTask(String id)async {
    try {
      final response =  await networkservices.deleteTodoFromApi(id);
        return   response;
    } catch (e) {
    rethrow;
    }
  }

  Future<ApiTodo>UpdateTodo(ApiTodo todo)async {
    try {
      final response = await networkservices.UpdateTodoaFromApi(todo);
      return ApiTodo.fromMap(response);
    } catch (e) {
     rethrow ;
    }
  }                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           
}
