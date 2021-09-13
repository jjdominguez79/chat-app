import 'package:chatapp/widgets/chat_message.dart';
import 'package:flutter/material.dart';

import 'dart:io';

import 'package:flutter/cupertino.dart';


class ChatPage extends StatefulWidget {

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> with TickerProviderStateMixin {

  final _textController = new TextEditingController();
  final _focusNode = new FocusNode();

  bool _estaEscribiendo = false;

  List<ChatMessage> _messages = [

  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Column(
          children: [
            CircleAvatar(
              child: Text('M&L', style: TextStyle(fontSize: 12)),
              backgroundColor: Colors.blue[100],
              maxRadius: 17,
            ),
            SizedBox(height: 3),
            Text('Mario&Lucas', style: TextStyle(color: Colors.black87, fontSize: 12))
          ],
        ),
        centerTitle: true,
      ),
      body: Container(
        child: Column(
          children: [

            Flexible(
              child: ListView.builder(
                physics: BouncingScrollPhysics(),
                itemBuilder: (_, i) => _messages[i],
                reverse: true,
                itemCount: _messages.length,
              ),
            ),

            Divider( height: 1.0 ),

            Container(
              color: Colors.white,
              child: _inputChat(),
            )

          ],
        ),
      ),
   );
  }

  Widget _inputChat() {

    return SafeArea(

      child: Container(
        margin: EdgeInsets.symmetric( horizontal: 10.0 ),
        child: Row(
          children: <Widget> [
            
            Flexible(
              child: TextField(
                controller: _textController,
                onSubmitted: _handleSubmit,
                onChanged: ( texto ){
                  setState(() {
                    if ( texto.trim().length > 0) {
                      _estaEscribiendo = true;
                    } else {
                      _estaEscribiendo = false;
                    }
                  });
                },
                decoration: InputDecoration.collapsed(
                  hintText: 'Enviar Mensaje'
                ),
                focusNode: _focusNode,
              )
            ),

            // Boton de Enviar
            Container(
              margin: EdgeInsets.symmetric( horizontal: 4.0 ),
              child: Platform.isIOS

              ? CupertinoButton(
                child: Text('Enviar'),
                onPressed: _estaEscribiendo
                    ? () => _handleSubmit( _textController.text.trim() )
                    : null,
              )
              
              : Container(
                margin: EdgeInsets.symmetric( horizontal: 4.0 ),
                child: IconTheme(
                  data: IconThemeData(color: Colors.blue[400]),
                  child: IconButton(
                    highlightColor: Colors.transparent,
                    splashColor: Colors.transparent,
                    icon: Icon( Icons.send ),
                    onPressed: _estaEscribiendo
                    ? () => _handleSubmit( _textController.text.trim() )
                    : null,
                  ),
                ),
              )

            )
          ] 
        ),
      )
    );

  }


  _handleSubmit( String texto ) {

    if ( texto.length == 0 ) return;

    _textController.clear();
    _focusNode.requestFocus();
    
    final newMessage = new ChatMessage(
      uid: '123',
      texto: texto,
      animationController: AnimationController(vsync: this, duration: Duration(milliseconds: 200)),
    );
    
    _messages.insert(0, newMessage);
    newMessage.animationController.forward();

    setState(() {
      _estaEscribiendo = false;
    });

  }

  @override
  void dispose() {
  
    for( ChatMessage message in _messages ) {
      message.animationController.dispose();
    }
    
    super.dispose();
  }

}