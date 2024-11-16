import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key,});

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Privacy Policy",
          style: GoogleFonts.montserrat(
            fontSize: 26.sp,
            fontWeight: FontWeight.bold,

            color: isDarkMode ? Colors.white : Colors.black,
          ),
        ),
        backgroundColor: isDarkMode ? Colors.black : Colors.white,
        iconTheme: IconThemeData(
          color: isDarkMode ? Colors.white : Colors.black,
        ),
      ),
      backgroundColor: isDarkMode ? Colors.black : Colors.white,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: RichText(
          text: TextSpan(
            style: GoogleFonts.poppins(
              fontSize: 16,
              color: isDarkMode ? Colors.white70 : Colors.black87,
            ),
            children: <TextSpan>[
              TextSpan(
                text: 'Introduction\n',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: isDarkMode ? Colors.white : Colors.black,
                ),
              ),
              const TextSpan(
                text: 'At Streamix, we respect your privacy and are committed to protecting your personal information. This privacy policy outlines how we collect, use, and safeguard your data.\n\n',
              ),
              const TextSpan(
                text: '1. Information Collection\n',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const TextSpan(
                text: 'We collect information that helps us personalize your experience, such as:\n'
                    '- Account details (e.g., email, username).\n'
                    '- Movie preferences and viewing history.\n'
                    '- Device information and IP address.\n\n',
              ),
              const TextSpan(
                text: '2. How We Use Your Data\n',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const TextSpan(
                text: 'The information we collect is used to:\n'
                    '- Provide personalized movie recommendations.\n'
                    '- Improve the app’s features and performance.\n'
                    '- Send notifications on new releases and updates.\n'
                    '- Analyze user behavior to enhance our service.\n\n',
              ),
              const TextSpan(
                text: '3. Data Sharing\n',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const TextSpan(
                text: 'We may share your data with third-party services to enable:\n'
                    '- Ad services that help keep the app free.\n'
                    '- Analytics tools for app improvement.\n'
                    'However, we do not sell your personal information to third parties.\n\n',
              ),
              const TextSpan(
                text: '4. Advertising Preferences\n',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const TextSpan(
                text: 'You have the option to adjust ad and analytics preferences within the app settings. Disabling ads may affect the availability of some features.\n\n',
              ),
              const TextSpan(
                text: '5. Security\n',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const TextSpan(
                text: 'We implement security measures to protect your data. However, please remember that no method of transmission over the internet is 100% secure.\n\n',
              ),
              const TextSpan(
                text: '6. User Rights\n',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const TextSpan(
                text: 'You have the right to:\n'
                    '- Access, modify, or delete your personal data.\n'
                    '- Opt-out of certain data collection practices.\n'
                    'Contact us if you wish to exercise these rights.\n\n',
              ),
              const TextSpan(
                text: '7. Changes to This Policy\n',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const TextSpan(
                text: 'We may update this policy periodically. You will be notified of any significant changes, and the updated policy will be available in the app.\n\n',
              ),
              const TextSpan(
                text: 'Contact Us\n',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const TextSpan(
                text: 'If you have any questions about this privacy policy, please contact us at:\n'
                    'Email: support@streamix.com\n'
                    'Phone: +123 456 7890\n\n',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
