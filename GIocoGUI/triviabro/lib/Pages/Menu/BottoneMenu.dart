import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Questa funzione ritorna un bottone
TextButton bottoneMenu(
      String contenutoBottone,
      BuildContext context,
      String route
    ) {
  return TextButton(
    onPressed: () {
      Navigator.pushNamed(context, route);
    },
    style: TextButton.styleFrom(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10)
        ),
        padding: EdgeInsets.fromLTRB(30, 25, 30, 20),
        backgroundColor: Colors.grey.withOpacity(0.5)
    ),
    child: Text(
        contenutoBottone,
        style: GoogleFonts.pressStart2p(
          textStyle: const TextStyle(
            fontSize: 30,
            letterSpacing: 2,
            color: Colors.white,
            fontWeight: FontWeight.w800,
          ),
        )
    ),
  );
}