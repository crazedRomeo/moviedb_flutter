import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter/services.dart';
import 'package:test/routes.dart';

Future<void> main() async{
  await dotenv.load();
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}
class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      theme: ThemeData.light(),
      title:"Test",
      debugShowCheckedModeBanner: false,
      initialRoute: '/index',
      onGenerateRoute: RouteGenerator.generateRoute,
    );
  }
}
