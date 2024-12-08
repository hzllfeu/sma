import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StudentModel {
  static final StudentModel _instance = StudentModel._internal();

  StudentModel._internal();

  factory StudentModel() {
    return _instance;
  }
  String email = "louis.mouchon@edu.devinci.fr";
  String name = "Mouchon";
  String surname = "Louis";
  String APIToken = "32504db3f803d04a4c6ffb7d9266da6a";
}