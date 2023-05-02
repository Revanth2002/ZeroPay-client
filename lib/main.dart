import 'package:client/helpers/headers.dart';
import 'package:client/screens/auth/login.dart';
import 'package:client/screens/auth/otppage.dart';
import 'package:client/screens/auth/splash.dart';
import 'package:client/screens/home/addcard.dart';
import 'package:client/screens/home/cardlist.dart';
import 'package:client/screens/home/home.dart';
import 'package:client/screens/home/profile.dart';
import 'package:client/screens/home/setuppin.dart';


void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

    //This screen is used when it causes red screen error
  //   ErrorWidget.builder = (FlutterErrorDetails details) {
  //     //TODO:To change the UI
  //   return Material(
  //     child: Container(
  //       color: Colors.white,
  //       alignment: Alignment.center,
  //       padding: EdgeInsets.all(30),
  //       child: Column(
  //         children: [
  //           Expanded(
  //             flex: 2,
  //             child: Image.asset("assets/images/error.png",fit: BoxFit.contain,height: double.infinity,width: double.infinity,)),
  //           Expanded(
  //             flex: 1,
  //             child: RichText(
  //                       textAlign: TextAlign.center,
  //                       text: TextSpan(children: <TextSpan>[
  //                         TextSpan(
  //                             text: 'This page caused an unexpected ',
  //                             style: TextStyle(color: kPrimaryColor)),
  //                         TextSpan(
  //                             text: ' ERROR. ',
  //                             style: TextStyle(
  //                                 color: kRedColor,
  //                                 fontWeight: FontWeight.bold)),
  //                         TextSpan(
  //                             text: ' Try again...',
  //                             style: TextStyle(color: kPrimaryColor)),
  //                       ]),
  //                     ),
  //           )
  //         ],
  //       )
  //     ),
  //   );
  // };
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
    final _flutterSecureStorage = const FlutterSecureStorage();
  
  @override
    void initState() {
      super.initState();
      getStoredAccessTokenOrEmpty;
    }   

  Future<String> get getStoredAccessTokenOrEmpty async {
    var _userBearerToken = await _flutterSecureStorage.read(key: "BEARERTOKEN");
    if(_userBearerToken == null) return "";
    return _userBearerToken;
  }
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Square Pay',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: kPrimaryColor,
      ),
      home:FutureBuilder(
        future: getStoredAccessTokenOrEmpty,
        builder: (context,snapshot) {
           if(!snapshot.hasData) return customCircularProgress() ;
          if(snapshot.data != ""){
            return  LoginPage(); //AppScreenController(indexScreen: 0,) ;
          }else{
          return SetupPinPage(); //AppScreenController(indexScreen:)
          }
        },
      ),
      routes: {
        //Auth Screens
        SplashInfo.routeName: (context) => const SplashInfo(), //Path : /loginpage
        LoginPage.routeName: (context) => const LoginPage(), //Path : /loginpage
        OtpPage.routeName: (context) => OtpPage(phoneNumber: "",secretCode: ""), //Path : /loginpage
        HomePage.routeName: (context) => HomePage(), //Path : /loginpage
        AddCardPage.routeName: (context) => const AddCardPage(), //Path : /loginpage
        AllCardPage.routeName: (context) => const AllCardPage(), //Path : /loginpage
        MyProfilePage.routeName: (context) => const MyProfilePage(), //Path : /loginpage
        SetupPinPage.routeName: (context) => const SetupPinPage(), //Path : /loginpage
      },
    );
  }
}