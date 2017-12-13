import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart' hide Hero;
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

import 'package:heroes_companion_data/heroes_companion_data.dart';

import 'package:heroes_companion/redux/selectors/selectors.dart';
import 'package:heroes_companion/view/common/hero_list.dart';
import 'package:heroes_companion/redux/state.dart';
import 'package:heroes_companion/services/heroes_service.dart';

class HeroHome extends StatelessWidget {
  HeroHome({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new StoreConnector<AppState, _ViewModel>(
      converter: _ViewModel.fromStore,
      builder: (context, vm) {
        return new HeroList(vm.heroes, vm.favorite);
      },
    );
  }
}

class _ViewModel {
  final List<Hero> heroes;
  final bool loading;
  final dynamic favorite;

  _ViewModel({
    @required this.heroes,
    @required this.loading,
    this.favorite,
  });

  static _ViewModel fromStore(Store<AppState> store) {
    final dynamic _favorite = (Hero hero) {
      hero.is_favorite ? unFavorite(store, hero) : setFavorite(store, hero);
    };
    return new _ViewModel(
      heroes: heroesSelector(store.state),
      loading: store.state.isLoading,
      favorite: _favorite
    );
  }
}