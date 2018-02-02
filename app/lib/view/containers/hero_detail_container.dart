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

class HeroDetailContainer extends StatefulWidget {
  final int heroesCompanionId;

  @override
  _HeroDetailContainerState createState() =>
      new _HeroDetailContainerState(heroesCompanionId);

  HeroDetailContainer(this.heroesCompanionId)
      : super(
            key: new Key(
                Routes.heroDetail + '_' + heroesCompanionId.toString()));
}

class _HeroDetailContainerState extends State<HeroDetailContainer> {
  bool _isCurrentBuild = true;
  final int _heroesCompanionId;
  String _buildNumber = '';

  _HeroDetailContainerState(this._heroesCompanionId);

  void fetchData(Store<dynamic> store) {
    if (isAppLoading(store.state)) {
      return;
    }
    _buildNumber = (_isCurrentBuild
            ? currentBuildSelector(store.state)
            : previousBuildSelector(store.state))
        .fullVersion;
    if (winRatesByBuildNumber(store.state, _buildNumber).isNotPresent) {
      getWinRatesForBuild(store, _buildNumber);
    }
    Optional<Hero> hero = heroSelectorByCompanionId(
        heroesSelector(store.state), _heroesCompanionId);
    if (hero.isPresent &&
        buildWinRatesByCompanionIdAndBuildNumber(
                store.state, hero.value.heroes_companion_hero_id, _buildNumber)
            .isNotPresent) {
      getHeroBuildWinRates(store, hero.value, _buildNumber);
    }
  }

  @override
  Widget build(BuildContext context) {
    return new StoreBuilder<AppState>(onInit: (store) {
      fetchData(store);
    }, builder: (context, store) {
      if (!isAppLoading(store.state)) {
        fetchData(store);
      }
      _ViewModel vm =
          new _ViewModel.from(store, _heroesCompanionId, _buildNumber);

      return new HeroDetail(vm.hero,
          key: new Key(vm.hero.short_name),
          favorite: vm.favorite,
          winLossCount: vm.winLossCount,
          buildWinRates: vm.buildWinRates,
          isCurrentBuild: _isCurrentBuild,
          buildNumber: _buildNumber, buildSwitch: () {
        setState(() {
          _isCurrentBuild = !_isCurrentBuild;
          _buildNumber = (_isCurrentBuild ? vm.currentBuild : vm.previousBuild)
              .fullVersion;
        });
      });
    });
  }
}

class _ViewModel {
  final Hero hero;
  final dynamic favorite;
  final WinLossCount winLossCount;
  final BuildWinRates buildWinRates;
  final Patch currentBuild;
  final Patch previousBuild;

  _ViewModel(
      {@required this.hero,
      @required this.favorite,
      this.winLossCount,
      this.buildWinRates,
      this.currentBuild,
      this.previousBuild});

  factory _ViewModel.from(Store<AppState> store, int id, String buildNumber) {
    final dynamic _favorite = (Hero hero) {
      hero.is_favorite ? unFavorite(store, hero) : setFavorite(store, hero);
    };

    final hero = heroSelectorByCompanionId(heroesSelector(store.state), id);
    // TODO Wrap win loss count to have a sensible model in app
    final winLossCount =
        winLossCountByCompanionIdAndBuildNumber(store.state, id, buildNumber);
    final buildWinRates =
        buildWinRatesByCompanionIdAndBuildNumber(store.state, id, buildNumber);

    return new _ViewModel(
      hero: hero.value,
      favorite: _favorite,
      winLossCount: winLossCount.isPresent ? winLossCount.value : null,
      buildWinRates: buildWinRates.isPresent ? buildWinRates.value : null,
      currentBuild: currentBuildSelector(store.state),
      previousBuild: previousBuildSelector(store.state),
    );
  }
}
