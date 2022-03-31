// @dart=2.9
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ota_update/ota_update.dart';
import 'package:get_version/get_version.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: 'Material App', home: Update());
  }
}

class Update extends StatefulWidget {
  Update({Key key}) : super(key: key);

  @override
  State<Update> createState() => _UpdateState();
}

class _UpdateState extends State<Update> {
  OtaEvent currentEvent;
  String version = "";

  Future<void> tryOtaUpdate() async {
    try {
      OtaUpdate().execute('https://raw.githubusercontent.com/xjosk/FlutterApk/master/build/app/outputs/flutter-apk/app-release.apk').listen((OtaEvent event) {
        setState(() => currentEvent = event);
      });
    } catch (e) {
      print("Falló algo: $e");
    }
  }

  Future<void> getVersion() async {
    
    try {
      String getVersion = await GetVersion.projectVersion;
      setState(() {
        version = getVersion;
      });
    } on PlatformException {
      version = 'Failed to get project version';
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getVersion();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: Center(
          child: ElevatedButton(
              onPressed: () {
                tryOtaUpdate();
              },
              child: Text("ACTUALIZADO!!!!!!!!!! $version")),
        ));
  }
}
