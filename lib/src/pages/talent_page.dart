import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:mi_cameo/src/models/user_model.dart';
import 'package:mi_cameo/src/state/talent_state.dart';
import 'package:mi_cameo/src/widgets/widgets.dart';

class TalentPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Talent talent = ModalRoute.of(context).settings.arguments;

    return ChangeNotifierProvider(
      create: (_) => new TalentState(talent),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          alignment: Alignment.topCenter,
          children: <Widget>[
            SingleChildScrollView(child: _BackgroundImage()),
            SingleChildScrollView(child: _CardBackground()),
            Positioned(bottom: 20, child: _RequestButton()),
            Positioned(left: -5, top: 40, child: _BackButton()),
          ],
        ),
      ),
    );
  }
}

class _BackgroundImage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    return Hero(
      tag: Provider.of<TalentState>(context).userName,
      child: ClipRRect(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(50),
          bottomRight: Radius.circular(50),
        ),
        child: Container(
          width: double.infinity,
          height: screenSize.width,
          child: (Provider.of<TalentState>(context).urlImage == null ||
                  Provider.of<TalentState>(context).urlImage == '')
              ? Image(
                  image: AssetImage('assets/img/no_talent_image.png'),
                  fit: BoxFit.cover,
                )
              : FadeInImage(
                  fit: BoxFit.cover,
                  placeholder: AssetImage('assets/img/loading_gif.gif'),
                  image: NetworkImage(Provider.of<TalentState>(context).urlImage),
                ),
        ),
      ),
    );
  }
}

class _CardBackground extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 22, vertical: 30),
      margin: EdgeInsets.only(top: screenSize.width),
      child: _CardBody(),
      decoration: BoxDecoration(color: Colors.white),
    );
  }
}

class _CardBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        _Title(),
        SizedBox(height: 10),
        _Info(),
        SizedBox(height: 15),
        _Description(),
        SizedBox(height: 10),
        _Categories(),
        SizedBox(height: 50),
      ],
    );
  }
}

class _Title extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    String fullName = Provider.of<TalentState>(context).fullName;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          fullName,
          overflow: TextOverflow.ellipsis,
          style: Theme.of(context).textTheme.headline4,
        ),
      ],
    );
  }
}

class _Info extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[_Rating(), _ResponseTime()],
    );
  }
}

class _Rating extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(Icons.star, color: Theme.of(context).accentColor),
            Icon(Icons.star, color: Theme.of(context).accentColor),
            Icon(Icons.star, color: Theme.of(context).accentColor),
            Icon(Icons.star, color: Theme.of(context).accentColor),
            Icon(Icons.star, color: Theme.of(context).disabledColor),
          ],
        ),
        SizedBox(height: 6),
        Text('76 calificaciones'),
      ],
    );
  }
}

class _ResponseTime extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    int responseDays = Provider.of<TalentState>(context).responseDays;
    String days = responseDays == 1 ? 'día' : 'días';
    return Column(
      children: <Widget>[
        Text('$responseDays $days', style: TextStyle(color: Colors.black87)),
        SizedBox(height: 6),
        Text('Tiempo de respuesta'),
      ],
    );
  }
}

class _Description extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    String description = Provider.of<TalentState>(context).description;
    return Text(description, style: Theme.of(context).textTheme.bodyText1);
  }
}

class _Categories extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<String> categories = Provider.of<TalentState>(context).categories;
    return Wrap(
      spacing: 10,
      children: categories.map((category) => Chip(label: Text(category))).toList(),
    );
  }
}

class _RequestButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: MediaQuery.of(context).size.width * 0.88,
      child: ButtonType1(
        text: 'Solictar Cameo',
        colorPurple: true,
        shadow: true,
        onPressed: () => Navigator.pushNamed(
          context,
          'request_present',
          arguments: {
            'userName': Provider.of<TalentState>(context, listen: false).userName,
            'price': Provider.of<TalentState>(context, listen: false).price,
          },
        ),
      ),
    );
  }
}

class _BackButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      shape: CircleBorder(),
      color: Colors.white,
      onPressed: () => Navigator.pop(context),
      child: Container(
        width: 45,
        height: 45,
        child: Icon(Icons.arrow_back, size: 25),
      ),
    );
  }
}
