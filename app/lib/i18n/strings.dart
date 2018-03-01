import 'dart:async';

import 'package:intl/intl.dart';
import 'package:flutter/widgets.dart';

import 'messages_all.dart';

// Information about how this file relates to i18n/messages.dart and how the i18n files
// were generated can be found in i18n/regenerate.md.

class AppStrings {
  AppStrings(Locale locale) : _localeName = locale.toString();

  final String _localeName;

  static Future<AppStrings> load(Locale locale) {
    return initializeMessages(locale.toString())
      .then((Object _) {
        return new AppStrings(locale);
      });
  }

  static AppStrings of(BuildContext context) {
    return Localizations.of<AppStrings>(context, AppStrings);
  }

  String title() {
    return Intl.message(
      'Heroes Companion',
      name: 'title',
      desc: 'Title for the Heroes Companion application',
      locale: _localeName,
    );
  }

  String about() => Intl.message(
    'About',
    name: 'about',
    desc: 'Label for the about drawer option',
    locale: _localeName,
  );

  String sendFeedback() => Intl.message(
    'Send Feedback',
    name: 'sendFeedback',
    desc: 'Label for the Send Feedback drawer option',
    locale: _localeName,
  );

  String readPatchNotes() => Intl.message(
    'Read Patch Notes',
    name: 'readPatchNotes',
    desc: 'Label for the read patch notes overflow menu option on the home screen',
    locale: _localeName,
  );

  String heroPatchNotes() => Intl.message(
    'Hero Patch Notes',
    name: 'heroPatchNotes',
    desc: 'Label for the hero patch notes overflow menu option on the hero screen',
    locale: _localeName,
  );

  String lastUpdated() => Intl.message(
    'Last Updated',
    name: 'lastUpdated',
    locale: _localeName,
  );

  String currentPatchVersion() => Intl.message(
    'Current Patch Version',
    name: 'currentPatchVersion',
    locale: _localeName,
  );

  String poweredByDataFrom() => Intl.message(
    'Powered By data from',
    name: 'poweredByDataFrom',
    desc: 'The list of places data is obtained from',
    locale: _localeName,
  );

  String all() => Intl.message(
    'All',
    name: 'all',
    desc: 'The label for showing all heroes on the home screen',
    locale: _localeName,
  );

  String favorite() => Intl.message(
    'Favorite',
    name: 'favorite',
    desc: 'The label for showing favorite heroes on the home screen',
    locale: _localeName,
  );

  String freeToPlay() => Intl.message(
    'Free to Play',
    name: 'freeToPlay',
    desc: 'The label for showing free to play heroes on the home screen',
    locale: _localeName,
  );

  String noFavorites() => Intl.message(
    'No Favorites',
    name: 'noFavorites',
    desc: 'The header text displayed where there are no favorite heroes in the app',
    locale: _localeName,
  );

  String favoritedHeroesWillAppearHere() => Intl.message(
    'Favorited Heroes Will Appear Here',
    name: 'favoritedHeroesWillAppearHere',
    desc: 'The subtitle text displayed when there are no favorited heroes',
    locale: _localeName,
  );

  String searchHeroes() => Intl.message(
    'Search heroes',
    name: 'searchHeroes',
    desc: 'The hint text displayed in the empty search box.',
    locale: _localeName,
  );

  String showingPreviousPatchData() => Intl.message(
    'Showing previous patch data',
    name: 'showingPreviousPatchData',
    desc: 'The text shown when previous patch data is being displayed',
    locale: _localeName,
  );

  String gamesPlayed() => Intl.message(
    'games played',
    name: 'gamesPlayed',
    desc: 'The suffix text displayed after the number of games played for a hero',
    locale: _localeName,
  );

  String statisticalBuilds() => Intl.message(
    'Statistical Builds',
    name: 'statisticalBuilds',
    desc: 'The label text for the statistical builds tab.',
    locale: _localeName,
  );

  String recommendedBuilds() => Intl.message(
    'Recommended Builds',
    name: 'recommendedBuilds',
    desc: 'The label text for the recommended builds tab.',
    locale: _localeName,
  );

  String sortByPopularity() => Intl.message(
    'Sort by Popularity',
    name: 'sortByPopularity',
    desc: 'The sort option for most popular builds',
    locale: _localeName,
  );

  String sortByWinRate() => Intl.message(
    'Sort by Win Rate',
    name: 'sortByWinRate',
    desc: 'The sort option for the most succesful builds',
    locale: _localeName,
  );

  String seePreviousPatchData() => Intl.message(
    'See Previous Patch Data',
    name: 'seePreviousPatchData',
    desc: 'The overflow text for the option to switch to the previous patch\'s data',
    locale: _localeName,
  );

  String seeCurrentPatchData() => Intl.message(
    'See Current Patch Data',
    name: 'seeCurrentPatchData',
    desc: 'The overflow text for the option to switch to the current patch\'s data',
    locale: _localeName,
  );

  String noDataAvailable() => Intl.message(
    'No Data Available',
    name: 'noDataAvailable',
    desc: 'The error text title for when no data can be found for a particular hero',
    locale: _localeName,
  );

  String noStatisticalDataFound() => Intl.message(
    'No statistical data found for this hero',
    name: 'noStatisticalDataFound',
    desc: 'The error text subtitle for when no data can be found for a particular hero',
    locale: _localeName,
  );

  String dataSource() => Intl.message(
    'Data Source',
    name: 'dataSource',
    desc: 'The place where data comes from i.e. hots.dog or hotslogs.com',
    locale: _localeName,
  );

  String settingUpdateOnNextLaunch() => Intl.message(
    'This setting will update next time you launch the app.',
    name: 'settingUpdateOnNextLaunch',
    desc: 'The prompt text that informs the user that the changed setting won\'t reflect in the app until it is launched again.',
    locale: _localeName,
  );

  String theme() => Intl.message(
    'Theme',
    name: 'theme',
    desc: 'Theme, the colour scheme for the app',
    locale: _localeName,
  );

  String light() => Intl.message(
    'Light',
    name: 'light',
    desc: 'Light theme',
    locale: _localeName,
  );

  String dark() => Intl.message(
    'Dark',
    name: 'dark',
    desc: 'Dark theme',
    locale: _localeName,
  );

  String current() => Intl.message(
    'Current',
    name: 'current',
    desc: 'Used in the context of the current option for a setting. i.e. Current: Light',
    locale: _localeName,
  );

  String heroes() => Intl.message(
    'Heroes',
    name: 'heroes',
    locale: _localeName,
  );

  String settings() => Intl.message(
    'Settings',
    name: 'settings',
    locale: _localeName,
  );

  String goBack() => Intl.message(
    'Go back',
    name: 'goBack',
    desc: 'Tooltip for the button that goes to the hero page when playing a build ',
    locale: _localeName,
  );

  String goToFirstTalent() => Intl.message(
    'Go to first talent',
    name: 'goToFirstTalent',
    desc: 'Tooltip for the button that goes to the first talent when playing a build ',
    locale: _localeName,
  );

  String nextTalent() => Intl.message(
    'Next talent',
    name: 'nextTalent',
    desc: 'Tooltip for the button that goes to the next talent when playing a build ',
    locale: _localeName,
  );

  String previousTalent() => Intl.message(
    'Previous talent',
    name: 'previousTalent',
    desc: 'Tooltip for the button that goes to the next talent when playing a build ',
    locale: _localeName,
  );

  String unfavorite() => Intl.message(
    'Unfavorite',
    name: 'unfavorite',
    desc: 'The tooltip for the button that removes a hero from the list of favorites',
    locale: _localeName,
  );

  String favoriteTooltip() => Intl.message(
    'Favorite',
    name: 'favoriteTooltip',
    desc: 'The tooltip for the button that adds a hero to the list of favorites',
    locale: _localeName,
  );

  String win() => Intl.message(
    'Win',
    name: 'win',
    desc: 'Used to describes the win percentage of a hero i.e. 51 Win %',
    locale: _localeName,
  );
}