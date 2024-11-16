import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_app/core/global/resources/app_color.dart';
import 'package:movie_app/search/presentation/controller/search_events.dart';
import 'package:movie_app/settings/presentation/screens/history_screen.dart';
import 'package:movie_app/settings/presentation/screens/privacy_policy.dart';
import 'package:provider/provider.dart';
import '../controllers/manager/theme_notifier.dart';

class SettingsViewBody extends StatelessWidget {
  const SettingsViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    final darkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title: Text(
          "Settings",
          style: GoogleFonts.montserrat(
            fontSize: 26.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: ListView(
        children: [
          // Dark Mode Toggle
          ListTile(
            leading: Icon(
              Provider.of<ThemeNotifier>(context).themeMode == ThemeMode.dark
                  ? Icons.dark_mode
                  : Icons.light_mode,
            ),
            title: Text(
              "Dark Mode",
              style: GoogleFonts.poppins(),
            ),
            trailing: Switch(
              value: darkMode,
              onChanged: (value) {
                Provider.of<ThemeNotifier>(context, listen: false)
                    .toggleTheme(value ? ThemeMode.dark : ThemeMode.light);
              },
              activeTrackColor: AppColors.gold.withOpacity(0.6),
              activeColor: AppColors.gold,
            ),
          ),
          const Divider(),
          // Privacy & Security
          ListTile(
            leading: SvgPicture.asset(
              "assets/icons/Chield_check_light.svg",
              color: darkMode ? Colors.white : Colors.black,
              height: 27,
            ),
            title: Text(
              "Privacy & Security",
              style: GoogleFonts.poppins(),
            ),
            onTap: () {
              showModalBottomSheet(
                context: context,
                builder: (context) => Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ListTile(
                      leading: const Icon(Icons.description),
                      title: Text(
                        "Privacy Policy",
                        style: GoogleFonts.poppins(),
                      ),
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const PrivacyPolicyScreen()));
                      },
                    ),
                    ListTile(
                      leading: const Icon(Icons.history),
                      title: Text(
                        "Clear Search History",
                        style: GoogleFonts.poppins(),
                      ),
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const HistoryScreen()));
                      },
                    ),
                    ListTile(
                      leading: const Icon(Icons.analytics_outlined),
                      title: Text(
                        "Ads & Analytics Preferences",
                        style: GoogleFonts.poppins(),
                      ),
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) =>
                                const AdsAnalyticsPreferencesScreen(), // Replace with your actual screen widget
                          ),
                        );
                      },
                    )
                  ],
                ),
              );
            },
          ),

          const Divider(),

          // About
          ListTile(
            leading: SvgPicture.asset(
              "assets/icons/Info_light.svg",
              color: darkMode ? Colors.white : Colors.black,
              height: 27,
            ),
            title: Text(
              "About",
              style: GoogleFonts.poppins(),
            ),
            onTap: () {
              showAboutDialog(
                context: context,
                applicationName: "Streamix",
                applicationVersion: "1.0.0",
                applicationLegalese: "© 2024 Streamix Inc.",
                applicationIcon: Image.asset(
                  'assets/icons/app_icon_solid.png',
                  width: 80,
                  height: 80,
                ),
                barrierColor: darkMode
                    ? Colors.white.withOpacity(0.2)
                    : Colors.black.withOpacity(0.6),
              );
            },
          ),
          const Divider(),

          // Contact Us
          ListTile(
            leading: SvgPicture.asset(
              "assets/icons/Send_light.svg",
              color: darkMode ? Colors.white : Colors.black,
              height: 27,
            ),
            title: Text(
              "Contact Us",
              style: GoogleFonts.poppins(),
            ),
            onTap: () {
              showDialog(
                barrierColor: darkMode
                    ? Colors.white.withOpacity(0.2)
                    : Colors.black.withOpacity(0.6),
                context: context,
                builder: (context) => AlertDialog(
                  title: Text(
                    "Contact Us",
                    style: GoogleFonts.poppins(
                        color: darkMode ? Colors.white : Colors.black),
                  ),
                  content: Text(
                    "Email: alshnawyahmd668@gmail.com",
                    style: GoogleFonts.poppins(
                        color: darkMode ? Colors.white : Colors.black),
                  ),
                  actions: [
                    TextButton(
                      style: TextButton.styleFrom(
                        foregroundColor: AppColors.gold,
                      ),
                      onPressed: () {
                        Navigator.of(context).pop(true);
                      },
                      child: Text(
                        'Ok',
                        style: GoogleFonts.poppins(fontSize: 16.sp),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
          const Divider(),

          // App Version
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Center(
              child: Text(
                "App Version 1.0.0",
                style: GoogleFonts.poppins(color: Colors.grey),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class AdsAnalyticsPreferencesScreen extends StatelessWidget {
  const AdsAnalyticsPreferencesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final darkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Ads & Analytics Preferences",
          style: GoogleFonts.montserrat(
            fontSize: 17.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: darkMode ? Colors.black : Colors.white,
      ),
      body: Center(
        // Centering the main content vertically and horizontally
        child: Container(
          decoration: BoxDecoration(
            color: Theme.of(context).brightness == Brightness.dark
                ? Colors.grey[850]
                : Colors.white, // Change background based on theme
            borderRadius: BorderRadius.circular(12.0),
            boxShadow: const [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 8.0,
                offset: Offset(0, 4), // Changes position of shadow
              ),
            ],
          ),
          padding: EdgeInsets.all(16.0), // Padding inside the container
          width: 300.w, // Set a fixed width for the container (responsive)
          child: Column(
            mainAxisSize: MainAxisSize.min, // Use min size to center content
            children: [
              Text(
                "Manage your ads and analytics preferences here.",
                style: GoogleFonts.poppins(
                  color: AppColors.gold,
                  fontSize: 18.sp,
                ),
                textAlign: TextAlign.center, // Center align the text
              ),
              SizedBox(height: 20.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Enable Ads"),
                  Switch(
                    value: false,
                    onChanged: (value) {},
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
