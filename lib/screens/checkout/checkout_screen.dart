import 'package:ecommerce_bloc/blocs/checkout/checkout_bloc.dart';
import 'package:ecommerce_bloc/models/notification_services.dart';
import 'package:ecommerce_bloc/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CheckoutScreen extends StatelessWidget {
  const CheckoutScreen({super.key});

  static const String routeName = '/checkout';
  static Route route() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (context) => const CheckoutScreen(),
    );
  }

  static NotificationServices notificationServices = NotificationServices();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CheckoutBloc, CheckoutState>(
      builder: (context, state) {
        if (state is CheckoutLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (state is CheckoutLoaded) {
          return Scaffold(
            appBar: const CustomAppBar(title: 'Checkout'),
            bottomNavigationBar: ElevatedButton(
              onPressed: () async {
                context
                    .read<CheckoutBloc>()
                    .add(ConfirmCheckout(checkoutModel: state.checkoutModel));
                await notificationServices.sendNotification(
                  'Đặt hàng',
                  'Khách hàng đã đạt ${state.checkoutModel.products![0].name}',
                );
                // ignore: use_build_context_synchronously
                Navigator.pushNamed(context, '/');
              },
              style: ElevatedButton.styleFrom(backgroundColor: Colors.black),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 15),
                child: Text(
                  'ĐẶT HÀNG',
                  style: Theme.of(context).textTheme.headline3!.copyWith(
                        color: Colors.white,
                      ),
                ),
              ),
            ),
            body: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'THÔNG TIN KHÁCH HÀNG',
                    style: Theme.of(context).textTheme.headline3,
                  ),
                  CustomTextFormField(
                    title: 'Email',
                    onChanged: (value) {
                      context
                          .read<CheckoutBloc>()
                          .add(UpdateCheckout(email: value));
                    },
                  ),
                  CustomTextFormField(
                    title: 'Họ và tên',
                    onChanged: (value) {
                      context
                          .read<CheckoutBloc>()
                          .add(UpdateCheckout(fullName: value));
                    },
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'THÔNG TIN GIAO HÀNG',
                    style: Theme.of(context).textTheme.headline3,
                  ),
                  CustomTextFormField(
                    title: 'Địa chỉ',
                    onChanged: (value) {
                      context
                          .read<CheckoutBloc>()
                          .add(UpdateCheckout(address: value));
                    },
                  ),
                  CustomTextFormField(
                    title: 'Thành phố',
                    onChanged: (value) {
                      context
                          .read<CheckoutBloc>()
                          .add(UpdateCheckout(city: value));
                    },
                  ),
                  CustomTextFormField(
                    title: 'Quốc gia',
                    onChanged: (value) {
                      context
                          .read<CheckoutBloc>()
                          .add(UpdateCheckout(country: value));
                    },
                  ),
                  CustomTextFormField(
                    title: 'Mã ZIP',
                    onChanged: (value) {
                      context
                          .read<CheckoutBloc>()
                          .add(UpdateCheckout(zipCode: value));
                    },
                  ),
                  const SizedBox(height: 20),
                  Container(
                    height: 60,
                    alignment: Alignment.bottomCenter,
                    decoration: const BoxDecoration(color: Colors.black),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Center(
                          child: TextButton(
                            onPressed: () {
                              Navigator.pushNamed(
                                context,
                                '/payment-selection',
                              );
                            },
                            child: Text(
                              'CHỌN MỘT PHƯƠNG THỨC THANH TOÁN',
                              style: Theme.of(context)
                                  .textTheme
                                  .headline5!
                                  .copyWith(color: Colors.white),
                            ),
                          ),
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.arrow_forward,
                            color: Colors.white,
                          ),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'TỔNG QUAN ĐƠN HÀNG',
                    style: Theme.of(context).textTheme.headline3,
                  ),
                  const OrderSummary()
                ],
              ),
            ),
          );
        } else {
          return const Text('Đã xảy ra sự cố');
        }
      },
    );
  }
}
