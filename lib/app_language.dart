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

  // General translation helper.
  static String get(String key) {
    final language = appLanguageController.language;

    final translations = <String, List<String>>{
      'Welcome': [
        'Welcome',
        'ಸ್ವಾಗತ',
        'स्वागत',
        'స్వాగతం',
        'வரவேற்பு',
      ],
      'Farmer Dashboard': [
        'Farmer Dashboard',
        'ರೈತ ಡ್ಯಾಶ್‌ಬೋರ್ಡ್',
        'किसान डैशबोर्ड',
        'రైతు డ్యాష్‌బోర్డ్',
        'விவசாயி டாஷ்போர்டு',
      ],
      'Buyer Dashboard': [
        'Buyer Dashboard',
        'ಖರೀದಿದಾರ ಡ್ಯಾಶ್‌ಬೋರ್ಡ್',
        'खरीदार डैशबोर्ड',
        'కొనుగోలుదారు డ్యాష్‌బోర్డ్',
        'வாங்குபவர் டாஷ்போர்டு',
      ],
      'Home': [
        'Home',
        'ಮುಖಪುಟ',
        'होम',
        'హోమ్',
        'முகப்பு',
      ],
      'Crops': [
        'Crops',
        'ಬೆಳೆಗಳು',
        'फसलें',
        'పంటలు',
        'பயிர்கள்',
      ],
      'Market': [
        'Market',
        'ಮಾರುಕಟ್ಟೆ',
        'बाज़ार',
        'మార్కెట్',
        'சந்தை',
      ],
      'Profile': [
        'Profile',
        'ಪ್ರೊಫೈಲ್',
        'प्रोफ़ाइल',
        'ప్రొఫైల్',
        'சுயவிவரம்',
      ],
      'Notifications': [
        'Notifications',
        'ಅಧಿಸೂಚನೆಗಳು',
        'सूचनाएं',
        'నోటిఫికేషన్లు',
        'அறிவிப்புகள்',
      ],
      'Language': [
        'Language',
        'ಭಾಷೆ',
        'भाषा',
        'భాష',
        'மொழி',
      ],
      'Account Details': [
        'Account Details',
        'ಖಾತೆ ವಿವರಗಳು',
        'खाता विवरण',
        'ఖాతా వివరాలు',
        'கணக்கு விவரங்கள்',
      ],
      'Help & Support': [
        'Help & Support',
        'ಸಹಾಯ ಮತ್ತು ಬೆಂಬಲ',
        'सहायता और समर्थन',
        'సహాయం & మద్దతు',
        'உதவி & ஆதரவு',
      ],
      'About Crop\'D UP': [
        "About Crop'D UP",
        "Crop'D UP ಬಗ್ಗೆ",
        "Crop'D UP के बारे में",
        "Crop'D UP గురించి",
        "Crop'D UP பற்றி",
      ],
      'Connecting farmers and buyers.': [
        'Connecting farmers and buyers.',
        'ರೈತರು ಮತ್ತು ಖರೀದಿದಾರರನ್ನು ಸಂಪರ್ಕಿಸಲಾಗುತ್ತಿದೆ.',
        'किसानों और खरीदारों को जोड़ना।',
        'రైతులు మరియు కొనుగోలుదారులను కలుపుతోంది.',
        'விவசாயிகள் மற்றும் வாங்குபவர்களை இணைக்கிறது.',
      ],
      'MVP': [
        'MVP',
        'MVP',
        'MVP',
        'MVP',
        'MVP',
      ],
      'My Requests': [
        'My Requests',
        'ನನ್ನ ವಿನಂತಿಗಳು',
        'मेरे अनुरोध',
        'నా అభ్యర్థనలు',
        'எனது கோரிக்கைகள்',
      ],
      'No requests yet': [
        'No requests yet',
        'ಇನ್ನೂ ಯಾವುದೇ ವಿನಂತಿಗಳಿಲ್ಲ',
        'अभी तक कोई अनुरोध नहीं',
        'ఇంకా అభ్యర్థనలు లేవు',
        'இன்னும் கோரிக்கைகள் இல்லை',
      ],
    };

    final values = translations[key];

    if (values == null) {
      return key;
    }

    switch (language) {
      case AppLanguage.english:
        return values[0];
      case AppLanguage.kannada:
        return values[1];
      case AppLanguage.hindi:
        return values[2];
      case AppLanguage.telugu:
        return values[3];
      case AppLanguage.tamil:
        return values[4];
    }
  }

  // Backward-compatible Welcome helper.
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
}