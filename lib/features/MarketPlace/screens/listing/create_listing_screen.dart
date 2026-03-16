import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../core/constants/colors.dart';
import '../../../../core/constants/sizes.dart';
import '../../../../data/repositories/product/product_repository.dart';
import '../../../../widgets/appbar/appbar.dart';
import '../../../personalization/controllers/user_controller.dart';
import '../../models/product_model.dart';

class CreateListingScreen extends StatefulWidget {
  const CreateListingScreen({super.key});

  @override
  State<CreateListingScreen> createState() => CreateListingScreenState();
}

class CreateListingScreenState extends State<CreateListingScreen> {
  final formKey = GlobalKey<FormState>();

  final title = TextEditingController();
  final desc = TextEditingController();
  final price = TextEditingController();
  final location = TextEditingController();
  final category = TextEditingController();
  final weight = TextEditingController();

  // "Other" text controllers (used only if user selects Other)
  final gemTypeOther = TextEditingController();
  final colorOther = TextEditingController();
  final originOther = TextEditingController();
  final cutOther = TextEditingController();
  final clarityOther = TextEditingController();
  final treatmentOther = TextEditingController();

  bool certification = true;

  final images = <XFile>[];
  bool saving = false;

  // Dropdown options
  static const String other = "Other...";

  final List<String> gemTypes = const [
    "Amethyst", "Aquamarine", "Citrine", "Diamond", "Emerald", "Garnet", "Gold", "Garnet", "Opal", "Peridot", "Ruby", "Sapphire",
    "Tanzanite", "Topaz", other,
  ];

  final List<String> colors = const [
    "Colorless (D–F)", "Near Colorless (G–J)", "Faint (K–M)", "Very Light (N–R)", "Light Color (S–Z)", "Light Yellow", "Fancy Yellow", "Fancy Pink",
    "Fancy Blue", "Fancy Green", "Grey/Silver", "Multicolor", "Red", "Green", "Yellow", "Blue", "Purple", "Orange", other,
  ];

  final List<String> origins = const [
    "Pakistan", "Afghanistan", "Sri Lanka", "Myanmar (Burma)", "Madagascar", "Tanzania",
    "Mozambique", "Brazil", other,
  ];

  final List<String> cuts = const [
    "Round", "Oval", "Princess", "Pear", "Cushion", "Radiant", "Asscher", "Marquise", "Heart", "Emerald Cut",
    "Trillion", other,
  ];

  final List<String> clarities = const [
    "FL (Flawless)", "IF (Internally Flawless)", "VVS1(Very Very Slightly Included 1)", "VVS2(Very Very Slightly      Included2)",
    "VS1(Very Slightly Included 1)", "VS2(Very Slightly Included 2)", "SI1(Slightly Included 1)", "SI2(Slightly Included 2)", "I1(Included 1)", "I2(Included 2)", "I3(Included 3)", other,
  ];

  final List<String> treatments = const [
    "Untreated", "Heat Treated", "Oiled", "Dyed",
    "Irradiated", "Fracture Filled", other,
  ];

  // Selected dropdown values
  late String selectedGemType;
  late String selectedColor;
  late String selectedOrigin;
  late String selectedCut;
  late String selectedClarity;
  late String selectedTreatment;

  @override
  void initState() {
    super.initState();

    // Default selections
    selectedGemType = gemTypes.first;
    selectedColor = colors.first;
    selectedOrigin = origins.first;
    selectedCut = cuts.first;
    selectedClarity = clarities.first;
    selectedTreatment = treatments.first;
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

  InputDecoration decoration(String label, {String? hint, IconData? icon}) {
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

  Widget card({required Widget child}) {
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
          )
        ],
      ),
      child: child,
    );
  }

  Widget sectionTitle(String title, {String? subtitle}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700)),
        if (subtitle != null) ...[
          const SizedBox(height: 4),
          Text(subtitle, style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.grey.shade600)),
        ],
      ],
    );
  }

  Future<void> pickImages() async {
    final picker = ImagePicker();
    final files = await picker.pickMultiImage(imageQuality: 75, maxWidth: 1280);
    if (files.isNotEmpty) setState(() => images.addAll(files));
  }

  void _removeImageAt(int index) => setState(() => images.removeAt(index));

  String _finalValue(String selected, TextEditingController otherCtrl) {
    if (selected != other) return selected;
    return otherCtrl.text.trim();
  }

  Future<void> submit() async {
    if (saving) return;

    final form = formKey.currentState;
    if (form == null || !form.validate()) return;

    if (images.isEmpty) {
      Get.snackbar("Images required", "Please select at least 1 image.");
      return;
    }

    setState(() => saving = true);

    try {
      final user = UserController.instance.user.value;
      if (user.id.isEmpty) throw "User not loaded. Please re-login.";

      final repo = ProductRepository.instance;

      final productId = repo.newProductId();
      final priceValue = double.tryParse(price.text.trim()) ?? 0;
      final weightValue = double.tryParse(weight.text.trim()) ?? 0;

      final gemType = _finalValue(selectedGemType, gemTypeOther);
      final color = _finalValue(selectedColor, colorOther);
      final origin = _finalValue(selectedOrigin, originOther);
      final cut = _finalValue(selectedCut, cutOther);
      final clarity = _finalValue(selectedClarity, clarityOther);
      final treatment = _finalValue(selectedTreatment, treatmentOther);

      final imageUrls = await repo.uploadImages(
        sellerId: user.id,
        productId: productId,
        images: images,
      );

      final product = ProductModel(
        id: productId,
        title: title.text.trim(),
        description: desc.text.trim(),
        price: priceValue,
        location: location.text.trim(),
        category: category.text.trim(),
        sellerId: user.id,
        sellerName: user.fullName,
        sellerPhotoUrl: user.profilePicture,
        imageUrls: imageUrls,
        createdAt: DateTime.now(),
        views: 0,
        likes: 0,
        isActive: true,
        gemType: gemType,
        color: color,
        origin: origin,
        weightCarat: weightValue,
        cut: cut,
        clarity: clarity,
        treatment: treatment,
        certification: certification,
      );

      await repo.createProduct(product: product);

      Get.back();
      Get.snackbar("Success", "Product listed successfully.");
    } catch (e) {
      Get.snackbar("Error", e.toString());
    } finally {
      if (mounted) setState(() => saving = false);
    }
  }

  Widget dropdown({
    required String label,
    required IconData icon,
    required String value,
    required List<String> items,
    required void Function(String?) onChanged,
  }) {
    return DropdownButtonFormField<String>(
      initialValue: value,
      decoration: decoration(label, icon: icon),
      isExpanded: true,
      items: items.map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
      onChanged: saving ? null : onChanged,
      validator: (v) => (v == null || v.trim().isEmpty) ? "Required" : null,
    );
  }

  Widget otherFieldIfNeeded({
    required String selected,
    required TextEditingController controller,
    required String label,
  }) {
    if (selected != other) return const SizedBox.shrink();
    return Padding(
      padding: const EdgeInsets.only(top: 12),
      child: TextFormField(
        controller: controller,
        decoration: decoration(label, hint: "Type custom value"),
        validator: (v) {
          if (selected != other) return null;
          return (v == null || v.trim().isEmpty) ? "Please enter value" : null;
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppAppBar(
        title: const Text("List Product"),showBackArrow: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                card(
                  child: Row(
                    children: [
                      Container(
                        width: 46,
                        height: 46,
                        decoration: BoxDecoration(
                          color: AppColors.buttonSecondary.withValues(alpha: 0.09),
                          borderRadius: BorderRadius.circular(AppSizes.sm),
                        ),
                        child: Icon(Icons.diamond_outlined, color: AppColors.buttonSecondary),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: sectionTitle(
                          "Create a Gem Listing",
                          subtitle: "Add clear photos and accurate gem details to sell faster.",
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 14),
                // Photos
                card(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      sectionTitle("Photos", subtitle: "Add at least 1 photo. More photos = more trust."),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          Expanded(
                            child: OutlinedButton.icon(
                              onPressed: saving ? null : pickImages,
                              icon: const Icon(Icons.image_outlined),
                              label: Text("Pick Images (${images.length})"),
                            ),
                          ),
                          const SizedBox(width: 10),
                          if (images.isNotEmpty)
                            IconButton(
                              onPressed: saving ? null : () => setState(() => images.clear()),
                              icon: const Icon(Icons.delete_outline),
                              tooltip: "Remove all",
                            ),
                        ],
                      ),
                      if (images.isNotEmpty) ...[
                        const SizedBox(height: 12),
                        SizedBox(
                          height: 92,
                          child: ListView.separated(
                            scrollDirection: Axis.horizontal,
                            itemCount: images.length,
                            separatorBuilder: (_, _) => const SizedBox(width: 10),
                            itemBuilder: (context, index) {
                              final img = images[index];
                              return Stack(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(14),
                                    child: Image.file(
                                      File(img.path),
                                      width: 92,
                                      height: 92,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  Positioned(
                                    top: 6,
                                    right: 6,
                                    child: InkWell(
                                      onTap: saving ? null : () => _removeImageAt(index),
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
                      ],
                    ],
                  ),
                ),

                const SizedBox(height: 14),

                // Basic info
                card(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      sectionTitle("Basic Information"),
                      const SizedBox(height: 12),
                      TextFormField(
                        controller: title,
                        decoration: decoration("Title", hint: "e.g. Certified Emerald Necklace", icon: Icons.title),
                        validator: (v) => (v == null || v.trim().isEmpty) ? "Required" : null,
                      ),
                      const SizedBox(height: 12),
                      TextFormField(
                        controller: desc,
                        decoration: decoration(
                          "Description",
                          hint: "Mention clarity, certification, treatments, etc.",
                          icon: Icons.description_outlined,
                        ),
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
                              decoration: decoration("Price (Rs)", hint: "e.g. 50000", icon: Icons.currency_rupee),
                              keyboardType: TextInputType.number,
                              validator: (v) =>
                              (double.tryParse((v ?? "").trim()) == null) ? "Enter valid price" : null,
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: TextFormField(
                              controller: location,
                              decoration: decoration("Location", hint: "e.g. Gilgit,Pakistan", icon: Icons.location_on_outlined),
                              validator: (v) => (v == null || v.trim().isEmpty) ? "Required" : null,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      TextFormField(
                        controller: category,
                        decoration: decoration("Category", hint: "Diamond, Emerald, Ruby, Sapphire...", icon: Icons.category_outlined),
                        validator: (v) => (v == null || v.trim().isEmpty) ? "Required" : null,
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 14),

                // Gem details as dropdowns + Other
                card(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      sectionTitle("Gem Details", subtitle: "Select values or choose Other to type custom."),
                      const SizedBox(height: 12),

                      dropdown(
                        label: "Gem Type",
                        icon: Icons.diamond_outlined,
                        value: selectedGemType,
                        items: gemTypes,
                        onChanged: (v) => setState(() => selectedGemType = v ?? gemTypes.first),
                      ),
                      otherFieldIfNeeded(
                        selected: selectedGemType,
                        controller: gemTypeOther,
                        label: "Custom Gem Type",
                      ),

                      const SizedBox(height: 12),

                      dropdown(
                        label: "Color",
                        icon: Icons.palette_outlined,
                        value: selectedColor,
                        items: colors,
                        onChanged: (v) => setState(() => selectedColor = v ?? colors.first),
                      ),
                      otherFieldIfNeeded(
                        selected: selectedColor,
                        controller: colorOther,
                        label: "Custom Color",
                      ),

                      const SizedBox(height: 12),

                      dropdown(
                        label: "Origin",
                        icon: Icons.public_outlined,
                        value: selectedOrigin,
                        items: origins,
                        onChanged: (v) => setState(() => selectedOrigin = v ?? origins.first),
                      ),
                      otherFieldIfNeeded(
                        selected: selectedOrigin,
                        controller: originOther,
                        label: "Custom Origin",
                      ),

                      const SizedBox(height: 12),

                      TextFormField(
                        controller: weight,
                        decoration: decoration("Weight (Carat)", hint: "e.g. 5.2", icon: Icons.scale_outlined),
                        keyboardType: TextInputType.number,
                        validator: (v) =>
                        (double.tryParse((v ?? "").trim()) == null) ? "Enter valid number" : null,
                      ),

                      const SizedBox(height: 12),

                      dropdown(
                        label: "Cut",
                        icon: Icons.auto_fix_high_outlined,
                        value: selectedCut,
                        items: cuts,
                        onChanged: (v) => setState(() => selectedCut = v ?? cuts.first),
                      ),
                      otherFieldIfNeeded(
                        selected: selectedCut,
                        controller: cutOther,
                        label: "Custom Cut",
                      ),

                      const SizedBox(height: 12),

                      dropdown(
                        label: "Clarity",
                        icon: Icons.visibility_outlined,
                        value: selectedClarity,
                        items: clarities,
                        onChanged: (v) => setState(() => selectedClarity = v ?? clarities.first),
                      ),
                      otherFieldIfNeeded(
                        selected: selectedClarity,
                        controller: clarityOther,
                        label: "Custom Clarity",
                      ),

                      const SizedBox(height: 12),

                      dropdown(
                        label: "Treatment",
                        icon: Icons.science_outlined,
                        value: selectedTreatment,
                        items: treatments,
                        onChanged: (v) => setState(() => selectedTreatment = v ?? treatments.first),
                      ),
                      otherFieldIfNeeded(
                        selected: selectedTreatment,
                        controller: treatmentOther,
                        label: "Custom Treatment",
                      ),

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
                    onPressed: saving ? null : submit,
                    child: Text(saving ? "Publishing..." : "Publish"),
                  ),
                ),
                SizedBox(height: AppSizes.defaultSpace,)
              ],
            ),
          ),
        ),
      ),
    );
  }
}