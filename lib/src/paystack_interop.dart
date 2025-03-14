import 'dart:js_interop';

import 'package:flutter/material.dart';
import 'package:flutter_paystack_plus/src/abstract_class.dart';

@JS()
external JSVoid paystackPopUp(
  JSString publicKey,
  JSString email,
  JSString amount,
  JSString ref,
  JSString plan,
  JSString currency,
  JSFunction onClosed,
  JSFunction callback,
);

class PayForWeb implements MakePlatformSpecificPayment {
  @override
  Future<void> makePayment({
    required String customerEmail,
    required String amount,
    required String reference,
    String? callBackUrl,
    String? publicKey,
    String? secretKey,
    String? currency,
    metadata,
    String? plan,
    BuildContext? context,
    required void Function() onClosed,
    required void Function() onSuccess,
  }) async {
    // Convert Dart functions to JavaScript functions
    final jsOnClosed = onClosed.toJS;
    final jsOnSuccess = onSuccess.toJS;

    // Call the JavaScript function
    paystackPopUp(
      publicKey!.toJS,
      customerEmail.toJS,
      amount.toJS,
      reference.toJS,
      (plan ?? '').toJS,
      'ZAR'.toJS,
      jsOnClosed,
      jsOnSuccess,
    );
  }
}

MakePlatformSpecificPayment makePlatformSpecificPayment() => PayForWeb();
