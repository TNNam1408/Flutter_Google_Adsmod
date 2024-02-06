import 'package:flutter/material.dart';

import 'ads/interstitial.dart';

class InterstitialScreen extends StatefulWidget {
  const InterstitialScreen({super.key});

  @override
  State<InterstitialScreen> createState() => _InterstitialScreenState();
}

class _InterstitialScreenState extends State<InterstitialScreen>
    with InterstitialClass {
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
