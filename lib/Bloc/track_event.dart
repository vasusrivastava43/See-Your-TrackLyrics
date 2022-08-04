import 'package:equatable/equatable.dart';

abstract class TrackEvent extends Equatable {}

class NoNetEvent extends TrackEvent {
  List<Object> get props => [];
}

class LoadTrack extends TrackEvent {
  List<Object> get props => [];
}


