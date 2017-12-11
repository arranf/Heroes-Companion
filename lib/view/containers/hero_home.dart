import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:heroes_companion/redux/selectors/selectors.dart';
import 'package:heroes_companion/view/common/hero_list.dart';


import 'package:heroes_companion_data/heroes_companion_data.dart' as data;

import 'package:redux/redux.dart';
import 'package:heroes_companion/redux/state.dart';

class HeroHome extends StatelessWidget {
  HeroHome({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new StoreConnector<AppState, _ViewModel>(
      converter: _ViewModel.fromStore,
      builder: (context, vm) {
        return new HeroList(vm.heroes);
      },
    );
  }
}

class _ViewModel {
  final List<data.Hero> heroes;
  final bool loading;

  _ViewModel({
    @required this.heroes,
    @required this.loading,
  });

  static _ViewModel fromStore(Store<AppState> store) {
    return new _ViewModel(
      heroes: heroesSelector(store.state),
      loading: store.state.isLoading,
    );
  }
}