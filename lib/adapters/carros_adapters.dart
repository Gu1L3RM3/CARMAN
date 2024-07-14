import 'package:carman/models/caracter_car.dart';
import 'package:hive/hive.dart';


class CarrosAdapter extends TypeAdapter<Carro>{
  @override
  final typeId=0;
  @override
  Carro read(BinaryReader reader){
    return Carro(
      ano: reader.readString(),
      apelido: reader.readString(),
      id: reader.readString(),
      marca: reader.readString(),
      modelo: reader.readString()
      
    );
  }
  @override
  void write(BinaryWriter writer,Carro obj){
    writer.writeString(obj.ano);
    writer.writeString(obj.apelido);
    writer.writeString(obj.id);
    writer.writeString(obj.marca);
    writer.writeString(obj.modelo);
}}