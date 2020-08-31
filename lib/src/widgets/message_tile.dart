import 'package:flutter/material.dart';
import 'package:mi_cameo/src/themes/theme.dart';

class MessageTile extends StatelessWidget {
  final String title;
  final String subtitle;
  final String urlImage;
  final int messagesCount;

  const MessageTile({
    @required this.title,
    this.subtitle = '',
    this.urlImage,
    this.messagesCount = 0,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 84,
      child: InkWell(
        onTap: () {},
        child: Row(
          children: <Widget>[
            _TalentImage(urlImage: urlImage),
            _BodyTile(title: title, subtitle: subtitle),
            _MessagesCount(messagesCount: messagesCount),
          ],
        ),
      ),
    );
  }
}

class _TalentImage extends StatelessWidget {
  final String urlImage;

  const _TalentImage({@required this.urlImage});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 68,
      width: 68,
      padding: EdgeInsets.all(5),
      margin: EdgeInsets.only(right: 9, left: 9),
      decoration: BoxDecoration(color: lightGrey, shape: BoxShape.circle),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(30),
        child: Container(
          child: (urlImage == null)
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
    );
  }
}

class _MessagesCount extends StatelessWidget {
  final int messagesCount;

  const _MessagesCount({this.messagesCount});
  @override
  Widget build(BuildContext context) {
    return messagesCount > 0
        ? Center(
            child: Container(
              margin: EdgeInsets.only(right: 20, left: 10),
              height: 24,
              width: 24,
              alignment: Alignment.center,
              decoration: BoxDecoration(color: red, shape: BoxShape.circle),
              // child: Text(messagesCount.toString()),
              child: Text(
                messagesCount.toString().length > 2? '99+': messagesCount.toString(),
                style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.w500),
              ),
            ),
          )
        : Container(width: 18);
  }
}