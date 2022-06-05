import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:app/providers/providers.dart';
import 'package:app/routes/router.dart';
import 'package:app/screens/log_screen.dart';
import 'package:app/services/auth_service.dart';
import 'package:app/services/log_service.dart';
import 'package:app/services/service_query.dart';
import 'package:app/theme/app_theme.dart';

void main() => runApp( const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_)=>AuthService()),
        ChangeNotifierProvider(create: (_)=>SocketProvider()),
        ChangeNotifierProvider(create: (_)=>ServiceQuery()),
        ChangeNotifierProvider(create: (_)=>FeedBackProvider()),
        ChangeNotifierProvider(create: (_)=>UsersSiteProvider()),
        ChangeNotifierProvider(create: (_)=>LogService()),
        ChangeNotifierProvider(create: (_)=>LogSearchProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: Apptheme.lightTheme,
        title: 'App',
        initialRoute: 'loading',
        routes: appRoutes,
      ),
    );
  }
}