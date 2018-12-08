import 'package:flutter/material.dart' hide Hero;
import 'package:flutter_redux/flutter_redux.dart';
import 'package:heroes_companion/redux/selectors/selectors.dart';
import 'package:heroes_companion/redux/state.dart';
import 'package:heroes_companion/routes.dart';
import 'package:heroes_companion/services/build_service.dart';
import 'package:heroes_companion/services/heroes_service.dart';
import 'package:heroes_companion/services/win_rates_service.dart';
import 'package:heroes_companion/view/hero_detail/hero_detail.dart';
import 'package:heroes_companion_data/heroes_companion_data.dart';
import 'package:meta/meta.dart';
import 'package:redux/redux.dart';

class HeroDetailContainer extends StatefulWidget {
  final int heroId;

  @override
  _HeroDetailContainerState createState() => new _HeroDetailContainerState();

  HeroDetailContainer(this.heroId)
      : super(key: new Key(Routes.heroDetail + '_' + heroId.toString()));
}

class _HeroDetailContainerState extends State<HeroDetailContainer> {
  bool _isCurrentBuildDirty = false;
  bool _isCurrentPatch = true;
  Patch _patch;

  Patch getCorrectBuild(Store<AppState> store) {
    return _isCurrentPatch
        ? currentPatchSelector(store.state)
        : previousPatchSelector(store.state);
  }

  void fetchData(Store<AppState> store) {
    // Ensure if we're missing data we still show something
    if (!_isCurrentBuildDirty) {
      Patch currentPatch = currentPatchSelector(store.state);
      if (currentPatch != null) {
        int differenceInDays =
            currentPatch.liveDate.difference(new DateTime.now()).inDays;
        // If a newish patch - let's show previous patch data
        _isCurrentPatch = (differenceInDays * -1) > 5;
        _isCurrentBuildDirty = true;
      }
    }

    // If we're loading don't requery
    if (isAppLoading(store.state)) {
      return;
    }

    _patch = getCorrectBuild(store);
    if (winRatesByBuildNumber(store.state, _patch.fullVersion).isNotPresent) {
      getWinRatesForBuild(store, _patch);
    }

    Optional<Hero> hero =
        heroSelectorByHeroId(heroesSelector(store.state), widget.heroId);
    if (hero.isNotPresent) {
      throw new Exception('Hero selected that\'s not in database');
    }

    if (statisticalBuildsByHeroIdAndBuildNumber(
            store.state, hero.value.hero_id, _patch.fullVersion)
        .isNotPresent) {
      getStatisticalBuilds(store, hero.value, _patch);
    }

    if (regularBuildsByHeroId(store.state, hero.value.hero_id).isNotPresent) {
      getBuilds(store, hero.value, _patch);
    }
  }

  @override
  Widget build(BuildContext context) {
    return new StoreBuilder<AppState>(builder: (context, store) {
      fetchData(store);
      _ViewModel vm = new _ViewModel.from(
          store, widget.heroId, _patch ?? getCorrectBuild(store));
      return new HeroDetail(vm.hero,
          key: new Key(vm.hero.short_name),
          favorite: vm.favorite,
          canOfferPreviousBuild: vm.hero.last_modified != null &&
              vm.previousBuild.liveDate.isAfter(vm.hero.last_modified),
          heroWinRate: vm.heroWinRate,
          statisticalBuilds: vm.buildWinRates,
          regularBuilds: vm.regularBuilds,
          isCurrentBuild: _isCurrentPatch,
          heroPatchNotesUrl: vm.heroPatchNotesUrl,
          patch: (_isCurrentPatch ? vm.currentBuild : vm.previousBuild),
          buildSwitch: () {
        setState(() {
          _isCurrentPatch = !_isCurrentPatch;
          _patch = (_isCurrentPatch ? vm.currentBuild : vm.previousBuild);
        });
      });
    });
  }
}

class _ViewModel {
  final Hero hero;
  final dynamic favorite;
  final HeroWinRate heroWinRate;
  final List<StatisticalHeroBuild> buildWinRates;
  final Patch currentBuild;
  final Patch previousBuild;
  final String heroPatchNotesUrl;
  final List<Build> regularBuilds;

  _ViewModel({
    @required this.hero,
    @required this.favorite,
    this.heroWinRate,
    this.buildWinRates,
    this.currentBuild,
    this.previousBuild,
    this.heroPatchNotesUrl,
    this.regularBuilds,
  });

  factory _ViewModel.from(Store<AppState> store, int id, Patch patch) {
    final dynamic _favorite = (Hero hero) {
      hero.is_favorite ? unFavorite(store, hero) : setFavorite(store, hero);
    };

    final hero = heroSelectorByHeroId(heroesSelector(store.state), id);
    if (hero.isNotPresent) {
      throw new Exception('No hero when optional unwrapped');
    }

    final heroWinRate =
        heroWinRateByHeroIdAndBuildNumber(store.state, id, patch.fullVersion);
    final Optional<List<StatisticalHeroBuild>> buildWinRates =
        statisticalBuildsByHeroIdAndBuildNumber(
            store.state, id, patch.fullVersion);

    final Optional<List<Build>> regularBuilds =
        regularBuildsByHeroId(store.state, id);
    final String heroPatchNotesUrl =
        currentPatchUrlForHero(store.state, hero.value);

    return new _ViewModel(
      hero: hero.value,
      favorite: _favorite,
      heroWinRate: heroWinRate.isPresent ? heroWinRate.value : null,
      buildWinRates: buildWinRates.isPresent ? buildWinRates.value : null,
      regularBuilds: regularBuilds.isPresent ? regularBuilds.value : null,
      currentBuild: currentPatchSelector(store.state),
      previousBuild: previousPatchSelector(store.state),
      heroPatchNotesUrl: heroPatchNotesUrl,
    );
  }
}
