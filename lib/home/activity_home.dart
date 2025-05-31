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

import '../gen/l10n/app_localizations.dart';

class ActivityHome extends StatelessWidget {
  const ActivityHome({super.key});

  Future<void> _sendFeedbackMail(BuildContext context) async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    String deviceData = "Unknown Device";

    String header = "Beta-Feedback | ${DateFormat('dd.MM.yyyy').format(DateTime.now())}";
    String date = DateFormat('yyyy-MM-dd-HH-mm').format(DateTime.now());

    if (Platform.isAndroid) {
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      deviceData = """
********* ${AppLocalizations.of(context)!.dontRemove} ********
*************************************

Date: $date                     
Brand: ${androidInfo.manufacturer}
Model: ${androidInfo.model}
Android: ${androidInfo.version.release}
SDK: ${androidInfo.version.sdkInt}
ABIs: ${androidInfo.supportedAbis.join(', ')}

*************************************
********* ${AppLocalizations.of(context)!.dontRemove} ********
    """;
    } else if (Platform.isIOS) {
      IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
      deviceData = """
********* ${AppLocalizations.of(context)!.dontRemove} ********
*************************************

Date: $date 
Brand: Apple                    
Model: ${iosInfo.utsname.machine}
IOS: ${iosInfo.systemVersion}
System: ${iosInfo.systemName}

*************************************
********* ${AppLocalizations.of(context)!.dontRemove} ********
    """;
    }

    final Uri emailUri = Uri(
      scheme: 'mailto',
      path: 'rommelbendel@gmail.com',
      query: Uri.encodeFull('subject=$header&body=$deviceData\n\n${AppLocalizations.of(context)!.feedbackMailHeader}: '),
    );
    if (await canLaunchUrl(emailUri)) {
      await launchUrl(emailUri);
    }
  }

  Future<void> _openFeedbackSurvey(BuildContext context) async {
    Uri? surveyUri = null;

    if (Platform.isIOS) {
      surveyUri = Uri.parse("https://forms.gle/SqJxaG444RXJ3Q5C7");
    } else if(Platform.isAndroid) {
      surveyUri = Uri.parse("https://forms.gle/CkXPdGBrVjVdAXxx7");
    }

    if (surveyUri != null && await canLaunchUrl(surveyUri)) {
      await launchUrl(surveyUri);
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(
          AppLocalizations.of(context)!.surveyUnavailable)
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(15, 10, 15, 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            'ScanQ',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold, color: Colors.teal, fontFamily: "ScanQFont"),
          ),
          _buildCard(
              AppLocalizations.of(context)!.myVocabs,
              context,
              [
                _buildImageButton(
                    context, 'assets/icon/home_overview.png', AppLocalizations.of(context)!.overview, ActivityCategoryOverview()),
                _buildImageButton(context, 'assets/icon/home_quiz.png', AppLocalizations.of(context)!.quiz, ActivityQuizSelect()),
              ],
              null),
          _buildCard(
              AppLocalizations.of(context)!.addVocabularies,
              context,
              [
                _buildImageButton(
                    context, 'assets/icon/home_scan.png', AppLocalizations.of(context)!.scan, ActivityImageSelect()),
                _buildImageButton(context, 'assets/icon/home_manually.png', AppLocalizations.of(context)!.tapManuallyTitle,
                    ActivityVocabularyManually()),
              ],
              _buildButton(context, AppLocalizations.of(context)!.createNewCategory, ActivityCreateCategory())),
          _buildFeedbackCard(context, _openFeedbackSurvey, () => _sendFeedbackMail(context)),
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
  Widget _buildFeedbackCard(
      BuildContext context,
      Future<void> Function(BuildContext) onFeedbackTap,
      VoidCallback onContactTap
      ) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(AppLocalizations.of(context)!.betaThanks, style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500)),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () async {
                    await onFeedbackTap(context);
                  },
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text(AppLocalizations.of(context)!.feedback, style: TextStyle(color: Colors.white, fontSize: 16)),
                ),
                ElevatedButton(
                  onPressed: onContactTap,
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text(AppLocalizations.of(context)!.contact, style: TextStyle(color: Colors.white, fontSize: 16)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
