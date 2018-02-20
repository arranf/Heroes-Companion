import 'package:flutter/material.dart';
import 'package:heroes_companion/routes.dart';
class Settings extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: const Text('Settings')
      ),
      body: new ListView(
        padding: const EdgeInsets.symmetric(vertical: 20.0),
        children: [
          new ListTile(
            leading: const Icon(Icons.cloud_download),
            title: new Text('Data Source'),
            subtitle: new Text('Current: hots.dog'),
            onTap: () => Navigator.of(context).pushNamed(Routes.settingsDataSource),
          )
        ],
      )
    );
  }
}