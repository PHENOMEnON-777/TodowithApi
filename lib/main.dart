import 'package:api_todo/data/repository/networkservices.dart';
import 'package:api_todo/data/repository/repository.dart';
import 'package:api_todo/logic/bloc_observer/blocobserver.dart';
import 'package:api_todo/logic/todos_bloc/bloc/api_todo_bloc.dart';
import 'package:api_todo/router/routing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HydratedBloc.storage = await HydratedStorage.build(
      storageDirectory: await getApplicationDocumentsDirectory());
  Bloc.observer = MyBlocObserver();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final repository = Repository(networkservices: Networkservices());

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ApiTodoBloc(repository: repository),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        onGenerateRoute: AppRoute.generateRoute,
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        initialRoute: '/',
      ),
    );
  }
}
