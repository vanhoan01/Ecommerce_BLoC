part of 'cart_bloc.dart';

abstract class CartEvent extends Equatable {
  const CartEvent();

  @override
  List<Object> get props => [];
}

class LoadCart extends CartEvent {
  @override
  List<Object> get props => [];
}

class AddProduct extends CartEvent {
  final ProductModel productModel;
  const AddProduct({required this.productModel});

  @override
  List<Object> get props => [productModel];
}

class RemoveProduct extends CartEvent {
  final ProductModel productModel;
  const RemoveProduct({required this.productModel});

  @override
  List<Object> get props => [productModel];
}
