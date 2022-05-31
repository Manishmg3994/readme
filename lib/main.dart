import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:provider/provider.dart';
import 'package:thememanager/theme_service/app_basic_theme.dart';
import 'package:thememanager/theme_service/if_you_are_using_provider_then_use_this/colors.dart';
import 'package:thememanager/theme_service/service_locator.dart';
import 'package:thememanager/theme_service/theme_view_moodel.dart';

void main() async {
  await GetStorage.init();
  ServiceLocator.init();
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (_) => ServiceLocator.get<ThemeViewModel>())
  ], child: MyApp()));
}

///simple method
///clourscheme method
///get_it method or get method
///provider method
///store the last theme in the device
/// and importent part is we prefer provider method because it is easy to use
/// because using both get and provider make the app size bigger
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Theme Dark / Light  Store State',
      theme: AppBasicTheme.getThemeData(),
      darkTheme: AppBasicTheme.getThemeDataDark(),
      themeMode: ThemeViewModel().theme,
      // getPages: AppPages.routes,

      home: const MyHomePage(title: 'Theme Manager'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  static bool get isDarkMode => ServiceLocator.get<ThemeViewModel>().darkMode;

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeViewModel>(builder: (contet, viewModel, _) {
      return Scaffold(
        backgroundColor:
            isDarkMode ? Colors.black87 : Colors.white, //simpe use can be used
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text('You are in:',
                  style: TextStyle(
                    color: CustomColors.primaryColor, fontSize: 15,

                    ///use this to change the color of the text if provider is  used
                  )),
              Text('isDarkMode: $isDarkMode',
                  style: TextStyle(
                    color: CustomColors.primaryTextColor,
                    fontSize: 18,
                  ) //Theme.of(context).textTheme.headline4,
                  ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            {
              viewModel.darkMode = !viewModel.darkMode;
              viewModel.saveTheme(viewModel.darkMode);
            }
          },
          tooltip: 'Increment',
          child: Icon(isDarkMode ? Icons.wb_sunny : Icons.brightness_3),
        ),
      );
    });
  }
}
