part of 'checkout_bloc.dart';

abstract class CheckoutState extends Equatable {
  const CheckoutState();

  @override
  List<Object?> get props => [];
}

class CheckoutLoading extends CheckoutState {
  @override
  List<Object?> get props => [];
}

class CheckoutLoaded extends CheckoutState {
  final String? fullName;
  final String? email;
  final String? address;
  final String? city;
  final String? country;
  final String? zipCode;
  final List<ProductModel>? products;
  final String? subtotal;
  final String? deliveryFee;
  final String? total;
  final CheckoutModel checkoutModel;
  final PaymentMethod paymentMethod;

  CheckoutLoaded({
    this.fullName,
    this.email,
    this.address,
    this.city,
    this.country,
    this.zipCode,
    this.products,
    this.subtotal,
    this.deliveryFee,
    this.total,
    this.paymentMethod = PaymentMethod.google_pay,
  }) : checkoutModel = CheckoutModel(
          address: address,
          city: city,
          country: country,
          deliveryFee: deliveryFee,
          email: email,
          fullName: fullName,
          products: products,
          subtotal: subtotal,
          total: total,
          zipCode: zipCode,
        );

  @override
  List<Object?> get props => [
        fullName,
        email,
        address,
        city,
        country,
        zipCode,
        products,
        subtotal,
        deliveryFee,
        total,
        checkoutModel,
        paymentMethod,
      ];
}

class CheckoutError extends CheckoutState {
  @override
  List<Object> get props => [];
}
