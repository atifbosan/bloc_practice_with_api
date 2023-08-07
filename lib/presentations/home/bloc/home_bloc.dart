import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:bloc_cfl/data/models/comments_model.dart';
import 'package:bloc_cfl/data/models/products_model.dart';
import 'package:bloc_cfl/data/models/user_model.dart';
import 'package:bloc_cfl/presentations/home/bloc/home_event.dart';
import 'package:bloc_cfl/presentations/home/bloc/home_state.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../../data/respositories/home_respository.dart';

class HomeBloc extends Bloc<HomeEvent, HomeSate> {
  List<CommentsModel> comments = [];
  List<ProductsModel> products = [];
  List<UserModel> users = [];
  final ImagePicker _imagePicker = ImagePicker();

  File? _selectedImg;

  int page = 1;
  HomeRepository repository;
  HomeBloc({required this.repository}) : super(HomeInitSate()) {
    on<HomeCommentsLoadDataEvent>(
        (event, emit) => loadComments(event, emit, state));
    on<HomeProductLoadPageEvent>(
        (event, emit) => loadProducts(event, emit, state));
    on<HomeUsersEvent>((event, emit) => loadUsers(event, emit, state));
    on<HomePermissionEvent>(
        (event, emit) => getCameraPermission(event, emit, state));
    on<HomePickImageEvent>((event, emit) => pickImage(event, emit, state));
  }

  loadComments(event, emit, state) async {
    try {
      emit(HomeCommentsState(
          commentsList: comments, isLoading: true, message: '', error: ''));
      Map<String, dynamic>? resp = await repository.getComment(page: page);
      print("Show Resposne:${resp}");
      if (resp != null) {
        comments.addAll(List<CommentsModel>.from(resp['comments']
            .map<CommentsModel>((json) => CommentsModel.fromJson(json))));
        emit(HomeCommentsState(
            commentsList: comments, isLoading: false, message: '', error: ''));
        page++;
      } else {
        emit(HomeCommentsState(
            commentsList: comments,
            isLoading: false,
            message: 'No data found!',
            error: ''));
      }
    } catch (e) {
      emit(HomeCommentsState(
          commentsList: [], isLoading: false, message: '', error: '$e'));
    }
  }

  loadProducts(event, emit, state) async {
    try {
      emit(HomeProductState(
          productList: products, isLoading: true, message: '', error: ''));
      Map<String, dynamic>? resp = await repository.getProducts(page: page);
      print("Show Resposne:${resp}");
      if (resp != null) {
        products.addAll(List<ProductsModel>.from(resp['products']
            .map<ProductsModel>((json) => ProductsModel.fromJson(json))));
        emit(HomeProductState(
            productList: products, isLoading: false, message: '', error: ''));
        page++;
      } else {
        emit(HomeProductState(
            productList: products,
            isLoading: false,
            message: 'No data found!',
            error: ''));
      }
    } catch (e) {
      emit(HomeProductState(
          productList: [], isLoading: false, message: '', error: '$e'));
    }
  }

  loadUsers(event, emit, state) async {
    try {
      emit(HomeUsersState(
        usersList: users,
        isLoading: true,
        message: '',
        error: '',
        imageFile: _selectedImg,
      ));
      Map<String, dynamic>? resp = await repository.getUsers(page: page);
      print("Show Resposne:${resp}");
      if (resp != null) {
        users.addAll(List<UserModel>.from(
            resp['data'].map<UserModel>((json) => UserModel.fromJson(json))));
        emit(HomeUsersState(
          usersList: users,
          isLoading: false,
          message: '',
          error: '',
          imageFile: _selectedImg,
        ));
        page++;
      } else {
        emit(HomeUsersState(
          usersList: users,
          isLoading: false,
          message: 'No data found!',
          error: '',
          imageFile: _selectedImg,
        ));
      }
    } catch (e) {
      emit(HomeUsersState(
        usersList: [],
        isLoading: false,
        message: '',
        error: '$e',
        imageFile: _selectedImg,
      ));
    }
  }

  getCameraPermission(event, emit, state) async {
    final status = await Permission.camera.request();
    print("Status:${status}");
    if (status == PermissionStatus.granted) {
      // pickImage(event, emit, state);
    } else if (status == PermissionStatus.denied) {
      await Permission.camera.request();
    } else {
      openAppSettings();
    }
  }

  pickImage(event, emit, state) async {
    final pick = await _imagePicker.pickImage(source: ImageSource.camera);
    if (pick != null) {
      _selectedImg = File(pick.path);
      print('picked image:$_selectedImg');
      emit(HomeUsersState(imageFile: _selectedImg, usersList: users));
    }
  }
}
