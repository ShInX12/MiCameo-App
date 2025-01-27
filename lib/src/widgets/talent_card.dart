import 'package:flutter/material.dart';
import 'package:mi_cameo/src/themes/theme.dart';

class TalentCard extends StatelessWidget {
  final String userName;
  final String title;
  final String ocupation;
  final String urlImage;
  final String price;
  final Function onTap;

  const TalentCard({
    @required this.userName,
    @required this.title,
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
        margin: EdgeInsets.all(8),
        width: 135,
        height: 165,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Stack(
              alignment: Alignment.bottomCenter,
              children: [
                _TalentCardImage(urlImage: urlImage, userName: userName),
                _Price(price: price),
              ],
            ),
            SizedBox(height: 5),
            _TalentCardTitle(title: title),
            _TalentCardSubtitle(ocupation: ocupation),
          ],
        ),
      ),
    );
  }
}

class _TalentCardImage extends StatelessWidget {
  final String urlImage;
  final String userName;

  const _TalentCardImage({@required this.urlImage, this.userName});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(6),
      height: 135,
      width: 135,
      child: Hero(
        tag: userName,
        child: ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(100)),
          child: (urlImage == null || urlImage == '')
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
      ),
      decoration: BoxDecoration(color: lightGrey, shape: BoxShape.circle),
    );
  }
}

class _TalentCardTitle extends StatelessWidget {
  final String title;
  const _TalentCardTitle({@required this.title});

  @override
  Widget build(BuildContext context) {
    return Text(
      title == null ? '' : title,
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
          BoxShadow(color: Colors.grey, blurRadius: 3, spreadRadius: -1),
        ],
      ),
    );
  }
}
