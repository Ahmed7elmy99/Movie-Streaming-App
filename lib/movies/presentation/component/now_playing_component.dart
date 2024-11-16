import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_app/core/global/resources/app_color.dart';
import 'package:movie_app/core/global/resources/strings_manger.dart';
import 'package:movie_app/movies/presentation/controllers/movies_bloc.dart';
import 'package:movie_app/movies/presentation/controllers/movies_state.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:animate_do/animate_do.dart';
import '../../../core/network/api_constance.dart';
import '../../../core/utils/enums.dart';
import '../screens/movie_detail_screen.dart';

class NowPlayingComponent extends StatelessWidget {
  const NowPlayingComponent({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;

    return BlocBuilder<MoviesBloc, MoviesState>(buildWhen: (previous, current) {
      return previous.nowPlayingState != current.nowPlayingState;
    }, builder: (context, state) {
      switch (state.nowPlayingState) {
        case RequestState.loading:
          return SizedBox(
            height: 350,
            child: Center(
              child: Image.asset(
                'assets/images/loading.gif'
                ,fit: BoxFit.fill

              ),
            ),
          );

        case RequestState.loaded:
          return FadeIn(
            duration: const Duration(milliseconds: 500),
            child: CarouselSlider(
              options: CarouselOptions(
                height: 350.0,
                viewportFraction: 1.0,
              ),
              items: state.nowPlayingMovies.map(
                (item) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => MovieDetailScreen(id: item.id),
                        ),
                      );
                    },
                    child: Stack(
                      children: [
                        ShaderMask(
                          shaderCallback: (rect) {
                            return LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                Colors.transparent,
                                isDarkMode
                                    ? Colors.black.withOpacity(0.5)
                                    : Colors.white.withOpacity(0.99),
                                isDarkMode
                                    ? Colors.black.withOpacity(0.6)
                                    : Colors.white.withOpacity(0.99),
                                Colors.transparent,
                              ],
                              stops: const [0, 0.15, 0.75, 1],
                            ).createShader(
                              Rect.fromLTRB(0, 0, rect.width, rect.height),
                            );
                          },
                          blendMode: BlendMode.dstIn,
                          child: CachedNetworkImage(
                            height: 560.0,
                            imageUrl: ApiConstance.imageUrl(item.backdropPath),
                            fit: BoxFit.cover,
                          ),
                        ),
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(bottom: 4.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Icon(
                                      Icons.circle,
                                      color: Colors.redAccent,
                                      size: 16.0,
                                    ),
                                    const SizedBox(width: 5.0),
                                    Text(
                                      AppString.nowStreaming.toUpperCase(),
                                      style: GoogleFonts.poppins(
                                        fontSize: 16,
                                      ).copyWith(
                                        color: isDarkMode
                                            ? Colors.white.withOpacity(0.7)
                                            : Colors.black,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 8.0),
                                child: Text(
                                  item.title,
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.poppins(fontSize: 24),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ).toList(),
            ),
          );

        case RequestState.error:
          return SizedBox(
            height: 400,
            child: Center(
              child: Text(state.nowPlayingMessage),
            ),
          );
      }
    });
  }
}
