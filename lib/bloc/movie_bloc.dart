import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/rendering.dart';
import 'package:tmdb_using_bloc/model/movie.dart';

import 'package:tmdb_using_bloc/repository/movie_repo.dart';

part 'movie_event.dart';
part 'movie_state.dart';

class MovieBloc extends Bloc<MovieEvent, MovieState> {
  final MovieRepo movieRepository; //check
  MovieBloc(this.movieRepository) : super(MovieLoadingState()) {
    on<LoadMovieEvent>(
      (event, emit) async {
        emit(MovieLoadingState());
        print('laoding finis');
        final movie = await movieRepository.getMovieData();
        emit(MovieLoadedState(movie));
        // try {

        // } catch (e) {}
        // emit(MovieErrorState(e.toString()));
      },
    );
  }
}
