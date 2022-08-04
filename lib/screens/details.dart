import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as https;
import '../Services/lyrics.dart';
import '../Services/track.dart';

class Details extends StatefulWidget {
  const Details({
    Key? key,
    required this.tid,
  }) : super(key: key);

  final tid;

  @override
  State<Details> createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  var data1;
  var data2;
  bool isloading = true;

  @override
  void initState() {
    super.initState();
    getDetail();
    getLyrics();
  }

  Future<void> getLyrics() async {
    try {
      final response = await https.get(Uri.parse(
          'https://api.musixmatch.com/ws/1.1/track.lyrics.get?track_id=${widget.tid}&apikey=9d4ce927ed15360ac3ddc6092e5d62e0'));
      var jsonData = jsonDecode(response.body);
      var data =
          AutoGenerate2.fromJson(jsonData).message.body.lyrics.lyricsBody;
      setState(() {
        data1 = data;
        isloading = false;
      });
    } catch (e) {
      if (kDebugMode) {
        print('error : $e');
      }
    }
  }

  Future<void> getDetail() async {
    try {
      final response = await https.get(Uri.parse(
          'https://api.musixmatch.com/ws/1.1/track.get?track_id=${widget.tid}&apikey=9d4ce927ed15360ac3ddc6092e5d62e0'));
      var jsonData = jsonDecode(response.body);
      var data = AutoGenerate3.fromJson(jsonData).message.body.track;
      setState(() {
        data2 = data;
      });
    } catch (e) {
      if (kDebugMode) {
        print('error : $e');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.black),
          backgroundColor: Colors.white,
          title: const Text(
            'Track Details',
            style: TextStyle(
                fontWeight: FontWeight.bold, color: Colors.black, fontSize: 25),
          ),
        ),
        body: isloading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.only(left: 15.0, top: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Name',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                      Text(
                        '${data2.trackName}',
                        style: const TextStyle(fontSize: 22),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Text(
                        'Artist',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                      Text(
                        '${data2.artistName}',
                        style: const TextStyle(fontSize: 22),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Text(
                        'Album Name',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                      Text(
                        '${data2.albumName}',
                        style: const TextStyle(fontSize: 22),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Text(
                        'Explicit',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                      Text(
                        '${data2.explicit}',
                        style: const TextStyle(fontSize: 22),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Text(
                        'Rating',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                      const SizedBox(
                        height: 3,
                      ),
                      Text(
                        '${data2.trackRating}',
                        style: const TextStyle(fontSize: 22),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Text(
                        'Lyrics',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        data1,
                        style: const TextStyle(fontSize: 22),
                      )
                    ],
                  ),
                ),
              ));
  }
}
