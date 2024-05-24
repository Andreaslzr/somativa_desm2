import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class MoviesScreen extends StatefulWidget {
  const MoviesScreen({super.key});

  @override
  State<MoviesScreen> createState() => _MoviesScreenState();
}

class _MoviesScreenState extends State<MoviesScreen> {
  void initState(){
    super.initState();
    lerdados();
  }
  List  dado =[];
  Future<void> lerdados() async{
    String url = "https://raw.githubusercontent.com/danielvieira95/DESM-2/master/filmes.json";
    http.Response resposta = await http.get(Uri.parse(url));
   
      if(resposta.statusCode ==200){
        setState(() {
        dado = jsonDecode(resposta.body)  as List<dynamic>;// conversao dos produtos para uma lista convertendo do formato json
        });
      }
      else {
        print(resposta.statusCode);
        throw Exception('Falha ao consumir api');
      } 
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Filmes", style: TextStyle(color: Colors.white),),
          backgroundColor: Colors.purple.shade900,
        ),
        body: Center(
        child:       
          ListView.builder(
            itemCount: dado.length,
            itemBuilder:(context,index ){
            final filme = dado[index];
            return ListTile(
            title: Text("Título: ${filme["nome"]}",style: TextStyle(fontSize: 18),
            textAlign: TextAlign.center,),
            subtitle: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.network(filme["imagem"]),
                ),
                Text("Duração: ${filme["duração"]}",style: TextStyle(fontSize: 18),),              
                Text("Ano de lançamento: ${filme["ano de lançamento"]}",style: TextStyle(fontSize: 18),),                
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("Nota: ${filme["nota"]}",style: TextStyle(fontSize: 18),),
                ),
              ],
            ),
            );
            } ),
            
      ),
    );
    
  }
}

class filmes{
  String nome;
  String img;
  String duracao;
  String ano;
  String nota;
  filmes(this.nome, this.img, this.duracao, this.ano,this.nota);
  factory filmes.fromJson(Map<String, dynamic> json){
    return filmes(json['nome'],json['imagem'],json['duração'],json['ano de lançamento'],json['nota']);
  }
}