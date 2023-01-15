import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Gioca extends StatefulWidget {
  const Gioca({Key? key}) : super(key: key);

  @override
  _GiocaState createState() => _GiocaState();
}

class _GiocaState extends State<Gioca> {

  String username = "";
  int punteggio = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      backgroundColor: Colors.green[200],

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

            /// Inserimento username
            TextFormField(),

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
      ) : Text(
        "gioca"
      ),

    );
  }
}
