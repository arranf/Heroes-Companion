import 'dart:async';
import 'dart:convert';

import 'package:heroes_companion_data/heroes_companion_data.dart';
import 'package:heroes_companion_data/src/api/DTO/build.dart';
import 'package:heroes_companion_data/src/api/DTO/hots_log_builds.dart';
import 'package:heroes_companion_data/src/api/DTO/hots_log_winrate.dart';
import 'package:heroes_companion_data/src/api/DTO/rotation_data.dart';
import 'package:heroes_companion_data/src/api/DTO/patch_data.dart';
import 'package:heroes_companion_data/src/api/DTO/update_info.dart';
import 'package:heroes_companion_data/src/api/DTO/update_payload.dart';
import 'package:http/http.dart' as http;

String _baseUrl = 'cdn.heroescompanion.com';
Utf8Decoder _utf8Decoder = new Utf8Decoder();

Map<String, String> _getHeaders() {
  return {
    "Accept": "application/jsonResponse",
    "Content-Type": "application/jsonResponse",
    "User-Agent": "Heroes Companion"
  };
}

String _getUtf8String(http.Response response) {
  return _utf8Decoder.convert(response.bodyBytes);
}

Future<RotationData> getRotation() async {
  Uri uri = new Uri.https(_baseUrl, '/v1/rotation');
  http.Response response = await http.get(uri, headers: _getHeaders());
  if (response.statusCode != 200) {
    return null;
  }

  Map<dynamic, dynamic> jsonResponseData =
      json.decode(_getUtf8String(response));
  return new RotationData.fromJson(jsonResponseData);
}

Future<UpdatePayload> getUpdate() async {
  Uri uri = new Uri.https(_baseUrl, '/v1/update');
  try {
    http.Response response = await http.get(uri, headers: _getHeaders());
    if (response.statusCode != 200) {
      return null;
    }

    Map<dynamic, dynamic> jsonResponse = json.decode(_getUtf8String(response));
    return new UpdatePayload.fromJson(jsonResponse);
  } catch (e) {
    throw new Exception('Couldn\'t contact update server');
  }
}

Future<UpdateInfo> getUpdateInfo() async {
  Uri uri = new Uri.https(_baseUrl, '/v1/update/id');

  try {
    http.Response response = await http.get(uri, headers: _getHeaders());
    if (response.statusCode != 200) {
      return null;
    }

    Map<dynamic, dynamic> jsonResponse = json.decode(_getUtf8String(response));
    return new UpdateInfo.fromJson(jsonResponse);
  } catch (e) {
    throw new Exception('Couldn\'t contact update server');
  }
}

Future<List<PatchData>> getPatchData() async {
  Uri uri = new Uri.https(_baseUrl, '/v2/patches');

  try {
    http.Response response = await http.get(uri, headers: _getHeaders());
    if (response.statusCode != 200) {
      return null;
    }

    List<dynamic> jsonResponse = json.decode(_getUtf8String(response));
    if (!(jsonResponse is List)) {
      throw new Exception(
          'Unexpected JSON format encounted fetching patch data. Expected a list.');
    }
    List<PatchData> patchData = new List();
    List<Map<dynamic, dynamic>> jsonResponseArray =
        jsonResponse.cast<Map<dynamic, dynamic>>();
    jsonResponseArray.forEach((Map<dynamic, dynamic> patchInfo) {
      patchData.add(new PatchData.fromJson(patchInfo));
    });
    return patchData;
  } catch (e) {
    throw new Exception('Failed to fetch patch data ${e.message}');
  }
}

Future<List<HotsLogsWinrate>> getHotsLogWinRates(Patch patch) async {
  Uri uri =
      new Uri.https(_baseUrl, '/v1/hotslogs', {'patch': patch.fullVersion});

  try {
    http.Response response = await http.get(uri, headers: _getHeaders());
    if (response.statusCode != 200) {
      return null;
    }

    dynamic jsonResponse = json.decode(_getUtf8String(response));
    if (!(jsonResponse is List)) {
      throw new Exception(
          'Unexpected JSON format encounted fetching hotslog winrate data');
    }
    List<HotsLogsWinrate> winRates = new List();
    List<dynamic> jsonResponseArray = jsonResponse;
    jsonResponseArray.forEach((winRate) {
      winRates
          .add(new HotsLogsWinrate.fromJson(winRate as Map<dynamic, dynamic>));
    });
    return winRates;
  } catch (e) {
    throw new Exception('Failed to fetch hots log winrates ${e.message}');
  }
}

Future<List<HotsLogBuild>> getHotsLogBuilds(
    Patch patch, String heroName) async {
  Uri uri = new Uri.https(
      _baseUrl, '/v1/hotslogs/${heroName}', {'patch': patch.fullVersion});

  try {
    http.Response response = await http.get(uri, headers: _getHeaders());
    if (response.statusCode != 200) {
      return null;
    }

    dynamic jsonResponse = json.decode(_getUtf8String(response));
    // is a list which is empty or contains maps
    if (!(jsonResponse is List)) {
      throw new Exception(
          'Unexpected JSON format encounted fetching hots log builds');
    }
    List<HotsLogBuild> builds = new List();
    List<dynamic> jsonResponseArray = jsonResponse;
    jsonResponseArray.forEach((build) {
      builds.add(new HotsLogBuild.fromJson(build as Map<dynamic, dynamic>));
    });
    return builds;
  } catch (e) {
    throw new Exception('Failed to fetch hots log builds ${e.message}');
  }
}

Future<List<Build>> getBuildsForHero(int heroId) async {
  Uri uri = new Uri.https(_baseUrl, '/v1/builds/${heroId}');

  try {
    http.Response response = await http.get(uri, headers: _getHeaders());
    if (response.statusCode != 200) {
      return null;
    }
    dynamic jsonResponse = json.decode(_getUtf8String(response));
    // is a list which is empty or contains maps
    if (!(jsonResponse is List)) {
      throw new Exception(
          'Unexpected JSON format encountered fetching build data');
    }
    List<dynamic> jsonResponseArray = jsonResponse;
    List<Build> builds = jsonResponseArray
        .map((dynamic a) => new Build.fromJson(a as Map<dynamic, dynamic>))
        .toList();
    return builds;
  } catch (e) {
    throw new Exception('Failed to fetch (evergreen) builds: ${e.message}');
  }
}
