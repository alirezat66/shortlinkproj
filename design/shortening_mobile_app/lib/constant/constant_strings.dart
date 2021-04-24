import 'package:shortening_mobile_app/data/model/footer_menu.dart';

class StringValue {
  static const String homeTitle = 'More than just shorter links';
  static const String homeDescription =
      'Build your brand\'s recognition and get detailed insights on how your links are performing.';
  static const String startButton = 'Get Started';
  static const String shortenButton = 'Shorten It!';
  static const String boostTitle = 'Boost your links today';

  static const String advancedTitle = 'Advanced Statistics';
  static const String advancedDescription =
      'Track how your links are performing across the web with our advanced statistics dashboard.';
  static const String advancedListTitleFirst = 'Brand Recognition';
  static const String advancedListDescriptionFirst =
      'Boost your brand recognition with each click. Generic links don\'t mean a thing. Branded links help instill confidence in your content.';
  static const String advancedListTitleSecond = 'Detailed Records';
  static const String advancedListDescriptionSecond =
      'Gain insights into who is clicking your links. knowing when and where people engage with your content helps inform better decisions.';
  static const String advancedListTitleThird = 'Fully Customizable';
  static const String advancedListDescriptionThird =
      'Improve brand awareness and content discoverability through customizable links, supercharging audience engagement.';
  static const String shortenLinkTextHint = 'Shorten a link here...';
  static List<FooterMenu> footerMenu = [
    FooterMenu(
      'Features',
      ['Link Shortening', 'Branded Links', 'Analytics'],
    ),
    FooterMenu(
      'Resources',
      ['Blog', 'Developers', 'Support'],
    ),
    FooterMenu(
      'Company',
      ['About', 'Our Team', 'Careers', 'Contact'],
    ),
  ];

  static const String emptyError = 'please add a link';
  static const String internetError = 'No internet connection';
  static const String copyButtonText = 'Copy';
  static const String copiedButtonText = 'Copied!';
  static const String urlCloud = 'https://api.shrtco.de/v2/';
}
