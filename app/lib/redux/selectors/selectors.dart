import 'package:heroes_companion/redux/state.dart';
import 'package:heroes_companion_data/heroes_companion_data.dart';

List<Hero> heroesSelector(AppState state) => state.heroes;
Optional<Hero> heroSelectorByCompanionId(List<Hero> heroes, int id) {
  try {
    return new Optional.of(heroes.firstWhere((h) => h.heroes_companion_hero_id == id));
  }
  catch (e) {
    return new Optional.absent();
  }
}