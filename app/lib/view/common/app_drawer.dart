import 'package:flutter/material.dart';
import 'package:heroes_companion/models/overflow_choices.dart';
import 'package:heroes_companion/routes.dart';
import 'package:heroes_companion/view/i18n/strings.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Drawer(
      child: new ListView(
        children: <Widget>[
          new DrawerHeader(
              decoration: new BoxDecoration(
                  image: new DecorationImage(
                image: new AssetImage('assets/images/maiev_1280x1024.jpg'),
                fit: BoxFit.cover,
                colorFilter:
                    new ColorFilter.mode(Colors.black45, BlendMode.darken),
                // colorFilter: new ColorFilter.mode(Colors.black, BlendMode.darken)
              )),
              child: new Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  new Text(
                    'Heroes Companion',
                    style: Theme
                        .of(context)
                        .textTheme
                        .title
                        .apply(color: Colors.white),
                  ),
                  // new Text('Patch 3.0', style: Theme.of(context).textTheme.body1.apply(color: Colors.white),)
                ],
              )),
          new ListTile(
            leading: new Icon(Icons.supervisor_account),
            title: new Text(AppStrings.of(context).heroes()),
            onTap: () {
              Navigator.popAndPushNamed(context, Routes.home);
            },
          ),
          // new ListTile(
          //   leading: new Icon(Icons.dashboard),
          //   title: new Text('Maps'),
          //   // onTap: () {
          //   //   Navigator.of(context).pop();
          //   //   Navigator.of(context).pushNamed(Routes.maps);
          //   // },
          // ),
          const Divider(),
          new ListTile(
            leading: const Icon(Icons.settings),
            title: new Text(AppStrings.of(context).settings(),),
            onTap: () => Navigator.popAndPushNamed(context, Routes.settings),
          ),
          new ListTile(
            leading: const Icon(Icons.report),
            title: new Text(AppStrings.of(context).feedback()),
            onTap: () =>
                OverflowChoice.handleChoice(OverflowChoice.Feedback, context),
          )
        ],
      ),
    );
  }
}
