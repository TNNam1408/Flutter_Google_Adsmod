import 'package:ads_mob/ads/ad_unit_id.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

mixin InterstitialClass {
  InterstitialAd? _interstitialAd;

  // Hàm loadAd sẽ khởi tạo và load quảng cáo.
  void loadAd() async {
    await InterstitialAd.load(
      adUnitId: adUnitIdInterstitial,
      request: const AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        // Called when an ad is successfully received.
        onAdLoaded: (InterstitialAd ad) {
          debugPrint('namtn: onAdLoaded');
          ad.fullScreenContentCallback = FullScreenContentCallback(
            // Called when the ad showed the full screen content.
            onAdShowedFullScreenContent: (ad) {
              debugPrint('namtn: onAdShowedFullScreenContent');
            },
            // Called when an impression occurs on the ad.
            onAdImpression: (ad) {
              debugPrint('namtn: onAdImpression');
            },
            // Called when the ad failed to show full screen content.
            onAdFailedToShowFullScreenContent: (ad, err) {
              debugPrint('namtn: onAdFailedToShowFullScreenContent');
              ad.dispose();
            },
            // Called when the ad dismissed full screen content.
            onAdDismissedFullScreenContent: (ad) {
              ad.dispose();
            },
            // Called when a click is recorded for an ad.
            onAdClicked: (ad) {
              debugPrint('namtn: onAdClicked');
            },
          );

          // Lưu tham chiếu tới quảng cáo để hiển thị sau này.
          _interstitialAd = ad;
        },
        // Called when an ad request failed.
        onAdFailedToLoad: (LoadAdError error) {
          // ignore: avoid_debugPrint
          debugPrint('namtn: InterstitialAd failed to load: $error');
        },
      ),
    );
  }

  // Hàm này sẽ được gọi khi bạn muốn hiển thị quảng cáo.
  void showInterstitialAd() {
    loadAd();
    _interstitialAd?.show();
  }
}
