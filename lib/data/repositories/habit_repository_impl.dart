import 'package:minimal_habit_tracker/domain/entities/habit_entity.dart';
import 'package:minimal_habit_tracker/domain/repositories/habit_repository.dart';

import 'local_data_source_impl.dart';

class HabitRepositoryImpl implements HabitRepository {
  LocalDataSourceImpl localDataSource = LocalDataSourceImpl();

  @override
  Future<List<HabitEntity>> get() {
    return localDataSource.get();
  }

  @override
  insert(HabitEntity habitEntity) {
    localDataSource.insert(habitEntity);
  }
}
