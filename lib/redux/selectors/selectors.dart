import 'package:heroes_companion/redux/state.dart';
import 'package:heroes_companion_data/heroes_companion_data.dart';

List<Hero> heroesSelector(AppState state) => state.heroes;