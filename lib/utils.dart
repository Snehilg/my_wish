import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

TextStyle textStyle(double size, Color color, FontWeight fw) {
  return GoogleFonts.montserrat(fontSize: size, color: color, fontWeight: fw);
}

CollectionReference<Map<String, dynamic>> userCollection =
    FirebaseFirestore.instance.collection("user");
