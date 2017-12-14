import 'package:flutter/material.dart' hide Hero;
import 'package:flutter_redux/flutter_redux.dart';
import 'package:heroes_companion/redux/selectors/selectors.dart';
import 'package:heroes_companion/redux/state.dart';
import 'package:heroes_companion/routes.dart';
import 'package:heroes_companion/view/common/hero_detail.dart';
import 'package:heroes_companion_data/heroes_companion_data.dart';
import 'package:meta/meta.dart';
import 'package:redux/redux.dart';

class HeroDetailContainer extends StatelessWidget { 
  final int heroes_companion_id;

  HeroDetailContainer(this.heroes_companion_id) : super(key: Routes.heroDetailKey);

  @override
  Widget build(BuildContext context) {
    return new StoreConnector<AppState, _ViewModel>(
      ignoreChange: (state) => heroSelectorByCompanionId(state.heroes, heroes_companion_id).isNotPresent,
      converter: (Store<AppState> store) => new _ViewModel.from(store, heroes_companion_id),
      builder: (context, vm) {
        return new HeroDetail(vm.hero);
      } 
    );
  }
}

class _ViewModel {
  final Hero hero;

  _ViewModel({
    @required this.hero
  });

  factory _ViewModel.from(Store<AppState> store, int id) {
    final hero = heroSelectorByCompanionId(heroesSelector(store.state), id);

    return new _ViewModel(
      hero: hero.value,
    );
  }
}