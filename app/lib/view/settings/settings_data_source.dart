import 'package:flutter/material.dart';
import 'package:heroes_companion_data/heroes_companion_data.dart';
class SettingsDataSource extends StatefulWidget {
  _SettingsDataSourceState createState() => new _SettingsDataSourceState();
}

class _SettingsDataSourceState extends State<SettingsDataSource> {
  DataSource _dataSource = DataSource.HotsDog;
  Settings _settings;

  @override
  void initState() {
    super.initState();
    DataProvider.settingsProvider.readSettings()
    .then((Settings settings) {
      setState(() {
        _settings = settings;
        _dataSource = settings.dataSource;
      });
    });
  }

  @override
  Widget build(BuildContext context) {

    dynamic onChanged = (DataSource value) { Settings settings = _settings.copyWith(dataSource: value); DataProvider.settingsProvider.writeSettings(settings); setState(() { _settings = settings; _dataSource = settings.dataSource; }); };

    return new Scaffold(
      appBar: new AppBar(
        title: const Text('Data Source')
      ),
      body: new Column(
      children: <Widget>[
        new RadioListTile<DataSource>(
          title: new Text(DataSource.HotsDog.name),
          value: DataSource.HotsDog,
          groupValue: _dataSource,
          onChanged: onChanged,
        ),
        new RadioListTile<DataSource>(
          title: new Text(DataSource.HotsLogs.name),
          value: DataSource.HotsLogs,
          groupValue: _dataSource,
          onChanged: onChanged,
        ),
      ],
    )
    );
  }
}