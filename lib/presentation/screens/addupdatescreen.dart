import 'package:api_todo/data/models/apitodo.dart';
import 'package:api_todo/logic/todos_bloc/bloc/api_todo_bloc.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddUpdateScreen extends StatelessWidget {
  AddUpdateScreen({super.key, required this.todo});
  ApiTodo todo;
  @override
  Widget build(BuildContext context) {
    final TextEditingController titlecontroller =
        TextEditingController(text: todo.title);
    final TextEditingController subtitlecontroller =
        TextEditingController(text: todo.subtitle);
    final bool isEditing = todo.id.isNotEmpty;

    return Scaffold(
      appBar: AppBar(
        title: isEditing ? const Text('Updating') : const Text('Adding'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            TextField(
              controller: titlecontroller,
              decoration: const InputDecoration(
                filled: true,
                border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.all(
                    Radius.circular(100),
                  ),
                ),
                hintText: 'title',
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            TextField(
                controller: subtitlecontroller,
                decoration: const InputDecoration(
                  filled: true,
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.all(
                      Radius.circular(100),
                    ),
                  ),
                  hintText: 'description',
                )),
            const SizedBox(
              height: 10,
            ),
            IconButton(
              onPressed: () {
                final title = titlecontroller.text;
                final subtitle = subtitlecontroller.text;
                final mytodo = ApiTodo(
                  id: isEditing ? todo.id : DateTime.now().toString(),
                  title: title,
                  subtitle: subtitle,
                  isCompleted: isEditing ? todo.isCompleted : false,
                );
                if (isEditing) {
                  BlocProvider.of<ApiTodoBloc>(context).add(ApiUpdateTodo(
                    todo: mytodo,
                  ));
                } else if (titlecontroller.text.isEmpty ||
                    subtitlecontroller.text.isEmpty) {
                  ScaffoldMessenger.of(context).hideCurrentSnackBar();
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text(
                        'fill the title and description \n befor addding to your todo list',
                        style: TextStyle(color: Colors.red),
                      ),
                      duration: Duration(seconds: 5),
                    ),
                  );
                } else {
                  BlocProvider.of<ApiTodoBloc>(context).add(
                    ApiAddTodo(todo: mytodo),
                  );
                }
              },
              icon: isEditing
                  ? const Text(
                      'Update',
                      style: TextStyle(color: Colors.blue),
                    )
                  : const Icon(
                      Icons.add_task,
                      color: Colors.green,
                    ),
            ),
             Container(
              height: 200,
              width: 200,
              child: const FlareActor(
                'lib/presentation/assets/animations/animation.flr',
                animation: 'Alarm',
                color: Color.fromARGB(255, 5, 107, 8),
              ),
            )
          ],
        ),
      ),
    );
  }
}
