import 'package:flutter/material.dart';


class BotonAzulWidget extends StatelessWidget {
  
  final String titulo;
  final Function onPressed;

  const BotonAzulWidget({
    Key key, 
    @required this.titulo,
    @required this.onPressed
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      elevation: 2.0,
      highlightElevation: 5,
      color: Colors.blue,
      shape: StadiumBorder(),
      onPressed: this.onPressed,
      child: Container(
        width: double.infinity,
        height: 55.0,
        child: Center(
          child: Text(
            this.titulo, 
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white, fontSize: 17)
          )
        ),
      ),
    );
  }

}