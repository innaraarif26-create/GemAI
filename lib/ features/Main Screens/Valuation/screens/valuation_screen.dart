import 'package:GemAI/core/constants/sizes.dart';
import 'package:GemAI/core/utils/helpers/helper_functions.dart';
import 'package:GemAI/widgets/appbar/appbar.dart';
import 'package:flutter/material.dart';

class ValuationScreen extends StatefulWidget {
  const ValuationScreen({super.key});

  @override
  State<ValuationScreen> createState() => _ValuationScreenState();
}

class _ValuationScreenState extends State<ValuationScreen> {
  // GEM TYPES
  final List<String> gemTypes = [
    "Diamond", "Ruby", "Emerald", "Sapphire", "Topaz",
    "Amethyst", "Citrine", "Opal", "Garnet", "Aquamarine",
    "Peridot", "Tanzanite", "Morganite"
  ];

  final List<String> cuts = [
    "Round", "Oval", "Princess", "Pear", "Cushion",
    "Radiant", "Asscher", "Marquise", "Heart",
    "Emerald Cut", "Trillion"
  ];

  final List<String> colors = [
    "Colorless (D–F)", "Near Colorless (G–J)", "Faint (K–M)",
    "Very Light (N–R)", "Light Yellow", "Fancy Yellow",
    "Fancy Pink", "Fancy Blue", "Fancy Green",
    "Grey/Silver", "Multicolor", "Red", "Green",
    "Yellow", "Blue", "Purple", "Orange"
  ];

  final List<String> clarities = [
    "FL", "IF", "VVS1", "VVS2", "VS1",
    "VS2", "SI1", "SI2", "I1", "I2", "I3"
  ];

  String? selectedGem;
  String? selectedCut;
  String? selectedColor;
  String? selectedClarity;

  TextEditingController weightController = TextEditingController();

  double pricePKR = 0;
  double priceUSD = 0;

  /// Calculate price and show in a dialog box
  void calculatePrice() {
    if (selectedGem == null ||
        selectedCut == null ||
        selectedColor == null ||
        selectedClarity == null ||
        weightController.text.isEmpty) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Please fill all fields")));
      return;
    }

    final basePrices = {
      "Diamond": 150000, "Ruby": 80000, "Emerald": 95000,
      "Sapphire": 70000, "Topaz": 20000, "Amethyst": 12000,
      "Citrine": 9000, "Opal": 50000, "Garnet": 15000,
      "Aquamarine": 40000, "Peridot": 18000, "Tanzanite": 60000,
      "Morganite": 25000,
    };

    final cutMap = {
      "Round": 1.3, "Oval": 1.15, "Princess": 1.25, "Pear": 1.2,
      "Cushion": 1.18, "Radiant": 1.22, "Asscher": 1.28,
      "Marquise": 1.26, "Heart": 1.35, "Emerald Cut": 1.10, "Trillion": 1.32
    };

    final colorMap = {
      "Colorless (D–F)": 1.4, "Near Colorless (G–J)": 1.25, "Faint (K–M)": 1.1,
      "Very Light (N–R)": 1.0, "Light Yellow": 1.05, "Fancy Yellow": 1.2,
      "Fancy Pink": 1.35, "Fancy Blue": 1.5, "Fancy Green": 1.45,
      "Grey/Silver": 1.0, "Multicolor": 1.2, "Red": 1.3, "Green": 1.25,
      "Yellow": 1.1, "Blue": 1.35, "Purple": 1.2, "Orange": 1.15,
    };

    final clarityMap = {
      "FL": 1.5, "IF": 1.4, "VVS1": 1.3, "VVS2": 1.25,
      "VS1": 1.2, "VS2": 1.15, "SI1": 1.1, "SI2": 1.05,
      "I1": 1.0, "I2": 0.95, "I3": 0.9,
    };

    double weight = double.tryParse(weightController.text) ?? 0;

    double result = (basePrices[selectedGem] ?? 20000) *
        (cutMap[selectedCut] ?? 1) *
        (colorMap[selectedColor] ?? 1) *
        (clarityMap[selectedClarity] ?? 1) *
        weight;

    setState(() {
      pricePKR = result;
      priceUSD = result / 290; // approximate USD
    });

    showPriceDialog();
  }

  /// Show price in a dialog
  void showPriceDialog() {
    bool dark = AppHelperFunctions.isDarkMode(context);
    Color textColor = dark ? Colors.white : Colors.black;
    Color bgColor = dark ? Colors.grey[850]! : Colors.white;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: bgColor,
        title: Text("Estimated Price", style: TextStyle(color: textColor)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text("PKR: ${pricePKR.toStringAsFixed(0)}",
                style: TextStyle(color: textColor, fontWeight: FontWeight.bold, fontSize: 18)),
            const SizedBox(height: 10),
            Text("USD: \$${priceUSD.toStringAsFixed(2)}",
                style: TextStyle(color: textColor, fontWeight: FontWeight.bold, fontSize: 16)),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();

              setState(() {
                selectedGem = null;
                selectedCut = null;
                selectedColor = null;
                selectedClarity = null;
                weightController.clear();
                pricePKR = 0;
                priceUSD = 0;
              });
            },
            child: Text("Close", style: TextStyle(color: dark ? Colors.tealAccent : Colors.blue)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    bool dark = AppHelperFunctions.isDarkMode(context);
    Color textColor = dark ? Colors.white : Colors.black;
    Color cardColor = dark ? Colors.grey[850]! : Colors.white;
    Color borderColor = dark ? Colors.grey[700]! : Colors.grey.shade500;

    return Scaffold(
      appBar: AppAppBar(
        title: Text("Estimate Price"),
        showBackArrow: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSizes.defaultSpace),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Enter gemstone details to estimate market price.",
              style: Theme.of(context).textTheme.titleLarge?.copyWith(color: textColor),
            ),
            const SizedBox(height: AppSizes.spaceBtwItems),

            sectionTitle("Gem Type", textColor),
            dropDown(gemTypes, selectedGem, (v) => setState(() => selectedGem = v),
                cardColor, textColor, borderColor),

            sectionTitle("Cut", textColor),
            dropDown(cuts, selectedCut, (v) => setState(() => selectedCut = v),
                cardColor, textColor, borderColor),

            sectionTitle("Color", textColor),
            dropDown(colors, selectedColor, (v) => setState(() => selectedColor = v),
                cardColor, textColor, borderColor),

            sectionTitle("Clarity", textColor),
            dropDown(clarities, selectedClarity, (v) => setState(() => selectedClarity = v),
                cardColor, textColor, borderColor),

            sectionTitle("Weight (Carat)", textColor),
            TextFormField(
              controller: weightController,
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              style: TextStyle(color: textColor),
              decoration: InputDecoration(
                labelText: "Enter Weight in carat",
                labelStyle: TextStyle(color: textColor),
                filled: true,
                fillColor: cardColor,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(AppSizes.sm),
                  borderSide: BorderSide(color: borderColor),
                ),
              ),
            ),

            const SizedBox(height: AppSizes.spaceBtwSections),

            Center(
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: calculatePrice,
                  child: Text("Estimate Price",
                      style: TextStyle(color: dark ? Colors.black : Colors.white)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget sectionTitle(String title, Color textColor) => Padding(
    padding: const EdgeInsets.only(top: AppSizes.sm, bottom: AppSizes.sm),
    child: Text(title, style: TextStyle(color: textColor, fontSize: 16, fontWeight: FontWeight.bold)),
  );

  Widget dropDown(List<String> items, String? value,
      Function(String?) onChanged, Color bgColor, Color textColor, Color borderColor) {
    return Container(
      margin: const EdgeInsets.only(bottom: AppSizes.sm),
      padding: const EdgeInsets.symmetric(horizontal: AppSizes.md),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(AppSizes.md),
        border: Border.all(color: borderColor),
      ),
      child: DropdownButton<String>(
        value: value,
        isExpanded: true,
        underline: Container(),
        hint: Text("Select", style: TextStyle(color: textColor)),
        items: items
            .map((e) => DropdownMenuItem(
          value: e,
          child: Text(e, style: TextStyle(color: textColor)),
        ))
            .toList(),
        onChanged: onChanged,
      ),
    );
  }
}