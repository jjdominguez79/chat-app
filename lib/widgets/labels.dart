import 'package:flutter/material.dart';

class LabelsWidget extends StatelessWidget {
  
  final String ruta;
  final String text;
  final String text2;

  const LabelsWidget({
    Key key,
    @required this.ruta,
    @required this.text,
    @required this.text2
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Text(this.text, style: TextStyle(color: Colors.black54, fontSize: 15, fontWeight: FontWeight.w300)),
          SizedBox(height: 10),
          GestureDetector(
            child: Text(this.text2, style: TextStyle(color: Colors.blue[600], fontSize: 18, fontWeight: FontWeight.bold)),
            onTap: () => Navigator.pushReplacementNamed( context, ruta ),
          )
        ],
      ),
    );
  }

}