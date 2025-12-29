import 'package:flutter/material.dart';
import 'package:medidropbox/core/extensions/button_extension.dart';
import 'package:medidropbox/core/helpers/app_export.dart';
import 'package:url_launcher/url_launcher.dart';

extension UrlLauncherExtension on String {
  // Open any URL
  Future<void> openUrl({
    LaunchMode mode = LaunchMode.externalApplication,
  }) async {
    try {
      final uri = Uri.parse(this);

      await launchUrl(uri, mode: mode);
    } catch (e) {
      debugPrint("Could not launch $this");
      debugPrint(e.toString());
    }
  }

  // Open URL in WebView
  Future<void> openUrlInApp() async {
    try {
      final uri = Uri.parse(this);

      await launchUrl(uri, mode: LaunchMode.inAppWebView);
    } catch (e) {
      debugPrint("Could not launch $this");
      debugPrint(e.toString());
    }
  }

  // Open WhatsApp with message
  Future<void> openWhatsApp({String? message}) async {
    try {
      final phone = replaceAll(RegExp(r'[^0-9]'), '');

      final encodedMessage = message != null
          ? Uri.encodeComponent(message)
          : null;

      final url = encodedMessage != null
          ? "https://wa.me/$phone?text=$encodedMessage"
          : "https://wa.me/$phone";

      final uri = Uri.parse(url);

      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } catch (e) {
      debugPrint("WhatsApp not installed or cannot open");
      debugPrint(e.toString());
    }
  }

  // Open WhatsApp without message (just the number)
  // Future<void> openWhatsAppChat() async {
  //   final uri = Uri.parse("https://wa.me/$this");

  //   if (await canLaunchUrl(uri)) {
  //     await launchUrl(uri, mode: LaunchMode.externalApplication);
  //   } else {
  //     debugPrint("WhatsApp not installed or cannot open");
  //   }
  // }

  // Make phone call
  Future<void> makeCall() async {
    final uri = Uri.parse("tel:$this");

    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      debugPrint("Could not make call to $this");
    }
  }

  // Send SMS
  Future<void> sendSMS({String? body}) async {
    final uri = body != null
        ? Uri.parse("sms:$this?body=${Uri.encodeComponent(body)}")
        : Uri.parse("sms:$this");

    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      debugPrint("Could not send SMS to $this");
    }
  }

  // Send Email
  Future<void> sendEmail({
    String? subject,
    String? body,
    List<String>? cc,
    List<String>? bcc,
  }) async {
    try {
      String emailUrl = "mailto:$this";
      final params = <String>[];

      if (subject != null) {
        params.add("subject=${Uri.encodeComponent(subject)}");
      }
      if (body != null) {
        params.add("body=${Uri.encodeComponent(body)}");
      }
      if (cc != null && cc.isNotEmpty) {
        params.add("cc=${cc.join(',')}");
      }
      if (bcc != null && bcc.isNotEmpty) {
        params.add("bcc=${bcc.join(',')}");
      }

      if (params.isNotEmpty) {
        emailUrl += "?${params.join('&')}";
      }

      final uri = Uri.parse(emailUrl);

      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } catch (e) {
      debugPrint("Could not send email to $this");
      debugPrint(e.toString());
    }
  }

  // Open Google Maps with location
  Future<void> openMaps() async {
    final uri = Uri.parse(
      "https://www.google.com/maps/search/?api=1&query=$this",
    );

    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      debugPrint("Could not open maps for $this");
    }
  }

  // Open Google Maps with coordinates
  Future<void> openMapsWithCoordinates(double latitude, double longitude)  async{
    final Uri uri = Uri.parse(
      'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude',
    );

    if (await canLaunchUrl(uri)) {
      await launchUrl(
        uri,
        mode: LaunchMode.externalApplication,
      );
    } else {
      debugPrint('Could not open Google Maps');
    }
  }
  // Open Telegram
  Future<void> openTelegram() async {
    final uri = Uri.parse("https://t.me/$this");

    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      debugPrint("Telegram not installed or cannot open");
    }
  }

  // Open Instagram profile
  Future<void> openInstagram() async {
    final uri = Uri.parse("https://www.instagram.com/$this");

    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      debugPrint("Could not open Instagram");
    }
  }

  // Open Twitter/X profile
  Future<void> openTwitter() async {
    final uri = Uri.parse("https://twitter.com/$this");

    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      debugPrint("Could not open Twitter");
    }
  }

  // Open Facebook profile
  Future<void> openFacebook() async {
    final uri = Uri.parse("https://www.facebook.com/$this");

    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      debugPrint("Could not open Facebook");
    }
  }

  // Open LinkedIn profile
  Future<void> openLinkedIn() async {
    final uri = Uri.parse("https://www.linkedin.com/in/$this");

    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      debugPrint("Could not open LinkedIn");
    }
  }

  // Open YouTube channel or video
  Future<void> openYouTube() async {
    final uri = Uri.parse(
      this.startsWith('http') ? this : "https://www.youtube.com/$this",
    );

    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      debugPrint("Could not open YouTube");
    }
  }

  // Open app store (Play Store or App Store)
  Future<void> openAppStore({bool isAndroid = true}) async {
    final uri = isAndroid
        ? Uri.parse("https://play.google.com/store/apps/details?id=$this")
        : Uri.parse("https://apps.apple.com/app/id$this");

    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      debugPrint("Could not open app store");
    }
  }

  // Share via system share sheet
  Future<void> shareText() async {
    final uri = Uri.parse("sms:?body=${Uri.encodeComponent(this)}");

    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      debugPrint("Could not share text");
    }
  }

  // Open Skype
  Future<void> openSkype() async {
    final uri = Uri.parse("skype:$this?chat");

    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      debugPrint("Skype not installed or cannot open");
    }
  }

  // Open Viber
  Future<void> openViber() async {
    final uri = Uri.parse("viber://chat?number=$this");

    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      debugPrint("Viber not installed or cannot open");
    }
  }

  // Open WeChat
  Future<void> openWeChat() async {
    final uri = Uri.parse("weixin://dl/chat?$this");

    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      debugPrint("WeChat not installed or cannot open");
    }
  }

  // Check if URL can be launched
  Future<bool> canLaunch() async {
    final uri = Uri.parse(this);
    return await canLaunchUrl(uri);
  }
}

// Extension for better error handling
extension UrlLauncherWithCallbackExtension on String {
  // Open URL with success/error callbacks
  Future<void> openUrlWithCallback({
    LaunchMode mode = LaunchMode.externalApplication,
    VoidCallback? onSuccess,
    VoidCallback? onError,
  }) async {
    try {
      final uri = Uri.parse(this);

      await launchUrl(uri, mode: mode);

      onSuccess?.call();
    } catch (e) {
      debugPrint("Could not launch $this");
      debugPrint(e.toString());
      onError?.call();
    }
  }

  // Try to launch with fallback URL
  Future<void> openUrlWithFallback(String fallbackUrl) async {
    try {
      await launchUrl(Uri.parse(this), mode: LaunchMode.externalApplication);
    } catch (_) {
      try {
        await launchUrl(
          Uri.parse(fallbackUrl),
          mode: LaunchMode.externalApplication,
        );
      } catch (e) {
        debugPrint("Could not launch both $this and $fallbackUrl");
        debugPrint(e.toString());
      }
    }
  }
}

// Example usage
class UrlLauncherExamples extends StatelessWidget {
  const UrlLauncherExamples({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Open website
        ElevatedButton(
          onPressed: () {
            "https://flutter.dev/".openUrl();
          },
          child: const Text('Open Website'),
        ),
        ElevatedButton(
          onPressed: () {
            "https://www.smartbecho.in/".openUrlInApp();
          },
          child: const Text("Open In App"),
        ),

        // Make phone call
        ElevatedButton(
          onPressed: () => '+1234567890'.makeCall(),
          child: const Text('Call'),
        ),

        // Send SMS
        ElevatedButton(
          onPressed: () => '+1234567890'.sendSMS(body: 'Hello!'),
          child: const Text('Send SMS'),
        ),

        // Send Email
        ElevatedButton(
          onPressed: () => 'example@email.com'.sendEmail(
            subject: 'Hello',
            body: 'This is a test email',
          ),
          child: const Text('Send Email'),
        ),

        // Open WhatsApp
        ElevatedButton(
          onPressed: () {
            "917009006977".openWhatsApp(
              message: ''' 
                Hi there!
                This is a test message.
                Have a great day!
            ''',
            );
          },
          child: const Text('WhatsApp'),
        ),

        // Open Maps
        ElevatedButton(
          onPressed: () => 'Eiffel Tower, Paris'.openMaps(),
          child: const Text('Open Maps'),
        ),

        // Open social media
        ElevatedButton(
          onPressed: () => 'flutterdev'.openInstagram(),
          child: const Text('Instagram'),
        ),

        'Twitter'.toHeadingText().asElevatedButton(
          onPressed: () => 'https://flutter.dev'.openUrlInApp(),
         
        ),
        // With callbacks
        ElevatedButton(
          onPressed: () => 'https://flutter.dev'.openUrlWithCallback(
            onSuccess: () => debugPrint('Success!'),
            onError: () => debugPrint('Failed!'),
          ),
          child: const Text('Open with Callback'),
        ),

        // With fallback
        ElevatedButton(
          onPressed: () => 'fb://profile/flutter'.openUrlWithFallback(
            'https://facebook.com/flutter',
          ),
          child: const Text('Facebook (with fallback)'),
        ),
      ],
    );
  }
}
