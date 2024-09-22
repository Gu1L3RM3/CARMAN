import 'package:flutter/material.dart';

abstract class Lembrete{
  final String tag;
  final int id;
  final int  carroId;
  final String observacao;
  final TimeOfDay timeOfDay;
  final int idNotificacao;
  Lembrete({
    required this.idNotificacao,
    required this.carroId,
    required this.timeOfDay,
    required this.tag,
    required this.observacao,
    required this.id,
  });

  static String timeOfDayName ="timeOfDay";
  static String tagName="tag";
  static String carroIdName="carroId";
  static String observacaoName="observacao";
  static String idName="id";
  static String idNotificacaoName='idNotificacao';

}

class LembreteAgendado extends Lembrete{
  final DateTime dateTime;
  static String tipo="Agendado";
  static IconData icon=Icons.calendar_month;
  static String dateTimeName ="dateTime";


  LembreteAgendado({
    required this.dateTime,
    required super.idNotificacao,
    required super.carroId,
    required super.timeOfDay,
    required super.tag,
    required super.observacao,
    required super.id});

  

}

class LembretePeriodico extends Lembrete{

  final String tipoIntervalo;
  final DateTime dataInicial;
  static String tipo="Periódico";
  static IconData icon=Icons.event_repeat_rounded;
  static String tipoIntervaloName='tipoIntervalo';
  static String dataInicialName='dataInicial';
  static List<String> tipoIntervaloList=["Semanalmente","Mensalmente","Anualmente","Semestralmente"];
  LembretePeriodico({
    required this.tipoIntervalo,
    required super.idNotificacao,
    required this.dataInicial,
    required super.carroId,
    required super.timeOfDay,
    required super.tag,
    required super.observacao,
    required super.id,
  
    });




}

class LembreteKmRodado extends Lembrete{
  final int kmRodado;
  static String tipo="Por Km rodado";
  static IconData iconAdd= Icons.add_road;
  static IconData iconEdit= Icons.edit_road;
  static String kmRodadoName='kmRodado';
  static String kmMesCarro='kmMesCarro';
  LembreteKmRodado({
    required super.idNotificacao,
    required this.kmRodado,
    required super.carroId,
    required super.timeOfDay,
    required super.tag,
    required super.observacao,
    required super.id});
  

}