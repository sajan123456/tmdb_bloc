import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import 'package:tmdb_using_bloc/bloc/movie_bloc.dart';
import 'package:tmdb_using_bloc/model/movie.dart';
import 'package:tmdb_using_bloc/repository/movie_repo.dart';

import '../constants.dart';

class BlocHomePage extends StatefulWidget {
  @override
  State<BlocHomePage> createState() => _BlocHomePageState();
}

class _BlocHomePageState extends State<BlocHomePage> {
  // const BlocHomePage({super.key});
  int _currentTab = 0;

  int activePage = 0;

  final _controller = PageController(
    viewportFraction: 0.6,
  );

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MovieBloc(
        RepositoryProvider.of<MovieRepo>(context),
      )..add(LoadMovieEvent()),
      child: Scaffold(body: BlocBuilder<MovieBloc, MovieState>(
        builder: (context, state) {
          if (state is MovieLoadingState) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is MovieLoadedState) {
            //if data is loaded
            List<Movie> movieList = state.movie;

            return Scaffold(
              backgroundColor: kPrimaryColor,
              appBar: AppBar(
                backgroundColor: kPrimaryColor,
                elevation: 0,
              ),
              body: ListView(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Column(children: [
                      ListTile(
                        contentPadding: EdgeInsets.all(0),
                        leading: Container(
                          padding: EdgeInsets.all(6), //avatar padding
                          height: 45,
                          width: 45,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle, color: Colors.white),
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(60),
                              child: Image.asset(
                                'assets/images/girl.png',
                                fit: BoxFit.cover,
                              )),
                        ),
                        title: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            RichText(
                                text: TextSpan(children: [
                              TextSpan(
                                text: 'Hello ',
                                style: TextStyle(
                                    fontSize: 18, color: Colors.white70),
                              ),
                              TextSpan(
                                  text: 'Arie',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18)),
                            ])),
                            SizedBox(
                              height: 2,
                            ),
                            Text(
                              'Book your favourite movie',
                              style: TextStyle(
                                  fontSize: 12, color: Colors.white70),
                            )
                          ],
                        ),
                        trailing: Container(
                          padding: EdgeInsets.all(4),
                          decoration: BoxDecoration(
                              color: Colors.white30,
                              borderRadius: BorderRadius.circular(60)),
                          child: Icon(
                            Icons.notifications,
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 20, bottom: 30),
                        padding: EdgeInsets.symmetric(
                          vertical: 1,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white12,
                          borderRadius: BorderRadius.circular(60),
                        ),
                        child: TextFormField(
                          decoration: InputDecoration(
                              // prefixIcon: Icon(Icons.search),
                              prefixIcon: Icon(
                                CupertinoIcons.search,
                              ),
                              suffixIcon:
                                  Icon(CupertinoIcons.slider_horizontal_3),
                              border: InputBorder.none,
                              hintText: 'Search movie ..',
                              hintStyle: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white70)),
                        ),
                      ),
                      Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            RichText(
                                text: TextSpan(
                                    style: TextStyle(fontSize: 20),
                                    children: [
                                  TextSpan(
                                      text: 'Now ',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600)),
                                  TextSpan(text: 'Showing')
                                ])),
                            Text(
                              'See more',
                              style: TextStyle(
                                  fontSize: 12, color: Colors.white38),
                            )
                          ],
                        ),
                      )
                    ]),
                  ),
                  Column(
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(vertical: 10),
                        height: 300,
                        child: PageView.builder(
                          onPageChanged: (value) {
                            setState(() {
                              activePage = value;
                            });
                          },
                          itemCount: 3,
                          physics: ClampingScrollPhysics(),
                          controller: _controller,
                          itemBuilder: (context, index) {
                            bool active = index == activePage;
                            return Padding(
                              padding: active
                                  ? EdgeInsets.all(0.0)
                                  : EdgeInsets.all(0),
                              child: BackdropFilter(
                                filter: ImageFilter.blur(
                                    sigmaX: active ? 5 : 0,
                                    sigmaY: active ? 5 : 0),
                                child: AnimatedContainer(
                                  duration: Duration(milliseconds: 400),
                                  curve: Curves.easeInOutCubic,
                                  margin: active
                                      ? EdgeInsets.all(5)
                                      : EdgeInsets.symmetric(
                                          horizontal: 16, vertical: 35),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(40),
                                    // color: Colors.amber,
                                    image: DecorationImage(
                                        image: NetworkImage(
                                            movieList[index].poster_path),
                                        fit: BoxFit.fill),
                                  ),
                                  // child: Text(''),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      SmoothPageIndicator(
                        controller: _controller,
                        count: 3,
                        effect: ExpandingDotsEffect(
                            activeDotColor: Colors.blue,
                            dotColor: Colors.white,
                            dotWidth: 16),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        RichText(
                            text: TextSpan(
                                style: TextStyle(fontSize: 20),
                                children: [
                              TextSpan(
                                  text: 'Animation ',
                                  style:
                                      TextStyle(fontWeight: FontWeight.w600)),
                              TextSpan(text: 'Film')
                            ])),
                        Text(
                          'See more',
                          style: TextStyle(fontSize: 12, color: Colors.white38),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Container(
                    height: 200,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: 5,
                      itemBuilder: (context, index) {
                        return Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20)),
                          margin: EdgeInsets.all(8),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(30),
                            child: Image(
                                image:
                                    NetworkImage(movieList[index].poster_path)),
                          ),
                        );
                      },
                    ),
                  )
                ],
              ),
              bottomNavigationBar: BottomNavigationBar(
                  currentIndex: _currentTab,
                  onTap: (int value) {
                    setState(() {
                      _currentTab = value;
                    });
                  },
                  selectedItemColor: Colors.white,
                  unselectedItemColor: Colors.white24,
                  type: BottomNavigationBarType.fixed,
                  items: [
                    BottomNavigationBarItem(icon: Icon(Icons.home), label: ''),
                    BottomNavigationBarItem(
                        icon: Icon(Icons.widgets), label: ''),
                    BottomNavigationBarItem(
                        icon: Icon(Icons.wallet), label: ''),
                    BottomNavigationBarItem(
                        icon: Icon(Icons.person), label: ''),
                  ]),
            );
          }
          return Container(
            child: Center(child: Text('no data')),
          );
        },
      )),
    );
  }
}
