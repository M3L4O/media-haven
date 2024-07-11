import 'package:flutter/material.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigo,
        title: const Text(
          'Dashboard',
            style: TextStyle(
            color: Colors.white,
          ),
        ),
        centerTitle: true,
      ),
      drawer: Drawer(
        child: Column(
          children: <Widget>[
            Container(
              color: const Color.fromRGBO(71, 86, 197, 1),
              child: const Padding(
                padding: EdgeInsets.all(20),
                child: Row(
                  children: [
                      CircleAvatar(
                        backgroundImage: AssetImage('path_to_image'),
                        radius: 25,
                      ),
                      SizedBox(width: 10),
                      Text( // Trocar a string 'nomeDeUsuario' pelo nome do usuário
                        'nomeDeUsuario',
                        style:
                          TextStyle(fontSize: 16, color: Colors.white),
                      ),
                  ],
                ),
               ),
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text('Configurações'),
              onTap: () {
                // Handle Configurações action
              },
            ),
            Spacer(),
            ListTile(
              leading: Icon(Icons.exit_to_app),
              title: Text('Sair'),
              onTap: () {
                // Handle Sair action
              },
            ),
          ],
        )
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 10.0),
        child: GridView.builder(
          padding: const EdgeInsets.all(10.0),
          itemCount: 10,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 5, // Número de colunas
            crossAxisSpacing: 20.0,
            mainAxisSpacing: 20.0,
          ),
          itemBuilder: (BuildContext context, int index) {
            return Container(
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Center(
                child: Text('Media $index'),
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Adicionar mídias
        },
        child: Icon(
            Icons.add,
            color: Colors.white
        ),
        backgroundColor: Color(0xFF2C23B2),
        tooltip: 'Adicionar Mídias',
      ),
    );
  }
}
