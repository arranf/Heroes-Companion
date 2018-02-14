import 'package:flutter/material.dart';
import 'package:heroes_companion/routes.dart';

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
                        colorFilter: new ColorFilter.mode(Colors.black45, BlendMode.darken),
                        // colorFilter: new ColorFilter.mode(Colors.black, BlendMode.darken)
                      )
                    ),
                    child: new Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        new Text('Heroes Companion', style: Theme.of(context).textTheme.title.apply(color: Colors.white, fontSizeFactor: 1.2),),
                      ],
                    )
                  ),
                  new ListTile(
                    leading: new Icon(Icons.supervisor_account),
                    title: new Text('Heroes'),
                    onTap: () {
                      Navigator.of(context).pop();
                      Navigator.of(context).pushNamed(Routes.home);
                    },
                  ),
                  new ListTile(
                    leading: new Icon(Icons.dashboard),
                    title: new Text('Maps'),
                    onTap: () {
                      Navigator.of(context).pop();
                      Navigator.of(context).pushNamed(Routes.maps);
                    },
                  )
                ],
              ),
            );
  }
}