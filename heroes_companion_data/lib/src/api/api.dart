import 'dart:async';
import 'dart:convert';

import 'package:heroes_companion_data/src/api/DTO/heroes_companion_data.dart';
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


Future<HeroesCompanionData> getData() async {
  Uri uri = new Uri.https(_baseUrl, '/');
  http.Response response = await http.get(uri, headers: _getHeaders());
  if (response.statusCode != 200) {
    return null;
  }
  // print(response.body);
  dynamic jsonData = JSON.decode(_getUtf8String(response));
  return new HeroesCompanionData.fromJson(jsonData);
}