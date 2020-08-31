import 'package:flutter/material.dart';
import 'package:mi_cameo/src/themes/theme.dart';

class TalentCard extends StatelessWidget {
  final String name;
  final String ocupation;
  final String urlImage;
  final String price;
  final Function onTap;

  const TalentCard({
    @required this.name,
    @required this.ocupation,
    @required this.urlImage,
    @required this.price,
    @required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(14),
      child: Container(
        // margin: EdgeInsets.all(10),
        margin: EdgeInsets.all(8),
        // width: 150,
        // height: 180,
        width: 135,
        height: 165,
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                _TalentCardImage(urlImage: urlImage),
                SizedBox(height: 5),
                _TalentCardTitle(name: name),
                _TalentCardSubtitle(ocupation: ocupation),
              ],
            ),
            Positioned(
              // right: 10,
              bottom: 45,
              child: _Price(price: price),
            ),
          ],
        ),
      ),
    );
  }
}

class _TalentCardImage extends StatelessWidget {
  final String urlImage;

  const _TalentCardImage({@required this.urlImage});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(6),
      // height: 150,
      // width: 150,
      height: 135,
      width: 135,
      child: ClipRRect(
        // borderRadius: BorderRadius.all(Radius.circular(15)),
        borderRadius: BorderRadius.all(Radius.circular(100)),
        child: (urlImage == null)
            ? Image(
                image: AssetImage('assets/img/no_talent_image.png'),
                fit: BoxFit.cover,
              )
            : FadeInImage(
                fit: BoxFit.cover,
                placeholder: AssetImage('assets/img/loading_gif.gif'),
                image: NetworkImage(urlImage),
              ),
      ),
      decoration: BoxDecoration(color: lightGrey, shape: BoxShape.circle),
      // decoration: BoxDecoration(
      //   borderRadius: BorderRadius.circular(15),
      //   boxShadow: <BoxShadow>[
      //     BoxShadow(
      //       offset: Offset(0, 0),
      //       color: Colors.blueGrey.withOpacity(0.3),
      //       spreadRadius: 0,
      //       blurRadius: 7,
      //     )
      //   ],
      // ),
    );
  }
}

class _TalentCardTitle extends StatelessWidget {
  final String name;
  const _TalentCardTitle({@required this.name});

  @override
  Widget build(BuildContext context) {
    return Text(
      name == null ? '' : name,
      overflow: TextOverflow.ellipsis,
      style: Theme.of(context).textTheme.subtitle1,
    );
  }
}

class _TalentCardSubtitle extends StatelessWidget {
  final String ocupation;

  const _TalentCardSubtitle({@required this.ocupation});

  @override
  Widget build(BuildContext context) {
    return Text(
      ocupation == null ? '' : ocupation,
      overflow: TextOverflow.ellipsis,
      style: Theme.of(context).textTheme.bodyText2,
    );
  }
}

class _Price extends StatelessWidget {
  final String price;

  const _Price({this.price = '0'});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 6, vertical: 1),
      child: Text(
        '\$ $price',
        style: TextStyle(color: Colors.black87),
      ),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(50),
          boxShadow: <BoxShadow>[
            BoxShadow(color: Colors.grey, blurRadius: 3, spreadRadius: -1)
          ]),
    );
  }
}
