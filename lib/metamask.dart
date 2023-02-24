import 'package:flutter/material.dart';
import 'package:flutter_web3/flutter_web3.dart';

class MetamaskProvider extends ChangeNotifier {
  static const operationgChain = 4;
  String currentAdrerss = "";
  num currentChain = -1;

  bool get isEnabled => ethereum != null;
  bool get isInOperationChain => currentChain == operationgChain;
  bool get isConnected => isEnabled && currentAdrerss.isEmpty;

  Future<void> connect() async {
    if (isEnabled) {
      final accs = await ethereum!.requestAccount();
      if (accs.isNotEmpty) currentAdrerss = accs.first;

      currentChain = await ethereum!.getChainId();

      notifyListeners();
    }
  }

  clear() {
    currentAdrerss = "";
    currentChain = -1;
  }

  int() {
    if (isEnabled) {
      ethereum!.onAccountsChanged((accounts) {
        clear();
      });

      ethereum!.onChainChanged((accounts) {
        clear();
      });
    }
  }
}
