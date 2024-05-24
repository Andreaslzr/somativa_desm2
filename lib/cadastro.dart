import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:somativa/login.dart';

class Cadastro extends StatefulWidget {

  @override
  State<Cadastro> createState() => _CadastroState();
}

class _CadastroState extends State<Cadastro> {
  TextEditingController newuser = TextEditingController();
  TextEditingController newsenha = TextEditingController();
  bool exibir = true;
  _cadastrousuario(){
    Map<String,dynamic> users={
      "id": newuser.text,
      "login": newuser.text,
      "senha": newsenha.text,
    };
    String url = "http://10.109.83.25:3000/usuarios";
    if(newuser.text != ""){
      if(newsenha.text != "") {
        http.post(Uri.parse(url),
        headers:<String,String>{
          'Content-type': 'application/json; charset=UTF-8',
        } ,
        body: jsonEncode(users)
        );
        print("Cliente  cadastrado");
        newuser.text ="";
        newsenha.text = "";
        Navigator.push(context, MaterialPageRoute(builder: (context)=>Login()));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple.shade900,
        title:  Text("Mangeflix", style: TextStyle(color: Colors.white),),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 300,
              height: 300,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      keyboardType: TextInputType.name, // define o tipo de entrada do teclado
                      decoration: InputDecoration(border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      icon: Icon(Icons.people_alt_outlined),iconColor: Colors.deepPurpleAccent.shade700,
                      hintText: "Digite seu nome"                    
                      ),
                      controller: newuser,     
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      keyboardType: TextInputType.name, // define o tipo de entrada do teclado
                      decoration: InputDecoration(border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      icon: Icon(Icons.key),iconColor: Colors.deepPurpleAccent.shade700,
                      hintText: "Digite sua senha",
                      suffixIcon: IconButton(icon: Icon(exibir? Icons.visibility:Icons.visibility_off,
                       ),onPressed: (){
                        setState(() {
                          exibir =!exibir;
                        });
                      },    
                       ),                  
                      ),
                      obscureText: exibir ,
                      obscuringCharacter: "*",
                      controller: newsenha,
                    ),
                  ),
                ],
              ),     
            ),
           ElevatedButton(onPressed: _cadastrousuario, child: Text("Cadastrar")),
          ],         
        ),
      ),
    );
  }
}