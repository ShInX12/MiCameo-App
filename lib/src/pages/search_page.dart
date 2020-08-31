import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:mi_cameo/src/bloc/talents_by_category_bloc.dart';
import 'package:mi_cameo/src/helpers/api_base_helper.dart';
import 'package:mi_cameo/src/models/category_model.dart';
import 'package:mi_cameo/src/models/user_model.dart';
import 'package:mi_cameo/src/repository/categories_repository.dart';
import 'package:mi_cameo/src/widgets/talent_card.dart';
import 'package:mi_cameo/src/widgets/widgets.dart';

class SearchPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => new BlocState(),
      child: Scaffold(
        body: SafeArea(
          child: Column(
            children: <Widget>[
              _SearchInput(),
              _Categories(),
              Expanded(child: _Results()),
            ],
          ),
        ),
      ),
    );
  }
}

class _SearchInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(right: 12, left: 12, top: 14, bottom: 8),
      child: TextField(
        onChanged: (value) {
          if (value.length > 0) {
            Provider.of<BlocState>(context, listen: false)
                .talentsByCategoryBloc
                .fetchTalentList(value, true);
          }
        },
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.search),
          hintText: 'Buscar...',
        ),
      ),
    );
  }
}

class _Categories extends StatefulWidget {
  @override
  __CategoriesState createState() => __CategoriesState();
}

class __CategoriesState extends State<_Categories> {
  final _categoriesRespository = CategoriesRespository();

  int select = -1;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      child: FutureBuilder(
        future: this._categoriesRespository.fetchCategories(),
        builder: (context, AsyncSnapshot<List<Category>> snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              padding: EdgeInsets.symmetric(horizontal: 8),
              scrollDirection: Axis.horizontal,
              itemCount: snapshot.data.length,
              itemBuilder: (BuildContext context, int i) {
                return Container(
                  margin: EdgeInsets.symmetric(horizontal: 4),
                  child: ChoiceChip(
                    selected: i == select ? true : false,
                    label: Text(snapshot.data[i].categories[0]),
                    onSelected: (value) async {
                      setState(() => select = i);
                      Provider.of<BlocState>(context, listen: false).category =
                          snapshot.data[i].categories[0];
                      await Provider.of<BlocState>(context, listen: false)
                          .talentsByCategoryBloc
                          .fetchTalentList(snapshot.data[i].categories[0], true);
                    },
                  ),
                );
              },
            );
          } else {
            return Container(height: 50);
          }
        },
      ),
    );
  }
}

class _Results extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: Provider.of<BlocState>(context).talentsByCategoryBloc.talentsByCategoryStream,
      builder: (context, AsyncSnapshot<ApiResponse<List<Talent>>> snapshot) {
        if (snapshot.hasData) {
          switch (snapshot.data.status) {
            case Status.LOADING:
              return Center(child: CircularProgressIndicator());
              break;
            case Status.COMPLETED:
              return _TalentList(
                talents: snapshot.data.data,
                category: Provider.of<BlocState>(context).category,
                bloc: Provider.of<BlocState>(context).talentsByCategoryBloc,
              );
              break;
            case Status.ERROR:
              return Center(
                child: ErrorMessage(
                  errorMessage: snapshot.data.message,
                  buttonText: 'Volver',
                  onPressed: () {},
                ),
              );
              break;
          }
        } else {
          return Center(child: Text('Realiza una busqueda'));
        }
        return Container();
      },
    );
  }
}

class _TalentList extends StatelessWidget {
  final List<Talent> talents;
  final String category;
  final TalentsByCategoryBloc bloc;

  _TalentList({this.talents, this.category, this.bloc});

  final _talentListController = new ScrollController();

  @override
  Widget build(BuildContext context) {
    _talentListController.addListener(() {
      if (_talentListController.position.pixels >=
          _talentListController.position.maxScrollExtent - 200) {
        bloc.fetchTalentList(category, false);
      }
    });
    if (talents.length == 0) return Center(child: Text('No hay resultados'));
    return GridView.builder(
      itemCount: talents.length,
      controller: _talentListController,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.925,
      ),
      itemBuilder: (BuildContext context, int i) {
        return TalentCard(
          name: talents[i].user.username,
          ocupation: talents[i].description,
          urlImage: talents[i].profileImage,
          price: talents[i].price,
          onTap: () => Navigator.pushNamed(context, 'talent', arguments: talents[i]),
        );
      },
    );
  }
}

class BlocState with ChangeNotifier {
  TalentsByCategoryBloc _talentsByCategoryBloc;
  String _category;

  BlocState() {
    _talentsByCategoryBloc = TalentsByCategoryBloc();
  }

  set talentsByCategoryBloc(TalentsByCategoryBloc value) {
    this._talentsByCategoryBloc = value;
    notifyListeners();
  }

  TalentsByCategoryBloc get talentsByCategoryBloc => this._talentsByCategoryBloc;

  set category(String value) {
    this._category = value;
    notifyListeners();
  }

  String get category => this._category;
}
