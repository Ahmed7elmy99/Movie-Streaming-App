import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/global/resources/app_color.dart';
import '../../../search/presentation/controller/history_bloc.dart';
import '../../../search/presentation/controller/history_events.dart';
import '../../../search/presentation/controller/history_state.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final darkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Search History',
          style: GoogleFonts.montserrat(
            fontSize: 26.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: darkMode ? Colors.black : Colors.white,
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          context.read<HistoryBloc>().add(ClearHistory());
        },
        label: Text(
          'Clear All',
          style: TextStyle(
            color: darkMode ? Colors.white : Colors.black,
            fontSize: 15.sp,
          ),
        ),
        icon: SvgPicture.asset(
          "assets/icons/Trash_light.svg",
          color: darkMode ? Colors.white : Colors.black,
        ),
        backgroundColor: Colors.red,
      ),
      body: BlocBuilder<HistoryBloc, HistoryState>(
        builder: (context, state) {
          bool isArabic(String text) {
            return RegExp(r'^[\u0600-\u06FF]')
                .hasMatch(text); // Arabic Unicode range
          }

          if (state is HistoryLoading) {
            return const Center(
              child: CircularProgressIndicator(color: AppColors.gold),
            );
          } else if (state is HistoryLoaded) {
            if (state.history.isEmpty) {
              return Center(
                child: Text(
                  'No search history found.',
                  style: GoogleFonts.poppins(
                    color: AppColors.gold,
                    fontSize: 18.sp,
                  ),
                ),
              );
            }
            return ListView.builder(
                itemCount: state.history.length,
                itemBuilder: (context, index) {
                  final entry = state.history[index];
                  return Column(
                    children: [
                      ListTile(
                        leading: Icon(Icons.history, color: Colors.grey[700]),
                        title: Text(
                          entry.query,
                          style: GoogleFonts.poppins(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                          textDirection: isArabic(entry.query)
                              ? TextDirection.rtl
                              : TextDirection.ltr,
                        ),
                        subtitle: Text(
                          isArabic(entry.query)
                              ? 'تم البحث في: ${entry.timestamp.toLocal().toString().split('.')[0]}'
                              : 'Searched on: ${entry.timestamp.toLocal().toString().split('.')[0]}',
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                            fontStyle: FontStyle.italic,
                            color: Colors.grey[600],
                          ),
                          textDirection: isArabic(entry.query)
                              ? TextDirection.rtl
                              : TextDirection.ltr,
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.0),
                        child: Divider(
                          color: Colors.grey,
                          thickness: 0.5,
                        ),
                      ),
                    ],
                  );
                });
          } else {
            return Center(
              child: Text(
                'Failed to load search history.',
                style: GoogleFonts.poppins(
                  color: AppColors.gold,
                  fontSize: 18.sp,
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
