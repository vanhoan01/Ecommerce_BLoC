part of 'checkout_bloc.dart';

abstract class CheckoutEvent extends Equatable {
  const CheckoutEvent();

  @override
  List<Object?> get props => [];
}

class LoadCheckout extends CheckoutEvent {
  @override
  List<Object> get props => [];
}

class UpdateCheckout extends CheckoutEvent {
  final String? fullName;
  final String? email;
  final String? address;
  final String? city;
  final String? country;
  final String? zipCode;
  final CartModel? cartModel;
  final PaymentMethod? paymentMethod;

  const UpdateCheckout({
    this.fullName,
    this.email,
    this.address,
    this.city,
    this.country,
    this.zipCode,
    this.cartModel,
    this.paymentMethod,
  });

  @override
  List<Object?> get props => [
        fullName,
        email,
        address,
        city,
        country,
        zipCode,
        cartModel,
        paymentMethod,
      ];
}

class ConfirmCheckout extends CheckoutEvent {
  final CheckoutModel checkoutModel;

  const ConfirmCheckout({required this.checkoutModel});

  @override
  List<Object> get props => [checkoutModel];
}
