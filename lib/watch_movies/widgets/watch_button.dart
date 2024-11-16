import 'package:flutter/material.dart';

import '../screens/watch_movies.dart';

class WatchNowButton extends StatefulWidget {
  final int movieId;

  const WatchNowButton({Key? key, required this.movieId}) : super(key: key);

  @override
  _WatchNowButtonState createState() => _WatchNowButtonState();
}

class _WatchNowButtonState extends State<WatchNowButton> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: isLoading
          ? null
          : () async {
        setState(() {
          isLoading = true;
        });
        await Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => WatchMovieScreen(movieId: widget.movieId),
          ),
        );
        setState(() {
          isLoading = false;
        });
      },
      child: isLoading
          ? const CircularProgressIndicator(color: Colors.white)
          : const Text('Watch Movie'),
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        backgroundColor: Colors.yellow,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}
