import 'package:minimal_habit_tracker/domain/entities/habit_entity.dart';

import '../../domain/repositories/local_data_source.dart';
import '../database/database_client.dart';

class LocalDataSourceImpl implements LocalDataSource {
  final DatabaseClient databaseClient = DatabaseClient();

  @override
  Future<List<HabitEntity>> get() async {
    final list = await databaseClient.get();
    return list;
  }

  @override
  insert(HabitEntity habitEntity) {
    databaseClient.insertHabit(habitEntity);
  }
}
