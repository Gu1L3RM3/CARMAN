import 'package:carman/components/custom_circular_progress.dart';
import 'package:carman/components/list_view_objects.dart';
import 'package:carman/components/uso_geral/custom_alert_dialog.dart';

import 'package:carman/components/config/tags_edit.dart';
import 'package:carman/models/config_service.dart';
import 'package:carman/utils/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EditTagsPage extends StatefulWidget {
  const EditTagsPage({super.key});

  @override
  State<EditTagsPage> createState() => _EditTagsPageState();
}

class _EditTagsPageState extends State<EditTagsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:const Text("Serviços"),
        centerTitle: true,
        actions: [
          GestureDetector(
            onTap: ()async{
              return await showDialog(
                context: context, 
                builder: (context)=> CustomAlertDialog(
                  titulo: "Ajuda",
                  descricao: "Aqui você pode ver todos os serviços\nClique em algum caso queira excluí-lo",
                  apenasBotaoFechar: true,
                  onPressedClose: ()=>Navigator.of(context).pop(),
                  )
                  
                  );


            },
            child: const Icon(Icons.help),
          )
        ],
      ),
      body:Padding(
        padding: const EdgeInsets.only(top:8.0),
        child: Consumer<ConfigService>(
          builder: (context, value, child) => FutureBuilder(
            future: value.initRepository(),
            builder: (context,snapshot) {
              return snapshot.connectionState==ConnectionState.waiting
              ?const CustomCircularProgress()
              :ListViewObjects(
                isListEmpty: false,
                floatingButtonRoute: AppRoutes.addServicePage,
                lista: value.tags,
                emptyList: const Text("Empty"),
               
                itemBuilder: (context, index) {
                  
                  return Container(
                    alignment: Alignment.center,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TagsEdit(tagName: value.tags[index][0] as String, provider: value, id: value.tags[index][1] as int),
                        ),
                        const Divider(height: 1.0)
                      ],
                    ),
                  );
                  
                },);
            }
          ),
        ),
      )
    );
  }
}


