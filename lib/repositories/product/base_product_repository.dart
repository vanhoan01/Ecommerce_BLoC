import 'package:ecommerce_bloc/models/models.dart';

abstract class BaseProductRepository {
  Stream<List<ProductModel>> getAllProducts();
}
