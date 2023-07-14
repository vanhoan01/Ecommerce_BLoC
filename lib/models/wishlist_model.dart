import 'package:ecommerce_bloc/models/models.dart';
import 'package:equatable/equatable.dart';

class WishListModel extends Equatable {
  final List<ProductModel> products;

  const WishListModel({this.products = const <ProductModel>[]});

  @override
  List<Object?> get props => [products];
}
