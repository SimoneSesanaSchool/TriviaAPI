import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:triviabro/Utilities/Api.dart';

class Gioca extends StatefulWidget {
  const Gioca({Key? key}) : super(key: key);

  @override
  _GiocaState createState() => _GiocaState();
}

class _GiocaState extends State<Gioca> {

  String username = "";
  int punteggio = 0;
  int indiceDomanda = 0;

  bool haiPerso = false;

  /// Domande gia uscite
  String domandeGiaUscite = "-1";

  /// Domanda e risposte
  String domanda = "domanda";
  String risposta1 = "risposta1";
  String risposta2 = "risposta2";
  String risposta3 = "risposta3";
  String risposta4 = "risposta4";

  /// Funzione per generare una domanda
  void getDomanda() async {

    Api api = Api('http://localhost:30333/getDomanda?domandeGiaUscite=$domandeGiaUscite');
    var data = await api.getData();

    setState(() {
      domanda = data["domanda"];
      risposta1 = data["risposta1"];
      risposta2 = data["risposta2"];
      risposta3 = data["risposta3"];
      risposta4 = data["risposta4"];
      indiceDomanda = data["numeroDomanda"];
      domandeGiaUscite = domandeGiaUscite + ", $indiceDomanda";
    });

  }

  /// Funzione per inviare la risposta e verificarne la correttezza
  void inviaRisposta(int indiceRisposta) async {


    Api api = Api('http://localhost:30333/verificaRisposta?numeroDomanda=$indiceDomanda&numeroRisposta=$indiceRisposta');
    var data = await api.getData();

    if(data["corretta"] == "si") {
      setState(() {
        punteggio = punteggio + 1;
        getDomanda();
      });
    } else {

      /// Aggiornamento classifica
      Api api = Api('http://localhost:30333/aggiornaClassifica?username=$username&punteggio=$punteggio');
      var data = await api.getData();

      setState(() {
        haiPerso = true;
      });
    }

  }

  @override
  void initState() {
    getDomanda();
    super.initState();
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

      /// Se lo username non è stato ancora inserito viene visualizzata la
      /// pagina di inserimento
      body: haiPerso ? Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
                "Hai perso\nIl tuo punteggio: $punteggio",
                textAlign: TextAlign.center,
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
              padding: const EdgeInsets.only(
                  top: 20
              ),
              child: TextButton(
                onPressed: () {
                  setState(() {
                    getDomanda();
                    domandeGiaUscite = "-1";
                    haiPerso = false;
                    punteggio = 0;
                  });
                },
                style: TextButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)
                    ),
                    padding: EdgeInsets.fromLTRB(30, 25, 30, 20),
                    backgroundColor: Colors.grey.withOpacity(0.5)
                ),
                child: Text(
                    "GIOCA ANCORA",
                    style: GoogleFonts.pressStart2p(
                      textStyle: const TextStyle(
                        fontSize: 17,
                        letterSpacing: 2,
                        color: Colors.white,
                        fontWeight: FontWeight.w800,
                      ),
                    )
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  top: 20
              ),
              child: TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                style: TextButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)
                    ),
                    padding: EdgeInsets.fromLTRB(30, 25, 30, 20),
                    backgroundColor: Colors.grey.withOpacity(0.5)
                ),
                child: Text(
                    "TORNA AL MENU",
                    style: GoogleFonts.pressStart2p(
                      textStyle: const TextStyle(
                        fontSize: 17,
                        letterSpacing: 2,
                        color: Colors.white,
                        fontWeight: FontWeight.w800,
                      ),
                    )
                ),
              ),
            )
          ],
        )


      ) : (
          username == "" ? Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [

                /// Label username
                Text(
                    "INSERISCI USERNAME:",
                    style: GoogleFonts.pressStart2p(
                      textStyle: const TextStyle(
                        fontSize: 16,
                        letterSpacing: 2,
                        color: Colors.white,
                        fontWeight: FontWeight.w800,
                      ),
                    )
                ),

                /// Inserimento username
                Padding(
                  padding: EdgeInsets.only(
                      left: MediaQuery.of(context).size.width /3,
                      right: MediaQuery.of(context).size.width /3,
                      top: 10
                  ),
                  child: TextFormField(
                    onEditingComplete: (){
                      FocusManager.instance.primaryFocus?.unfocus();
                    },
                    cursorColor: Colors.white,
                    style: GoogleFonts.pressStart2p(
                      textStyle: const TextStyle(
                        fontSize: 17,
                        letterSpacing: 2,
                        color: Colors.white,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(

                      // Border decoration
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(
                          color: Colors.white,
                          width: 1.5,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(
                          color: Colors.white,
                          width: 1,
                        ),
                      ),

                    ),
                    onChanged: (String value){
                      username = value;
                    },
                  ),
                ),

                /// Bottone gioca
                Padding(
                  padding: const EdgeInsets.only(
                      top: 20
                  ),
                  child: TextButton(
                    onPressed: () {
                      setState(() {
                        username = username;
                      });
                    },
                    style: TextButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)
                        ),
                        padding: EdgeInsets.fromLTRB(30, 25, 30, 20),
                        backgroundColor: Colors.grey.withOpacity(0.5)
                    ),
                    child: Text(
                        "GIOCA",
                        style: GoogleFonts.pressStart2p(
                          textStyle: const TextStyle(
                            fontSize: 30,
                            letterSpacing: 2,
                            color: Colors.white,
                            fontWeight: FontWeight.w800,
                          ),
                        )
                    ),
                  ),
                )

              ],
            ),
          ) : Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [

                /// Domanda
                Text(
                    domanda,
                    style: GoogleFonts.pressStart2p(
                      textStyle: const TextStyle(
                        fontSize: 16,
                        letterSpacing: 2,
                        color: Colors.white,
                        fontWeight: FontWeight.w800,
                      ),
                    )
                ),

                /// Risposte
                /// Risposta 1
                Padding(
                    padding: EdgeInsets.only(
                      top: 20,
                    ),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width / 2,
                      child: TextButton(
                        onPressed: () {
                          inviaRisposta(1);
                        },
                        style: TextButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)
                            ),
                            padding: EdgeInsets.fromLTRB(30, 25, 30, 20),
                            backgroundColor: Colors.grey.withOpacity(0.2)
                        ),
                        child: Text(
                            risposta1,
                            style: GoogleFonts.pressStart2p(
                              textStyle: const TextStyle(
                                fontSize: 16,
                                letterSpacing: 2,
                                color: Colors.white,
                                fontWeight: FontWeight.w800,
                              ),
                            )
                        ),
                      ),
                    )
                ),
                /// Risposta 2
                Padding(
                    padding: EdgeInsets.only(
                      top: 20,
                    ),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width / 2,
                      child: TextButton(
                        onPressed: () {
                          inviaRisposta(2);
                        },
                        style: TextButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)
                            ),
                            padding: EdgeInsets.fromLTRB(30, 25, 30, 20),
                            backgroundColor: Colors.grey.withOpacity(0.2)
                        ),
                        child: Text(
                            risposta2,
                            style: GoogleFonts.pressStart2p(
                              textStyle: const TextStyle(
                                fontSize: 16,
                                letterSpacing: 2,
                                color: Colors.white,
                                fontWeight: FontWeight.w800,
                              ),
                            )
                        ),
                      ),
                    )
                ),
                /// Risposta 3
                Padding(
                    padding: EdgeInsets.only(
                      top: 20,
                    ),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width / 2,
                      child: TextButton(
                        onPressed: () {
                          inviaRisposta(3);
                        },
                        style: TextButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)
                            ),
                            padding: EdgeInsets.fromLTRB(30, 25, 30, 20),
                            backgroundColor: Colors.grey.withOpacity(0.2)
                        ),
                        child: Text(
                            risposta3,
                            style: GoogleFonts.pressStart2p(
                              textStyle: const TextStyle(
                                fontSize: 16,
                                letterSpacing: 2,
                                color: Colors.white,
                                fontWeight: FontWeight.w800,
                              ),
                            )
                        ),
                      ),
                    )
                ),
                /// Risposta 4
                Padding(
                    padding: EdgeInsets.only(
                      top: 20,
                    ),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width / 2,
                      child: TextButton(
                        onPressed: () {
                          inviaRisposta(4);
                        },
                        style: TextButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)
                            ),
                            padding: EdgeInsets.fromLTRB(30, 25, 30, 20),
                            backgroundColor: Colors.grey.withOpacity(0.2)
                        ),
                        child: Text(
                            risposta4,
                            style: GoogleFonts.pressStart2p(
                              textStyle: const TextStyle(
                                fontSize: 16,
                                letterSpacing: 2,
                                color: Colors.white,
                                fontWeight: FontWeight.w800,
                              ),
                            )
                        ),
                      ),
                    )
                ),

                /// Punteggio
                Padding(
                  padding: EdgeInsets.only(
                    top: 30
                  ),
                  child: Text(
                      "PUNTEGGIO: $punteggio",
                      style: GoogleFonts.pressStart2p(
                        textStyle: const TextStyle(
                          fontSize: 16,
                          letterSpacing: 2,
                          color: Colors.white,
                          fontWeight: FontWeight.w800,
                        ),
                      )
                  ),
                )

              ],
            ),
          )
      )
    );
  }
}
