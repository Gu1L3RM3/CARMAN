import 'dart:io';
import 'package:camera_camera/camera_camera.dart';
import 'package:carman/components/custom_button.dart';
import 'package:carman/components/custom_form.dart';
import 'package:carman/components/custom_input_text.dart';
import 'package:carman/models/carro/car_list.dart';
import 'package:carman/models/carro/caracter_car.dart';
import 'package:carman/utils/validations_mixin.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';


class AddCarPage extends StatefulWidget {
  
  const AddCarPage({super.key});

  @override
  State<AddCarPage> createState() => _AddCarPageState();
}

class _AddCarPageState extends State<AddCarPage> with ValidationsMixin {
  File? photo;
  final picker=ImagePicker();
  final crop=ImageCropper();


  Future<CroppedFile?> cropper(file)async{
    return await crop.cropImage(
        sourcePath: file.path,
        uiSettings: [
          AndroidUiSettings(
            cropStyle: CropStyle.circle,
            toolbarTitle: 'Cropper',
            showCropGrid: false,
            
            activeControlsWidgetColor: Colors.cyan,
          )
        ],);
  }
  void showPreview(file)async{
    final croppedPhoto=await cropper(file);
        
    if(croppedPhoto!=null){
      setState(() {
        photo=File(croppedPhoto.path);
        Navigator.pop(context);
      });
      
    }


  }


  void openCamera(){
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_)=>CameraCamera(
          onFile: (file){
            showPreview(file);
          }
          )
          )

     );
  }

  Future getPhotoFromGallery()async {
    final file=await picker.pickImage(source: ImageSource.gallery);
    
    
    if(file!=null){
      final croppedFile=await cropper(file);
        if(croppedFile!=null){
          setState(() {photo=File(croppedFile.path);});

        }
        

    }
  }




  final _formData=<String,Object>{};

  @override
  Widget build(BuildContext context) {
    
    _formData[Carro.imagePath]=photo!=null?photo!.path:'';
    
    return  CustomForm(
        title: 'Adicionar Carro',
        showButtons: false,
        formData: _formData,
        addObjectFromData:Provider.of<CarList>(context,listen: false).addObjectFromData ,
        children:<Widget> [
            FittedBox(
              fit: BoxFit.contain,
              alignment: Alignment.center,
              child: CircleAvatar(
                backgroundImage: photo!=null?FileImage(photo!):null,
                radius: 80.0,
                child: photo!=null
                ?null
                :const Icon(Icons.drive_eta,size: 80.0,),
                ),
            ),
            Container(
              margin:const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  
                  CustomButton(
                    icon: const Icon(Icons.photo_camera),
                    onPressed: (){
                      
                      openCamera();},
                    label: "Tirar Foto"),
                  ElevatedButton(
                    onPressed: (){setState(() {
                    photo=null;
                  });},
                  child: const Icon(Icons.delete),
                  ),
                  CustomButton(onPressed: ()=>getPhotoFromGallery(),
                   margin:4.0,
                   label: "Galeria",
                   icon:const Icon(Icons.link) ,),
                ],
              ),
            ),
            CustomInputText(
              maxLength: 10,             
              icon: const Icon(Icons.list),
              hintText: 'Modelo', 
              labelText: 'Modelo',
              onSaved: (modelo)=>_formData[Carro.modeloName]=modelo??'',
              validate: isNotEmpty,
            
            ),
            
            CustomInputText(
              //TODO:colocar opções com icones das marcas
              maxLength: 12,
              icon:const Icon(Icons.factory),
              hintText: 'Marca',
              labelText: 'Marca',
              onSaved: (marca)=>_formData[Carro.marcaName]=marca ?? '',
              validate: isNotEmpty,
            
        
            ),
            CustomInputText(
              maxLength: 10,
              icon: const Icon(Icons.local_offer_rounded),
              hintText: 'Apelido (Opcional)', 
              labelText: 'Apelido', 
              onSaved: (apelido)=>_formData[Carro.apelidoName]=apelido??'', 
              validate: (_){return null;}
              ),
            CustomInputText(
              hintText: 'Ano', 
              icon: const Icon(Icons.edit_calendar_rounded),
              labelText: 'Ano', 
              isKeyNumber: true,
              digitsOnly: true,
              onSaved: (ano) =>_formData[Carro.anoName]=int.parse(ano ?? '') ,
              validate: (_ano) {
              final ano=_ano ?? '';
              if (ano.trim().isEmpty){
                return 'Ano é obrigatório';
              }
              if(int.parse(ano.trim())<1960 || int.parse(ano.trim())>DateTime.now().year+1){
                return 'Ano inválido';
              }
              return null;
              
            },),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Expanded>[
                Expanded(
                  child: CustomInputText(
                    maxLength: 6,
                    icon: const Icon(Icons.add_road_sharp),
                    hintText: 'Odômetro', 
                    labelText: 'Odômetro',
                    descricaoHelper: '''
Insira quantos quilômetros rodados tem seu carro''',
                    isHelper: true,
                    isKeyNumber: true, 
                    digitsOnly: true,
                    onSaved: (odometro)=>_formData[Carro.odometroName]=int.parse(odometro??''), 
                    validate: isNotEmpty,
                    ),
                ),
                Expanded(
                  child: CustomInputText(
                      maxLength: 6,
                      hintText: "km/mês", 
                      labelText: "km/mês", 
                      descricaoHelper:
'''Insira quantos quilômetros você anda por mês.
Não se preocupe em dar valores exatos.
Você pode alterar esse valor posteriormente''' ,
                      isDone: true, 
                      isKeyNumber: true, 
                      digitsOnly: true, 
                      isHelper:true,
                      onSaved: (mediaKm)=>_formData[Carro.mediaKmName]=int.parse(mediaKm ??''), 
                      // ignore: no_leading_underscores_for_local_identifiers
                      validate:(_mediaKm){
                        final mediaKm=_mediaKm??'';
                        if(mediaKm.trim().isEmpty){
                          return "Km/mês é obrigatório";
                        }
                        if(int.parse(mediaKm) ==0){
                          return "Km/mês inválido";
                        }
                        return null;

                      } ),
                ),
              ],
            ),
            
            
            
            
          ],
          ) ;
          
      
    
  }
}