import 'dart:async';

import 'package:flutter/material.dart' hide Hero;
import 'package:flutter/services.dart';
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
  _HeroDetailContainerState createState() => new _HeroDetailContainerState(heroesCompanionId);

  HeroDetailContainer(this.heroesCompanionId) : super(key: Routes.heroDetailKey);
}

class _HeroDetailContainerState extends State<HeroDetailContainer> {
  static final _platform = const MethodChannel('com.heroescompanion.app/screen');
  bool _isCurrentBuild = true;
  final int _heroesCompanionId;
  String _buildNumber = '';

  _HeroDetailContainerState(this._heroesCompanionId);

  // TODO Move these somewhere else
  Future _setScreenNoSleep() async {
    try {
      await _platform.invokeMethod('setScreenNoSleep');
    } on PlatformException catch (e) {
      debugPrint(e.toString());
    }
  }

  Future _setScreenCanSleep() async {
    try {
      await _platform.invokeMethod('setScreenCanSleep');
    } on PlatformException catch (e) {
      debugPrint(e.toString());
    }
  }

  void fetchData(Store<dynamic> store) {
    if (isAppLoading(store.state)) {
      return;
    }
    _buildNumber = (_isCurrentBuild ? currentBuildSelector(store.state) : previousBuildSelector(store.state)).number;
    if (winRatesByBuildNumber(store.state, _buildNumber).isNotPresent) {
      getWinRatesForBuild(store, _buildNumber);
    }
    Optional<Hero> hero = heroSelectorByCompanionId(
        heroesSelector(store.state), _heroesCompanionId);
    if (hero.isPresent && buildWinRatesByCompanionIdAndBuildNumber(store.state, hero.value.heroes_companion_hero_id, _buildNumber).isNotPresent) {
      getHeroBuildWinRates(store, hero.value, _buildNumber);
    }
  }

  @override
  Widget build(BuildContext context) {
    debugPrint('Building!');
    return new StoreConnector<AppState, _ViewModel>(
        onInit: (store) {
          fetchData(store);
          _setScreenNoSleep();
        },
        onDispose: (store) {
          _setScreenCanSleep();
        },
        ignoreChange: (state) =>
            heroSelectorByCompanionId(state.heroes, _heroesCompanionId)
                .isNotPresent,
        converter: (Store<AppState> store) {
          if (!isAppLoading(store.state)){
            debugPrint('Fetching data in convertor');
            fetchData(store);
          }
          debugPrint('Convertor');
          return new _ViewModel.from(store, _heroesCompanionId, _buildNumber);
        },
        builder: (context, vm) {
          void _handleTap() {
            setState(() {
              debugPrint('set state');
              _isCurrentBuild = !_isCurrentBuild;
              _buildNumber = (_isCurrentBuild ? vm.currentBuild : vm.previousBuild).number;
            });
          }
          return new HeroDetail(
            vm.hero,
            favorite: vm.favorite,
            winLossCount: vm.winLossCount,
            buildWinRates: vm.buildWinRates,
            isCurrentBuild: _isCurrentBuild,
            buildNumber: _buildNumber,
            buildSwitch: _handleTap
          );
        }
    );
  }
}

class _ViewModel {
  final Hero hero;
  final dynamic favorite;
  final WinLossCount winLossCount;
  final BuildWinRates buildWinRates;
  final BuildInfo currentBuild;
  final BuildInfo previousBuild;

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
    final winLossCount = winLossCountByCompanionIdAndBuildNumber(store.state, id, buildNumber);
    final buildWinRates = buildWinRatesByCompanionIdAndBuildNumber(store.state, id, buildNumber);

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
