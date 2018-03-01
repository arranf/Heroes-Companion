import 'dart:async';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:heroes_companion/i18n/strings.dart';
import 'package:heroes_companion_data/heroes_companion_data.dart';
import 'package:url_launcher/url_launcher.dart';

class OverflowChoice {
  static const About = const OverflowChoice('About');
  static const Feedback = const OverflowChoice('Feedback');
  static const PatchNotes = const OverflowChoice('Read Patch Notes');
  static const HeroPatchNotes = const OverflowChoice('Hero Patch Notes');
  // Todo get a localised name with a getter
  final String name;

  static get values => [About, Feedback, PatchNotes];

  static Future handleChoice(OverflowChoice choice, BuildContext context,
      {String patchNotesUrl}) async {
    switch (choice) {
      case About:
        Settings settings = await DataProvider.settingsProvider.readSettings();
        TapGestureRecognizer tapGestureRecognizer = new TapGestureRecognizer();
        tapGestureRecognizer.onTap = () async {
          const String url = 'https://hots.dog';
          if (await canLaunch(url)) {
            await launch(url);
          } else {
            throw new Exception('Could not launch $url');
          }
        };
        DateTime lastUpdated = settings.currentUpdateOriginTime;
        showAboutDialog(
            context: context,
            applicationName: 'Heroes Companion',
            children: [
              new Text(
                  '${AppStrings.of(context).lastUpdated()}: ${lastUpdated.toLocal().year}-${lastUpdated.toLocal().month}-${lastUpdated.toLocal().day} ${lastUpdated.toLocal().hour.toString().padLeft(2, '0')}:${lastUpdated.toLocal().minute.toString().padLeft(2, '0')}'),
              new Text('${AppStrings.of(context).currentPatchVersion()} ${settings.updatePatch}'),
              new RichText(
                text: new TextSpan(
                    text: '${AppStrings.of(context).poweredByDataFrom()} ',
                    style: new TextStyle().apply(color: Colors.black),
                    children: [
                      new TextSpan(
                          text: 'hots.dog',
                          style: new TextStyle().apply(
                              color: Colors.blue,
                              decoration: TextDecoration.underline),
                          recognizer: tapGestureRecognizer)
                    ]),
              )
            ]);
        break;
      case Feedback:
        const String url =
            'mailto:feedback@heroescompanion.com?subject=Feedback&body=';
        if (await canLaunch(url)) {
          await launch(url);
        } else {
          throw new Exception('Could not launch $url');
        }
        break;
      case HeroPatchNotes:
      case PatchNotes:
        String url = patchNotesUrl;
        if (url == null || url.isEmpty) {
          throw new Exception('Could get patch notes URL');
        }
        url = 'https://' + url;
        if (await canLaunch(url)) {
          await launch(url);
        } else {
          throw new Exception('Could not launch $url');
        }
        break;
      default:
        throw new Exception('Not an overflow choice');
    }
  }

  const OverflowChoice(this.name);
}
