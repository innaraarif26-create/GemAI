import 'package:flutter/material.dart';
import '../../../models/real_fake_gem_model.dart';

class RealFakeDetailScreen extends StatelessWidget {
  final RealFakeGem gem;

  const RealFakeDetailScreen({super.key, required this.gem});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffE6E3E3),
      appBar: AppBar(
        backgroundColor: const Color(0xffE6E3E3),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [

            /// TITLE
            RichText(
              text: const TextSpan(
                style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
                children: [
                  TextSpan(text: "Real "),
                  TextSpan(
                      text: "V",
                      style: TextStyle(color: Colors.orange)),
                  TextSpan(
                      text: "S",
                      style: TextStyle(color: Colors.red)),
                  TextSpan(text: " Fake"),
                ],
              ),
            ),

            const SizedBox(height: 8),

            /// NAME
            Text(gem.name,
                style: const TextStyle(
                    fontSize: 20, fontWeight: FontWeight.w600)),

            const SizedBox(height: 10),

            /// IMAGE
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.asset(gem.image, height: 140),
            ),

            const SizedBox(height: 10),

            Text(gem.description),

            const SizedBox(height: 20),

            section("Overview", gem.overviewReal, gem.overviewFake),
            section("Color", gem.colorReal, gem.colorFake),
            section("Touch Test", gem.touchReal, gem.touchFake),
            section("Specific Gravity", gem.gravityReal, gem.gravityFake),
            section(gem.extraTitle, gem.extraReal, gem.extraFake),
          ],
        ),
      ),
    );
  }

  Widget section(String title, String real, String fake) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 14),
        Text(title,
            style: const TextStyle(
                fontSize: 18, fontWeight: FontWeight.bold)),
        Row(
          children: [
            Expanded(child: box("Real", real, Colors.orange.shade100)),
            Expanded(child: box("Fake", fake, Colors.red.shade100)),
          ],
        )
      ],
    );
  }

  Widget box(String title, String text, Color color) {
    return Container(
      margin: const EdgeInsets.all(4),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: color, borderRadius: BorderRadius.circular(12)),
      child: Column(
        children: [
          Text(title,
              style: const TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 6),
          Text(text, textAlign: TextAlign.center),
        ],
      ),
    );
  }
}