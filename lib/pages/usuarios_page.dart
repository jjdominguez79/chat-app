import 'package:flutter/material.dart';

import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'package:chatapp/models/usuario.dart';

class UsuariosPage extends StatefulWidget {
  @override
  _UsuariosPageState createState() => _UsuariosPageState();
}

class _UsuariosPageState extends State<UsuariosPage> {

  RefreshController _refreshController = RefreshController(initialRefresh: false);

  final List<Usuario> usuarios = [
    Usuario(uid: '1', nombre: 'Lucas', email: 'test1@test.com', onLine: true),
    Usuario(uid: '2', nombre: 'Juanjo', email: 'test2@test.com', onLine: true),
    Usuario(uid: '3', nombre: 'Mario', email: 'test3@test.com', onLine: false)
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 1.0,
        title: Text('Mi Nombre',style: TextStyle(color: Colors.black54)),
        backgroundColor: Colors.white,
        leading: IconButton(
          color: Colors.black54,
          icon: Icon(Icons.exit_to_app),
          onPressed:() {},
        ),
        actions: [
          Container(
            margin: EdgeInsets.only( right: 10.0 ),
            child: Icon( Icons.check_circle, color: Colors.blue[400]),
            // child: Icon( Icons.offline_bolt, color: Colors.red),
          )
        ],
      ),
      body: SmartRefresher(
        controller: _refreshController,
        enablePullDown: true,
        onRefresh: _cargarUsuarios,
        header: WaterDropHeader(
          complete: Icon(Icons.check, color: Colors.blue[400]),
          waterDropColor: Colors.blue[400],
        ),
        child: _listViewUsuarios(),
      )
    );
  }

  ListView _listViewUsuarios() {
    return ListView.separated(
      physics: BouncingScrollPhysics(),
      itemBuilder: (_, i) => _usuarioListTile( usuarios[i] ),
      separatorBuilder: (_ , i) => Divider(),
      itemCount: usuarios.length,
    );
  }

  ListTile _usuarioListTile( Usuario usuario ) {
    return ListTile(
        title: Text(usuario.nombre),
        subtitle: Text( usuario.email ),
        leading: CircleAvatar(
          backgroundColor: Colors.blue[100],
          child: Text(usuario.nombre.substring(0,2))
        ),
        trailing: Container(
          width: 10.0,
          height: 10.0,
          decoration: BoxDecoration(
            color: usuario.onLine ? Colors.green[300] : Colors.red,
            borderRadius: BorderRadius.circular(100)
          ),
        ),
      );
  }

  _cargarUsuarios() async {
    await Future.delayed(Duration(milliseconds: 1000));
    _refreshController.refreshCompleted();
  }

}