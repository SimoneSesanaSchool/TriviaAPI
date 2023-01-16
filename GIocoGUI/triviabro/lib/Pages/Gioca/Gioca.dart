import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:triviabro/Pages/Gioca/RadioTextStyle.dart';

class Gioca extends StatefulWidget {
  const Gioca({Key? key}) : super(key: key);

  @override
  _GiocaState createState() => _GiocaState();
}

class _GiocaState extends State<Gioca> {

  String username = "";
  int punteggio = 0;

  int _selectedRadio = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      backgroundColor: Colors.blue[900],

      /// AppBar usata come padding
      appBar: AppBar(
        backgroundColor: Colors.white.withOpacity(0),
        leading: Container(),
        elevation: 0,
      ),

      /// Se lo username non è stato ancora inserito viene visualizzata la
      /// pagina di inserimento
      body: username == "" ? Center(
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
              padding: EdgeInsets.only(
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
      ) : Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [

          /// Domanda
          Text(
              "DOMANDA",
              style: GoogleFonts.pressStart2p(
                textStyle: const TextStyle(
                  fontSize: 16,
                  letterSpacing: 2,
                  color: Colors.white,
                  fontWeight: FontWeight.w800,
                ),
              )
          ),

          RadioListTile(
            value: 1,
            groupValue: _selectedRadio,
            onChanged: (inb){
              setState(() {
                _selectedRadio = 1;
              });
            },
            title: Text(
              "Opzione 1",
              style: radioTextStyle(),
            ),
          ),
          RadioListTile(
            value: 2,
            groupValue: _selectedRadio,
            onChanged: (inb){
              setState(() {
                _selectedRadio = 2;
              });
            },
            title: Text(
              "Opzione 2",
              style: radioTextStyle(),
            ),
          ),
          RadioListTile(
            value: 3,
            groupValue: _selectedRadio,
            onChanged: (inb){
              setState(() {
                _selectedRadio = 3;
              });
            },
            title: Text(
              "Opzione 3",
              style: radioTextStyle(),
            ),
          ),RadioListTile(
            value: 4,
            groupValue: _selectedRadio,
            onChanged: (inb){
              setState(() {
                _selectedRadio = 4;
              });
            },
            title: Text(
              "Opzione 4",
              style: radioTextStyle(),
            ),
          ),
        ],
      )
    );
  }
}
