import 'dart:developer';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import '../../helpers/enums.dart';
import '../domain/api_exceptions.dart';
import '../domain/home_repository.dart';
import '../model/menu_model.dart';

class HomeViewModel extends ChangeNotifier {

  Future<bool> checkInternet() async {
    bool internetAvailable = true;
    var connectivityResultList = await (Connectivity().checkConnectivity());
    var connectivityResult = connectivityResultList[0];
    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      internetAvailable = true;
      log('have internet connection');
      return internetAvailable;
    } else {
      log('no internet connection');
      internetAvailable = false;
      return internetAvailable;
    }
  }

  final HomeRepository _repo = HomeRepository();
  MenuModel? menuModel;
  String? errorMessage;
  HomeStatusEnum status = HomeStatusEnum.initial;

  Future<void> loadMenu() async {
    status = HomeStatusEnum.loading;
    errorMessage = null;
    notifyListeners();

    final hasInternet = await checkInternet();
    if (!hasInternet) {
      status = HomeStatusEnum.noInternet;
      errorMessage = 'No internet connection. Please try again.';
      notifyListeners();
      return;
    }

    try {
      menuModel = await _repo.fetchMenu();
      status = HomeStatusEnum.success;
    } on ApiException catch (e) {
      status = HomeStatusEnum.apiError;
      errorMessage = e.message;
    } catch (e) {
      status = HomeStatusEnum.apiError;
      errorMessage = 'Something went wrong. Please try again.';
    }
    notifyListeners();
  }


  int selectedCategoryIndex = 0;
  void selectCategory(int index) {
    selectedCategoryIndex = index;
    notifyListeners();
  }

  final Map<int, int> _items = {};
  Map<int, int> get items => _items;
  int get totalCount => _items.values.fold(0, (sum, qty) => sum + qty);

  int getQty(int dishId) => _items[dishId] ?? 0;

  void increment(int dishId) {
    _items[dishId] = getQty(dishId) + 1;
    notifyListeners();
  }

  void decrement(int dishId) {
    if (!_items.containsKey(dishId)) return;

    if (_items[dishId]! > 1) {
      _items[dishId] = _items[dishId]! - 1;
    } else {
      _items.remove(dishId);
    }
    notifyListeners();
  }Dish? getDishById(int dishId) {
    for (var category in menuModel?.categories ?? []) {
      for (var dish in category.dishes) {
        if (dish.id == dishId) {
          return dish;
        }
      }
    }
    return null;
  }

 void refresh(){
   notifyListeners();
 }

}