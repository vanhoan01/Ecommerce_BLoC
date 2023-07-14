import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_bloc/models/models.dart';
import 'package:ecommerce_bloc/repositories/category/base_category_repository.dart';

class CategoryRepository extends BaseCategoryRepository {
  final FirebaseFirestore _firebaseFirestore;

  CategoryRepository({FirebaseFirestore? firebaseFirestore})
      : _firebaseFirestore = firebaseFirestore ?? FirebaseFirestore.instance;

  @override
  Stream<List<CategoryModel>> getAllCategories() {
    return _firebaseFirestore.collection('categories').snapshots().map(
      (snapshot) {
        return snapshot.docs
            .map((doc) => CategoryModel.fromSnapshot(doc))
            .toList();
      },
    );
  }
}
