import 'package:get_it/get_it.dart';
import '../../features/task/domain/repositories/task_repository.dart';
import '../../features/task/domain/usecases/add_task.dart';
import '../../features/task/domain/usecases/delete_task.dart';
import '../../features/task/domain/usecases/get_tasks.dart';
import '../../features/task/domain/usecases/update_task.dart';
import '../../features/task/data/datasources/task_local_datasource.dart';
import '../../features/task/data/repositories/task_repository_impl.dart';
import '../../features/task/presentation/bloc/task/task_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // Bloc
  sl.registerFactory(
    () => TaskBloc(
      getTasks: sl(),
      addTask: sl(),
      updateTask: sl(),
      deleteTask: sl(),
    ),
  );

  // Use cases
  sl.registerLazySingleton(() => GetTasks(sl()));
  sl.registerLazySingleton(() => AddTask(sl()));
  sl.registerLazySingleton(() => UpdateTask(sl()));
  sl.registerLazySingleton(() => DeleteTask(sl()));

  // Repository
  sl.registerLazySingleton<TaskRepository>(
    () => TaskRepositoryImpl(localDataSource: sl()),
  );

  // Data sources
  sl.registerLazySingleton<TaskLocalDataSource>(
    () => TaskLocalDataSourceImpl(),
  );
}
