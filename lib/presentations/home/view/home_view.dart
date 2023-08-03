import 'package:bloc_cfl/app/const/globals.dart';
import 'package:bloc_cfl/data/respositories/home_respository.dart';
import 'package:bloc_cfl/presentations/home/bloc/home_bloc.dart';
import 'package:bloc_cfl/presentations/home/bloc/home_event.dart';
import 'package:bloc_cfl/presentations/home/bloc/home_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  HomeBloc bloc = HomeBloc(repository: HomeRepository());
  ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    bloc.add(HomeCommentsLoadDataEvent());
    _scrollController.addListener(_onScroll);
    super.initState();
  }

  void _onScroll() {
    if (_scrollController.position.atEdge &&
        _scrollController.position.pixels != 0) {
      bloc.add(HomeCommentsLoadDataEvent());
    }
  }

  TimeOfDay nowTime = TimeOfDay.now();

  @override
  void dispose() {
    _scrollController.dispose();
    bloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Bloc Api Demo ${Globals.userName}"),
        actions: [
          IconButton(
              onPressed: () {
                // LocalDB.clear();
                // Navigator.pushNamedAndRemoveUntil(
                //     context, '/login', (route) => false);
                //controller.addListener(_addListener);
                bloc.add(HomeCommentsLoadDataEvent());
              },
              icon: Icon(Icons.restart_alt))
        ],
      ),
      body: SafeArea(
        child: BlocConsumer<HomeBloc, HomeSate>(
          bloc: bloc,
          listener: (context, state) {},
          builder: (context, state) {
            if (state is HomeStateData) {
              return Column(
                children: [
                  (state.commentsList.isNotEmpty)
                      ? Flexible(
                          child: ListView.builder(
                              controller: _scrollController,
                              shrinkWrap: true,
                              physics: ClampingScrollPhysics(),
                              itemCount: state.commentsList.length,
                              itemBuilder: (context, index) {
                                final items = state.commentsList[index];
                                return Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: Card(
                                      child: Column(
                                    children: [
                                      Text(items.user!.username!),
                                      Text(items.body!),
                                      Text('${items.postId!}'),
                                    ],
                                  )),
                                );
                              }),
                        )
                      : SizedBox(),
                  (state.isLoading)
                      ? Center(
                          child: CircularProgressIndicator(),
                        )
                      : SizedBox(),
                  state.message.isNotEmpty
                      ? Center(
                          child: Text(state.message),
                        )
                      : SizedBox(),
                  state.error.isNotEmpty
                      ? Center(
                          child: Text(state.error),
                        )
                      : SizedBox(),
                ],
              );
            }
            return SizedBox();
          },
        ),
      ),
    );
  }
}
