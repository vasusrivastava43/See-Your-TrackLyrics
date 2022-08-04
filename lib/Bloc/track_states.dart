import 'package:equatable/equatable.dart';
import 'package:tracks/Services/class.dart';

abstract class TrackState extends Equatable {}

class NoNet extends TrackState {
  @override
  List<Object> get props => [];
}

class TrackLoadingState extends TrackState {
  @override
  List<Object> get props => [];
}

class TrackLoadedState extends TrackState {
  late List<TrackList> tracklist;
  TrackLoadedState(this.tracklist);
  @override
  List<Object> get props => [];
}

class ErrorState extends TrackState {
  String message;
  ErrorState(this.message);
  @override
  List<Object> get props => [message];
}


