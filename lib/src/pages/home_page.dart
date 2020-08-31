import 'package:flutter/material.dart';
import 'package:mi_cameo/src/bloc/subcategories_bloc.dart';
import 'package:mi_cameo/src/models/subcategory_model.dart';
import 'package:mi_cameo/src/helpers/api_base_helper.dart';
import 'package:mi_cameo/src/widgets/talents_slider.dart';
import 'package:mi_cameo/src/widgets/widgets.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  SubcategoriesBloc _subcategoriesBloc;

  @override
  void initState() {
    super.initState();
    _subcategoriesBloc = new SubcategoriesBloc();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image(
          height: 24,
          image: AssetImage('assets/img/logo-black.png'),
        ),
      ),
      body: RefreshIndicator(
        onRefresh: () => _subcategoriesBloc.fetchSubcategorylist(),
        child: StreamBuilder<ApiResponse<List<Subcategory>>>(
          stream: _subcategoriesBloc.subcategoriesListStream,
          builder: (context, AsyncSnapshot<ApiResponse<List<Subcategory>>> snapshot) {
            if (snapshot.hasData) {
              switch (snapshot.data.status) {
                case Status.LOADING:
                  return Center(child: CircularProgressIndicator());
                  break;
                case Status.COMPLETED:
                  return ListView.builder(
                    itemCount: snapshot.data.data.length,
                    itemBuilder: (BuildContext context, int i) {
                      return TalentsSlider(subcategory: snapshot.data.data[i]);
                    },
                  );
                  break;
                case Status.ERROR:
                  return Center(
                    child: ErrorMessage(
                      errorMessage: snapshot.data.message,
                      onPressed: () => _subcategoriesBloc.fetchSubcategorylist(),
                    ),
                  );
                  break;
              }
            }
            return Container();
          },
        ),
      ),
    );
  }
}
