import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tracks/Bloc/track_event.dart';
import 'package:tracks/Bloc/track_states.dart';
import 'package:tracks/repository/track_Repository.dart';
import '../Services/class.dart';
import '../Services/connectivity.dart';

class TrackBloc extends Bloc<TrackEvent, TrackState> {
  TrackRepository repository;
  final ConnectivityService _connectivityService;
  TrackBloc(this.repository, this._connectivityService)
      : super(TrackLoadingState()) {
    _connectivityService.connectivityStream.stream.listen((event) {
      if (event == ConnectivityResult.none) {
        if (kDebugMode) {
          print('no internet');
        }
        add(NoNetEvent());
      } else {
        if (kDebugMode) {
          print('yes internet');
        }
        add(LoadTrack());
      }
    });

    on<LoadTrack>((event, emit) async {
      emit(TrackLoadingState());
      List<TrackList> track = await repository.getTrack();
      emit(TrackLoadedState(track));
    });

    on<NoNetEvent>((event, emit) {
      emit(NoNet());
    });
  }
}
