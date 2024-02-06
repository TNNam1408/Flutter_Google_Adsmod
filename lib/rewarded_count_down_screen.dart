import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class RewardedScreen extends StatefulWidget {
  const RewardedScreen({super.key});

  @override
  RewardedScreenState createState() => RewardedScreenState();
}

class RewardedScreenState extends State<RewardedScreen> {
  RewardedAd? _rewardedAd;
  final String _adUnitId = Platform.isAndroid
      ? 'ca-app-pub-3940256099942544/5224354917'
      : 'ca-app-pub-3940256099942544/1712485313';

  bool isReady = false;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _loadAd();
    _countDown();
  }

  void _countDown() {
    setState(() {
      isLoading = true;
    });
    Future.delayed(const Duration(seconds: 3), () {
      setState(() {
        isLoading = false;
      });
    });
  }

  void _startNewGame() async {
    print("namtn: isReady: $isReady");
    if (isReady) {
      _rewardedAd?.show(
          onUserEarnedReward: (AdWithoutView ad, RewardItem rewardItem) {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: isLoading
            ? const CircularProgressIndicator()
            : const Text("Rewarded Ad Example"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _startNewGame();
        },
        tooltip: 'Back',
        child: const Icon(Icons.add),
      ),
    );
  }

  /// Loads a rewarded ad.
  void _loadAd() async {
    final now = DateTime.now().second;
    await RewardedAd.load(
        adUnitId: _adUnitId,
        request: const AdRequest(),
        rewardedAdLoadCallback: RewardedAdLoadCallback(onAdLoaded: (ad) {
          print("namtn: date: ${DateTime.now().second - now}");
          isReady = true;
          ad.fullScreenContentCallback = FullScreenContentCallback(
              // Called when the ad showed the full screen content.
              onAdShowedFullScreenContent: (ad) {},
              // Called when an impression occurs on the ad.
              onAdImpression: (ad) {},
              // Called when the ad failed to show full screen content.
              onAdFailedToShowFullScreenContent: (ad, err) {
                ad.dispose();
              },
              // Called when the ad dismissed full screen content.
              onAdDismissedFullScreenContent: (ad) {
                ad.dispose();
              },
              // Called when a click is recorded for an ad.
              onAdClicked: (ad) {});

          // Keep a reference to the ad so you can show it later.
          _rewardedAd = ad;
        }, onAdFailedToLoad: (LoadAdError error) {
          // ignore: avoid_print
          isReady = false;
          debugPrint('RewardedAd failed to load: $error');
        }));
  }

  @override
  void dispose() {
    _rewardedAd?.dispose();
    super.dispose();
  }
}
