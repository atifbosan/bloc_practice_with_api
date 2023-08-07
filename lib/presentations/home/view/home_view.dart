import 'package:bloc_cfl/app/const/globals.dart';
import 'package:bloc_cfl/data/models/user_model.dart';
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
    // bloc.add(HomeCommentsLoadDataEvent());
    // bloc.add(HomeProductLoadPageEvent());
    bloc.add(HomeUsersEvent());
    // bloc.add(HomePermissionEvent());
    _scrollController.addListener(_onScroll);
    super.initState();
  }

  void _onScroll() {
    if (_scrollController.position.atEdge &&
        _scrollController.position.pixels != 0) {
      // bloc.add(HomeCommentsLoadDataEvent());
      // bloc.add(HomeProductLoadPageEvent());
      bloc.add(HomeUsersEvent());
    }
  }

  TimeOfDay nowTime = TimeOfDay.now();
  UserModel? userModel;
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
                bloc.add(HomePickImageEvent());
                //bloc.add(HomeUsersEvent());
              },
              icon: Icon(Icons.restart_alt))
        ],
      ),
      body: SafeArea(
        child: BlocConsumer<HomeBloc, HomeSate>(
          bloc: bloc,
          listener: (context, state) {},
          builder: (context, state) {
            if (state is HomeUsersState) {
              return Column(
                children: [
                  state.imageFile != null
                      ? Image(
                          image: FileImage(state.imageFile!),
                          height: 200,
                        )
                      : SizedBox(),
                  DropdownButton<UserModel>(
                    value: userModel,
                    hint: Text('Select a user'),
                    onChanged: (UserModel? newValue) {
                      userModel = newValue!;
                      setState(() {});
                    },
                    items: state.usersList
                        .map<DropdownMenuItem<UserModel>>((UserModel model) {
                      return DropdownMenuItem<UserModel>(
                        value: model,
                        child: Text(model.firstName!),
                      );
                    }).toList(),
                  ),
                  /*   (state.commentsList.isNotEmpty)
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
                      : SizedBox(),*/
                  /*  state.productList.isNotEmpty
                      ? Flexible(
                          child: GridView.builder(
                              controller: _scrollController,
                              itemCount: state.productList.length,
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                      crossAxisSpacing: 3.0,
                                      mainAxisSpacing: 3.0),
                              itemBuilder: (context, index) {
                                final items = state.productList[index];
                                return Card(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Image.network(
                                        items.thumbnail!,
                                        height: 130,
                                        width: 230,
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Center(child: Text("${items.title}")),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 2.0, right: 2),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text("Price: \$${items.price}"),
                                            Column(
                                              children: [
                                                RatingBar.builder(
                                                  initialRating: items.rating!,
                                                  allowHalfRating: true,
                                                  minRating: 1,
                                                  ignoreGestures: false,
                                                  tapOnlyMode: false,
                                                  updateOnDrag: false,
                                                  itemSize: 15,
                                                  direction: Axis.horizontal,
                                                  itemCount: 5,
                                                  itemPadding:
                                                      EdgeInsets.symmetric(
                                                          horizontal: 0.4),
                                                  itemBuilder: (context, _) =>
                                                      Icon(
                                                    Icons.star,
                                                    color: Colors.amber,
                                                  ),
                                                  onRatingUpdate: (rating) {
                                                    print(rating);
                                                  },
                                                ),
                                                Text(
                                                  "(Rating: ${items.rating})",
                                                  style: TextStyle(
                                                      fontSize: 10,
                                                      color: Colors.grey
                                                          .withOpacity(0.7)),
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              }))
                      : SizedBox(),*/

                  state.usersList.isNotEmpty
                      ? Flexible(
                          child: ListView.builder(
                              controller: _scrollController,
                              shrinkWrap: true,
                              itemCount: state.usersList.length,
                              itemBuilder: (context, index) {
                                final items = state.usersList[index];
                                return ListTile(
                                  title: Text(
                                      "${items.firstName} ${items.lastName!}"),
                                  subtitle: Text("${items.email}"),
                                  leading: CircleAvatar(
                                    backgroundImage: NetworkImage(items.avatar!)
                                        as ImageProvider,
                                  ),
                                );
                              }))
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
