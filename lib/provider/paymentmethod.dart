import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

enum PaymentMethodType{
  None,
  CreditCard,
  Promptpay,
  Banking
}

class PaymentMethod with ChangeNotifier,DiagnosticableTreeMixin{
  PaymentMethodType _methodType = PaymentMethodType.None;
  PaymentMethodType get methodType => _methodType;

  void ToggleMethod(PaymentMethodType type){
    _methodType = type;
    notifyListeners();
  }
}