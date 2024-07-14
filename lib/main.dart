import 'package:carman/models/car_list.dart';
import 'package:carman/models/theme_data.dart';
import 'package:carman/pages/home_page.dart';
import 'package:carman/utils/app_routes.dart';
import 'package:carman/utils/notification_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:provider/provider.dart';


final navigatorKey = GlobalKey<NavigatorState>();

String? initialRoute;
String? payload;
Future<void> main(List<String> args) async {
  
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await NotificationController.init();
  //informações caso seja aberto por uma notificação
  final  NotificationAppLaunchDetails? details=await NotificationController.plugin.getNotificationAppLaunchDetails();
  if (details?.didNotificationLaunchApp ?? false){
    initialRoute=AppRoutes.adicionarCarro;
    payload=details?.notificationResponse?.payload;
  }
  runApp(const CarmanApp() );
}

class CarmanApp extends StatelessWidget {
  const CarmanApp({super.key});

  @override
  Widget build(BuildContext context) {
    return   MultiProvider(
      providers: [
        ChangeNotifierProvider<CarList>(create: (_)=>CarList()),
        Provider<NotificationController>(create: (context)=>NotificationController(),)
        
      ],
      
      child: MaterialApp(
        title:'Qualquer coisa',
        navigatorKey: navigatorKey,
        debugShowCheckedModeBanner: false,
        theme: theme,
        home:  const HomePage(),
        routes: AppRoutes.routes
      ),
    );
  }
}

