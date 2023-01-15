// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:triviabro/Pages/Menu/BottoneMenu.dart';

/// In questa pagina l'utente potrà selezionare le opzioni disponibili
class Menu extends StatefulWidget {
  const Menu({Key? key}) : super(key: key);

  @override
  _MenuState createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      backgroundColor: Colors.green[200],

      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            bottoneMenu("GIOCA", context, ''),
            SizedBox(
              height: 20,
            ),
            bottoneMenu("CLASSIFICA", context, '')

          ],
        ),
      ),

    );
  }
}
