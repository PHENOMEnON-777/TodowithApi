import 'package:api_todo/data/models/apitodo.dart';
import 'package:api_todo/logic/todos_bloc/bloc/api_todo_bloc.dart';
import 'package:api_todo/router/routing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TodoWidget extends StatelessWidget {
  final List<ApiTodo> tododata;
  const TodoWidget({
    super.key,
    required this.tododata,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: tododata.length,
        itemBuilder: (context, index) {
          return Card(
            child: ListTile(
              title: Text(tododata[index].title),
              subtitle: Text(tododata[index].subtitle),
              trailing: Container(
                width: 144,
                child: Row(
                  children: <Widget>[
                    IconButton(
                      onPressed: () {
                        BlocProvider.of<ApiTodoBloc>(context).add(
                          ApiCompletTodo(
                            apiTodo: tododata[index],
                          ),
                        );
                      },
                      icon: tododata[index].isCompleted
                          ?const Icon(Icons.favorite)
                          :const Icon(Icons.favorite_border),
                    ),
                    IconButton(
                      onPressed: () {
                        print(tododata.length);
                        final todo = tododata[index];
                        Navigator.pushNamed(context,
                          addupdatescreen,
                          arguments: todo,
                        );
                      },
                      icon: const Icon(Icons.edit),
                    ),
                    IconButton(
                      onPressed: () {
                        BlocProvider.of<ApiTodoBloc>(context).add(
                          ApiDeletTodo(id: tododata[index].id),
                          
                        );
                      },
                      icon: const Icon(Icons.delete),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }
}
