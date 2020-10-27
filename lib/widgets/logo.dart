import 'package:flutter/material.dart';

class LogoWidget extends StatelessWidget {

  final String titulo;

  const LogoWidget({
    Key key,
    @required this.titulo
  }) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 170.0,
        margin: EdgeInsets.only( top: 50 ),
        child: Column(
          children: [

            Image( image: AssetImage('assets/tag-logo.png') ),
            SizedBox( height: 20.0 ),
            Text( this.titulo, style: TextStyle(fontSize: 30.0) ),

          ],
        ) ,
      ),
    );
  }

}