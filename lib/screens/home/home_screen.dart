import 'package:carousel_slider/carousel_slider.dart';
import 'package:ecommerce_bloc/blocs/category/category_bloc.dart';
import 'package:ecommerce_bloc/blocs/product/product_bloc.dart';
import 'package:ecommerce_bloc/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  static const String routeName = '/';
  static Route route() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (_) => const HomeScreen(),
    );
  }

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'Zero To Unicorn',
      ),
      bottomNavigationBar: const CustomNavBar(screen: HomeScreen.routeName),
      body: Column(
        children: [
          BlocBuilder<CategoryBloc, CategoryState>(
            builder: (context, state) {
              if (state is CategoryLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (state is CategoryLoaded) {
                return CarouselSlider(
                  options: CarouselOptions(
                    aspectRatio: 1.5,
                    viewportFraction: 0.9,
                    enlargeCenterPage: true,
                    enlargeStrategy: CenterPageEnlargeStrategy.height,
                  ),
                  items: state.categories
                      .map((categorie) =>
                          HeroCarouseCard(categoryModel: categorie))
                      .toList(),
                );
              } else {
                return const Text('Đã xảy ra sự cố');
              }
            },
          ),
          const SectionTitle(title: 'KHUYẾN KHÍCH'),
          BlocBuilder<ProductBloc, ProductState>(
            builder: (context, state) {
              if (state is ProductLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (state is ProductLoaded) {
                return ProductCarousel(
                  productLisst: state.products
                      .where((product) => product.isRecommended)
                      .toList(),
                );
              } else {
                return const Text('Đã xảy ra sự cố');
              }
            },
          ),
          const SectionTitle(title: 'PHỔ BIẾN NHẤT'),
          BlocBuilder<ProductBloc, ProductState>(
            builder: (context, state) {
              if (state is ProductLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (state is ProductLoaded) {
                return ProductCarousel(
                  productLisst: state.products
                      .where((product) => product.isPopular)
                      .toList(),
                );
              } else {
                return const Text('Đã xảy ra sự cố');
              }
            },
          ),
        ],
      ),
    );
  }
}
