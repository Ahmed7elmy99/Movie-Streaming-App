import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movie_app/curved_navigation_bar/presentaion/manager/navigation_provider.dart';
import 'package:movie_app/search/presentation/controller/history_bloc.dart';
import 'package:movie_app/search/presentation/controller/history_events.dart';
import 'package:movie_app/settings/presentation/controllers/manager/theme_notifier.dart';
// ignore: depend_on_referenced_packages
import 'package:provider/provider.dart';
import 'package:movie_app/core/utils/app_strings.dart';
import 'Splash/presentation/views/screens/splash_view.dart';
import 'core/services/service_locator.dart';
import 'core/global/theme/theme_data/theme_data_light.dart';
import 'core/global/theme/theme_data/theme_data_dark.dart';
import 'favourites/presentation/controller/favourite_screen_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await ScreenUtil.ensureScreenSize();
  await dotenv.load(fileName: ".env");


  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
  ]);

  ServiceLocator().init();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeNotifier()),
        ChangeNotifierProvider(create: (_) => NavigationProvider()),
        ChangeNotifierProvider(create: (_) => FavoriteMovieProvider()),

      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => getIt<HistoryBloc>()..add(LoadHistory())),
        ],
      child: const MyApp(),
    ),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeNotifier>(
      builder: (context, themeNotifier, child) {
        ScreenUtil.init(context);
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: AppStrings.appName,
          theme: lightTheme,
          darkTheme: darkTheme,
          themeMode: themeNotifier.themeMode,
          home: const SplashView(),
        );
      },
    );
  }
}
