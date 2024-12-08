import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import 'AppointmentModel.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  static Database? _database;

  DatabaseHelper._internal();

  factory DatabaseHelper() => _instance;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'appointments.db');

    return openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE appointments(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            startTime TEXT,
            endTime TEXT,
            location TEXT,
            subject TEXT,
            title TEXT,
            speaker TEXT,
            groupClass TEXT
          )
        ''');
      },
    );
  }

  Future<List<AppointmentModel>> getAppointments() async {
    try {
      final db = await database;
      final List<Map<String, dynamic>> maps = await db.query('appointments');

      return maps.map((map) {
        try {
          return AppointmentModel.fromMap({
            "id": map["id"] ?? 0,
            "startTime": map["startTime"] ?? "",
            "endTime": map["endTime"] ?? "",
            "location": map["location"] ?? "",
            "subject": map["subject"] ?? "",
            "title": map["title"] ?? "",
            "speaker": map["speaker"] ?? "",
            "group": map["groupClass"] ?? "",
          });
        } catch (e) {
          // Si la conversion échoue, retourner un AppointmentModel avec des valeurs par défaut
          return AppointmentModel(
            id: 0,
            startTime: DateTime.now(),
            endTime: DateTime.now(),
            location: "",
            subject: "",
            title: "",
            speaker: "",
            groupClass: "",
          );
        }
      }).toList();
    } catch (e) {
      // En cas d'erreur globale, retourner une liste vide
      print("Error fetching appointments: $e");
      return [];
    }
  }

  Future<void> insertAppointment(AppointmentModel appointment) async {
    try {
      final db = await database;
      await db.insert(
        'appointments',
        appointment.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    } catch (e) {
      print("Error inserting appointment: $e");
    }
  }

  Future<void> clearAppointments() async {
    try {
      final db = await database;
      await db.delete('appointments');
    } catch (e) {
      print("Error clearing appointments: $e");
    }
  }
}