import 'dart:convert';

import 'package:chatapp/models/usuario.dart';

LoginResponse loginResponseFromJson(String str) => LoginResponse.fromJson(json.decode(str));

String loginResponseToJson(LoginResponse data) => json.encode(data.toJson());

class LoginResponse {
    
  Usuario usuario;
  bool ok;
  String token;
    
  LoginResponse({
    this.ok,
    this.usuario,
    this.token,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) => LoginResponse(
    ok      : json["ok"],
    usuario : Usuario.fromJson(json["usuario"]),
    token   : json["token"],
  );

  Map<String, dynamic> toJson() => {
    "ok"      : ok,
    "usuario" : usuario.toJson(),
    "token"   : token,
  };

}

