import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:movie_app/movies/presentation/screens/movies_screen.dart';
import 'package:provider/provider.dart';
import '../../../core/utils/styles.dart';
import '../../../favourites/presentation/favoutite_screen.dart';
import '../../../search/presentation/screens/search_view.dart';
import '../../../settings/presentation/screens/settings_view_body.dart';
import '../manager/navigation_provider.dart';
import 'package:curved_labeled_navigation_bar/curved_navigation_bar.dart';
import 'package:curved_labeled_navigation_bar/curved_navigation_bar_item.dart';

class CurvedNavigationBarScreen extends StatefulWidget {
  const CurvedNavigationBarScreen({super.key});

  @override
  State<CurvedNavigationBarScreen> createState() =>
      _CurvedNavigationBarScreenState();
}

class _CurvedNavigationBarScreenState extends State<CurvedNavigationBarScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final navigationProvider = Provider.of<NavigationProvider>(context);
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      body: _getScreen(navigationProvider.currentPageIndex),
      bottomNavigationBar: CurvedNavigationBar(
        height: 70.h,
        backgroundColor: const Color(0xffEB5757),
        animationCurve: Curves.easeInOut,
        animationDuration: const Duration(milliseconds: 500),
        color: Theme.of(context).scaffoldBackgroundColor,
        items: [
          CurvedNavigationBarItem(
            child: SvgPicture.asset("assets/icons/Home_light.svg",
                width: 30,
                height: 30,
                color: isDarkMode ? Colors.white : Colors.black),
            label: 'Home',
            labelStyle: AppStyles.style6(context),
          ),
          CurvedNavigationBarItem(
            child: AnimatedBuilder(
              animation: _animationController,
              builder: (context, child) {
                // Scale animation for the search icon
                double scale = navigationProvider.currentPageIndex == 1
                    ? 1 + 0.2 * _animationController.value // Scale up to 1.2
                    : 1.0;

                return Transform.scale(
                  scale: scale,
                  child: Transform.rotate(
                    angle: navigationProvider.currentPageIndex == 1
                        ? _animationController.value * 2 * 3.14159
                        : 0,
                    child: SvgPicture.asset(
                      "assets/icons/Search_duotone.svg",
                      width: 25,
                      height: 25,
                      color: isDarkMode ? Colors.white : Colors.black,
                    ),
                  ),
                );
              },
            ),
            label: 'Search',
            labelStyle: AppStyles.style6(context),
          ),
          CurvedNavigationBarItem(
            child: AnimatedBuilder(
              animation: _animationController,
              builder: (context, child) {
                // Scale animation for the favorite icon
                double scale = navigationProvider.currentPageIndex == 2
                    ? 1 + 0.2 * _animationController.value // Scale up to 1.2
                    : 1.0;

                return Transform.scale(
                  scale: scale,
                  child: SvgPicture.asset("assets/icons/Favorite_light.svg",
                      width: 25,
                      height: 25,
                      color: isDarkMode ? Colors.white : Colors.black),
                );
              },
            ),
            label: 'Favorite',
            labelStyle: AppStyles.style6(context),
          ),
          CurvedNavigationBarItem(
            child: AnimatedBuilder(
              animation: _animationController,
              builder: (context, child) {
                bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
                return SvgPicture.asset(
                  "assets/icons/Setting_line_light.svg",
                  width: 25,
                  height: 25,
                  color: isDarkMode ? Colors.white : Colors.black,
                );
              },
            ),
            label: 'Settings',
            labelStyle: AppStyles.style6(context),
          )

        ],
        onTap: (index) {
          // Update the current index using the NavigationProvider
          navigationProvider.setCurrentPageIndex(index);

          // Play the animation for the search and favorite icons when selected
          if (index == 1 || index == 2 || index == 3) {
            _animationController.forward(from: 0).then((_) {
              _animationController.reverse();
            });
          }
        },
      ),
    );
  }

  // Helper method to return the current screen based on index
  Widget _getScreen(int index) {
    switch (index) {
      case 0:
        return const MoviesScreen();
      case 1:
        return const SearchView();
      case 2:
        return FavoriteScreen();
      case 3:
        return const SettingsViewBody();
      default:
        return const MoviesScreen();
    }
  }
}
