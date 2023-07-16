import 'package:ecommerce_bloc/blocs/wishlist/wishlist_bloc.dart';
import 'package:ecommerce_bloc/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WishlistScreen extends StatelessWidget {
  const WishlistScreen({super.key});
  static const String routeName = '/wishlist';
  static Route route() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (_) => const WishlistScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'Wishlist',
      ),
      bottomNavigationBar: const CustomNavBar(screen: routeName),
      body: BlocBuilder<WishlistBloc, WishlistState>(
        builder: (context, state) {
          if (state is WishlistLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is WishlistLoaded) {
            return GridView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 1,
                childAspectRatio: 2.2,
              ),
              itemCount: state.wishlist.products.length,
              itemBuilder: (context, index) {
                return Center(
                  child: ProductCard.wishlist(
                    productModel: state.wishlist.products[index],
                  ),
                );
              },
            );
          } else {
            return const Text('Đã xảy ra sự cố!');
          }
        },
      ),
    );
  }
}
