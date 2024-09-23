import 'package:carman/models/carro/car_list.dart';
import 'package:carman/models/carro/caracter_car.dart';
import 'package:carman/models/config_service.dart';
import 'package:carman/models/lembrete/caracter_lembrete.dart';
import 'package:carman/models/lembrete/lembrete_agendado_list.dart';
import 'package:carman/models/lembrete/lembrete_km_list.dart';
import 'package:carman/models/lembrete/lembrete_periodico_list.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DB{
  
  DB._();
  static final DB instance=DB._();

  static  Database? _database;

  get database async{
    if(_database !=null) return _database;
    return await _initDatabase();
  }
  _initDatabase()async{
    return await openDatabase(
      join(await getDatabasesPath(),'carman.db'),
      version: 1,
      onCreate:_onCreate, 
    );
  }

  _onCreate(db,versao)async{
    await db.execute(_lembretePeriodicoList);
    await db.execute(_lembreteAgendadoList);
    await db.execute(_lembreteKmList);
    await db.execute(_carList);
    await db.execute(_tagList);
  
  }
  
  String get _lembretePeriodicoList=>'''
    CREATE TABLE ${LembretePeriodicoList.tableName}(
      ${Lembrete.idName} INT PRIMARY KEY,
      ${Lembrete.idNotificacaoName} INT ,
      ${Lembrete.carroIdName} INT,
      ${LembretePeriodico.dataInicialName} TEXT,
      ${LembretePeriodico.tipoIntervaloName} TEXT,
      ${Lembrete.timeOfDayName} TEXT,
      ${Lembrete.tagName} TEXT,
      ${Lembrete.observacaoName} TEXT
    );

  ''';
  String get _lembreteAgendadoList=>'''
    CREATE TABLE ${LembreteAgendadoList.tableName}(
      ${Lembrete.idName} INT PRIMARY KEY,
      ${Lembrete.idNotificacaoName} INT ,
      ${Lembrete.carroIdName} INT,
      ${LembreteAgendado.dateTimeName} TEXT,
      ${Lembrete.timeOfDayName} TEXT,
      ${Lembrete.tagName} TEXT,
      ${Lembrete.observacaoName} TEXT
    );

  ''';
  String get _lembreteKmList=>'''
    CREATE TABLE ${LembreteKmList.tableName}(
      ${Lembrete.idName} INT PRIMARY KEY,
      ${Lembrete.idNotificacaoName} INT ,
      ${Lembrete.carroIdName} INT,
      ${LembreteKmRodado.kmRodadoName} INT,
      ${Lembrete.timeOfDayName} TEXT,
      ${Lembrete.tagName} TEXT,
      ${Lembrete.observacaoName} TEXT
    );

  ''';
  String get _carList=>'''
    CREATE TABLE ${CarList.tableName}(
      ${Carro.idName} INT PRIMARY KEY,
      ${Carro.marcaName} TEXT,
      ${Carro.modeloName} TEXT,
      ${Carro.apelidoName} TEXT,
      ${Carro.imagePath} TEXT,
      ${Carro.anoName} INT,
      ${Carro.odometroName} INT,
      ${Carro.mediaKmName} INT
    );

  ''';
  String get _tagList=>'''
    CREATE TABLE ${ConfigService.tableName}(
      ${ConfigService.idName} INT PRIMARY KEY,
      ${ConfigService.tagName} TEXT
    );

  ''';

}