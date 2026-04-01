import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:gemai/core/constants/colors.dart';
import 'package:gemai/core/constants/sizes.dart';
import 'package:gemai/features/MarketPlace/models/product_model.dart';
import 'package:gemai/features/personalization/controllers/user_controller.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class EditUploadScreen extends StatefulWidget {
  const EditUploadScreen({super.key, required this.product});

  final ProductModel product;

  @override
  State<EditUploadScreen> createState() => _EditUploadScreenState();
}

class _EditUploadScreenState extends State<EditUploadScreen> {
  final formKey = GlobalKey<FormState>();

  late final TextEditingController title;
  late final TextEditingController desc;
  late final TextEditingController price;
  late final TextEditingController location;
  late final TextEditingController category;
  late final TextEditingController weight;

  static const String other = "Other...";

  final List<String> gemTypes = const [
    "Amethyst", "Aquamarine", "Citrine", "Diamond", "Emerald", "Garnet",
    "Gold", "Opal", "Peridot", "Ruby", "Sapphire", "Tanzanite", "Topaz", "Other...",
  ];
  final List<String> colors = const [
    "Colorless (D–F)", "Near Colorless (G–J)", "Faint (K–M)", "Very Light (N–R)",
    "Light Color (S–Z)", "Light Yellow", "Fancy Yellow", "Fancy Pink", "Fancy Blue",
    "Fancy Green", "Grey/Silver", "Multicolor", "Red", "Green", "Yellow", "Blue",
    "Purple", "Orange", "Other...",
  ];
  final List<String> origins = const [
    "Pakistan", "Afghanistan", "Sri Lanka", "Myanmar (Burma)", "Madagascar",
    "Tanzania", "Mozambique", "Brazil", "Other...",
  ];
  final List<String> cuts = const [
    "Round", "Oval", "Princess", "Pear", "Cushion", "Radiant", "Asscher",
    "Marquise", "Heart", "Emerald Cut", "Trillion", "Other...",
  ];
  final List<String> clarities = const [
    "FL (Flawless)", "IF (Internally Flawless)", "VVS1(Very Very Slightly Included 1)",
    "VVS2(Very Very Slightly Included2)", "VS1(Very Slightly Included 1)",
    "VS2(Very Slightly Included 2)", "SI1(Slightly Included 1)", "SI2(Slightly Included 2)",
    "I1(Included 1)", "I2(Included 2)", "I3(Included 3)", "Other...",
  ];
  final List<String> treatments = const [
    "Untreated", "Heat Treated", "Oiled", "Dyed", "Irradiated", "Fracture Filled", "Other...",
  ];

  late String selectedGemType;
  late String selectedColor;
  late String selectedOrigin;
  late String selectedCut;
  late String selectedClarity;
  late String selectedTreatment;
  late bool certification;

  final gemTypeOther = TextEditingController();
  final colorOther = TextEditingController();
  final originOther = TextEditingController();
  final cutOther = TextEditingController();
  final clarityOther = TextEditingController();
  final treatmentOther = TextEditingController();

  // Existing image URLs still kept
  late List<String> existingImageUrls;
  // Newly picked local images
  final List<XFile> newImages = [];

  bool saving = false;

  String _initDropdown(List<String> options, String value) {
    if (options.contains(value)) return value;
    return other;
  }

  @override
  void initState() {
    super.initState();
    final p = widget.product;
    title = TextEditingController(text: p.title);
    desc = TextEditingController(text: p.description);
    price = TextEditingController(text: p.price.toString());
    location = TextEditingController(text: p.location);
    category = TextEditingController(text: p.category);
    weight = TextEditingController(text: p.weightCarat.toString());

    existingImageUrls = List<String>.from(p.imageUrls);

    selectedGemType = _initDropdown(gemTypes, p.gemType);
    if (selectedGemType == other) gemTypeOther.text = p.gemType;

    selectedColor = _initDropdown(colors, p.color);
    if (selectedColor == other) colorOther.text = p.color;

    selectedOrigin = _initDropdown(origins, p.origin);
    if (selectedOrigin == other) originOther.text = p.origin;

    selectedCut = _initDropdown(cuts, p.cut);
    if (selectedCut == other) cutOther.text = p.cut;

    selectedClarity = _initDropdown(clarities, p.clarity);
    if (selectedClarity == other) clarityOther.text = p.clarity;

    selectedTreatment = _initDropdown(treatments, p.treatment);
    if (selectedTreatment == other) treatmentOther.text = p.treatment;

    certification = p.certification;
  }

  @override
  void dispose() {
    title.dispose();
    desc.dispose();
    price.dispose();
    location.dispose();
    category.dispose();
    weight.dispose();
    gemTypeOther.dispose();
    colorOther.dispose();
    originOther.dispose();
    cutOther.dispose();
    clarityOther.dispose();
    treatmentOther.dispose();
    super.dispose();
  }

  InputDecoration _decoration(String label, {String? hint, IconData? icon}) {
    return InputDecoration(
      labelText: label,
      hintText: hint,
      prefixIcon: icon == null ? null : Icon(icon),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(AppSizes.md)),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: BorderSide(color: Colors.grey.shade300),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: BorderSide(color: Theme.of(context).colorScheme.primary, width: 1.5),
      ),
      filled: true,
      fillColor: Theme.of(context).colorScheme.surface,
      contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
    );
  }

  Widget _card({required Widget child}) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade200),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 14,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: child,
    );
  }

  Widget _sectionTitle(String t, {String? subtitle}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(t, style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700)),
        if (subtitle != null) ...[
          const SizedBox(height: 4),
          Text(subtitle, style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.grey.shade600)),
        ],
      ],
    );
  }

  Widget _dropdown({
    required String label,
    required IconData icon,
    required String value,
    required List<String> items,
    required ValueChanged<String?> onChanged,
  }) {
    return DropdownButtonFormField<String>(
      value: value,
      decoration: _decoration(label, icon: icon),
      items: items
          .map((e) => DropdownMenuItem(value: e, child: Text(e, overflow: TextOverflow.ellipsis)))
          .toList(),
      onChanged: saving ? null : onChanged,
    );
  }

  Widget _otherField({required String selected, required TextEditingController controller, required String label}) {
    if (selected != other) return const SizedBox.shrink();
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: TextFormField(
        controller: controller,
        decoration: _decoration(label, icon: Icons.edit_outlined),
        validator: (v) => (v == null || v.trim().isEmpty) ? "Required" : null,
      ),
    );
  }

  String _finalValue(String selected, TextEditingController otherCtrl) {
    if (selected != other) return selected;
    return otherCtrl.text.trim();
  }

  Future<void> _pickImages() async {
    final files = await ImagePicker().pickMultiImage(imageQuality: 75, maxWidth: 1280);
    if (files.isNotEmpty) setState(() => newImages.addAll(files));
  }

  Future<void> _save() async {
    if (saving) return;
    if (!formKey.currentState!.validate()) return;

    final totalImages = existingImageUrls.length + newImages.length;
    if (totalImages == 0) {
      Get.snackbar("Images required", "Please keep at least 1 image.");
      return;
    }

    setState(() => saving = true);
    try {
      final user = UserController.instance.user.value;
      final productId = widget.product.id;

      // Upload new images
      List<String> newUrls = [];
      if (newImages.isNotEmpty) {
        final storage = FirebaseStorage.instance;
        for (final img in newImages) {
          final fileName = "img_${DateTime.now().millisecondsSinceEpoch}_${img.name}";
          final ref = storage.ref("Products/${user.id}/$productId/$fileName");
          await ref.putFile(File(img.path));
          newUrls.add(await ref.getDownloadURL());
        }
      }

      final allImageUrls = [...existingImageUrls, ...newUrls];

      final updatedData = <String, dynamic>{
        "title": title.text.trim(),
        "description": desc.text.trim(),
        "price": double.tryParse(price.text.trim()) ?? 0,
        "location": location.text.trim(),
        "category": category.text.trim(),
        "gemType": _finalValue(selectedGemType, gemTypeOther),
        "color": _finalValue(selectedColor, colorOther),
        "origin": _finalValue(selectedOrigin, originOther),
        "weightCarat": double.tryParse(weight.text.trim()) ?? 0,
        "cut": _finalValue(selectedCut, cutOther),
        "clarity": _finalValue(selectedClarity, clarityOther),
        "treatment": _finalValue(selectedTreatment, treatmentOther),
        "certification": certification,
        "imageUrls": allImageUrls,
      };

      await FirebaseFirestore.instance.collection("Products").doc(productId).update(updatedData);

      Get.back(result: true);
      Get.snackbar("Success", "Product updated successfully.");
    } catch (e) {
      Get.snackbar("Error", e.toString());
    } finally {
      if (mounted) setState(() => saving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Listing"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: saving ? null : () => Get.back(),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSizes.defaultSpace),
        child: Form(
          key: formKey,
          child: Column(
            children: [
              // Images section
              _card(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _sectionTitle("Photos", subtitle: "Tap × to remove, or add new photos."),
                    const SizedBox(height: 12),
                    if (existingImageUrls.isNotEmpty || newImages.isNotEmpty) ...[
                      SizedBox(
                        height: 100,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: existingImageUrls.length + newImages.length,
                          itemBuilder: (_, i) {
                            final isExisting = i < existingImageUrls.length;
                            return Stack(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(right: 8),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: isExisting
                                        ? Image.network(existingImageUrls[i],
                                            width: 90, height: 90, fit: BoxFit.cover)
                                        : Image.file(File(newImages[i - existingImageUrls.length].path),
                                            width: 90, height: 90, fit: BoxFit.cover),
                                  ),
                                ),
                                Positioned(
                                  top: 4,
                                  right: 12,
                                  child: GestureDetector(
                                    onTap: saving
                                        ? null
                                        : () {
                                            setState(() {
                                              if (isExisting) {
                                                existingImageUrls.removeAt(i);
                                              } else {
                                                newImages.removeAt(i - existingImageUrls.length);
                                              }
                                            });
                                          },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: Colors.black.withValues(alpha: 0.65),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      padding: const EdgeInsets.all(6),
                                      child: const Icon(Icons.close, color: Colors.white, size: 14),
                                    ),
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                      ),
                      const SizedBox(height: 10),
                    ],
                    OutlinedButton.icon(
                      onPressed: saving ? null : _pickImages,
                      icon: const Icon(Icons.add_photo_alternate_outlined),
                      label: const Text("Add Photos"),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 14),

              // Basic info
              _card(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _sectionTitle("Basic Information"),
                    const SizedBox(height: 12),
                    TextFormField(
                      controller: title,
                      decoration: _decoration("Title", icon: Icons.title),
                      validator: (v) => (v == null || v.trim().isEmpty) ? "Required" : null,
                    ),
                    const SizedBox(height: 12),
                    TextFormField(
                      controller: desc,
                      decoration: _decoration("Description", icon: Icons.description_outlined),
                      minLines: 3,
                      maxLines: 6,
                      validator: (v) => (v == null || v.trim().isEmpty) ? "Required" : null,
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            controller: price,
                            decoration: _decoration("Price (Rs)", icon: Icons.currency_rupee),
                            keyboardType: TextInputType.number,
                            validator: (v) =>
                                (double.tryParse((v ?? "").trim()) == null) ? "Enter valid price" : null,
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: TextFormField(
                            controller: location,
                            decoration: _decoration("Location", icon: Icons.location_on_outlined),
                            validator: (v) => (v == null || v.trim().isEmpty) ? "Required" : null,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    TextFormField(
                      controller: category,
                      decoration: _decoration("Category", icon: Icons.category_outlined),
                      validator: (v) => (v == null || v.trim().isEmpty) ? "Required" : null,
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 14),

              // Gem details
              _card(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _sectionTitle("Gem Details", subtitle: "Select values or choose Other to type custom."),
                    const SizedBox(height: 12),
                    _dropdown(
                      label: "Gem Type",
                      icon: Icons.diamond_outlined,
                      value: selectedGemType,
                      items: gemTypes,
                      onChanged: (v) => setState(() => selectedGemType = v ?? gemTypes.first),
                    ),
                    _otherField(selected: selectedGemType, controller: gemTypeOther, label: "Custom Gem Type"),
                    const SizedBox(height: 12),
                    _dropdown(
                      label: "Color",
                      icon: Icons.palette_outlined,
                      value: selectedColor,
                      items: colors,
                      onChanged: (v) => setState(() => selectedColor = v ?? colors.first),
                    ),
                    _otherField(selected: selectedColor, controller: colorOther, label: "Custom Color"),
                    const SizedBox(height: 12),
                    _dropdown(
                      label: "Origin",
                      icon: Icons.public_outlined,
                      value: selectedOrigin,
                      items: origins,
                      onChanged: (v) => setState(() => selectedOrigin = v ?? origins.first),
                    ),
                    _otherField(selected: selectedOrigin, controller: originOther, label: "Custom Origin"),
                    const SizedBox(height: 12),
                    TextFormField(
                      controller: weight,
                      decoration: _decoration("Weight (Carat)", icon: Icons.scale_outlined),
                      keyboardType: TextInputType.number,
                      validator: (v) =>
                          (double.tryParse((v ?? "").trim()) == null) ? "Enter valid number" : null,
                    ),
                    const SizedBox(height: 12),
                    _dropdown(
                      label: "Cut",
                      icon: Icons.auto_fix_high_outlined,
                      value: selectedCut,
                      items: cuts,
                      onChanged: (v) => setState(() => selectedCut = v ?? cuts.first),
                    ),
                    _otherField(selected: selectedCut, controller: cutOther, label: "Custom Cut"),
                    const SizedBox(height: 12),
                    _dropdown(
                      label: "Clarity",
                      icon: Icons.visibility_outlined,
                      value: selectedClarity,
                      items: clarities,
                      onChanged: (v) => setState(() => selectedClarity = v ?? clarities.first),
                    ),
                    _otherField(selected: selectedClarity, controller: clarityOther, label: "Custom Clarity"),
                    const SizedBox(height: 12),
                    _dropdown(
                      label: "Treatment",
                      icon: Icons.science_outlined,
                      value: selectedTreatment,
                      items: treatments,
                      onChanged: (v) => setState(() => selectedTreatment = v ?? treatments.first),
                    ),
                    _otherField(selected: selectedTreatment, controller: treatmentOther, label: "Custom Treatment"),
                    const SizedBox(height: 12),
                    SwitchListTile(
                      contentPadding: EdgeInsets.zero,
                      value: certification,
                      onChanged: saving ? null : (v) => setState(() => certification = v),
                      title: const Text("Certification Available"),
                      subtitle: const Text("Turn on if you have lab certificate/proof."),
                      activeThumbColor: AppColors.white,
                      activeTrackColor: AppColors.buttonSecondary,
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 16),

              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: saving ? null : _save,
                  child: Text(saving ? "Saving..." : "Save Changes"),
                ),
              ),
              const SizedBox(height: AppSizes.defaultSpace),
            ],
          ),
        ),
      ),
    );
  }
}
