
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:payment_new_app/Features/data/models/payment_intent_input_model.dart';
import 'package:payment_new_app/Features/data/models/payment_intent_model/payment_intent_model.dart';
import 'package:payment_new_app/core/utils/api_keys.dart';
import 'package:payment_new_app/core/utils/api_service.dart';

class StripeService {
  // paymentIntentObject create payment intent (amount , currency)
  final ApiService apiService = ApiService();

  Future<PaymentIntentModel> createPaymentIntent(
      PaymentIntentInputModel paymentIntentInputModel) async {
    var response = await apiService.post(
      body: paymentIntentInputModel.toJSon(),
      url: 'https://api.stripe.com/v1/payment_intents',
      token: ApiKeys.secretKey,
    );
    var paymentIntentModel = PaymentIntentModel.fromJson(response.data);
    return paymentIntentModel;
  }

// init payment sheet (paymentIntentClientSecret)
  Future initPaymentSheet({required String paymentIntentClientSecret}) async {
    Stripe.instance.initPaymentSheet(
      paymentSheetParameters: SetupPaymentSheetParameters(
        paymentIntentClientSecret: paymentIntentClientSecret,
        merchantDisplayName: 'salah',
      ),
    );
  }

// presentPaymentSheet()
  Future displayPaymentSheet() async {
    Stripe.instance.presentPaymentSheet();
  }

//
  Future makePayment(
      {required PaymentIntentInputModel paymentIntentInputModel}) async {
    var paymentIntentModel = await createPaymentIntent(paymentIntentInputModel);
    await initPaymentSheet(
        paymentIntentClientSecret: paymentIntentModel.clientSecret!);
    await displayPaymentSheet();
  }
}
