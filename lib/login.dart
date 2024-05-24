import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:somativa/cadastro.dart';
import 'dart:convert';
import 'package:somativa/filmes.dart';


class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController user = TextEditingController();
  TextEditingController senha = TextEditingController();
  bool exibir = true;
  _verificarlogin() async{

   String url = "http://10.109.83.25:3000/usuarios";
   http.Response resposta = await http.get(Uri.parse(url));
   bool login= false;
   List users = <Usuario>[];
   users = json.decode(resposta.body) ;
   for (int i=0; i<users.length; i++){
    if(user.text == users[i]["login"] && senha.text == users[i]["senha"]){
      login = true;
    }  
   }
   if(login ==true){
      print("Usuario encontrado");
      Navigator.push(context, MaterialPageRoute(builder: (context)=>MoviesScreen()));
      login = false;
      user.text="";
      senha.text="";
    }

    else{
      print("Usuario nao encontrado, realize o cadastro");
        ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Usuário não cadastrado"),duration: Duration(seconds: 2),),);
        login = false;
        showDialog(
          context: context,
          builder: (BuildContext) {
            return AlertDialog(
              content: Text('Usuário inválido, cadastre-se'),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text('Fechar'))
              ],
            );
          });
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple.shade900,
        title: Text("Mangeflix", style: TextStyle(color: Colors.white),),
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
                        borderRadius: BorderRadius.circular(20),
                      ),
                      icon: Icon(Icons.people_alt_outlined),iconColor: Colors.deepPurpleAccent.shade700,
                      hintText: "Digite seu nome"
                      ),
                      controller: user,        
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      keyboardType: TextInputType.name, // define o tipo de entrada do teclado
                      decoration: InputDecoration(border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
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
                      controller: senha,      
                    ),
                  ),
                ],
              ),      
            ),
           ElevatedButton(onPressed: _verificarlogin, child: Text("Entrar")),
            ElevatedButton(onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>Cadastro()));
            }, child: Text("Cadastrar")),
          ], 
        ),
      ),
    );
  }
}

class Usuario{
  String id;
  String login;
  String senha;
  Usuario(this.id, this.login, this.senha);
  factory Usuario.fromJson(Map<String,dynamic> json){
    return Usuario(json["id"],json["login"],json["senha"]);
  }
}