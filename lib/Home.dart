import 'package:flutter/material.dart';
import 'package:minhas_viagens/Mapa.dart';
class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List _listaViagens = [
    "Cristo Redentor",
    "Grande Muralha da China",
    "Taj Mahal",
    "Machu Picchu",
    "Coliseu"
  ];
  _abrirMapa(){

  }
  _excluirViagem(){

  }
  _adicionarLocal(){
    Navigator.push(
        context,
        MaterialPageRoute(builder: (_)=>AbrirMapa())
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Minhas viagens"),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        backgroundColor: Color(0xff0066cc),
        onPressed: (){
          _adicionarLocal();
        },
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: ListView.builder(
              itemCount: _listaViagens.length,
              itemBuilder: (context, index){
                String titulo = _listaViagens[index];
                return GestureDetector(
                  onTap: (){
                    _abrirMapa();
                  },
                  child: Card(
                    child: ListTile(
                      title: Text(titulo),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          GestureDetector(
                            onTap: (){
                              _excluirViagem();
                            },
                            child: Padding(
                              padding: EdgeInsets.all(8),
                              child: Icon(Icons.remove_circle, color: Colors.red,),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
