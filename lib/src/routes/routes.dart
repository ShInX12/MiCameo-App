import 'package:flutter/material.dart';
import 'package:mi_cameo/src/pages/home_page.dart';
import 'package:mi_cameo/src/pages/initial_page.dart';
import 'package:mi_cameo/src/pages/login_page.dart';
import 'package:mi_cameo/src/pages/messages_page.dart';
import 'package:mi_cameo/src/pages/navigation_bar_page.dart';
import 'package:mi_cameo/src/pages/notifications_page.dart';
import 'package:mi_cameo/src/pages/options_page.dart';
import 'package:mi_cameo/src/pages/profile_page.dart';
import 'package:mi_cameo/src/pages/register1_page.dart';
import 'package:mi_cameo/src/pages/register2_page.dart';
import 'package:mi_cameo/src/pages/request_cameo_page.dart';
import 'package:mi_cameo/src/pages/request_cameo_present_page.dart';
import 'package:mi_cameo/src/pages/search_page.dart';
import 'package:mi_cameo/src/pages/select_cameo_page.dart';
import 'package:mi_cameo/src/pages/subcategory_list_page.dart';
import 'package:mi_cameo/src/pages/talent_page.dart';

Map<String, WidgetBuilder> applicationRoutes(){

  return {
    'initial': (BuildContext context) => InitialPage(),
    'login': (BuildContext context) => LoginPage(),
    'register1': (BuildContext context) => Register1Page(),
    'register2': (BuildContext context) => Register2Page(),
    'home': (BuildContext context) => HomePage(),
    'messages': (BuildContext context) => MessagesPage(),
    'navigation_bar': (BuildContext context) => NavigationBarPage(),
    'notifications': (BuildContext context) => NotificationsPage(),
    'options': (BuildContext context) => OptionsPage(),
    'profile': (BuildContext context) => ProfilePage(),
    'search': (BuildContext context) => SearchPage(),
    'talent': (BuildContext context) => TalentPage(),
    'request': (BuildContext context) => RequestCameo(),
    'request_present': (BuildContext context) => RequestCameoAsPresent(),
    'select_cameo': (BuildContext context) => SelectCameoPage(),
    'subcategory_list': (BuildContext context) => SubcategoryList(),
  };

}