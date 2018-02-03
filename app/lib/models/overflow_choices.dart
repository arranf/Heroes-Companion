import 'dart:async';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:heroes_companion_data/heroes_companion_data.dart'
    as shared_pref_keys;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class OverflowChoice {
  static const About = const OverflowChoice('About');
  static const Feedback = const OverflowChoice('Feedback');
  static const PatchNotes = const OverflowChoice('Read Patch Notes');
  static const HeroPatchNotes = const OverflowChoice('Hero Patch Notes');
  final String name;

  static get values => [About, Feedback, PatchNotes];

  static Future handleChoice(OverflowChoice choice, BuildContext context, {String patchNotesUrl}) async {
    switch (choice) {
      case About:
        TapGestureRecognizer tapGestureRecognizer = new TapGestureRecognizer();
        tapGestureRecognizer.onTap = () async {
          const String url = 'https://hots.dog';
          if (await canLaunch(url)) {
            await launch(url);
          } else {
            throw new Exception('Could not launch $url');
          }
        };
        SharedPreferences preferences = await SharedPreferences.getInstance();
        DateTime lastUpdated =
            DateTime.parse(preferences.getString(shared_pref_keys.update_id));
        String patchVersion =
            preferences.getString(shared_pref_keys.update_patch);
        showAboutDialog(
            context: context,
            applicationName: 'Heroes Companion',
            children: [
              new Text(
                  'Last Updated ${lastUpdated.toLocal().year}-${lastUpdated.toLocal().month}-${lastUpdated.toLocal().day} ${lastUpdated.toLocal().hour.toString().padLeft(2, '0')}:${lastUpdated.toLocal().minute.toString().padLeft(2, '0')}'),
              new Text('Current Patch Version $patchVersion'),
              new RichText(
                text: new TextSpan(
                    text: 'Powered by data from ',
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
        if (url == null || url.isEmpty){
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
