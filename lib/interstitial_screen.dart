import 'package:flutter/material.dart';

import 'ads/interstitial.dart';

class Screen2 extends StatefulWidget {
  const Screen2({super.key});

  @override
  State<Screen2> createState() => _Screen2State();
}

class _Screen2State extends State<Screen2> with InterstitialClass {
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      setState(() {
        _isLoading = false;
      });
    });
    loadAd();
  }

  void showInterAd() {
    loadAd();
    showInterstitialAd();
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _isLoading
            ? const CircularProgressIndicator()
            : const Text("Screen 2"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showInterAd();
        },
        tooltip: 'Back',
        child: const Icon(Icons.add),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
