import 'package:ecommerce_bloc/models/models.dart';
import 'package:flutter/material.dart';

class HeroCarouseCard extends StatelessWidget {
  const HeroCarouseCard({super.key, this.categoryModel, this.productModel});
  final CategoryModel? categoryModel;
  final ProductModel? productModel;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (productModel == null) {
          Navigator.pushNamed(context, '/catalog', arguments: categoryModel);
        }
        // else {
        //   Navigator.pushNamed(context, '/product', arguments: productModel);
        // }
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 20),
        child: ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(5.0)),
            child: Stack(
              children: <Widget>[
                Image.network(
                    categoryModel == null
                        ? productModel!.imageUrl
                        : categoryModel!.imageUrl,
                    fit: BoxFit.cover,
                    width: 1000.0),
                Positioned(
                  bottom: 0.0,
                  left: 0.0,
                  right: 0.0,
                  child: Container(
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Color.fromARGB(200, 0, 0, 0),
                          Color.fromARGB(0, 0, 0, 0)
                        ],
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                      ),
                    ),
                    padding: const EdgeInsets.symmetric(
                        vertical: 10.0, horizontal: 20.0),
                    child: Text(
                      categoryModel == null
                          ? productModel!.name
                          : categoryModel!.name,
                      style: Theme.of(context).textTheme.headline2!.copyWith(
                            color: Colors.white,
                          ),
                    ),
                  ),
                ),
              ],
            )),
      ),
    );
  }
}
