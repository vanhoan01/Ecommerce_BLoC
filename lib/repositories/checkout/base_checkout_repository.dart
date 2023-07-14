import 'package:ecommerce_bloc/models/models.dart';

abstract class BaseCheckoutRepository {
  Future<void> addCheckouts(CheckoutModel checkoutModel);
}
