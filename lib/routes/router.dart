import 'package:app/models/log_response.dart';
import 'package:app/models/models.dart';
import 'package:app/screens/view_log.dart';
import 'package:flutter/material.dart';
import 'package:app/screens/screens.dart';

final Map<String, Widget Function(BuildContext)> appRoutes = {
  'loading'   : (context) => const LoadingScreen(),
  'login'     : (context) => const LoginScreen(),
  'home'      : (context) => const HomeScreen(),
  'details'   : (context) => const DetailService(),
  'feedback'  : (context) =>  FeedbackScreen(arguments: ModalRoute.of(context)?.settings.arguments as Service),
  'ranking'   : (context) => const RankingScreen(),
  'log'       : (context) => const LogScreen(),
  'ratings'   : (context) => const RatingScreen(),
  'viewlog'   : (context) => ViewLog(service: ModalRoute.of(context)?.settings.arguments as Bitacora)
};