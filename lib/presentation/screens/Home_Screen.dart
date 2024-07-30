import 'package:api_todo/data/models/apitodo.dart';
import 'package:api_todo/logic/todos_bloc/bloc/api_todo_bloc.dart';
import 'package:api_todo/presentation/Widgets/todoWidget.dart';
import 'package:api_todo/router/routing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    super.key,
  });
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
  final bloc =  BlocProvider.of<ApiTodoBloc>(context);
  if(bloc.state is !FetchingApiTodoSuccessful && bloc.state.todos.isEmpty){
    bloc.add(ApiFetchTodo());
  }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    
    // BlocProvider.of<ApiTodoBloc>(context).add(ApiFetchTodo());

    return Scaffold(
      appBar: AppBar(
        title: const Text('TodoApi'),
        actions: [
          IconButton(
            onPressed: () {
              final todo = ApiTodo(
                id: '',
                title: '',
                subtitle: '',
                isCompleted: false,
              );
              final todoobj = todo.copyWith();
              Navigator.pushNamed(
                context,
                addupdatescreen,
                arguments: todoobj,
              );
            },
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: BlocConsumer<ApiTodoBloc, ApiTodoState>(
          listener: (context, state) {
            if (state is FetchingApiTodoFailure) {
              showDialog(
                  context: context,
                  builder: (context) {
                    return Text(state.errorMessage);
                  });
            }
            if (state is AddingApiTodoSuccessful ||
                state is UpdateingApiTodoSuccessful) {
              Navigator.of(context).pop();
            }
            if (state is AddingApiTodoFailure) {
              showDialog(
                  context: context,
                  builder: (context) {
                    return const AlertDialog(
                      content: Text('Faild to add todo'),
                      title: Text('Adding error'),
                    );
                  });
            }
          },
          builder: ((context, state) {
            if (state is FetchingApiTodoSuccessful) {
              return TodoWidget(tododata: state.todos);
            }
            if (state is CompletingApiTodoSuccessful) {
              return TodoWidget(tododata: state.todos);
            }
            if (state is AddingApiTodoSuccessful) {
              return TodoWidget(tododata: state.todos);
            }
            if (state is UpdateingApiTodoSuccessful) {
              return TodoWidget(tododata: state.todos);
            }
            if (state is DeletingApiTodoSuccessful) {
              return TodoWidget(tododata: state.todos);
            }
            if (state is FetchingApiTodo ||
                state is DeletingApiTodo ||
                state is AddingApiTodo) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state is CompletingApiTodo) {
              return TodoWidget(tododata: state.todos);
            }

            return Center(child: Text(state.todos.length.toString()));
          }),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          final todo = ApiTodo(
            id: '',
            title: '',
            subtitle: '',
            isCompleted: false,
          );
          final todoobj = todo.copyWith();
          Navigator.pushNamed(
            context,
            addupdatescreen,
            arguments: todoobj,
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
