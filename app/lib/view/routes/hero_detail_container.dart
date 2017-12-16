import 'package:flutter/material.dart' hide Hero;
import 'package:flutter_redux/flutter_redux.dart';
import 'package:heroes_companion/redux/selectors/selectors.dart';
import 'package:heroes_companion/redux/state.dart';
import 'package:heroes_companion/routes.dart';
import 'package:heroes_companion/services/hero_build_win_rate_service.dart';
import 'package:heroes_companion/services/heroes_service.dart';
import 'package:heroes_companion/services/win_rates_service.dart';
import 'package:heroes_companion/view/common/hero_detail.dart';
import 'package:heroes_companion_data/heroes_companion_data.dart';
import 'package:hots_dog_api/hots_dog_api.dart';
import 'package:meta/meta.dart';
import 'package:redux/redux.dart';

class HeroDetailContainer extends StatelessWidget {
  final int heroesCompanionId;

  HeroDetailContainer(this.heroesCompanionId)
      : super(key: Routes.heroDetailKey);

  @override
  Widget build(BuildContext context) {
    return new StoreConnector<AppState, _ViewModel>(
        onInit: (store) {
          if (winRatesSelector(store.state) == null) {
            getCurrentWinRates(store);
          }
          Optional<Hero> hero = heroSelectorByCompanionId(
              heroesSelector(store.state), heroesCompanionId);
          if (hero.isPresent) {
            getHeroCurrentBuildWinRates(store, hero.value);
          }
        },
        ignoreChange: (state) =>
            heroSelectorByCompanionId(state.heroes, heroesCompanionId)
                .isNotPresent,
        converter: (Store<AppState> store) =>
            new _ViewModel.from(store, heroesCompanionId),
        builder: (context, vm) {
          return new HeroDetail(vm.hero,
              favorite: vm.favorite,
              winLossCount: vm.winLossCount,
              buildWinRates: vm.buildWinRates);
        });
  }
}

class _ViewModel {
  final Hero hero;
  final dynamic favorite;
  final WinLossCount winLossCount;
  final BuildWinRates buildWinRates;

  _ViewModel(
      {@required this.hero,
      @required this.favorite,
      this.winLossCount,
      this.buildWinRates});

  factory _ViewModel.from(Store<AppState> store, int id) {
    final dynamic _favorite = (Hero hero) {
      hero.is_favorite ? unFavorite(store, hero) : setFavorite(store, hero);
    };

    final hero = heroSelectorByCompanionId(heroesSelector(store.state), id);
    // TODO Wrap win losss count to have a sensible model in app
    final winLossCount = winLossCountByCompanionId(store.state, id);
    final buildWinRates = buildWinRatesByCompanionId(store.state, id);

    return new _ViewModel(
      hero: hero.value,
      favorite: _favorite,
      winLossCount: winLossCount.isPresent ? winLossCount.value : null,
      buildWinRates: buildWinRates.isPresent ? buildWinRates.value : null,
    );
  }
}
