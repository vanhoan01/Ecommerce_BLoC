import 'package:ecommerce_bloc/blocs/cart/cart_bloc.dart';
import 'package:ecommerce_bloc/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});
  static const String routeName = '/cart';
  static Route route() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (_) => const CartScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const CustomAppBar(
          title: 'Cart',
        ),
        bottomNavigationBar: BottomAppBar(
          color: Colors.black,
          child: SizedBox(
            height: 70,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  style:
                      ElevatedButton.styleFrom(backgroundColor: Colors.white),
                  onPressed: () {
                    Navigator.pushNamed(context, '/checkout');
                  },
                  child: Text(
                    'ĐẾN THANH TOÁN',
                    style: Theme.of(context).textTheme.headline3,
                  ),
                ),
              ],
            ),
          ),
        ),
        body: BlocBuilder<CartBloc, CartState>(
          builder: (context, state) {
            if (state is CartLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state is CartLoaded) {
              Map cart =
                  state.cartModel.productQuantity(state.cartModel.products);
              return Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Column(
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          state.cartModel.freeDeliveryString,
                          style: Theme.of(context).textTheme.headline5,
                        ),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.pushNamed(context, '/');
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.black,
                              shape: const RoundedRectangleBorder(),
                              elevation: 0),
                          child: Text(
                            'Thêm các sản phẩm khác',
                            style: Theme.of(context)
                                .textTheme
                                .headline5!
                                .copyWith(color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Expanded(
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: cart.keys.length,
                        itemBuilder: (context, index) {
                          return ProductCard.cart(
                            productModel: cart.keys.elementAt(index),
                            quantity: cart.values.elementAt(index),
                          );
                        },
                      ),
                    ),
                    const OrderSummary(),
                  ],
                ),
              );
            } else {
              return const Text('Đã xảy ra sự cố');
            }
          },
        ));
  }
}
