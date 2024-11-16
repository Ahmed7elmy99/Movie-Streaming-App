import 'package:animate_do/animate_do.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:movie_app/core/global/resources/app_color.dart';
import 'package:movie_app/watch_movies/screens/watch_movies.dart';

// ignore: depend_on_referenced_packages
import 'package:provider/provider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_app/core/services/service_locator.dart';
import 'package:movie_app/core/utils/enums.dart';
import 'package:movie_app/movies/presentation/controllers/movie_details_bloc.dart';
import 'package:movie_app/movies/presentation/controllers/movie_details_event.dart';
import 'package:movie_app/movies/presentation/controllers/movie_details_state.dart';
import 'package:shimmer/shimmer.dart';

import '../../../core/global/resources/darkmode.dart';
import '../../../core/network/api_constance.dart';
import '../../../favourites/presentation/controller/favourite_screen_provider.dart';
import '../../domain/entities/genres.dart';

class MovieDetailScreen extends StatelessWidget {
  final int id;

  const MovieDetailScreen({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => getIt<MovieDetailsBloc>()
          ..add(
            GetDetailsMovieEvent(id),
          )
          ..add(
            GetRecommendedMoviesEvent(id),
          ),
        child: const MovieDetailContent(),
      ),
    );
  }
}

class MovieDetailContent extends StatelessWidget {
  const MovieDetailContent({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MovieDetailsBloc, MovieDetailsState>(
      builder: (context, state) {
        switch (state.moviesDetailsState) {
          case RequestState.loading:
            return Center(
              child: Image.asset('assets/images/loading.gif', fit: BoxFit.fill),
            );
          case RequestState.loaded:
            final movieDetails = state.moviesDetails;
            if (movieDetails == null) {
              return Center(
                  child: Text(
                "Movie details unavailable.",
                style: GoogleFonts.poppins(
                  color: AppColors.gold,
                  fontSize: 18.sp,
                ),
              ));
            }

            return CustomScrollView(
              key: const Key('movieDetailScrollView'),
              slivers: [
                SliverAppBar(
                  pinned: false,
                  expandedHeight: 250.0,
                  flexibleSpace: FlexibleSpaceBar(
                    background: FadeIn(
                      duration: const Duration(milliseconds: 800),
                      child: Hero(
                        tag: "hero",
                        child: ShaderMask(
                          shaderCallback: (rect) {
                            return const LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                Colors.transparent,
                                Colors.black,
                                Colors.black,
                                Colors.transparent,
                              ],
                              stops: [0.0, 0.31, 0.92, 1.0],
                            ).createShader(
                              Rect.fromLTRB(0.0, 0.0, rect.width, rect.height),
                            );
                          },
                          blendMode: BlendMode.dstIn,
                          child: movieDetails.backdropPath != null
                              ? CachedNetworkImage(
                                  width: MediaQuery.of(context).size.width,
                                  imageUrl: ApiConstance.imageUrl(
                                      movieDetails.backdropPath),
                                  fit: BoxFit.cover,
                                )
                              : Container(
                                  width: MediaQuery.of(context).size.width,
                                  height: 250.0,
                                  color: Colors.grey,
                                  child: Center(
                                    child: Text(
                                      'Image not available',
                                      style: GoogleFonts.poppins(
                                        color: AppColors.gold,
                                        fontSize: 18.sp,
                                      ),
                                    ),
                                  ),
                                ),
                        ),
                      ),
                    ),
                  ),
                  leading: Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(18),
                        color: Colors.grey.withOpacity(0.4),
                      ),
                      child: IconButton(
                        icon: SvgPicture.asset(
                          "assets/icons/Arrow_alt_left_alt.svg",
                          color: ThemeUtils.isDarkMode(context)
                              ? Colors.white
                              : Colors.black,
                          width: 40,
                        ),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: FadeInUp(
                    from: 20,
                    duration: const Duration(milliseconds: 500),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                width: 280,
                                child: Text(
                                  movieDetails.title ?? 'Title Unavailable',
                                  style: GoogleFonts.poppins(
                                    fontSize: 23,
                                    fontWeight: FontWeight.w700,
                                    letterSpacing: 1.2,
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              PlayButtonWithHover(
                                movieId: movieDetails.id,
                              ),
                            ],
                          ),
                          const SizedBox(height: 8.0),
                          Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 2.0,
                                  horizontal: 8.0,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.red[800],
                                  borderRadius: BorderRadius.circular(4.0),
                                ),
                                child: Text(
                                  movieDetails.releaseDate.split('-')[0] ??
                                      'N/A',
                                  style: const TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 16.0),
                              Row(children: [
                                SvgPicture.asset(
                                  "assets/icons/Star_fill.svg",
                                  color: Colors.amber,
                                ),
                                const SizedBox(width: 4.0),
                                Text(
                                  movieDetails.voteAverage != null
                                      ? movieDetails.voteAverage
                                          .toStringAsFixed(1)
                                      : 'N/A',
                                  style: const TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.w500,
                                    letterSpacing: 1.2,
                                  ),
                                ),
                                IconButton(
                                  icon: Icon(
                                    Provider.of<FavoriteMovieProvider>(context, listen: true).isFavoriteMovie(
                                        state.moviesDetails!.id.toString())
                                        ? Icons.favorite
                                        : Icons.favorite_border_rounded,
                                    color: Colors.red,
                                    size: 28,
                                  ),
                                  onPressed: () async {
                                    final favoriteMovieProvider = Provider.of<FavoriteMovieProvider>(context, listen: false);

                                    if (favoriteMovieProvider.isFavoriteMovie(state.moviesDetails!.id.toString())) {
                                      await favoriteMovieProvider.removeFavoriteMovie(state.moviesDetails!.id.toString());
                                    } else {
                                      await favoriteMovieProvider.addFavoriteMovie(
                                        state.moviesDetails!.id.toString(),
                                        state.moviesDetails!.title,
                                        state.moviesDetails!.backdropPath ?? '',
                                      );
                                    }
                                  },
                                )

                              ]),
                              SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.25),
                              Text(
                                _showDuration(movieDetails.runtime),
                                style: const TextStyle(
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.w500,
                                  letterSpacing: 1.2,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20.0),
                          MovieOverview(movieDetails: movieDetails),
                          const SizedBox(height: 8.0),
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  'Genres: ',
                                  style: TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.w500,
                                    color: Theme.of(context)
                                        .textTheme
                                        .titleSmall!
                                        .color!
                                        .withOpacity(0.6),
                                  ),
                                ),
                                Wrap(
                                  spacing: 8.0,
                                  children: _showGenres(movieDetails.genres)
                                      .split(', ')
                                      .map((genre) {
                                    return Container(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 4.0, horizontal: 8.0),
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          color: Theme.of(context)
                                              .textTheme
                                              .titleSmall!
                                              .color!
                                              .withOpacity(0.6),
                                          width: 1.0, // Set border width
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                      ),
                                      child: Text(
                                        genre,
                                        style: TextStyle(
                                          fontSize: 14.0, // Adjust as needed
                                          fontWeight: FontWeight.w500,
                                          color: Theme.of(context)
                                              .textTheme
                                              .titleSmall!
                                              .color!
                                              .withOpacity(0.6),
                                        ),
                                      ),
                                    );
                                  }).toList(),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                SliverPadding(
                  padding: const EdgeInsets.fromLTRB(16.0, 4.0, 16.0, 4.0),
                  sliver: SliverToBoxAdapter(
                    child: FadeInUp(
                      from: 20,
                      duration: const Duration(milliseconds: 500),
                      child: const Text(
                        "Recommended",
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.w500,
                          letterSpacing: 1.2,
                        ),
                      ),
                    ),
                  ),
                ),
                SliverPadding(
                  padding: const EdgeInsets.all(16.0),
                  sliver: _showRecommendations(state),
                ),
              ],
            );
          case RequestState.error:
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(state.moviesDetailsMessage),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      BlocProvider.of<MovieDetailsBloc>(context)
                        ..add(GetDetailsMovieEvent(state.moviesDetails!.id))
                        ..add(
                            GetRecommendedMoviesEvent(state.moviesDetails!.id));
                    },
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
        }
      },
    );
  }

  String _showGenres(List<Genres> genres) {
    return genres.isNotEmpty
        ? genres.map((genre) => genre.name).join(', ')
        : 'No genres';
  }

  String _showDuration(int runtime) {
    final int hours = runtime ~/ 60;
    final int minutes = runtime % 60;
    return hours > 0 ? '${hours}h ${minutes}m' : '${minutes}m';
  }

  Widget _showRecommendations(MovieDetailsState state) {
    return SliverGrid(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          final recommendation = state.moviesRecommendation[index];
          return FadeInUp(
            from: 20,
            duration: const Duration(milliseconds: 500),
            child: InkWell(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) =>
                        MovieDetailScreen(id: recommendation.id),
                  ),
                );
              },
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(8.0)),
                child: CachedNetworkImage(
                  imageUrl:
                      ApiConstance.imageUrl(recommendation.posterPath ?? ""),
                  placeholder: (context, url) => Shimmer.fromColors(
                    baseColor: Colors.grey[850]!,
                    highlightColor: Colors.grey[800]!,
                    child: Container(
                      height: 170.0,
                      width: 120.0,
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                  ),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                  height: 180.0,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          );
        },
        childCount: state.moviesRecommendation.length,
      ),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 8.0,
        crossAxisSpacing: 8.0,
        childAspectRatio: 0.7,
      ),
    );
  }
}

class MovieOverview extends StatefulWidget {
  final dynamic movieDetails;

  const MovieOverview({super.key, required this.movieDetails});

  @override
  State<MovieOverview> createState() => _MovieOverviewState();
}

class _MovieOverviewState extends State<MovieOverview> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.movieDetails.overview ?? 'No overview available',
          style: GoogleFonts.poppins(
            fontSize: 14.0,
            fontWeight: FontWeight.w400,
          ),
          maxLines: isExpanded ? null : 4,
          overflow: isExpanded ? TextOverflow.visible : TextOverflow.ellipsis,
        ),
        const SizedBox(height: 8.0),
        Align(
          alignment: Alignment.centerRight,
          child: GestureDetector(
            onTap: () {
              setState(() {
                isExpanded = !isExpanded;
              });
            },
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  isExpanded ? 'Less' : 'More',
                  style: GoogleFonts.poppins(
                    fontSize: 12.0,
                    fontWeight: FontWeight.w800,
                    color: Colors.red,
                  ),
                ),
                const SizedBox(width: 4.0),
                Icon(
                  isExpanded ? Icons.arrow_upward : Icons.arrow_downward,
                  color: Colors.red,
                  size: 17.0,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class PlayButtonWithHover extends StatefulWidget {
  final int movieId;

  const PlayButtonWithHover({super.key, required this.movieId});

  @override
  _PlayButtonWithHoverState createState() => _PlayButtonWithHoverState();
}

class _PlayButtonWithHoverState extends State<PlayButtonWithHover> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) {
        setState(() {
          isHovered = true;
        });
      },
      onExit: (_) {
        setState(() {
          isHovered = false;
        });
      },
      child: Hero(
        tag: "movieHero",
        child: GestureDetector(
          onTap: () {
            Navigator.of(context).push(_createRouteToWatchMovieScreen());
          },
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            height: isHovered ? 40 : 50,
            width: isHovered ? 30 : 45,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.gold,
            ),
            child: Icon(
              Icons.play_arrow_rounded,
              size: isHovered ? 35 : 30,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  Route _createRouteToWatchMovieScreen() {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) =>
          WatchMovieScreen(movieId: widget.movieId),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        var begin = Offset(0.0, 1.0); // Slide from bottom to top
        var end = Offset.zero;
        var curve = Curves.ease;

        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
        var fadeTransition =
            FadeTransition(opacity: animation, child: child); // Add fade effect

        return SlideTransition(
          position: animation.drive(tween),
          child: fadeTransition,
        );
      },
      transitionDuration:
          Duration(milliseconds: 500), // Customize transition duration
    );
  }
}
