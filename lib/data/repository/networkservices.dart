import 'dart:convert';

import 'package:api_todo/data/models/apitodo.dart';
import 'package:http/http.dart' as http;

class Networkservices {
  final url = "http://10.0.2.2:3000/todos";

  Future<List<Map<String, dynamic>>> fetchTodosfromApi() async {
    try {
      final response = await http.get(Uri.parse("http://10.0.2.2:3000/todos"));
      if (response.statusCode == 200) {
        return List<Map<String, dynamic>>.from(jsonDecode(response.body));
      } else {
        throw Exception(response.statusCode.toString());
      }
    } catch (e) {
      return [];
    }
  }

  Future<ApiTodo> toggleIsCompleted(ApiTodo apiTodo) async {
    final id = apiTodo.id;
    final OldIsCompleted = apiTodo.isCompleted;
    final updatedAipTodo = apiTodo.copyWith(isCompleted: !apiTodo.isCompleted);
    try {
      final response = await http.patch(Uri.parse("$url/$id"),
          body: updatedAipTodo.toJson());
      if (response.statusCode == 200) {
        return updatedAipTodo;
      } else {
        throw Exception('errorMessage');
      }
    } catch (e) {
      apiTodo.isCompleted = OldIsCompleted;
      rethrow;
    }
  }

  Future<Map<String, dynamic>> addTodpToApiServer(ApiTodo todoobject) async {
    try {
      final response = await http.post(
        Uri.parse("$url"),
        body: todoobject.copyWith().toJson(),
      );
      if (response.statusCode == 201) {
        return Map<String, dynamic>.from(jsonDecode(response.body));
      } else {
        throw Exception('unable to add todo');
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<http.Response> deleteTodoFromApi(String id) async {
    try {
      final response = await http.delete(Uri.parse("$url/$id"));
      if (response.statusCode == 200) {
        return response;
      } else {
        throw false;
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<Map<String, dynamic>> UpdateTodoaFromApi(ApiTodo todo) async {
    final id = todo.id;
    try {
      final response = await http.put(
        Uri.parse("$url/$id"),
        body: todo.copyWith().toJson(),
      );
      if (response.statusCode == 200) {
        return Map<String, dynamic>.from(jsonDecode(response.body));
      } else {
        throw Exception(response.statusCode);
      }
    } catch (e) {
      rethrow;
    }
  }
}
