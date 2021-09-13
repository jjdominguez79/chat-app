import 'package:chatapp/helpers/mostrar_alerta.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:chatapp/services/auth_service.dart';
import 'package:chatapp/widgets/boton_azul.dart';
import 'package:chatapp/widgets/custom_input.dart';
import 'package:chatapp/widgets/labels.dart';
import 'package:chatapp/widgets/logo.dart';

class LoginPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF2F2F2),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Container(
            height: MediaQuery.of(context).size.height * 0.9,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [

                LogoWidget(titulo: 'Messenger'),

                _Form(),

                LabelsWidget(
                  text: '¿No tienes cuenta?',
                  text2: 'Crea una cuenta ahora!',
                  ruta: 'register'
                ),

                Text('Terminos y condiciones de uso', style: TextStyle(fontWeight: FontWeight.w200) ),

              ],
            ),
          ),
        ),
      )
   );
  }

}


class _Form extends StatefulWidget {
  @override
  __FormState createState() => __FormState();
}

class __FormState extends State<_Form> {

  final emailCtrl = TextEditingController();
  final passwCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {

    final authService = Provider.of<AuthService>(context);

    return Container(
      margin: EdgeInsets.only( top: 40.0 ),
      padding: EdgeInsets.symmetric( horizontal: 50.0 ),
      child: Column(
        children: [
          
          CustomInput(
            icon: Icons.mail_outline,
            placeholder: 'Correo',
            keyboardType: TextInputType.emailAddress,
            isPassword: false,
            textController: emailCtrl,
          ),
          
          CustomInput(
            icon: Icons.lock_outline,
            placeholder: 'Contraseña',
            isPassword: true,
            textController: passwCtrl,
          ),
          
          BotonAzulWidget(
            titulo: 'Ingresar',
            onPressed: ( authService.autenticando ) ? null : () async {
              FocusScope.of(context).unfocus();
              final loginOk = await authService.login(emailCtrl.text.trim(), passwCtrl.text.trim());

              if (loginOk) {
                Navigator.pushReplacementNamed(context, 'usuarios');
              } else {
                mostrarAlerta(context, 'Login Incorrecto', 'Revise sus credenciales.');
              }
            },
          )
        ],
      ),
    );
  }
}
