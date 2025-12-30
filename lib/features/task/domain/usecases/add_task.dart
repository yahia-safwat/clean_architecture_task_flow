import '../../../../core/usecases/usecase.dart';
import '../entities/task.dart';
import '../repositories/task_repository.dart';

class AddTask implements UseCase<void, Task> {
  final TaskRepository repository;

  AddTask(this.repository);

  @override
  Future<void> call(Task task) async {
    return await repository.addTask(task);
  }
}
