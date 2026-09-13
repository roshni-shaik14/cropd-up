import 'package:flutter/material.dart';

enum AppLanguage {
  english,
  kannada,
  hindi,
  telugu,
  tamil,
}

class AppLanguageController extends ChangeNotifier {
  AppLanguage _language = AppLanguage.english;

  AppLanguage get language => _language;

  Locale get locale {
    switch (_language) {
      case AppLanguage.english:
        return const Locale('en');
      case AppLanguage.kannada:
        return const Locale('kn');
      case AppLanguage.hindi:
        return const Locale('hi');
      case AppLanguage.telugu:
        return const Locale('te');
      case AppLanguage.tamil:
        return const Locale('ta');
    }
  }

  String get languageName {
    switch (_language) {
      case AppLanguage.english:
        return 'English';
      case AppLanguage.kannada:
        return 'ಕನ್ನಡ';
      case AppLanguage.hindi:
        return 'हिन्दी';
      case AppLanguage.telugu:
        return 'తెలుగు';
      case AppLanguage.tamil:
        return 'தமிழ்';
    }
  }

  void setLanguage(AppLanguage language) {
    if (_language == language) return;

    _language = language;
    notifyListeners();
  }
}

final appLanguageController = AppLanguageController();

class AppText {
  static String welcome(AppLanguage language) {
    switch (language) {
      case AppLanguage.english:
        return 'Welcome';
      case AppLanguage.kannada:
        return 'ಸ್ವಾಗತ';
      case AppLanguage.hindi:
        return 'स्वागत है';
      case AppLanguage.telugu:
        return 'స్వాగతం';
      case AppLanguage.tamil:
        return 'வரவேற்கிறோம்';
    }
  }

  static String betterPrices(AppLanguage language) {
    switch (language) {
      case AppLanguage.english:
        return 'Better prices. Better choices.';
      case AppLanguage.kannada:
        return 'ಉತ್ತಮ ಬೆಲೆಗಳು. ಉತ್ತಮ ಆಯ್ಕೆಗಳು.';
      case AppLanguage.hindi:
        return 'बेहतर कीमतें। बेहतर विकल्प।';
      case AppLanguage.telugu:
        return 'మెరుగైన ధరలు. మెరుగైన ఎంపికలు.';
      case AppLanguage.tamil:
        return 'சிறந்த விலைகள். சிறந்த தேர்வுகள்.';
    }
  }

  static String morePower(AppLanguage language) {
    switch (language) {
      case AppLanguage.english:
        return 'More power to farmers.';
      case AppLanguage.kannada:
        return 'ರೈತರಿಗೆ ಹೆಚ್ಚಿನ ಶಕ್ತಿ.';
      case AppLanguage.hindi:
        return 'किसानों को अधिक शक्ति।';
      case AppLanguage.telugu:
        return 'రైతులకు మరింత శక్తి.';
      case AppLanguage.tamil:
        return 'விவசாயிகளுக்கு அதிக அதிகாரம்.';
    }
  }

  static String farmer(AppLanguage language) {
    switch (language) {
      case AppLanguage.english:
        return "I'm a Farmer";
      case AppLanguage.kannada:
        return 'ನಾನು ರೈತ';
      case AppLanguage.hindi:
        return 'मैं किसान हूँ';
      case AppLanguage.telugu:
        return 'నేను రైతును';
      case AppLanguage.tamil:
        return 'நான் விவசாயி';
    }
  }

  static String farmerSubtitle(AppLanguage language) {
    switch (language) {
      case AppLanguage.english:
        return 'Sell crops at better prices';
      case AppLanguage.kannada:
        return 'ಉತ್ತಮ ಬೆಲೆಗೆ ಬೆಳೆಗಳನ್ನು ಮಾರಾಟ ಮಾಡಿ';
      case AppLanguage.hindi:
        return 'बेहतर कीमतों पर फसल बेचें';
      case AppLanguage.telugu:
        return 'మెరుగైన ధరలకు పంటలను అమ్మండి';
      case AppLanguage.tamil:
        return 'சிறந்த விலையில் பயிர்களை விற்கவும்';
    }
  }

  static String buyer(AppLanguage language) {
    switch (language) {
      case AppLanguage.english:
        return "I'm a Buyer";
      case AppLanguage.kannada:
        return 'ನಾನು ಖರೀದಿದಾರ';
      case AppLanguage.hindi:
        return 'मैं खरीदार हूँ';
      case AppLanguage.telugu:
        return 'నేను కొనుగోలుదారుని';
      case AppLanguage.tamil:
        return 'நான் வாங்குபவர்';
    }
  }

  static String buyerSubtitle(AppLanguage language) {
    switch (language) {
      case AppLanguage.english:
        return 'Find crops directly from farmers';
      case AppLanguage.kannada:
        return 'ರೈತರಿಂದ ನೇರವಾಗಿ ಬೆಳೆಗಳನ್ನು ಹುಡುಕಿ';
      case AppLanguage.hindi:
        return 'किसानों से सीधे फसल खोजें';
      case AppLanguage.telugu:
        return 'రైతుల నుండి నేరుగా పంటలను కనుగొనండి';
      case AppLanguage.tamil:
        return 'விவசாயிகளிடமிருந்து நேரடியாக பயிர்களை தேடுங்கள்';
    }
  }

  static String connecting(AppLanguage language) {
    switch (language) {
      case AppLanguage.english:
        return 'Connecting farmers and buyers';
      case AppLanguage.kannada:
        return 'ರೈತರು ಮತ್ತು ಖರೀದಿದಾರರನ್ನು ಸಂಪರ್ಕಿಸಲಾಗುತ್ತಿದೆ';
      case AppLanguage.hindi:
        return 'किसानों और खरीदारों को जोड़ना';
      case AppLanguage.telugu:
        return 'రైతులు మరియు కొనుగోలుదారులను కలుపుతోంది';
      case AppLanguage.tamil:
        return 'விவசாயிகள் மற்றும் வாங்குபவர்களை இணைக்கிறது';
    }
  }

  static String chooseLanguage(AppLanguage language) {
    switch (language) {
      case AppLanguage.english:
        return 'Choose Language';
      case AppLanguage.kannada:
        return 'ಭಾಷೆಯನ್ನು ಆಯ್ಕೆಮಾಡಿ';
      case AppLanguage.hindi:
        return 'भाषा चुनें';
      case AppLanguage.telugu:
        return 'భాషను ఎంచుకోండి';
      case AppLanguage.tamil:
        return 'மொழியைத் தேர்ந்தெடுக்கவும்';
    }
  }

  // ---------------- FARMER ----------------

  static String farmerDashboard(AppLanguage language) {
    switch (language) {
      case AppLanguage.english:
        return 'Farmer Dashboard';
      case AppLanguage.kannada:
        return 'ರೈತ ಡ್ಯಾಶ್‌ಬೋರ್ಡ್';
      case AppLanguage.hindi:
        return 'किसान डैशबोर्ड';
      case AppLanguage.telugu:
        return 'రైతు డ్యాష్‌బోర్డ్';
      case AppLanguage.tamil:
        return 'விவசாயி டாஷ்போர்டு';
    }
  }

  static String addCrop(AppLanguage language) {
    switch (language) {
      case AppLanguage.english:
        return 'Add Crop';
      case AppLanguage.kannada:
        return 'ಬೆಳೆ ಸೇರಿಸಿ';
      case AppLanguage.hindi:
        return 'फसल जोड़ें';
      case AppLanguage.telugu:
        return 'పంటను జోడించండి';
      case AppLanguage.tamil:
        return 'பயிரைச் சேர்க்கவும்';
    }
  }

  static String myCrops(AppLanguage language) {
    switch (language) {
      case AppLanguage.english:
        return 'My Crops';
      case AppLanguage.kannada:
        return 'ನನ್ನ ಬೆಳೆಗಳು';
      case AppLanguage.hindi:
        return 'मेरी फसलें';
      case AppLanguage.telugu:
        return 'నా పంటలు';
      case AppLanguage.tamil:
        return 'எனது பயிர்கள்';
    }
  }

  static String marketPrices(AppLanguage language) {
    switch (language) {
      case AppLanguage.english:
        return 'Market Prices';
      case AppLanguage.kannada:
        return 'ಮಾರುಕಟ್ಟೆ ಬೆಲೆಗಳು';
      case AppLanguage.hindi:
        return 'बाज़ार की कीमतें';
      case AppLanguage.telugu:
        return 'మార్కెట్ ధరలు';
      case AppLanguage.tamil:
        return 'சந்தை விலைகள்';
    }
  }

  static String findShops(AppLanguage language) {
    switch (language) {
      case AppLanguage.english:
        return 'Find Shops';
      case AppLanguage.kannada:
        return 'ಅಂಗಡಿಗಳನ್ನು ಹುಡುಕಿ';
      case AppLanguage.hindi:
        return 'दुकानें खोजें';
      case AppLanguage.telugu:
        return 'దుకాణాలను కనుగొనండి';
      case AppLanguage.tamil:
        return 'கடைகளைக் கண்டறியவும்';
    }
  }

  // ---------------- BUYER ----------------

  static String buyerDashboard(AppLanguage language) {
    switch (language) {
      case AppLanguage.english:
        return 'Buyer Dashboard';
      case AppLanguage.kannada:
        return 'ಖರೀದಿದಾರ ಡ್ಯಾಶ್‌ಬೋರ್ಡ್';
      case AppLanguage.hindi:
        return 'खरीदार डैशबोर्ड';
      case AppLanguage.telugu:
        return 'కొనుగోలుదారు డ్యాష్‌బోర్డ్';
      case AppLanguage.tamil:
        return 'வாங்குபவர் டாஷ்போர்டு';
    }
  }

  static String findCrops(AppLanguage language) {
    switch (language) {
      case AppLanguage.english:
        return 'Find Crops';
      case AppLanguage.kannada:
        return 'ಬೆಳೆಗಳನ್ನು ಹುಡುಕಿ';
      case AppLanguage.hindi:
        return 'फसलें खोजें';
      case AppLanguage.telugu:
        return 'పంటలను కనుగొనండి';
      case AppLanguage.tamil:
        return 'பயிர்களைக் கண்டறியவும்';
    }
  }

  static String contactFarmer(AppLanguage language) {
    switch (language) {
      case AppLanguage.english:
        return 'Contact Farmer';
      case AppLanguage.kannada:
        return 'ರೈತರನ್ನು ಸಂಪರ್ಕಿಸಿ';
      case AppLanguage.hindi:
        return 'किसान से संपर्क करें';
      case AppLanguage.telugu:
        return 'రైతును సంప్రదించండి';
      case AppLanguage.tamil:
        return 'விவசாயியைத் தொடர்புகொள்ளவும்';
    }
  }

  static String directFromFarmers(AppLanguage language) {
    switch (language) {
      case AppLanguage.english:
        return 'Directly from farmers';
      case AppLanguage.kannada:
        return 'ನೇರವಾಗಿ ರೈತರಿಂದ';
      case AppLanguage.hindi:
        return 'सीधे किसानों से';
      case AppLanguage.telugu:
        return 'నేరుగా రైతుల నుండి';
      case AppLanguage.tamil:
        return 'நேரடியாக விவசாயிகளிடமிருந்து';
    }
  }
}