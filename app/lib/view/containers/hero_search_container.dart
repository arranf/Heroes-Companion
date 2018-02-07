import 'package:flutter/material.dart' hide Hero;
import 'package:flutter_redux/flutter_redux.dart';
import 'package:heroes_companion/redux/actions/actions.dart';
import 'package:heroes_companion/redux/selectors/selectors.dart';
import 'package:heroes_companion/redux/state.dart';
import 'package:heroes_companion/routes.dart';
import 'package:heroes_companion/view/common/empty_state.dart';
import 'package:heroes_companion/view/common/hero_list.dart';
import 'package:heroes_companion/view/common/hero_list_item.dart';
import 'package:heroes_companion/view/containers/hero_detail_container.dart';
import 'package:heroes_companion_data/heroes_companion_data.dart';
import 'package:meta/meta.dart';
import 'package:redux/redux.dart';

class HeroSearch extends StatelessWidget {
  HeroSearch() : super(key: Routes.heroDetailKey);

  @override
  Widget build(BuildContext context) {
    return new StoreConnector<AppState, _ViewModel>(
        onInit: (store) {},
        onDispose: (store) {
          store.dispatch(new ClearSearchQueryAction());
        },
        converter: (Store<AppState> store) => new _ViewModel.from(store),
        builder: (context, vm) {
          return new Scaffold(
              appBar: new AppBar(
                title: new Container(
                  padding: new EdgeInsets.only(right: 12.0),
                  child: new TextField(
                      onChanged: (query) => vm.onSearchType(query),
                      autofocus: true,
                      decoration: new InputDecoration(
                        hintText: "Search heroes...",
                        hintStyle: new TextStyle(
                          color: new Color.fromARGB(120, 255, 255, 255),
                          fontSize: 18.0,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                      style: new TextStyle(
                          color: Colors.white,
                          fontSize: 18.0,
                          fontWeight: FontWeight.normal)),
                ),
              ),
              body: vm.searchQuery.length > 0
                  ? new HeroList(vm.results, onTap: vm.onTap)
                  : new EmptyState(Icons.search));
        });
  }
}

class _ViewModel {
  final List<Hero> results;
  final String searchQuery;
  final dynamic onSearchType;
  final dynamic onTap;

  _ViewModel({
    @required this.results,
    @required this.searchQuery,
    @required this.onSearchType,
    this.onTap,
  });

  factory _ViewModel.from(Store<AppState> store) {
    final dynamic onSearchType = (String query) {
      store.dispatch(new SetSearchQueryAction(query));
    };

    final dynamic onTap = (BuildContext context, HeroListItem item) {
      Navigator.of(context).pushReplacement(new PageRouteBuilder(
          pageBuilder: (context, a1, a2) =>
              new HeroDetailContainer(item.hero.heroes_companion_hero_id)));
    };

    final results = searchSelector(store.state);
    final searchQuery = searchQuerySelector(store.state);
    return new _ViewModel(
        results: results,
        searchQuery: searchQuery,
        onSearchType: onSearchType,
        onTap: onTap);
  }
}
