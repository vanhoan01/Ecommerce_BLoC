import 'package:ecommerce_bloc/models/models.dart';

abstract class BaseCategoryRepository {
  Stream<List<CategoryModel>> getAllCategories();
}
