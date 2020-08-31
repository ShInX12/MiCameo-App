import 'package:flutter/material.dart';
import 'package:mi_cameo/src/models/subcategory_model.dart';
import 'package:mi_cameo/src/models/user_model.dart';
import 'package:mi_cameo/src/themes/theme.dart';
import 'package:mi_cameo/src/widgets/talent_card.dart';

class TalentsSlider extends StatelessWidget {
  final Subcategory subcategory;

  const TalentsSlider({this.subcategory});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: Column(
        children: <Widget>[
          _Header(subName: subcategory.subName),
          _Slider(talents: subcategory.talents),
          Divider(height: 1, indent: 10, endIndent: 10),
        ],
      ),
    );
  }
}

class _Header extends StatelessWidget {
  final String subName;

  const _Header({@required this.subName});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Expanded(
            child: Text(
              subName == null ? '' : subName,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.headline5,
            ),
          ),
          InkWell(
            onTap: () => Navigator.pushNamed(context, 'subcategory_list', arguments: subName),
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: Text(
                'Ver más',
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: purple,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _Slider extends StatelessWidget {
  final List<Talent> talents;

  const _Slider({@required this.talents});

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 210.0,
      height: 195.0,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: talents.length,
        itemBuilder: (BuildContext context, int i) {
          return TalentCard(
            name: talents[i].user.username,
            ocupation: talents[i].description,
            urlImage: talents[i].profileImage,
            price: talents[i].price,
            onTap: () => Navigator.pushNamed(
              context,
              'talent',
              arguments: talents[i],
            ),
          );
        },
      ),
    );
  }
}
