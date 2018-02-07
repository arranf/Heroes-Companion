import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart' hide Hero;
import 'package:flutter_redux/flutter_redux.dart';
import 'package:heroes_companion/models/hero_filter.dart';
import 'package:heroes_companion/models/overflow_choices.dart';
import 'package:heroes_companion/redux/actions/actions.dart';
import 'package:heroes_companion/routes.dart';
import 'package:heroes_companion/view/common/empty_favorite_list.dart';
import 'package:heroes_companion/view/common/empty_state.dart';
import 'package:heroes_companion/view/common/hero_list_item.dart';
import 'package:heroes_companion/view/containers/hero_detail_container.dart';
import 'package:redux/redux.dart';

import 'package:heroes_companion/icons.dart' as HeroesIcons;

import 'package:heroes_companion_data/heroes_companion_data.dart';

import 'package:heroes_companion/redux/selectors/selectors.dart';
import 'package:heroes_companion/view/common/hero_list.dart';
import 'package:heroes_companion/redux/state.dart';
import 'package:heroes_companion/services/heroes_service.dart';
import 'package:heroes_companion/global_keys.dart';

class HeroHome extends StatelessWidget {
  HeroHome({Key key}) : super(key: key);

  final List<OverflowChoice> overflowChoices = [
    OverflowChoice.About,
    OverflowChoice.PatchNotes,
    OverflowChoice.Feedback,
  ];

  @override
  Widget build(BuildContext context) {
    return new StoreConnector<AppState, _ViewModel>(
      converter: _ViewModel.fromStore,
      builder: (context, vm) {
        return new Scaffold(
            key: homeScaffoldKey,
            appBar: new AppBar(
              title: new Text('Heroes Companion'),
              actions: <Widget>[
                new PopupMenuButton(
                  onSelected: (OverflowChoice choice) => OverflowChoice
                      .handleChoice(choice, context, patchNotesUrl: vm.patchNotesUrl), // overflow menu
                  itemBuilder: (BuildContext context) {
                    return overflowChoices.map((OverflowChoice choice) {
                      return new PopupMenuItem(
                        value: choice,
                        child: new Text(choice.name),
                      );
                    }).toList();
                  },
                ),
              ],
            ),
            body:
            // Favorite list and no favorite heroes
                vm.currentFilter == HeroFilter.favorite && vm.heroes.isEmpty
                    ? new EmptyState(Icons.favorite, 'No Favorites', 'Favorited Heroes Will Appear Here') : new HeroList(vm.heroes,
                        onTap: vm.onTap,
                        onLongPress: vm.onLongPress,
                        onRefresh: vm.onRefresh,
                        allowRefresh: vm.allowRefresh),
            floatingActionButton: new FloatingActionButton(
              child: new Icon(Icons.search),
              onPressed: () => Navigator.of(context).pushNamed(Routes.search),
              backgroundColor: Theme.of(context).accentColor,
            ),
            bottomNavigationBar: new BottomNavigationBar(
              currentIndex: vm.currentFilter.index,
              items: [
                new BottomNavigationBarItem(
                    icon: new Icon(Icons.all_inclusive),
                    title: new Text('All')),
                new BottomNavigationBarItem(
                    icon: new Icon(Icons.favorite),
                    title: new Text('Favorite')),
                new BottomNavigationBarItem(
                  icon: new Icon(HeroesIcons.hexagon),
                  title: new Text('Free to Play'),
                ),
              ],
              onTap: (index) => vm.bottomNavTap(index),
            ));
      },
    );
  }
}

class _ViewModel {
  final List<Hero> heroes;
  final bool loading;
  final HeroFilter currentFilter;
  final Function onLongPress;
  final dynamic bottomNavTap;
  final Function onRefresh;
  final bool allowRefresh;
  final String patchNotesUrl;
  final Function onTap = (BuildContext context, HeroListItem heroListItem) {
    Navigator.of(context).push(new PageRouteBuilder(
          pageBuilder: (context, a1, a2) => new HeroDetailContainer(
              heroListItem.hero.heroes_companion_hero_id),
        ));
  };

  _ViewModel(
      {@required this.heroes,
      @required this.loading,
      this.patchNotesUrl,
      this.onLongPress,
      this.bottomNavTap,
      this.currentFilter,
      this.onRefresh,
      this.allowRefresh = false});

  static _ViewModel fromStore(Store<AppState> store) {
    final Function _favorite = (BuildContext context, HeroListItem item) {
      item.hero.is_favorite
          ? unFavorite(store, item.hero)
          : setFavorite(store, item.hero);
    };

    final dynamic _bottomNavTap = (int index) {
      HeroFilter filter = HeroFilter.values
          .firstWhere((v) => v.index == index, orElse: () => HeroFilter.all);
      store.dispatch(new SetFilterAction(filter));
    };

    HeroFilter filter = filterSelector(store.state);

    String patchNotesUrl = currentBuildSelector(store.state).patchNotesUrl;

    bool allowRefresh = false;
    Function onRefresh = () => true;
    if (filter == HeroFilter.freeToPlay) {
      allowRefresh = true;
      onRefresh = () {
        debugPrint('On Refresh');
        return getHeroesAsync(store, isForceRefreshRotation: true);
      };
    }

    List<Hero> heroes = heroesbyFilterSelector(store.state);

    if (heroes == null) {
      throw new Exception('Heroes selector is null');
    }

    return new _ViewModel(
        heroes: heroes,
        loading: store.state.isLoading,
        onLongPress: _favorite,
        bottomNavTap: _bottomNavTap,
        currentFilter: filterSelector(store.state),
        onRefresh: onRefresh,
        patchNotesUrl: patchNotesUrl,
        allowRefresh: allowRefresh);
  }
}
