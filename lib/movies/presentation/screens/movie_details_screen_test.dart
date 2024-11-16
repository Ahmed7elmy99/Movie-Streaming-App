import 'package:animate_do/animate_do.dart';
import 'package:flutter_svg/svg.dart';
import 'package:movie_app/watch_movies/screens/watch_movies.dart';
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
import '../../../core/network/api_constance.dart';

class MovieDetailScreen extends StatelessWidget {
  final int id;

  const MovieDetailScreen({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => getIt<MovieDetailsBloc>()
          ..add(GetDetailsMovieEvent(id))
          ..add(GetRecommendedMoviesEvent(id)),
        child: const MovieDetailContent(),
      ),
    );
  }
}

class MovieDetailContent extends StatefulWidget {
  const MovieDetailContent({super.key});

  @override
  _MovieDetailContentState createState() => _MovieDetailContentState();
}

class _MovieDetailContentState extends State<MovieDetailContent> {
  bool isFavorite = false; // State for favorite icon

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MovieDetailsBloc, MovieDetailsState>(
      builder: (context, state) {
        switch (state.moviesDetailsState) {
          case RequestState.loading:
            return const Center(child: CircularProgressIndicator());
          case RequestState.loaded:
            final movieDetails = state.moviesDetails;
            if (movieDetails == null) {
              return const Center(child: Text("Movie details unavailable."));
            }

            return Stack(
              children: [
                // Background Poster with Opacity
                Positioned.fill(
                  child: Opacity(
                    opacity: 0.3,
                    child: CachedNetworkImage(
                      imageUrl: ApiConstance.imageUrl(movieDetails.backdropPath),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                // Movie Details Content
                CustomScrollView(
                  key: const Key('movieDetailScrollView'),
                  slivers: [
                    SliverToBoxAdapter(
                      child: FadeIn(
                        duration: const Duration(milliseconds: 800),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Stack(
                                children: [
                                  // Movie Poster and Play Button
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      // Poster
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(8.0),
                                        child: CachedNetworkImage(
                                          imageUrl: ApiConstance.imageUrl(
                                              movieDetails.backdropPath),
                                          width: 120,
                                          height: 180,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      const SizedBox(width: 16.0),
                                      // Title, Rating, Duration
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              movieDetails.title ?? 'Title Unavailable',
                                              style: GoogleFonts.poppins(
                                                fontSize: 22,
                                                fontWeight: FontWeight.w600,
                                              ),
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                            const SizedBox(height: 8.0),
                                            Row(
                                              children: [
                                                // Rating Icon
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
                                                  ),
                                                ),
                                                const SizedBox(width: 16.0),
                                                // Release Date
                                                Text(
                                                  movieDetails.releaseDate
                                                      .split('-')[0] ??
                                                      'N/A',
                                                  style: const TextStyle(
                                                    fontSize: 16.0,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            const SizedBox(height: 8.0),
                                            // Runtime
                                            Text(
                                              _showDuration(movieDetails.runtime),
                                              style: const TextStyle(
                                                fontSize: 16.0,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  // Play Button
                                  Positioned(
                                    left: 40,
                                    bottom: 20,
                                    child: InkWell(
                                      child: const Icon(
                                        Icons.play_circle_fill,
                                        size: 50,
                                        color: Colors.red,
                                      ),
                                      onTap: () {
                                        if (movieDetails.id != null) {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  WatchMovieScreen(
                                                      movieId: movieDetails.id),
                                            ),
                                          );
                                        }
                                      },
                                    ),
                                  ),
                                  // Favorite Icon
                                  Positioned(
                                    right: 0,
                                    child: IconButton(
                                      icon: Icon(
                                        isFavorite ? Icons.favorite : Icons.favorite_border,
                                        color: Colors.red,
                                        size: 30,
                                      ),
                                      onPressed: () {
                                        setState(() {
                                          isFavorite = !isFavorite;
                                        });
                                        // Handle adding/removing from favorite here
                                      },
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 20.0),
                              // Overview Section
                              Text(
                                'Overview',
                                style: GoogleFonts.poppins(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 8.0),
                              Text(
                                '${movieDetails.overview}...',
                                style: const TextStyle(
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.w400,
                                ),
                                maxLines: 4,
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(height: 20.0),
                              // Recommendations Section
                              Text(
                                'Recommended',
                                style: GoogleFonts.poppins(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SliverPadding(
                      padding: const EdgeInsets.all(16.0),
                      sliver: _showRecommendations(state),
                    ),
                  ],
                ),
              ],
            );
          case RequestState.error:
            return Center(
              child: Text(state.moviesDetailsMessage),
            );
        }
      },
    );
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
                borderRadius: const BorderRadius.all(Radius.circular(4.0)),
                child: CachedNetworkImage(
                  imageUrl: ApiConstance.imageUrl(recommendation.backdropPath!),
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
                  errorWidget: (context, url, error) =>
                  const Icon(Icons.error),
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
        mainAxisSpacing: 8.0,
        crossAxisSpacing: 8.0,
        childAspectRatio: 0.7,
        crossAxisCount: 2,
      ),
    );
  }
}
