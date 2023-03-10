import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:triviabro/Pages/Classifica/ElementoClassifica.dart';

import '../../Utilities/Api.dart';


class Classifica extends StatefulWidget {
  const Classifica({Key? key}) : super(key: key);

  @override
  _ClassificaState createState() => _ClassificaState();
}

class _ClassificaState extends State<Classifica> {

  /// Liste classifica
  List<String> username = [];
  List<int> punteggi = [];

  @override
  void initState() {
    getClassifica();
    super.initState();
  }

  /// Funzione che aggiorna la classifica
  void getClassifica() async {

    /// Richiesta alla api
    Api api = Api('http://localhost:30333/getClassifica');
    var data = await api.getData();

    /// Vengono aggiornati i punteggi
    for(int i = 0; i < data["classifica"].length; i++){
      setState(() {
        username.add(data["classifica"][i]["username"]);
        punteggi.add(data["classifica"][i]["punteggio"]);
      });
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      backgroundColor: Colors.blue[900],

      /// AppBar usata come padding
      appBar: AppBar(
        backgroundColor: Colors.white.withOpacity(0),
        leading: IconButton(
          icon: Icon(
              Icons.arrow_back_ios
          ),
          onPressed: (){
            Navigator.pop(context);
          },
        ),
        elevation: 0,
      ),

      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [

            /// Titolo pagina
            Text(
                "CLASSIFICA",
                style: GoogleFonts.pressStart2p(
                  textStyle: const TextStyle(
                    fontSize: 30,
                    letterSpacing: 2,
                    color: Colors.white,
                    fontWeight: FontWeight.w800,
                  ),
                )
            ),

            Padding(
              padding: EdgeInsets.only(
                top: 10,
                bottom: 10,
                right: MediaQuery.of(context).size.width / 3.3,
                left: MediaQuery.of(context).size.width / 3.3,
              ),
              child: const Divider(
                thickness: 3,
                color: Colors.white,
              ),
            ),

            /// Classifica
            Padding(
              padding: const EdgeInsets.only(
                bottom: 20
              ),
              child: SizedBox(
                width: MediaQuery.of(context).size.width / 2.8,
                child: elementoClassifica("Username", "Punteggio", ""),
              ),
            ),

            Flexible(
              child: Padding(
                padding: const EdgeInsets.only(
                  bottom: 30
                ),
                child: ListView.builder(
                    itemCount: username.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Center(
                        child: Padding(
                          padding: const EdgeInsets.only(
                            bottom: 10
                          ),
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width / 2.8,
                            child: elementoClassifica(username[index], punteggi[index].toString(), index.toString())
                          )
                        )
                      );
                    }
                ),
              )
            ),

          ],
        ),
      ),

    );
  }
}
