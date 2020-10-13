import 'package:flutter/material.dart';
import 'package:product_seek_mobile/models/category_model.dart';
import 'package:product_seek_mobile/repository/category_repository.dart';

class CategoryViewModel extends ChangeNotifier {
  final CategoryRepository categoryRepo;

  CategoryViewModel({@required this.categoryRepo});

  init() async {
    await _refreshAllStates();
  }

  _refreshAllStates() {
    notifyListeners();
  }

  getCategoryInfoBackend(int id) => categoryRepo.getCategoryInfoBackend(id);

  Stream<CategoryModel> getCategoryInfo(int id) =>
      categoryRepo.getCategoryInfo(id);
}
