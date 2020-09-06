import 'package:flutter/material.dart';
import 'package:mi_cameo/src/themes/theme.dart';

class VideoCard extends StatelessWidget {
  final String name;
  final String ocupation;
  final String urlImage;
  final Function onTap;

  const VideoCard({this.name, this.ocupation, this.urlImage, this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.all(10),
        width: 84,
        height: 84,
        child: _VideoCardImage(urlImage: urlImage),
        decoration: BoxDecoration(
          color: darkPurple,
          borderRadius: BorderRadius.circular(16),
        ),
        // child: Column(
        //   crossAxisAlignment: CrossAxisAlignment.start,
        //   children: <Widget>[
        //     _VideoCardImage(urlImage: urlImage),
        //     SizedBox(height: 5),
        //     _VideoCardTitle(name: name),
        //     _VideoCardSubtitle(ocupation: ocupation),
        //   ],
        // ),
      ),
    );
  }
}

class _VideoCardImage extends StatelessWidget {
  final String urlImage;

  const _VideoCardImage({@required this.urlImage});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(6),
      padding: EdgeInsets.all(4),
      decoration: BoxDecoration(color: lightGrey, shape: BoxShape.circle),
      child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(100)),
        child: Container(
          child: (urlImage == null || urlImage == '')
              ? Image(
                  fit: BoxFit.cover,
                  image: AssetImage('assets/img/no_talent_image.png'),
                )
              : FadeInImage(
                  fit: BoxFit.cover,
                  placeholder: AssetImage('assets/img/loading_gif.gif'),
                  image: NetworkImage(urlImage),
                ),
        ),
      ),
    );
  }
}

// class _VideoCardTitle extends StatelessWidget {
//   final String name;
//   const _VideoCardTitle({@required this.name});

//   @override
//   Widget build(BuildContext context) {
//     return Text(
//       name == null ? '' : name,
//       style: TextStyle(
//         fontSize: 15,
//         fontWeight: FontWeight.w500,
//         color: Colors.blueGrey[900],
//       ),
//     );
//   }
// }

// class _VideoCardSubtitle extends StatelessWidget {
//   final String ocupation;

//   const _VideoCardSubtitle({@required this.ocupation});

//   @override
//   Widget build(BuildContext context) {
//     return Text(ocupation == null ? '' : ocupation);
//   }
// }

// Diseño anterior
// import 'package:flutter/material.dart';

// class VideoCard extends StatelessWidget {
//   final String name;
//   final String ocupation;
//   final String urlImage;
//   final Function onTap;

//   const VideoCard({this.name, this.ocupation, this.urlImage, this.onTap});

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: onTap,
//       child: Container(
//         margin: EdgeInsets.all(10),
//         width: 150,
//         height: 180,
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: <Widget>[
//             _VideoCardImage(urlImage: urlImage),
//             SizedBox(height: 5),
//             _VideoCardTitle(name: name),
//             _VideoCardSubtitle(ocupation: ocupation),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class _VideoCardImage extends StatelessWidget {
//   final String urlImage;

//   const _VideoCardImage({@required this.urlImage});

//   @override
//   Widget build(BuildContext context) {
//     return ClipRRect(
//       borderRadius: BorderRadius.all(Radius.circular(15)),
//       child: Container(

//         width: 150,
//         height: 150,
//         child: (urlImage == null)
//             ? Image(
//                 image: AssetImage('assets/img/no_talent_image.png'),
//                 fit: BoxFit.cover,
//               )
//             : FadeInImage(
//                 fit: BoxFit.cover,
//                 placeholder: AssetImage('assets/img/loading_gif.gif'),
//                 image: NetworkImage(urlImage),
//               ),
//       ),
//     );
//   }
// }

// class _VideoCardTitle extends StatelessWidget {
//   final String name;
//   const _VideoCardTitle({@required this.name});

//   @override
//   Widget build(BuildContext context) {
//     return Text(
//       name == null ? '' : name,
//       style: TextStyle(
//         fontSize: 15,
//         fontWeight: FontWeight.w500,
//         color: Colors.blueGrey[900],
//       ),
//     );
//   }
// }

// class _VideoCardSubtitle extends StatelessWidget {
//   final String ocupation;

//   const _VideoCardSubtitle({@required this.ocupation});

//   @override
//   Widget build(BuildContext context) {
//     return Text(ocupation == null ? '' : ocupation);
//   }
// }
