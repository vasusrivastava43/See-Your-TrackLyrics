import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tracks/Bloc/track_bloc.dart';
import 'package:tracks/Bloc/track_states.dart';
import 'package:tracks/Services/connectivity.dart';
import 'package:tracks/screens/details.dart';
import 'package:tracks/repository/track_Repository.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: ((context) => TrackBloc(
          RepositoryProvider.of<TrackRepositoryImpl>(context),
          RepositoryProvider.of<ConnectivityService>(context))),
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            title: const Center(
              child: Text(
                'Trending',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontSize: 25),
              ),
            ),
          ),
          body: BlocBuilder<TrackBloc, TrackState>(
            builder: (context, state) {
              if (state is TrackLoadingState) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (state is TrackLoadedState) {
                return ListView.builder(
                    shrinkWrap: true,
                    itemCount: state.tracklist.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          // Navigator.pushNamed(context, routeName)
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Details(
                                      tid: state.tracklist[index].track.trackId,
                                    )),
                          );
                        },
                        child: Container(
                            //height: 100,
                            color: Colors.white,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                const Icon(Icons.library_music_sharp,
                                    color: Colors.grey),
                                SizedBox(
                                  width: 200,
                                  height: 70,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Flexible(
                                        child: Text(
                                          state
                                              .tracklist[index].track.trackName,
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18),
                                          softWrap: true,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Flexible(
                                        child: Text(
                                          state
                                              .tracklist[index].track.albumName,
                                          style: const TextStyle(
                                            color: Colors.grey,
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                SizedBox(
                                    height: 70,
                                    width: 100,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Flexible(
                                            child: Text(state.tracklist[index]
                                                .track.artistName)),
                                      ],
                                    ))
                              ],
                            )),
                      );
                      // return Text("Hello");
                    });
              }
              if (state is NoNet) {
                return const Center(
                    child: Text(
                  'No Internet Connection',
                  style: TextStyle(fontSize: 25),
                ));
              }
              return Container();
            },
          )),
    );
  }
}
