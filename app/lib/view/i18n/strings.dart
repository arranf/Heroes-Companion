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

  String aboutPage() {
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

  String feedback() => Intl.message(
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
    name: 'lastUpdated'
  );

  String currentPatchVersion() => Intl.message(
    'Current Patch Version',
    name: 'currentPatchVersion'
  );

  String poweredBy() => Intl.message(
    'Powered By data from',
    name: 'poweredByDataFrom',
    desc: 'The list of places data is obtained from'
  );

  String all() => Intl.message(
    'All',
    name: 'all',
    desc: 'The label for showing all heroes on the home screen'
  );

  String favorite() => Intl.message(
    'Favorite',
    name: 'favorite',
    desc: 'The label for showing favorite heroes on the home screen'
  );

  String freeToPlay() => Intl.message(
    'Free to Play',
    name: 'freeToPlay',
    desc: 'The label for showing free to play heroes on the home screen'
  );

  String noFavorites() => Intl.message(
    'No Favorites',
    name: 'noFavorites',
    desc: 'The header text displayed where there are no favorite heroes in the app'
  );

  String favoritedHeroesWillAppearHere() => Intl.message(
    'Favorited Heroes Will Appear Here',
    name: 'favoritedHeroesWillAppearHere',
    desc: 'The subtitle text displayed when there are no favorited heroes'
  );

  String searchHeroes() => Intl.message(
    'Search heroes',
    name: 'searchHeroes',
    desc: 'The hint text displayed in the empty search box.'
  );

  String showingPreviousPatchData() => Intl.message(
    'Showing previous patch data',
    name: 'showingPreviousPatchData',
    desc: 'The text shown when previous patch data is being displayed'
  );

  String gamesPlayed() => Intl.message(
    'games played',
    name: 'gamesPlayed',
    desc: 'The suffix text displayed after the number of games played for a hero'
  );

  String statisticalBuilds() => Intl.message(
    'Statistical Builds',
    name: 'statisticalBuilds',
    desc: 'The label text for the statistical builds tab.'
  );

  String recommendedBuilds() => Intl.message(
    'Recommended Builds',
    name: 'recommendedBuilds',
    desc: 'The label text for the recommended builds tab.'
  );

  String sortByPopularity() => Intl.message(
    'Sort by Popularity',
    name: 'popularity',
    desc: 'The sort option for most popular builds'
  );

  String sortByWinRate() => Intl.message(
    'Sort by Win Rate',
    name: 'winRate',
    desc: 'The sort option for the most succesful builds'
  );

  String seePreviousPatchData() => Intl.message(
    'See Previous Patch Data',
    name: 'seePreviousPatchData',
    desc: 'The overflow text for the option to switch to the previous patch\'s data'
  );

  String seeCurrentPatchData() => Intl.message(
    'See Current Patch Data',
    name: 'seeCurrentPatchData',
    desc: 'The overflow text for the option to switch to the current patch\'s data'
  );

  String noDataAvailable() => Intl.message(
    'No Data Available',
    name: 'noDataAvailable',
    desc: 'The error text title for when no data can be found for a particular hero'
  );

  String noStatisticalDataFoundForThisHero() => Intl.message(
    'No statistical data found for this hero',
    name: 'noStatisticalDataFound',
    desc: 'The error text subtitle for when no data can be found for a particular hero'
  );

  String dataSource() => Intl.message(
    'Data Source',
    name: 'dataSource',
    desc: 'The place where data comes from i.e. hots.dog or hotslogs.com'
  );

  String thisSettingWillUpdateOnNextLaunch() => Intl.message(
    'This setting will update next time you launch the app.',
    name: 'settingUpdateOnNextLaunch',
    desc: 'The prompt text that informs the user that the changed setting won\'t reflect in the app until it is launched again.'
  );

  String theme() => Intl.message(
    'Theme',
    name: 'Theme',
    desc: 'Theme, the colour scheme for the app'
  );

  String light() => Intl.message(
    'Light',
    name: 'light',
    desc: 'Light theme'
  );

  String dark() => Intl.message(
    'Dark',
    name: 'dark',
    desc: 'Dark theme'
  );

  String current() => Intl.message(
    'Current',
    name: 'current',
    desc: 'Used in the context of the current option for a setting. i.e. Current: Light'
  );

  String heroes() => Intl.message(
    'Heroes',
    name: 'heroes'
  );

  String settings() => Intl.message(
    'Settings',
    name: 'settings'
  );

  String goBack() => Intl.message(
    'Go back',
    name: 'goBack',
    desc: 'Tooltip for the button that goes to the hero page when playing a build '
  );

  String goToFirstTalent() => Intl.message(
    'Go to first talent',
    name: 'goToFirstTalent',
    desc: 'Tooltip for the button that goes to the first talent when playing a build '
  );

  String nextTalent() => Intl.message(
    'Next talent',
    name: 'nextTalent',
    desc: 'Tooltip for the button that goes to the next talent when playing a build '
  );

  String previousTalent() => Intl.message(
    'Previous talent',
    name: 'previousTalent',
    desc: 'Tooltip for the button that goes to the next talent when playing a build '
  );

  String unfavorite() => Intl.message(
    'Unfavorite',
    name: 'unfavorite',
    desc: 'The tooltip for the button that removes a hero from the list of favorites'
  );

  String favoriteTooltip() => Intl.message(
    'Favorite',
    name: 'favorite',
    desc: 'The tooltip for the button that adds a hero to the list of favorites'
  );

  String win() => Intl.message(
    'Win',
    name: 'win',
    desc: 'Used to describes the win percentage of a hero i.e. 51 Win %'
  );
}