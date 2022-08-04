import 'dart:convert';
import 'package:tracks/apistring.dart';
import '../Services/class.dart';
import 'package:http/http.dart' as https;

abstract class TrackRepository {
  Future<List<TrackList>> getTrack();
}

class TrackRepositoryImpl implements TrackRepository {
  @override
  Future<List<TrackList>> getTrack() async {
    var response = await https.get(Uri.parse(ApiString.trackapi));
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      List<TrackList> tracklist =
          AutoGenerate.fromJson(data).message.body.trackList;
      return tracklist;
    } else {
      throw Exception();
    }
  }
}

