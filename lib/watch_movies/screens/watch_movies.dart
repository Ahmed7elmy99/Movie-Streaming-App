import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_app/core/global/resources/darkmode.dart';
import '../../core/global/resources/app_color.dart';

class WatchMovieScreen extends StatefulWidget {
  final int movieId;

  const WatchMovieScreen({super.key, required this.movieId});

  @override
  _WatchMovieScreenState createState() => _WatchMovieScreenState();
}

class _WatchMovieScreenState extends State<WatchMovieScreen> {
  InAppWebViewController? controller;
  bool isLoading = true;
  bool hasInternet = true;

  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeLeft]);
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
    _checkConnectivity();
  }

  @override
  void dispose() {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    controller?.clearCache();
    super.dispose();
  }

  Future<void> _checkConnectivity() async {
    var result = await Connectivity().checkConnectivity();
    if (result == ConnectivityResult.none) {
      setState(() {
        hasInternet = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('No Internet Connection')),
      );
    } else {
      setState(() {
        hasInternet = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (controller != null && await controller!.canGoBack()) {
          controller!.goBack(); // Navigate back within WebView if possible
          return false; // Prevent Flutter from popping the screen
        }
        return true; // Allow Flutter to pop the screen if WebView can't go back
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.gold,
          title: Text(
            "Watch Movie",

            style: GoogleFonts.poppins(
              fontSize: 24,
              fontWeight: FontWeight.w600,
            ),
          ),
          centerTitle: true,
          leading: IconButton(
            icon:  SvgPicture.asset(
              "assets/icons/Arrow_alt_left_alt.svg",
              color: ThemeUtils.isDarkMode(context)
                  ? Colors.white
                  : Colors.black,
              width: 40,
            ),
            onPressed: () async {
              if (controller != null && await controller!.canGoBack()) {
                controller!.goBack(); // Go back within WebView
              } else {
                Navigator.of(context)
                    .pop(); // Go back to movie details if no further navigation
              }
            },
          ),
          actions: [
            IconButton(
              icon:  SvgPicture.asset(
                "assets/icons/Refresh_2_light.svg",
                color: ThemeUtils.isDarkMode(context)
                    ? Colors.white
                    : Colors.black,
                width: 30,

              ),
              onPressed: () {
                controller?.reload(); // Reload current URL
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Page Reloaded')),
                );
              },
            ),
          ],
        ),
        body: Hero(
          tag: "hero",
          child: SafeArea(
            child: Stack(
              children: [
                if (hasInternet)
                  InAppWebView(
                    initialUrlRequest: URLRequest(
                      url: WebUri(
                          "https://vidsrc.net/embed/movie/${widget.movieId}"),
                    ),
                    initialOptions: InAppWebViewGroupOptions(
                      crossPlatform: InAppWebViewOptions(
                        mediaPlaybackRequiresUserGesture: false,
                        javaScriptEnabled: true,
                      ),
                    ),
                    onWebViewCreated: (InAppWebViewController webController) {
                      controller = webController;
                    },
                    onLoadStop: (controller, url) {
                      setState(() {
                        isLoading = false;
                      });
                    },
                    onLoadError: (controller, url, code, message) {
                      setState(() {
                        isLoading = false;
                      });
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Failed to load video: $message'),
                          action: SnackBarAction(
                            label: 'Retry',
                            onPressed: () {
                              controller?.reload();
                            },
                          ),
                        ),
                      );
                    },
                  ),
                if (!hasInternet)
                  const Center(
                    child: Text(
                      "No internet connection. Please check your settings.",
                      textAlign: TextAlign.center,
                      style: TextStyle(color: AppColors.gold),
                    ),
                  ),
                if (isLoading)
                  const Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(height: 70),
                        Text("Loading movie...",
                            style: TextStyle(color: AppColors.gold)),
                      ],
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
