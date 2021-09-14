import 'package:chatapp/pages/login_page.dart';
import 'package:chatapp/pages/usuarios_page.dart';
import 'package:chatapp/services/auth_service.dart';
import 'package:chatapp/services/socket_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class LoadingPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: checkLoginState( context),
        builder: ( context, snpashot ) { 
          return Center(
            child: Text('Autenticando.....', style: TextStyle( fontSize: 20) ),
          );
        }
      ),
   );
  }

  Future checkLoginState( BuildContext context) async{

    final authService = Provider.of<AuthService>(context, listen: false);
    final autenticado = await authService.isLoggedIn();
    final socketService = Provider.of<SocketService>(context, listen: false);

    if( autenticado ) {
      socketService.connect();
      Navigator.pushReplacement(
        context,
        PageRouteBuilder(
          pageBuilder: ( _, __, ___ ) => UsuariosPage(),
          transitionDuration: Duration( milliseconds: 0 )
        )
      );
    } else {
      Navigator.pushReplacement(
        context,
        PageRouteBuilder(
          pageBuilder: ( _, __, ___ ) => LoginPage(),
          transitionDuration: Duration( milliseconds: 0 )
        )
      );
    }

  }

}