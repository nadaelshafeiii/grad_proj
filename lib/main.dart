
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gp4/Dashboard.dart';
import 'package:gp4/HelpCenter.dart';
import 'package:gp4/camerapage.dart';
import 'package:gp4/local/localecontroller.dart';
import 'package:provider/provider.dart';
import 'LoginPage.dart';
import 'local/locale.dart';
import 'package:gp4/components/components.dart'; 

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
              
  final cameras = await availableCameras();
  final firstCamera = cameras.firstWhere(
    (camera) => camera.lensDirection == CameraLensDirection.front
  );

  MyLocaleController controller = MyLocaleController();
  await controller.initSharedPreferences();

  String? token = await AuthService.getToken();
  Get.put(MyLocaleController());

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => TokenProvider(token)),
      ],
      child: GetMaterialApp(
        home: MyApp(firstCamera: firstCamera),
        translations: MyLocale(),
        locale: controller.initialLang,
      ),
    ),
  );
}

class TokenProvider with ChangeNotifier {
  String? _token;

  TokenProvider(this._token);

  String? get token => _token;

  void setToken(String? token) {
    _token = token;
    notifyListeners();
  }

  void deleteToken() {
    _token = null;
    notifyListeners();
  }
}

class MyApp extends StatelessWidget {
  final CameraDescription firstCamera;

  MyApp({required this.firstCamera});

  @override
  Widget build(BuildContext context) {
    final tokenProvider = Provider.of<TokenProvider>(context);
    return MaterialApp(
      home: tokenProvider.token == null ? LoginPage() : HelpCenterPage(),
    );
  }
}

class MainPage extends StatefulWidget {
  final CameraDescription firstCamera;

  MainPage({required this.firstCamera});

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _currentIndex = 0;
  late List<Widget> _pages;

  @override
  void initState() {
    super.initState();
    _pages = [
      Dashboard(),
      CameraPage(camera : widget.firstCamera, cameraPermissionAllowed: true),
      HelpCenterPage(),
    ];
  }

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _pages.elementAt(_currentIndex),
      ),
      bottomNavigationBar: NavigatorBar(
        currentIndex: _currentIndex,
        onTap: _onTabTapped,
      ),
    );
  }
}
