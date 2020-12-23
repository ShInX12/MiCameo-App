import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:uuid/uuid.dart';
import 'package:provider/provider.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mi_cameo/src/models/cameo_model.dart';
import 'package:mi_cameo/src/models/user_model.dart';
import 'package:mi_cameo/src/repository/cameo_repository.dart';
import 'package:mi_cameo/src/repository/client_repository.dart';
import 'package:mi_cameo/src/state/client_state.dart';
import 'package:mi_cameo/src/widgets/video_preview.dart';
import 'package:mi_cameo/src/themes/theme.dart';

class ProfilePage extends StatelessWidget {
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
          Positioned(top: 90, child: _ColumnAvatar(Provider.of<ClientState>(context).client)),
          Positioned(top: 300, left: 20, child: _Title()),
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
    return Column(
      children: [
        Text(
          'Mis Cameos',
          style: Theme.of(context).textTheme.headline6,
        ),
        SizedBox(height: 10),
      ],
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
  final Client client;

  const _ColumnAvatar(this.client);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        _AvatarImageBox(client: client),
        SizedBox(height: 10),
        Text(
          client.user.username == null ? '' : client.user.username,
          style: Theme.of(context).textTheme.headline6,
        ),
        SizedBox(height: 5),
        Text(
          client.user.email == null ? '' : client.user.email,
          style: Theme.of(context).textTheme.bodyText2,
        ),
      ],
    );
  }
}

class _AvatarImageBox extends StatelessWidget {
  final Client client;

  const _AvatarImageBox({this.client});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 130,
      width: 130,
      decoration: BoxDecoration(shape: BoxShape.circle, color: red),
      child: Container(
        padding: EdgeInsets.all(6),
        margin: EdgeInsets.all(6),
        child: _AvatarImage(client: client),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: lightGrey,
        ),
      ),
    );
  }
}

class _AvatarImage extends StatefulWidget {
  final Client client;

  const _AvatarImage({this.client});

  @override
  __AvatarImageState createState() => __AvatarImageState();
}

class __AvatarImageState extends State<_AvatarImage> {
  FirebaseStorage storage = FirebaseStorage(storageBucket: 'gs://mi-cameo.appspot.com');
  final clientRepository = ClientRepository();
  final picker = ImagePicker();
  bool loading = false;

  imageMenu(Size size) {
    showMenu(
      context: context,
      position: RelativeRect.fromLTRB(size.width * 0.2, 180, size.width * 0.2, 200),
      items: [
        PopupMenuItem(
          child: ListTile(
            title: Text('Cambiar imagen'),
            onTap: () {
              pickImage();
              Navigator.pop(context);
            },
          ),
        ),
        if (widget.client.profileImage.length > 1)
          PopupMenuItem(
            child: ListTile(
              title: Text('Eliminar imagen'),
              onTap: () {
                deleteImage(widget.client.profileImage);
                Navigator.pop(context);
              },
            ),
          )
      ],
    );
  }

  Future<void> pickImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    if (pickedFile != null) _uploadFile(File(pickedFile.path));
  }

  Future<void> _uploadFile(File file) async {
    setState(() => loading = true);
    final lastImage = widget.client.profileImage;
    final String uuid = Uuid().v1();
    final StorageReference ref = storage.ref().child('uploads').child('img$uuid.jpg');
    final StorageUploadTask uploadTask = ref.putFile(
      file,
      StorageMetadata(contentLanguage: 'es'),
    );
    await uploadTask.onComplete;
    widget.client.profileImage = await ref.getDownloadURL();
    final clientUpdated = await clientRepository.updateClient(widget.client);
    setState(() => loading = false);

    if (clientUpdated != null) {
      Scaffold.of(context).showSnackBar(SnackBar(
        content: Text('Imagen actualizada'),
        duration: Duration(seconds: 4),
      ));
      deleteImageFromStorage(lastImage);
    } else {
      Scaffold.of(context).showSnackBar(SnackBar(
        content: Text('No se pudo actualizar la imagen'),
        duration: Duration(seconds: 4),
      ));
    }
  }

  Future<void> deleteImage(String lastImage) async {
    widget.client.profileImage = '';
    final clientUpdated = await clientRepository.updateClient(widget.client);
    if (clientUpdated != null) {
      Scaffold.of(context).showSnackBar(SnackBar(
        content: Text('Imagen eliminada'),
        duration: Duration(seconds: 4),
      ));
      setState(() {});
      deleteImageFromStorage(lastImage);
    } else {
      Scaffold.of(context).showSnackBar(SnackBar(
        content: Text('No se pudo eliminar la imagen'),
        duration: Duration(seconds: 4),
      ));
    }
  }

  Future<void> deleteImageFromStorage(String imageUrl) async {
    try {
      final ref = await storage.getReferenceFromUrl(imageUrl);
      await ref.delete();
    } on PlatformException {
      print('No existe la imagen en firebase');
    } catch (e) {
      print('Ha ocurrido un error: ' + e);
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () => imageMenu(size),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            width: 124,
            height: 124,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(100),
              child: (widget.client.profileImage == null || widget.client.profileImage == '')
                  ? Image(image: AssetImage('assets/img/no_talent_image.png'))
                  : FadeInImage(
                      placeholder: AssetImage('assets/img/loading_gif.gif'),
                      image: NetworkImage(widget.client.profileImage),
                      fit: BoxFit.cover,
                    ),
            ),
          ),
          if (loading) CircularProgressIndicator(),
        ],
      ),
    );
  }
}

class _Cameos extends StatelessWidget {
  final _cameoRepository = new CameoRepository();

  // Future<void> _launchBrowser(String url) async {
  //   if (await canLaunch(url)) {
  //     await launch(
  //       url,
  //       forceSafariVC: false,
  //       forceWebView: false,
  //       headers: <String, String>{},
  //     );
  //   } else {
  //     throw 'No se pudo lanzar el navegador';
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final int crossAxisCount = ((size.width / 127) - 1).round();

    // if (crossAxisCount >= 3) bloc.fetchTalentList(category, false);

    return Container(
      margin: EdgeInsets.only(top: 325),
      child: FutureBuilder(
        future: _cameoRepository.fetchCameos(),
        builder: (context, AsyncSnapshot<List<Cameo>> snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
            case ConnectionState.waiting:
              return Center(child: CircularProgressIndicator());
              break;
            default:
              if (snapshot.hasError)
                return Center(child: Text('Error al traer los cameos'));
              else if (snapshot.hasData) {
                if (snapshot.data.length == 0)
                  return Center(child: Text('Todavía no tienes cameos'));
                // return ListView.builder(
                //   itemCount: snapshot.data.length,
                //   itemBuilder: (context, i) {
                //     return ListTile(
                //       title: Text('Id: ${snapshot.data[i].id}'),
                //       subtitle: Text(snapshot.data[i].urlVideo),
                //       // onTap: () => _launchBrowser(snapshot.data[i].urlVideo),
                //       onTap: () => Navigator.pushNamed(
                //         context,
                //         'video_player',
                //         arguments: snapshot.data[i].urlVideo,
                //       ),
                //     );
                //   },
                // );
                return StaggeredGridView.countBuilder(
                  physics: BouncingScrollPhysics(),
                  itemCount: snapshot.data.length,
                  crossAxisCount: crossAxisCount,
                  crossAxisSpacing: 2,
                  mainAxisSpacing: 2,
                  addAutomaticKeepAlives: false,
                  staggeredTileBuilder: (index) => StaggeredTile.extent(1, 200),
                  itemBuilder: (context, i) {
                    return VideoPreview(
                      url: snapshot.data[i].urlVideo,
                      onTap: () => Navigator.pushNamed(
                        context,
                        'video_player',
                        arguments: snapshot.data[i].urlVideo,
                      ),
                    );
                  },
                );
              } else {
                return Container();
              }
          }
        },
      ),
    );
  }
}
