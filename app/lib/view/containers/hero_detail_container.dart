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
  final int heroId;

  @override
  _HeroDetailContainerState createState() =>
      new _HeroDetailContainerState(heroId);

  HeroDetailContainer(this.heroId)
      : super(
            key: new Key(
                Routes.heroDetail + '_' + heroId.toString()));
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
    return new StoreBuilder<AppState>(
    builder: (context, store) {
      fetchData(store);
      _ViewModel vm =
          new _ViewModel.from(store, _heroesCompanionId, _buildNumber);
      return new HeroDetail(vm.hero,
          key: new Key(vm.hero.short_name),
          favorite: vm.favorite,
          canOfferPreviousBuild: vm.hero.last_modified != null && vm.previousBuild.liveDate.isAfter(vm.hero.last_modified),
          heroWinRate: vm.heroWinRate,
          buildWinRates: vm.buildWinRates,
          isCurrentBuild: _isCurrentBuild,
          buildNumber: _buildNumber, 
          heroPatchNotesUrl: vm.heroPatchNotesUrl,
          patch: (_isCurrentBuild ? vm.currentBuild : vm.previousBuild),
          buildSwitch: () {
            print(vm.previousBuild.fullVersion);
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
  final HeroWinRate heroWinRate;
  final BuildWinRates buildWinRates;
  final Patch currentBuild;
  final Patch previousBuild;
  final String heroPatchNotesUrl;

  _ViewModel(
      {@required this.hero,
      @required this.favorite,
      this.heroWinRate,
      this.buildWinRates,
      this.currentBuild,
      this.previousBuild,
      this.heroPatchNotesUrl});

  factory _ViewModel.from(Store<AppState> store, int id, String buildNumber) {
    final dynamic _favorite = (Hero hero) {
      hero.is_favorite ? unFavorite(store, hero) : setFavorite(store, hero);
    };

    final hero = heroSelectorByCompanionId(heroesSelector(store.state), id);
    if (hero.isNotPresent) {
      throw new Exception('No hero when optional unwrapped');
    }
    
    final heroWinRate = heroWinRateByHeroIdAndBuildNumber(store.state, id, buildNumber);
    final buildWinRates =
        buildWinRatesByCompanionIdAndBuildNumber(store.state, id, buildNumber);
    final String heroPatchNotesUrl = currentPatchUrlForHero(store.state, hero.value);
    return new _ViewModel(
      hero: hero.value,
      favorite: _favorite,
      heroWinRate: heroWinRate.isPresent ? heroWinRate.value : null,
      buildWinRates: buildWinRates.isPresent ? buildWinRates.value : null,
      currentBuild: currentBuildSelector(store.state),
      previousBuild: previousBuildSelector(store.state),
      heroPatchNotesUrl: heroPatchNotesUrl,
    );
  }
}
