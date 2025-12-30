import '../../domain/entities/task.dart';
import '../../domain/repositories/task_repository.dart';
import '../datasources/task_local_datasource.dart';
import '../models/task_model.dart';

class TaskRepositoryImpl implements TaskRepository {
  final TaskLocalDataSource localDataSource;

  TaskRepositoryImpl({required this.localDataSource});

  @override
  Future<List<Task>> getTasks() async {
    return await localDataSource.getTasks();
  }

  @override
  Future<void> addTask(Task task) async {
    return await localDataSource.addTask(TaskModel.fromEntity(task));
  }

  @override
  Future<void> updateTask(Task task) async {
    return await localDataSource.updateTask(TaskModel.fromEntity(task));
  }

  @override
  Future<void> deleteTask(String id) async {
    return await localDataSource.deleteTask(id);
  }
}
