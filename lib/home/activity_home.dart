import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:scanq_multiplatform/layouts/activity_category_overview.dart';
import 'package:scanq_multiplatform/layouts/activity_create_category.dart';
import 'package:scanq_multiplatform/layouts/activity_vocabulary_manually.dart';
import 'package:scanq_multiplatform/ocr/ui/activity_image_select.dart';
import 'package:scanq_multiplatform/quiz/ui/activity_quiz_select.dart';
import 'package:url_launcher/url_launcher.dart';

class ActivityHome extends StatelessWidget {
  const ActivityHome({super.key});

  Future<void> _sendFeedback() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    String deviceData = "Unknown Device";

    String header = "Beta-Feedback | ${DateFormat('dd.MM.yyyy').format(DateTime.now())}";
    String date = DateFormat('yyyy-MM-dd-HH-mm').format(DateTime.now());

    if (Platform.isAndroid) {
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      deviceData = """
********* Bitte nicht entferen ********
*************************************

Date: $date                     
Brand: ${androidInfo.manufacturer}
Model: ${androidInfo.model}
Android: ${androidInfo.version.release}
SDK: ${androidInfo.version.sdkInt}
ABIs: ${androidInfo.supportedAbis.join(', ')}

*************************************
********* Bitte nicht entferen ********
    """;
    } else if (Platform.isIOS) {
      IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
      deviceData = """
********* Bitte nicht entferen ********
*************************************

Date: $date 
Brand: Apple                    
Model: ${iosInfo.utsname.machine}
IOS: ${iosInfo.systemVersion}
System: ${iosInfo.systemName}

*************************************
********* Bitte nicht entferen ********
    """;
    }

    final Uri emailUri = Uri(
      scheme: 'mailto',
      path: 'rommelbendel@gmail.com',
      query: Uri.encodeFull('subject=$header&body=$deviceData\n\nMein Feedback zur Beta-Version von ScanQ: '),
    );
    if (await canLaunchUrl(emailUri)) {
      await launchUrl(emailUri);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(height: 10),
          const Text(
            'ScanQ',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold, color: Colors.teal, fontFamily: "ScanQFont"),
          ),
          _buildCard(
              'Neue Vokabeln',
              context,
              [
                _buildImageButton(context, 'assets/icon/home_scan.png', 'Scannen', ActivityImageSelect()),
                _buildImageButton(context, 'assets/icon/home_manually.png', 'Eingeben', ActivityVocabularyManually()),
              ],
              _buildButton(context, 'Neue Kategorie erstellen', ActivityCreateCategory())),
          _buildCard(
              'Meine Vokabeln',
              context,
              [
                _buildImageButton(context, 'assets/icon/home_overview.png', 'Übersicht', ActivityCategoryOverview()),
                _buildImageButton(context, 'assets/icon/home_quiz.png', 'Quiz', ActivityQuizSelect()),
              ],
              null),
          _buildFeedbackCard(_sendFeedback),
        ],
      ),
    );
  }

  /// Card Widget for Sections
  Widget _buildCard(String title, BuildContext context, List<Widget> children, Widget? bottomWidget) {
    return Card(
      elevation: 4, // Shadow effect
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: children),
            if (bottomWidget != null) ...[
              const Divider(
                height: 40,
                thickness: 2,
              ),
              Center(child: bottomWidget),
            ],
          ],
        ),
      ),
    );
  }

  /// Image Buttons (With Navigation)
  Widget _buildImageButton(BuildContext context, String assetPath, String label, Widget screen) {
    return Column(
      children: [
        GestureDetector(
          onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => screen)),
          child: Image.asset(assetPath, width: 70, height: 70),
        ),
        Text(label, style: const TextStyle(fontSize: 16)),
      ],
    );
  }

  /// Simple Text Button
  Widget _buildButton(BuildContext context, String label, Widget screen) {
    return ElevatedButton(
      onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => screen)),
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      child: Text(label, style: const TextStyle(color: Colors.white, fontSize: 16)),
    );
  }

  /// Feedback Card Section
  Widget _buildFeedbackCard(VoidCallback onFeedbackTap) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
                "Vielen Dank, dass du die Beta-Version von ScanQ ausprobierst! Hast du Verbesserungen oder gab es Probleme?",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500)),
            const SizedBox(height: 10),
            Center(
              child: ElevatedButton(
                onPressed: onFeedbackTap,
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text('Feedback geben', style: TextStyle(color: Colors.white, fontSize: 16)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
