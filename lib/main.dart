import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:foolife/Bloc/auth/Register/ResturantRegistertionBloc.dart';
import 'package:foolife/Bloc/provider.dart';
import 'package:foolife/Screens/Main/MainScreen.dart';
import 'package:foolife/Screens/Welcome/ResturantSignup.dart';
import 'package:foolife/Screens/Welcome/Welcome_Screen.dart';
import 'AppLocalizations.dart';
import 'Bloc/AuthBloc.dart';
import 'Bloc/auth/Register/RegisterBloc.dart';
import 'Screens/Main/NotificationScreen.dart';
import 'Screens/Main/SearchScreen.dart';

import 'Screens/Restaurant/ManageMenuScreen.dart';
import 'Screens/Splash/VideoSplashScreen1.dart';

import 'Screens/Welcome/EntreyScreen.dart';
import 'Screens/Welcome/RsetSignup.dart';
import 'Screens/Welcome/SignInScreen.dart';
import 'Screens/Welcome/UserSignup.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // SharedPreferences prefs = await SharedPreferences.getInstance();

  runApp(MyApp());
  //runApp(MyApp());
}

class MyApp extends StatelessWidget {
  //final SharedPreferences prefs;
  //MyApp({this.prefs});
  MyApp();

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AuthBloc>(
      bloc: AuthBloc(),
      child: BlocProvider<RegisterBloc>(
        bloc: RegisterBloc(),
        child: BlocProvider<ResturantRegistertionBloc>(
          bloc: ResturantRegistertionBloc(),
          child: MaterialApp(
            title: 'Flutter Demo',
            debugShowCheckedModeBanner: false,
            routes: <String, WidgetBuilder>{
              '/splash1': (BuildContext context) => new VideoSplashScreen1(),
              '/walkthrough': (BuildContext context) => WelcomeScreen(),
              '/signin': (BuildContext context) => new SignInScreen(),
              '/entreyScreen': (BuildContext context) => new EntreyScreen(),
              '/usersignup': (BuildContext context) => new UserSignup(),
              '/resturantSignup': (BuildContext context) =>
                  new RetsturantSignup(),
              '/restsignup': (BuildContext context) => new RestSignup(),
              '/searchscreen': (BuildContext context) => new SearchScreen(),
              '/mainscreen': (BuildContext context) => new MainScreen(),
              '/notificationscreen': (BuildContext context) =>
                  new NotificationScreen(),
              '/mangemenuscreen': (BuildContext context) =>
                  new ManageMenuScreen(),

              /* '/root': (BuildContext context) => new RootScreen(),
            '/signin': (BuildContext context) => new SignInScreen(),
            '/signup': (BuildContext context) => new SignUpScreen(),
            '/main': (BuildContext context) => new MainScreen(),*/
            },
            theme: ThemeData(
              primaryColor: Colors.white,
              primarySwatch: Colors.grey,
            ),
            // List all of the app's supported locales here
            supportedLocales: [
              Locale('en', 'US'),
              Locale('du', 'DU'),
              Locale('de', 'DE'),
            ],
            // These delegates make sure that the localization data for the proper language is loaded
            localizationsDelegates: [
              // THIS CLASS WILL BE ADDED LATER
              // A class which loads the translations from JSON files
              AppLocalizations.delegate,
              // Built-in localization of basic text for Material widgets
              GlobalMaterialLocalizations.delegate,
              // Built-in localization for text direction LTR/RTL
              GlobalWidgetsLocalizations.delegate,
            ],
            // Returns a locale which will be used by the app
            localeResolutionCallback: (locale, supportedLocales) {
              // Check if the current device locale is supported
              for (var supportedLocale in supportedLocales) {
                if (supportedLocale.languageCode == locale.languageCode &&
                    supportedLocale.countryCode == locale.countryCode) {
                  return supportedLocale;
                }
              }
              // If the locale of the device is not supported, use the first one
              // from the list (English, in this case).
              return supportedLocales.first;
            },
            home: _handleCurrentScreen(),
          ),
        ),
      ),
    );
  }

  Widget _handleCurrentScreen() {
    //   bool seen = (prefs.getBool('seen') ?? false);
    /*if (seen) {
      return new RootScreen();
    } else {
      return new WalkthroughScreen(prefs: prefs);
    }*/

    return VideoSplashScreen1();
    //return WelcomeScreen();
  }
}
