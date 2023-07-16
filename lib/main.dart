import 'package:ecommerce_bloc/SimpleBlocObserver.dart';
import 'package:ecommerce_bloc/blocs/blocs.dart';
import 'package:ecommerce_bloc/config/app_router.dart';
import 'package:ecommerce_bloc/config/theme.dart';
import 'package:ecommerce_bloc/models/models.dart';
import 'package:ecommerce_bloc/repositories/repositories.dart';
import 'package:ecommerce_bloc/screens/screens.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
//https://console.firebase.google.com/u/0/project/ecommerce-bloc-app-cd95a/firestore
//https://github.com/abuanwar072/E-commerce-Complete-Flutter-UI/tree/master/lib

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await Hive.initFlutter();
  Hive.registerAdapter(ProductModelAdapter());
  Bloc.observer = SimpleBlocObserver();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => WishlistBloc(
            localStorageRepository: LocalStorageRepository(),
          )..add(LoadWishlist()),
        ),
        BlocProvider(create: (_) => CartBloc()..add(LoadCart())),
        BlocProvider(create: (_) => PaymentBloc()..add(LoadPaymentMethod())),
        BlocProvider(
          create: (context) => CheckoutBloc(
            cartBloc: context.read<CartBloc>(),
            paymentBloc: context.read<PaymentBloc>(),
            checkoutRepository: CheckoutRepository(),
          ),
        ),
        BlocProvider(
          create: (_) => CategoryBloc(categoryRepository: CategoryRepository())
            ..add(LoadCategories()),
        ),
        BlocProvider(
          create: (_) => ProductBloc(productRepository: ProductRepository())
            ..add(LoadProducts()),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: themeData(),
        onGenerateRoute: AppRouter.onGenerateRoute,
        initialRoute: SplashScreen.routeName,
      ),
    );
  }
}
