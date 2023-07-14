import 'package:ecommerce_bloc/models/models.dart';
import 'package:flutter/material.dart';
import 'package:pay/pay.dart';

class GooglePay extends StatelessWidget {
  const GooglePay({
    Key? key,
    required this.total,
    required this.products,
  }) : super(key: key);

  final String total;
  final List<ProductModel> products;

  @override
  Widget build(BuildContext context) {
    // ignore: no_leading_underscores_for_local_identifiers
    var _paymentItems = products
        .map(
          (product) => PaymentItem(
              label: product.name,
              amount: product.price.toString(),
              type: PaymentItemType.item,
              status: PaymentItemStatus.final_price),
        )
        .toList();

    _paymentItems.add(
      PaymentItem(
        label: "Total",
        amount: total,
        type: PaymentItemType.total,
        status: PaymentItemStatus.final_price,
      ),
    );

    void onGooglePayResult(paymentResult) {
      debugPrint(paymentResult.toString());
    }

    return SizedBox(
      width: MediaQuery.of(context).size.width - 50,
      child: GooglePayButton(
        // ignore: deprecated_member_use
        paymentConfigurationAsset: 'payment_profile_google_pay.json',
        onPaymentResult: onGooglePayResult,
        paymentItems: _paymentItems,
        // style: GooglePayButtonStyle.white,
        type: GooglePayButtonType.pay,
        margin: const EdgeInsets.only(top: 10),
        loadingIndicator: const CircularProgressIndicator(),
      ),
    );
  }
}
