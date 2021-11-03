import 'package:flutter/material.dart';
import 'package:loja_virtual/models/user_model.dart';
import 'package:loja_virtual/tiles/drawer_tile.dart';
import 'package:loja_virtual/screens/login_screen.dart';
import 'package:scoped_model/scoped_model.dart';

class CustomDrawer extends StatelessWidget {

  final PageController pageController;

  CustomDrawer(this.pageController);

  @override
  Widget build(BuildContext context) {

    Widget _buildDrawerBack() => Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [
                Color.fromARGB(255, 203, 236, 241),
                Colors.white
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter
          )
      ),
    );


    return Drawer(
      child: ScopedModelDescendant<UserModel>(
        builder: (context, child, model){
           return Stack(
            children: <Widget>[
              _buildDrawerBack(),
              ListView(
                padding: EdgeInsets.only(left: 32.0, top:  16.0),
                children: <Widget>[
                  Container(
                      margin: EdgeInsets.only(bottom: 8.0),
                      padding: EdgeInsets.fromLTRB(0.0, 16.0, 16.0, 8.0),
                      height: 170.0,
                      child: Stack(
                        children: <Widget>[
                          Positioned(
                            top: 8.0,
                            left: 0.0,
                            child: Text("Flutter'S\nClothing",
                                style: TextStyle(fontSize: 34.0, fontWeight: FontWeight.bold)
                            ),
                          ),
                          Positioned(
                            left: 0.0,
                            bottom: 0.0,
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text("olá," ,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18.0
                                    ),
                                  ),
                                  GestureDetector(
                                    child: Text(
                                      !model.isLoggedIn() ?
                                      "Entre ou Cadastre-se >"
                                      : "Sair",
                                      style: TextStyle(
                                          color: Theme.of(context).primaryColor,
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.bold
                                      ),
                                    ),
                                    onTap: (){
                                      if(!model.isLoggedIn())
                                      Navigator.of(context).push(
                                          MaterialPageRoute(builder: (context)=>LoginScreen())
                                      );
                                      else
                                        model.signOut();
                                    },
                                  ),
                                ]
                            ),
                          )
                        ],
                      )
                  ),
                 Divider(),
                  if(model.isLoggedIn())
                 DrawerTile(Icons.home, "início", pageController, 0),
                  DrawerTile(Icons.location_on, "Lojas", pageController, 2),
                  DrawerTile(Icons.playlist_add_check, "Meus Pedidos", pageController, 3),
                 DrawerTile(Icons.list, "produtos", pageController, 1),


                ],
              )
            ],
          );
        }
      )
    );
  }
}


