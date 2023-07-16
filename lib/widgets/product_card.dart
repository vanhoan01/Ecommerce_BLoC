import 'package:ecommerce_bloc/blocs/cart/cart_bloc.dart';
import 'package:ecommerce_bloc/blocs/wishlist/wishlist_bloc.dart';
import 'package:ecommerce_bloc/models/models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductCard extends StatelessWidget {
  const ProductCard.catalog({
    Key? key,
    required this.productModel,
    this.quantity,
    this.widthFactor = 2.25,
    this.height = 150,
    this.isCatalog = true,
    this.isWishlist = false,
    this.isCart = false,
    this.isSummary = false,
    this.iconColor = Colors.white,
    this.fontColor = Colors.white,
  }) : super(key: key);

  const ProductCard.cart({
    Key? key,
    required this.productModel,
    this.quantity,
    this.widthFactor = 2.25,
    this.height = 80,
    this.isCatalog = false,
    this.isWishlist = false,
    this.isCart = true,
    this.isSummary = false,
    this.iconColor = Colors.black,
    this.fontColor = Colors.black,
  }) : super(key: key);

  const ProductCard.wishlist({
    Key? key,
    required this.productModel,
    this.quantity,
    this.widthFactor = 1.1,
    this.height = 150,
    this.isCatalog = false,
    this.isWishlist = true,
    this.isCart = false,
    this.isSummary = false,
    this.iconColor = Colors.white,
    this.fontColor = Colors.white,
  }) : super(key: key);

  const ProductCard.summary({
    Key? key,
    required this.productModel,
    this.quantity,
    this.widthFactor = 2.25,
    this.height = 80,
    this.isCatalog = false,
    this.isWishlist = false,
    this.isCart = false,
    this.isSummary = true,
    this.iconColor = Colors.black,
    this.fontColor = Colors.black,
  }) : super(key: key);

  final ProductModel productModel;
  final int? quantity;
  final double height;
  final bool isCatalog;
  final bool isWishlist;
  final bool isCart;
  final bool isSummary;
  final double widthFactor;
  final Color iconColor;
  final Color fontColor;

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final double adjWidth = width / widthFactor;

    return InkWell(
      onTap: () {
        if (isCatalog || isWishlist) {
          Navigator.pushNamed(
            context,
            '/product',
            arguments: productModel,
          );
        }
      },
      child: isCart || isSummary
          ? Padding(
              padding: const EdgeInsets.only(bottom: 10.0),
              child: Row(
                children: [
                  ProductImage(
                    adjWidth: 100,
                    height: height,
                    productModel: productModel,
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: ProductInformation(
                      productModel: productModel,
                      fontColor: fontColor,
                      quantity: quantity,
                      isOrderSummary: isSummary ? true : false,
                    ),
                  ),
                  const SizedBox(width: 10),
                  ProductActions(
                    productModel: productModel,
                    isCatalog: isCatalog,
                    isWishlist: isWishlist,
                    isCart: isCart,
                    iconColor: iconColor,
                    quantity: quantity,
                  )
                ],
              ),
            )
          : Stack(
              alignment: Alignment.bottomCenter,
              children: [
                ProductImage(
                  adjWidth: adjWidth,
                  height: height,
                  productModel: productModel,
                ),
                ProductBackground(
                  adjWidth: adjWidth,
                  widgets: [
                    ProductInformation(
                      productModel: productModel,
                      fontColor: fontColor,
                    ),
                    ProductActions(
                      productModel: productModel,
                      isCatalog: isCatalog,
                      isWishlist: isWishlist,
                      isCart: isCart,
                      iconColor: iconColor,
                    )
                  ],
                ),
              ],
            ),
    );
  }
}

class ProductInformation extends StatelessWidget {
  const ProductInformation({
    Key? key,
    required this.productModel,
    required this.fontColor,
    this.isOrderSummary = false,
    this.quantity,
  }) : super(key: key);

  final ProductModel productModel;
  final Color fontColor;
  final bool isOrderSummary;
  final int? quantity;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: 85,
              child: Text(
                productModel.name,
                maxLines: 1,
                style: Theme.of(context)
                    .textTheme
                    .headline5!
                    .copyWith(color: fontColor),
              ),
            ),
            Text(
              '\$${productModel.price}',
              style: Theme.of(context)
                  .textTheme
                  .headline6!
                  .copyWith(color: fontColor),
            ),
          ],
        ),
        isOrderSummary
            ? Text(
                'Qty. $quantity',
                style: Theme.of(context)
                    .textTheme
                    .headline4!
                    .copyWith(color: fontColor),
              )
            : const SizedBox(),
      ],
    );
  }
}

class ProductImage extends StatelessWidget {
  const ProductImage({
    Key? key,
    required this.adjWidth,
    required this.height,
    required this.productModel,
  }) : super(key: key);

  final double adjWidth;
  final double height;
  final ProductModel productModel;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: adjWidth,
      height: height,
      child: Image.network(
        productModel.imageUrl,
        fit: BoxFit.cover,
      ),
    );
  }
}

class ProductActions extends StatelessWidget {
  const ProductActions({
    Key? key,
    required this.productModel,
    required this.isCatalog,
    required this.isWishlist,
    required this.isCart,
    required this.iconColor,
    this.quantity,
  }) : super(key: key);

  final ProductModel productModel;
  final bool isCatalog;
  final bool isWishlist;
  final bool isCart;
  final Color iconColor;
  final int? quantity;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartBloc, CartState>(
      builder: (context, state) {
        if (state is CartLoading) {
          return const Center(
            child: CircularProgressIndicator(color: Colors.white),
          );
        }
        if (state is CartLoaded) {
          IconButton addProduct = IconButton(
            icon: Icon(
              Icons.add_circle,
              color: iconColor,
            ),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Đã thêm vào giỏ hàng của bạn!'),
                ),
              );
              context
                  .read<CartBloc>()
                  .add(AddProduct(productModel: productModel));
            },
          );

          IconButton removeProduct = IconButton(
            icon: Icon(
              Icons.remove_circle,
              color: iconColor,
            ),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Đã xóa khỏi Giỏ hàng của bạn!'),
                ),
              );
              context
                  .read<CartBloc>()
                  .add(RemoveProduct(productModel: productModel));
            },
          );

          IconButton removeFromWishlist = IconButton(
            icon: Icon(
              Icons.delete,
              color: iconColor,
            ),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Đã xóa khỏi Danh sách Yêu thích!'),
                ),
              );
              context
                  .read<WishlistBloc>()
                  .add(RemoveProductFromWishlist(productModel));
            },
          );

          Text productQuantity = Text(
            '$quantity',
            style: Theme.of(context).textTheme.headline4,
          );

          if (isCatalog) {
            return Row(children: [addProduct]);
          } else if (isWishlist) {
            return Row(children: [addProduct, removeFromWishlist]);
          } else if (isCart) {
            return Row(children: [removeProduct, productQuantity, addProduct]);
          } else {
            return const SizedBox();
          }
        } else {
          return const Text('Đã xảy ra sự cố.');
        }
      },
    );
  }
}

class ProductBackground extends StatelessWidget {
  const ProductBackground({
    Key? key,
    required this.adjWidth,
    required this.widgets,
  }) : super(key: key);

  final double adjWidth;
  final List<Widget> widgets;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: adjWidth - 10,
      height: 80,
      margin: const EdgeInsets.only(bottom: 5),
      alignment: Alignment.bottomCenter,
      decoration: BoxDecoration(color: Colors.black.withAlpha(50)),
      child: Container(
        width: adjWidth - 20,
        height: 70,
        margin: const EdgeInsets.only(bottom: 5),
        alignment: Alignment.bottomCenter,
        decoration: const BoxDecoration(color: Colors.black),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [...widgets],
          ),
        ),
      ),
    );
  }
}
