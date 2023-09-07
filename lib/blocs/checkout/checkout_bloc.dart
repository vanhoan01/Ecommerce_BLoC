// ignore: depend_on_referenced_packages
import 'dart:async';
// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:ecommerce_bloc/blocs/blocs.dart';
import 'package:ecommerce_bloc/repositories/checkout/checkout_repository.dart';
import 'package:equatable/equatable.dart';
import '../../models/models.dart';
part 'checkout_event.dart';
part 'checkout_state.dart';

class CheckoutBloc extends Bloc<CheckoutEvent, CheckoutState> {
  final CartBloc _cartBloc;
  final CheckoutRepository _checkoutRepository;
  final PaymentBloc _paymentBloc;
  StreamSubscription? _cartSubscription;
  StreamSubscription? _paymentSubscription;
  StreamSubscription? _checkoutSubscription;

  CheckoutBloc({
    required CartBloc cartBloc,
    required PaymentBloc paymentBloc,
    required CheckoutRepository checkoutRepository,
  })  : _cartBloc = cartBloc,
        _paymentBloc = paymentBloc,
        _checkoutRepository = checkoutRepository,
        super(
          cartBloc.state is CartLoaded
              ? CheckoutLoaded(
                  products: (cartBloc.state as CartLoaded).cartModel.products,
                  deliveryFee: (cartBloc.state as CartLoaded)
                      .cartModel
                      .deliveryFeeString,
                  subtotal:
                      (cartBloc.state as CartLoaded).cartModel.subtotalString,
                  total: (cartBloc.state as CartLoaded).cartModel.totalString,
                )
              : CheckoutLoading(),
        ) {
    on<UpdateCheckout>(_onUpdateCheckout);
    on<ConfirmCheckout>(_onConfirmCheckout);
    _cartSubscription = _cartBloc.stream.listen(
      (state) {
        if (state is CartLoaded) {
          add(
            UpdateCheckout(cartModel: state.cartModel),
          );
        }
      },
    );

    _paymentSubscription = _paymentBloc.stream.listen(
      (state) {
        if (state is PaymentLoaded) {
          add(
            UpdateCheckout(paymentMethod: state.paymentMethod),
          );
        }
      },
    );
  }

  void _onUpdateCheckout(
    UpdateCheckout event,
    Emitter<CheckoutState> emit,
  ) {
    if (state is CheckoutLoaded) {
      final state = this.state as CheckoutLoaded;
      emit(
        CheckoutLoaded(
          email: event.email ?? state.email,
          fullName: event.fullName ?? state.fullName,
          products: event.cartModel?.products ?? state.products,
          deliveryFee: event.cartModel?.deliveryFeeString ?? state.deliveryFee,
          subtotal: event.cartModel?.subtotalString ?? state.subtotal,
          total: event.cartModel?.totalString ?? state.total,
          address: event.address ?? state.address,
          city: event.city ?? state.city,
          country: event.country ?? state.country,
          zipCode: event.zipCode ?? state.zipCode,
          paymentMethod: event.paymentMethod ?? state.paymentMethod,
        ),
      );
    }
  }

  void _onConfirmCheckout(
    ConfirmCheckout event,
    Emitter<CheckoutState> emit,
  ) async {
    _checkoutSubscription?.cancel();
    if (state is CheckoutLoaded) {
      try {
        await _checkoutRepository.addCheckouts(event.checkoutModel);
        // ignore: avoid_print
        print('Done');
      } catch (_) {}
    }
  }

  @override
  Future<void> close() {
    _cartSubscription?.cancel();
    _paymentSubscription?.cancel();
    return super.close();
  }
}
