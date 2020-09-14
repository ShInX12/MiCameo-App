import 'package:flutter/material.dart';
import 'package:mi_cameo/src/themes/theme.dart';

class NotificationTile extends StatelessWidget {
  final String title;
  final String subtitle;
  final String urlImage;
  final bool accentColor;
  final Function onTap;

  const NotificationTile({
    @required this.title,
    this.subtitle,
    this.urlImage,
    @required this.onTap,
    this.accentColor = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      height: 75,
      child: Material(
        borderRadius: BorderRadius.circular(14),
        color: lightGrey,
        child: InkWell(
          onTap: onTap,
          customBorder: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
          child: Row(
            children: <Widget>[
              _Image(urlImage: urlImage, accentColor: accentColor),
              _BodyTile(title: title, subtitle: subtitle),
            ],
          ),
        ),
      ),
    );
  }
}

class _Image extends StatelessWidget {
  final String urlImage;
  final bool accentColor;

  const _Image({this.urlImage, this.accentColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 75,
      height: 75,
      child: _Avatar(urlImage: urlImage),
      decoration: BoxDecoration(
        color: accentColor ? darkPurple : grey,
        borderRadius: BorderRadius.circular(14),
      ),
    );
  }
}

class _Avatar extends StatelessWidget {
  final String urlImage;

  const _Avatar({this.urlImage});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(6),
      padding: EdgeInsets.all(4),
      decoration: BoxDecoration(color: lightGrey, shape: BoxShape.circle),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(30),
        child: Container(
          child: (urlImage == null || urlImage == '')
              ? Image(image: AssetImage('assets/img/no_talent_image.png'))
              : FadeInImage(
                  placeholder: AssetImage('assets/img/loading_gif.gif'),
                  image: NetworkImage(urlImage),
                  fit: BoxFit.cover,
                ),
        ),
      ),
    );
  }
}

class _BodyTile extends StatelessWidget {
  final String title;
  final String subtitle;

  const _BodyTile({@required this.title, @required this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: EdgeInsets.only(left: 18.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              title == null ? '' : title,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.subtitle1,
            ),
            SizedBox(height: 7),
            Text(
              subtitle == null ? '' : subtitle,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.bodyText2,
            ),
          ],
        ),
      ),
    );
  }
}

// Diseño anterior
// import 'package:flutter/material.dart';

// class NotificationTile extends StatelessWidget {
//   final String title;
//   final String subtitle;
//   final String urlImage;

//   const NotificationTile({@required this.title, this.subtitle, this.urlImage});

//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
//       elevation: 2.0,
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
//       child: Container(
//         height: 75,
//         child: InkWell(
//           customBorder:
//               RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
//           onTap: () {},
//           child: Row(
//             children: <Widget>[
//               _BodyTile(title: title, subtitle: subtitle),
//               _NotificationIcon(urlImage: null),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// class _BodyTile extends StatelessWidget {
//   final String title;
//   final String subtitle;

//   const _BodyTile({@required this.title, @required this.subtitle});

//   @override
//   Widget build(BuildContext context) {
//     return Expanded(
//       child: Padding(
//         padding: EdgeInsets.only(left: 18.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             Text(title == null ? '' : title,
//                 style: TextStyle(fontSize: 19, color: Colors.black87)),
//             SizedBox(height: 7),
//             Text(subtitle == null ? '' : subtitle,
//                 style: TextStyle(fontSize: 15, color: Colors.black54)),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class _NotificationIcon extends StatelessWidget {
//   final String urlImage;

//   const _NotificationIcon({@required this.urlImage});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: 75,
//       width: 75,
//       padding: EdgeInsets.all(12),
//       margin: EdgeInsets.only(right: 5),
//       child: Icon(Icons.videocam),
//     );
//   }
// }
