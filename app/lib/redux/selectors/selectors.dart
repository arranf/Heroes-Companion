import 'package:heroes_companion/redux/state.dart';
import 'package:heroes_companion_data/heroes_companion_data.dart';
import 'package:hots_dog_api/hots_dog_api.dart';

List<Hero> heroesSelector(AppState state) => state.heroes;
Optional<Hero> heroSelectorByCompanionId(List<Hero> heroes, int id) {
  try {
    return new Optional.of(heroes.firstWhere((h) => h.heroes_companion_hero_id == id));
  }
  catch (e) {
    return new Optional.absent();
  }
}

BuildInfo currentBuildSelector(AppState state) {
  if (state.buildInfo == null) {
    throw new Exception('Build Info hasn''t been loaded');
  }
  return state.buildInfo[0];
}