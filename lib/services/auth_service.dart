import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:chatapp/global/environment.dart';
import 'package:chatapp/models/login_response.dart';
import 'package:chatapp/models/usuario.dart';

class AuthService with ChangeNotifier{

  Usuario usuario;
  bool _autenticando = false;

  // Crear Storage
  final _storage = new FlutterSecureStorage();

  // Getter del token de forma estagtica
  static Future<String> getToken() async {
    // Como es un metodo estatico no podemos acceder a las propiedades de la clase y tenemos que instanciar de nuevo
    final _storage = new FlutterSecureStorage(); 
    final token = await _storage.read(key: 'token');
    return token;
  }
  static Future<void> deleteToken() async {
    // Como es un metodo estatico no podemos acceder a las propiedades de la clase y tenemos que instanciar de nuevo
    final _storage = new FlutterSecureStorage(); 
    await _storage.delete(key: 'token');
  }

  // Getter y Setter del autenticando
  bool get autenticando => _autenticando;
  set autenticando( bool valor ){
    this._autenticando = valor;
    notifyListeners();
  }

  Future<bool> login( String email, String password) async {

    this.autenticando = true;

    final data = {
      'email': email,
      'password': password
    };

    final url = Uri.parse('${ Environment.apiURL}/login');

    final resp = await http.post( url,
      body: jsonEncode(data),
      headers: {'Content-Type': 'application/json' }

    );

    this.autenticando = false;
    
    // Si el login es correcto vamos a mapear la respuesta
    if ( resp.statusCode == 200 ){
      final loginResponse = loginResponseFromJson(resp.body);
      this.usuario = loginResponse.usuario;

      await this._guardarToken(loginResponse.token);
      
      return true;
    } else {
      return false;
    }

  }

  Future register( String nombre, String email, String password) async {

    this.autenticando = true;

    final data = {
      'nombre'   : nombre,
      'email'    : email,
      'password' : password
    };

    final url = Uri.parse('${ Environment.apiURL}/login/new');

    final resp = await http.post( url,
      body: jsonEncode(data),
      headers: {'Content-Type': 'application/json' }
    );

    this.autenticando = false;
    
    // Si el registro es correcto vamos a mapear la respuesta
    if ( resp.statusCode == 200 ){
      final loginResponse = loginResponseFromJson(resp.body);
      this.usuario = loginResponse.usuario;
      await this._guardarToken(loginResponse.token);
      
      return true;
    } else {

      final respBody = jsonDecode(resp.body);
      return respBody['msg'];
    }

  }

  Future<bool> isLoggedIn() async {
    
    final token = await this._storage.read(key: 'token');
    final url = Uri.parse('${ Environment.apiURL}/login/renew');
    final resp = await http.get( url,
      headers: {
        'Content-Type': 'application/json',
        'x-token': token
      }
    );

    if ( resp.statusCode == 200 ){
      final loginResponse = loginResponseFromJson(resp.body);
      this.usuario = loginResponse.usuario;
      await this._guardarToken(loginResponse.token);
      return true;
    } else {
      this.logout();
      return false;
    }

  }

  Future _guardarToken( String token) async {
    return await _storage.write(key: 'token', value: token);
  }

  Future logout() async {
    await _storage.delete(key: 'token');
  }

}