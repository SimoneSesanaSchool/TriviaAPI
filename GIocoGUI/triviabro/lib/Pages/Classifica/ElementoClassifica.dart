import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Questa funzione ritorna una riga che rappresenta un elemento nella classifica
Row elementoClassifica(
      String username,
      String punteggio,
      String index
    ) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text(
        index != "" ? "${int.parse(index) + 1}. $username" : "$username",
        textAlign: TextAlign.start,
        style: GoogleFonts.pressStart2p(
          textStyle: const TextStyle(
            fontSize: 20,
            letterSpacing: 2,
            color: Colors.white,
            fontWeight: FontWeight.w800,
          ),
        ),
      ),
      Text(
        "$punteggio",
        textAlign: TextAlign.start,
        style: GoogleFonts.pressStart2p(
          textStyle: const TextStyle(
            fontSize: 20,
            letterSpacing: 2,
            color: Colors.white,
            fontWeight: FontWeight.w800,
          ),
        ),
      ),
    ],
  );
}