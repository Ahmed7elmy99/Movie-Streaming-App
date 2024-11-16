import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_app/core/services/service_locator.dart';
import 'package:shimmer/shimmer.dart';

import '../../../core/global/resources/app_color.dart';
import '../../../core/global/resources/darkmode.dart';
import '../../../core/network/api_constance.dart';
import '../../../core/utils/enums.dart';
import '../controllers/movies_bloc.dart';
import '../controllers/movies_state.dart';
import '../controllers/movies_events.dart';
import 'movie_detail_screen.dart';

class TopRatedMoviesScreen extends StatelessWidget {
  const TopRatedMoviesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<MoviesBloc>()..add(GetTopRatedMoviesEvent()),
      child: Scaffold(
        body: BlocBuilder<MoviesBloc, MoviesState>(
          builder: (context, state) {
            switch (state.topRatedState) {
              case RequestState.loading:
                return  Center(
                    child: Image.asset(
                        'assets/images/loading.gif'
                        ,fit: BoxFit.fill

                    ),);

              case RequestState.loaded:
                final movies = state.topRatedMovies;

                if (movies.isEmpty) {
                  return Center(
                      child: Text(
                    'No Top Rated Movies Available',
                    style: GoogleFonts.poppins(
                      color: AppColors.gold,
                      fontSize: 18.sp,
                    ),
                  ));
                }

                return CustomScrollView(
                  slivers: [
                    SliverAppBar(
                      leading:  Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(18),
                            color: Colors.grey.withOpacity(0.5),

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
                      backgroundColor:
                          Theme.of(context).scaffoldBackgroundColor,
                      expandedHeight: 60.0,
                      floating: true,
                      pinned: true,
                      flexibleSpace: FlexibleSpaceBar(
                        title: Text(
                          'Top Rated Movies',
                          style: GoogleFonts.montserrat(
                            fontSize: 15.sp, // Adjust size as needed
                            fontWeight: FontWeight.bold, // Make it bold
                          ),
                          textAlign: TextAlign.center,
                        ),
                        centerTitle: true,
                      ),
                    ),
                    SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (context, index) {
                          final movie = movies[index];
                          return InkWell(
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) =>
                                      MovieDetailScreen(id: movie.id),
                                ),
                              );
                            },
                            child: Material(
                              type: MaterialType.transparency,
                              elevation: 5,
                              borderRadius: BorderRadius.circular(8.0),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // Movie Image
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(8.0),
                                      child: CachedNetworkImage(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.25,
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.32,
                                        imageUrl: movie.backdropPath != null
                                            ? ApiConstance.imageUrl(
                                                movie.backdropPath)
                                            : 'https://via.placeholder.com/150',
                                        fit: BoxFit.cover,
                                        placeholder: (context, url) =>
                                            Shimmer.fromColors(
                                          baseColor: Colors.grey[850]!,
                                          highlightColor: Colors.grey[800]!,
                                          child: Container(color: Colors.black),
                                        ),
                                        errorWidget: (context, url, error) =>
                                            const Icon(Icons.error),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            width: 200,
                                            child: Text(
                                              movie.title,
                                              style: GoogleFonts.poppins(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 18,
                                              ),
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 1,
                                            ),
                                          ),
                                          const SizedBox(height: 14),
                                          Row(
                                            children: [
                                              Container(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                  vertical: 2.0,
                                                  horizontal: 8.0,
                                                ),
                                                decoration: BoxDecoration(
                                                  color: Colors.red[800],
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          4.0),
                                                ),
                                                child: Text(
                                                  movie.releaseDate
                                                      .split('-')[0],
                                                  style: const TextStyle(
                                                    fontSize: 16.0,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(width: 32),
                                              SvgPicture.asset(
                                                "assets/icons/Star_fill.svg",
                                                color: AppColors.gold,
                                              ),
                                              const SizedBox(width: 8),
                                              Text(
                                                movie.voteAverage
                                                    .toStringAsFixed(1),
                                                style: const TextStyle(
                                                  fontSize: 16.0,
                                                  fontWeight: FontWeight.w500,
                                                  letterSpacing: 1.2,
                                                ),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(height: 16),

                                          SizedBox(
                                            width: 208.w,
                                            child: Text(
                                              movie.overview,
                                              style: GoogleFonts.poppins(),
                                              maxLines: 4,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                        childCount: movies.length,
                      ),
                    ),
                  ],
                );

              case RequestState.error:
                return Center(child: Text(state.nowPlayingMessage));

              default:
                return const SizedBox.shrink();
            }
          },
        ),
      ),
    );
  }
}
