
class Carro {
  final int id;
  String apelido;
  String marca;
  String modelo;
  int ano;
  int odometro;
  int mediaKm;
  String imageCar;
  Carro({
    required this.id,
    required this.marca,
    required this.modelo,
    required this.apelido,
    required this.ano,
    required this.odometro,
    required this.mediaKm,
    required this.imageCar,
    

   
   });

   static String idName='id';
   static String apelidoName='apelido';
   static String marcaName='marca';
   static String modeloName='modelo';
   static String anoName='ano';
   static String odometroName='odometro';
   static String mediaKmName='mediaKm';
   static String imagePath='imagePath';
}