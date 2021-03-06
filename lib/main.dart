
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
 
import 'package:chatapp/routes/routes.dart';

import 'package:chatapp/services/auth_service.dart';
import 'package:chatapp/services/socket_service.dart';
void main() => runApp(MyApp());
 
class MyApp extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: ( _ ) => AuthService() ),
        ChangeNotifierProvider(create: ( _ ) => SocketService() ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Chat App',
        initialRoute: 'loading',
        // initialRoute: 'login',
        routes: appRoutes,
      ),
    );
  }

}