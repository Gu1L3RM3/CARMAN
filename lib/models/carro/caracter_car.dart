
class Carro {
  final int id;
  String apelido;
  String marca;
  String modelo;
  int ano;
  int odometro;
  int mediaKm;
  Carro({
    required this.id,
    required this.marca,
    required this.modelo,
    required this.apelido,
    required this.ano,
    required this.odometro,
    required this.mediaKm

   
   });

   static String idName='id';
   static String apelidoName='apelido';
   static String marcaName='marca';
   static String modeloName='modelo';
   static String anoName='ano';
   static String odometroName='odometro';
   static String mediaKmName='mediaKm';
}