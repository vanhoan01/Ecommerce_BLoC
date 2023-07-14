import 'package:ecommerce_bloc/repositories/repositories.dart';
import 'package:hive/hive.dart';
import '/models/models.dart';

class LocalStorageRepository extends BaseLocalStorageRepository {
  String boxName = 'wishlist_products';
  Type boxType = ProductModel;

  @override
  Future<Box> openBox() async {
    Box box = await Hive.openBox<ProductModel>(boxName);
    return box;
  }

  @override
  List<ProductModel> getWishlist(Box box) {
    return box.values.toList() as List<ProductModel>;
  }

  @override
  Future<void> addProductToWishlist(Box box, ProductModel product) async {
    await box.put(product.id, product);
  }

  @override
  Future<void> removeProductFromWishlist(Box box, ProductModel product) async {
    await box.delete(product.id);
  }

  @override
  Future<void> clearWishlist(Box box) async {
    await box.clear();
  }
}
