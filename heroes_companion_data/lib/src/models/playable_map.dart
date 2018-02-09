import 'package:heroes_companion_data/src/tables/map_table.dart' as table;

class PlayableMap {
  final int id;
  final String name;
  final String objective_name;
  final String objective_start_prompt;
  final String objective_finish_prompt;
  final int objective_start_time;
  final int objective_interval;

  PlayableMap(this.id, this.name, this.objective_name, this.objective_start_prompt, this.objective_finish_prompt, this.objective_start_time, this.objective_interval);

  factory PlayableMap.fromMap(Map map) {
    int id = map[table.column_id];
    String name = map[table.column_name];
    String objective_name = map[table.column_objective_name];
    String objective_start_prompt = map[table.column_objective_start_prompt];
    String objective_finish_prompt = map[table.column_objective_finish_prompt];
    int objective_start_time = map[table.column_objective_start_time];
    int objective_interval = map[table.column_objective_interval];

    return new PlayableMap(id, name, objective_name, objective_start_prompt, objective_finish_prompt, objective_start_time, objective_interval);
  }

  @override
  String toString() {
    return 'Map $name';
  }
}