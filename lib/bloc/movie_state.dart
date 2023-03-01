part of 'movie_bloc.dart';

abstract class MovieState extends Equatable {}

class MovieLoadingState extends MovieState {
  @override
  List<Object> get props => [];
}

class MovieLoadedState extends MovieState {
  MovieLoadedState(this.movie);
  final List<Movie> movie;
  @override
  List<Object> get props => [movie];
}

//Error state

class MovieErrorState extends MovieState {
  MovieErrorState(this.error);
  final String error;
  @override
  List<Object> get props => [error];
}
