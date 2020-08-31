import 'package:flutter/material.dart';
import 'package:mi_cameo/src/models/user_model.dart';
import 'package:mi_cameo/src/preferences/user_preferences.dart';
import 'package:mi_cameo/src/repository/client_repository.dart';
import 'package:mi_cameo/src/themes/theme.dart';
import 'package:mi_cameo/src/widgets/video_card.dart';

class ProfilePage extends StatelessWidget {
  final prefs = UserPreferences();
  final clientRepository = ClientRepository();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Positioned(top: 0, child: _Background()),
          Positioned(top: 16, child: _Logo()),
          Positioned(top: 5, right: -12, child: _Options()),
          Positioned(
            top: 90,
            child: FutureBuilder(
              future: clientRepository.getCurrentClient(prefs.accessToken),
              builder: (context, AsyncSnapshot<Client> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                } else {
                  if (snapshot.hasData) {
                    return _ColumnAvatar(
                      name: snapshot.data.user.username,
                      email: snapshot.data.user.email,
                      urlImage: snapshot.data.profileImage,
                    );
                  } else {
                    return Text('Token incorrecto', style: TextStyle(color: Colors.white));
                  }
                }
              },
            ),
          ),
          Positioned(top: 295, left: 20, child: _Title()),
          _Cameos(),
        ],
      ),
    );
  }
}

class _Logo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Image(image: AssetImage('assets/img/logo-light.png'), width: 100),
    );
  }
}

class _Title extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Text(
      'Mis Cameos',
      style: Theme.of(context).textTheme.headline6,
    );
  }
}

class _Options extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: RaisedButton(
        color: Colors.transparent,
        elevation: 0,
        shape: CircleBorder(),
        child: Icon(Icons.settings, color: Colors.white),
        onPressed: () => Navigator.pushNamed(context, 'options'),
      ),
    );
  }
}

class _Background extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 180,
      decoration: BoxDecoration(
        color: purple,
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: <Color>[purple, darkPurple],
        ),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(60),
          bottomRight: Radius.circular(60),
        ),
        boxShadow: <BoxShadow>[BoxShadow(color: black, blurRadius: 22, spreadRadius: -4)],
      ),
    );
  }
}

class _ColumnAvatar extends StatelessWidget {
  final String name;
  final String email;
  final String urlImage;

  const _ColumnAvatar({this.name, this.email, this.urlImage});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        _AvatarImageBox(urlImage: urlImage),
        SizedBox(height: 10),
        Text(
          name == null ? '' : name,
          style: Theme.of(context).textTheme.headline6,
        ),
        SizedBox(height: 5),
        Text(
          email == null ? '' : email,
          style: Theme.of(context).textTheme.bodyText2,
        ),
      ],
    );
  }
}

class _AvatarImageBox extends StatelessWidget {
  final String urlImage;

  const _AvatarImageBox({this.urlImage});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 130,
      width: 130,
      decoration: BoxDecoration(shape: BoxShape.circle, color: red),
      child: Container(
        padding: EdgeInsets.all(6),
        margin: EdgeInsets.all(6),
        child: _AvatarImage(urlImage: urlImage),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: lightGrey,
        ),
      ),
    );
  }
}

class _AvatarImage extends StatelessWidget {
  final String urlImage;

  const _AvatarImage({this.urlImage});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(100),
      child: Container(
        child: (urlImage == null)
            ? Image(image: AssetImage('assets/img/no_talent_image.png'))
            : FadeInImage(
                placeholder: AssetImage('assets/img/loading_gif.gif'),
                image: NetworkImage(urlImage),
                fit: BoxFit.cover,
              ),
      ),
    );
  }
}

class _Cameos extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 320),
      child: ListView.builder(
        physics: BouncingScrollPhysics(),
        itemCount: 2,
        itemBuilder: (BuildContext context, int index) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              VideoCard(
                urlImage: 'https://pbs.twimg.com/media/EZzYzLvWsAAk6jR.jpg',
              ),
              VideoCard(
                urlImage: 'https://pbs.twimg.com/media/EZzYzLvWsAAk6jR.jpg',
              ),
              VideoCard(
                urlImage: 'https://pbs.twimg.com/media/EZzYzLvWsAAk6jR.jpg',
              ),
            ],
          );
        },
      ),
    );
  }
}
// class ProfilePage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         centerTitle: true,
//         title: Text(
//           'Mis cameos',
//           style: TextStyle(
//             fontSize: 28,
//             fontWeight: FontWeight.w500,
//             color: Colors.black87,
//           ),
//         ),
//         backgroundColor: Colors.transparent,
//         elevation: 0,
//         actions: <Widget>[
//           InkWell(
//             borderRadius: BorderRadius.circular(30),
//             onTap: () => Navigator.pushNamed(context, 'options'),
//             child: Container(
//               margin: EdgeInsets.symmetric(horizontal: 16),
//               child: Icon(
//                 Icons.settings,
//                 color: Colors.black87,
//               ),
//             ),
//           ),
//         ],
//       ),
//       body: GridView.builder(
//         gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//           crossAxisCount: 2,
//           childAspectRatio: 0.82,
//         ),
//         itemCount: 4,
//         itemBuilder: (BuildContext context, int index) {
//           return TalentCard(
//             name: 'Felicidades Juan',
//             ocupation: 'Michael Jackson',
//             onTap: () {},
//             urlImage: 'https://pbs.twimg.com/media/EZzYzLvWsAAk6jR.jpg',
//           );
//         },
//       ),
//     );
//   }
// }
