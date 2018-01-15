import 'dart:async';
import 'dart:convert';

import 'package:heroes_companion_data/src/api/DTO/heroes_companion_data.dart';
import 'package:heroes_companion_data/src/api/DTO/update_info.dart';
import 'package:heroes_companion_data/src/api/DTO/update_payload.dart';
import 'package:heroes_companion_data/src/providers/hero_provider.dart';
import 'package:http/http.dart' as http;

String _baseUrl = 'data.heroescompanion.com';
Utf8Decoder _utf8Decoder = new Utf8Decoder();

Map<String, String> _getHeaders() {
  return {
    "Accept": "application/json",
    "Content-Type": "application/json",
    "User-Agent": "Heroes Companion"
  };
}

String _getUtf8String(http.Response response) {
  return _utf8Decoder.convert(response.bodyBytes);
}

Future<HeroesCompanionData> getRotation() async {
  Uri uri = new Uri.https(_baseUrl, '/v1/rotation');
  http.Response response = await http.get(uri, headers: _getHeaders());
  if (response.statusCode != 200) {
    return null;
  }

  dynamic jsonData = JSON.decode(_getUtf8String(response));
  return new HeroesCompanionData.fromJson(jsonData);
}

Future<UpdatePayload> getUpdate() async {
  Uri uri = new Uri.https(_baseUrl, '/v1/update');
  http.Response response = await http.get(uri, headers: _getHeaders());
  if (response.statusCode != 200) {
    return null;
  }

  dynamic json = JSON.decode(_getUtf8String(response));
  return new UpdatePayload.fromJson(json);
}

Future<UpdateInfo> getUpdateInfo() async {
  Uri uri = new Uri.https(_baseUrl, '/v1/update/id');
  http.Response response = await http.get(uri, headers: _getHeaders());
  if (response.statusCode != 200) {
    return null;
  }

  dynamic json = JSON.decode(_getUtf8String(response));
  return new UpdateInfo.fromJson(json);
}