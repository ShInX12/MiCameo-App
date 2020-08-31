import 'package:flutter/material.dart';
import 'package:mi_cameo/src/bloc/talents_by_category_bloc.dart';
import 'package:mi_cameo/src/helpers/api_base_helper.dart';
import 'package:mi_cameo/src/models/user_model.dart';
import 'package:mi_cameo/src/widgets/talent_card.dart';
import 'package:mi_cameo/src/widgets/widgets.dart';

class SubcategoryList extends StatefulWidget {
  @override
  _SubcategoryListState createState() => _SubcategoryListState();
}

class _SubcategoryListState extends State<SubcategoryList> {
  TalentsByCategoryBloc _talentsByCategoryBloc;

  @override
  void initState() {
    super.initState();
    _talentsByCategoryBloc = new TalentsByCategoryBloc();
  }

  @override
  Widget build(BuildContext context) {
    final String category = ModalRoute.of(context).settings.arguments;
    _talentsByCategoryBloc.fetchTalentList(category, false);
    return Scaffold(
      appBar: AppBar(title: Text(category, style: TextStyle(color: Colors.black87))),
      body: RefreshIndicator(
        onRefresh: () => _talentsByCategoryBloc.fetchTalentList(category, false),
        child: StreamBuilder<ApiResponse<List<Talent>>>(
          stream: _talentsByCategoryBloc.talentsByCategoryStream,
          builder: (context, AsyncSnapshot<ApiResponse<List<Talent>>> snapshot) {
            if (snapshot.hasData) {
              switch (snapshot.data.status) {
                case Status.LOADING:
                  return Center(child: CircularProgressIndicator());
                  break;
                case Status.COMPLETED:
                  return _TalentList(
                    talents: snapshot.data.data,
                    category: category,
                    bloc: _talentsByCategoryBloc,
                  );
                  break;
                case Status.ERROR:
                  return Center(
                    child: ErrorMessage(
                      errorMessage: snapshot.data.message,
                      buttonText: 'Volver',
                      onPressed: () => Navigator.pop(context),
                    ),
                  );
                  break;
              }
            }
            return Center(child: Text('El Stream esta vacío'));
          },
        ),
      ),
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
      if (_talentListController.position.pixels >= _talentListController.position.maxScrollExtent - 200) {
        bloc.fetchTalentList(category, false);
      }
    });

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
