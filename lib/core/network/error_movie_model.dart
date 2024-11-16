import 'package:equatable/equatable.dart';

class ErrorMovieModel extends Equatable {
  final String success;
  final String statusMessage;
  final bool statusCode;

  const ErrorMovieModel(
      {required this.success,
      required this.statusMessage,
      required this.statusCode});

  factory ErrorMovieModel.fromJson(Map<String, dynamic> json) {
    return ErrorMovieModel(
        success: json["success"],
        statusMessage: json["status_message"],
        statusCode: json["status_code"]);
  }

  @override
  List<Object?> get props => [success, statusCode, statusMessage];
}
