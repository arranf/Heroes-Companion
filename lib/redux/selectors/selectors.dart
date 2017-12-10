import 'package:heroes_companion/redux/state.dart';
import 'package:hots_dog_api/hots_dog_api.dart';

List<HeroInfo> heroesSelector(AppState state) => state.gameInfo.heroInfo;