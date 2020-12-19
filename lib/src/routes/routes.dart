import 'package:flutter/material.dart';
import 'package:mi_cameo/src/pages/edit_profile_page.dart';
import 'package:mi_cameo/src/pages/home_page.dart';
import 'package:mi_cameo/src/pages/initial_page.dart';
import 'package:mi_cameo/src/pages/loading_page.dart';
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
import 'package:mi_cameo/src/pages/video_player_page.dart';

Map<String, WidgetBuilder> applicationRoutes(){

  return {
    'loading'         : (_) => LoadingPage(),
    'initial'         : (_) => InitialPage(),
    'login'           : (_) => LoginPage(),
    'register1'       : (_) => Register1Page(),
    'register2'       : (_) => Register2Page(),
    'navigation_bar'  : (_) => NavigationBarPage(),
    'home'            : (_) => HomePage(),
    'messages'        : (_) => MessagesPage(),
    'search'          : (_) => SearchPage(),
    'notifications'   : (_) => NotificationsPage(),
    'profile'         : (_) => ProfilePage(),
    'options'         : (_) => OptionsPage(),
    'talent'          : (_) => TalentPage(),
    'request'         : (_) => RequestCameo(),
    'request_present' : (_) => RequestCameoAsPresent(),
    'select_cameo'    : (_) => SelectCameoPage(),
    'subcategory_list': (_) => SubcategoryList(),
    'edit_profile'    : (_) => EditProfilePage(),
    'video_player'    : (_) => VideoPlayerPage(),
  };

}