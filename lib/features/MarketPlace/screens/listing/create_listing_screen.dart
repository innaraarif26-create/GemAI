import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../data/repositories/product/product_repository.dart';
import '../../../personalization/controllers/user_controller.dart';
import '../../models/product_model.dart';

class CreateListingScreen extends StatefulWidget {
  const CreateListingScreen({super.key});

  @override
  State<CreateListingScreen> createState() => _CreateListingScreenState();
}

class _CreateListingScreenState extends State<CreateListingScreen> {
  final _formKey = GlobalKey<FormState>();

  final _title = TextEditingController();
  final _desc = TextEditingController();
  final _price = TextEditingController();
  final _location = TextEditingController();
  final _category = TextEditingController(text: "Emerald");

  // Weight stays manual
  final _weight = TextEditingController(text: "0");

  // "Other" text controllers (used only if user selects Other)
  final _gemTypeOther = TextEditingController();
  final _colorOther = TextEditingController();
  final _originOther = TextEditingController();
  final _cutOther = TextEditingController();
  final _clarityOther = TextEditingController();
  final _treatmentOther = TextEditingController();

  bool _certification = true;

  final _images = <XFile>[];
  bool _saving = false;

  // Dropdown options
  static const String _other = "Other...";

  final List<String> _gemTypes = const [
    "Natural Emerald",
    "Natural Ruby",
    "Natural Sapphire",
    "Natural Topaz",
    "Natural Garnet",
    "Natural Aquamarine",
    _other,
  ];

  final List<String> _colors = const [
    "Rich Green",
    "Green",
    "Bluish Green",
    "Red",
    "Pinkish Red",
    "Blue",
    "Yellow",
    "White",
    "Black",
    _other,
  ];

  final List<String> _origins = const [
    "Pakistan",
    "Afghanistan",
    "Sri Lanka",
    "Myanmar (Burma)",
    "Madagascar",
    "Tanzania",
    "Mozambique",
    "Brazil",
    _other,
  ];

  final List<String> _cuts = const [
    "Oval Cut",
    "Round Cut",
    "Pear Cut",
    "Emerald Cut",
    "Cushion Cut",
    "Princess Cut",
    "Marquise Cut",
    "Cabochon",
    _other,
  ];

  final List<String> _clarities = const [
    "FL",
    "IF",
    "VVS",
    "VS",
    "SI",
    "I",
    _other,
  ];

  final List<String> _treatments = const [
    "Untreated",
    "Heat Treated",
    "Oiled",
    "Dyed",
    "Irradiated",
    "Fracture Filled",
    _other,
  ];

  // Selected dropdown values
  late String _selectedGemType;
  late String _selectedColor;
  late String _selectedOrigin;
  late String _selectedCut;
  late String _selectedClarity;
  late String _selectedTreatment;

  @override
  void initState() {
    super.initState();

    // Default selections
    _selectedGemType = _gemTypes.first;
    _selectedColor = _colors.first;
    _selectedOrigin = _origins.first;
    _selectedCut = _cuts.first;
    _selectedClarity = _clarities.first;
    _selectedTreatment = _treatments.first;
  }

  @override
  void dispose() {
    _title.dispose();
    _desc.dispose();
    _price.dispose();
    _location.dispose();
    _category.dispose();
    _weight.dispose();

    _gemTypeOther.dispose();
    _colorOther.dispose();
    _originOther.dispose();
    _cutOther.dispose();
    _clarityOther.dispose();
    _treatmentOther.dispose();
    super.dispose();
  }

  InputDecoration _decoration(String label, {String? hint, IconData? icon}) {
    return InputDecoration(
      labelText: label,
      hintText: hint,
      prefixIcon: icon == null ? null : Icon(icon),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(14)),
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
          )
        ],
      ),
      child: child,
    );
  }

  Widget _sectionTitle(String title, {String? subtitle}) {
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

  Future<void> _pickImages() async {
    final picker = ImagePicker();
    final files = await picker.pickMultiImage(imageQuality: 75, maxWidth: 1280);
    if (files.isNotEmpty) setState(() => _images.addAll(files));
  }

  void _removeImageAt(int index) => setState(() => _images.removeAt(index));

  String _finalValue(String selected, TextEditingController otherCtrl) {
    if (selected != _other) return selected;
    return otherCtrl.text.trim();
  }

  Future<void> _submit() async {
    if (_saving) return;

    final form = _formKey.currentState;
    if (form == null || !form.validate()) return;

    if (_images.isEmpty) {
      Get.snackbar("Images required", "Please select at least 1 image.");
      return;
    }

    setState(() => _saving = true);

    try {
      final user = UserController.instance.user.value;
      if (user.id.isEmpty) throw "User not loaded. Please re-login.";

      final repo = ProductRepository.instance;

      final productId = repo.newProductId();
      final price = double.tryParse(_price.text.trim()) ?? 0;
      final weight = double.tryParse(_weight.text.trim()) ?? 0;

      final gemType = _finalValue(_selectedGemType, _gemTypeOther);
      final color = _finalValue(_selectedColor, _colorOther);
      final origin = _finalValue(_selectedOrigin, _originOther);
      final cut = _finalValue(_selectedCut, _cutOther);
      final clarity = _finalValue(_selectedClarity, _clarityOther);
      final treatment = _finalValue(_selectedTreatment, _treatmentOther);

      final imageUrls = await repo.uploadImages(
        sellerId: user.id,
        productId: productId,
        images: _images,
      );

      final product = ProductModel(
        id: productId,
        title: _title.text.trim(),
        description: _desc.text.trim(),
        price: price,
        location: _location.text.trim(),
        category: _category.text.trim(),
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
        weightCarat: weight,
        cut: cut,
        clarity: clarity,
        treatment: treatment,
        certification: _certification,
      );

      await repo.createProduct(product: product);

      Get.back();
      Get.snackbar("Success", "Product listed successfully.");
    } catch (e) {
      Get.snackbar("Error", e.toString());
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  Widget _dropdown({
    required String label,
    required IconData icon,
    required String value,
    required List<String> items,
    required void Function(String?) onChanged,
  }) {
    return DropdownButtonFormField<String>(
      initialValue: value,
      decoration: _decoration(label, icon: icon),
      isExpanded: true,
      items: items.map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
      onChanged: _saving ? null : onChanged,
      validator: (v) => (v == null || v.trim().isEmpty) ? "Required" : null,
    );
  }

  Widget _otherFieldIfNeeded({
    required String selected,
    required TextEditingController controller,
    required String label,
  }) {
    if (selected != _other) return const SizedBox.shrink();
    return Padding(
      padding: const EdgeInsets.only(top: 12),
      child: TextFormField(
        controller: controller,
        decoration: _decoration(label, hint: "Type custom value"),
        validator: (v) {
          if (selected != _other) return null;
          return (v == null || v.trim().isEmpty) ? "Please enter value" : null;
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text("List Product"),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                _card(
                  child: Row(
                    children: [
                      Container(
                        width: 46,
                        height: 46,
                        decoration: BoxDecoration(
                          color: scheme.primary.withValues(alpha: 0.12),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Icon(Icons.diamond_outlined, color: scheme.primary),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _sectionTitle(
                          "Create a Gem Listing",
                          subtitle: "Add clear photos and accurate gem details to sell faster.",
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 14),

                // Photos
                _card(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _sectionTitle("Photos", subtitle: "Add at least 1 photo. More photos = more trust."),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          Expanded(
                            child: OutlinedButton.icon(
                              onPressed: _saving ? null : _pickImages,
                              icon: const Icon(Icons.image_outlined),
                              label: Text("Pick Images (${_images.length})"),
                            ),
                          ),
                          const SizedBox(width: 10),
                          if (_images.isNotEmpty)
                            IconButton(
                              onPressed: _saving ? null : () => setState(() => _images.clear()),
                              icon: const Icon(Icons.delete_outline),
                              tooltip: "Remove all",
                            ),
                        ],
                      ),
                      if (_images.isNotEmpty) ...[
                        const SizedBox(height: 12),
                        SizedBox(
                          height: 92,
                          child: ListView.separated(
                            scrollDirection: Axis.horizontal,
                            itemCount: _images.length,
                            separatorBuilder: (_, __) => const SizedBox(width: 10),
                            itemBuilder: (context, index) {
                              final img = _images[index];
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
                                      onTap: _saving ? null : () => _removeImageAt(index),
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
                _card(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _sectionTitle("Basic Information"),
                      const SizedBox(height: 12),
                      TextFormField(
                        controller: _title,
                        decoration: _decoration("Title", hint: "e.g. Certified Emerald Necklace", icon: Icons.title),
                        validator: (v) => (v == null || v.trim().isEmpty) ? "Required" : null,
                      ),
                      const SizedBox(height: 12),
                      TextFormField(
                        controller: _desc,
                        decoration: _decoration(
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
                              controller: _price,
                              decoration: _decoration("Price (Rs)", hint: "e.g. 50000", icon: Icons.currency_rupee),
                              keyboardType: TextInputType.number,
                              validator: (v) =>
                              (double.tryParse((v ?? "").trim()) == null) ? "Enter valid price" : null,
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: TextFormField(
                              controller: _location,
                              decoration: _decoration("Location", hint: "e.g. Gilgit", icon: Icons.location_on_outlined),
                              validator: (v) => (v == null || v.trim().isEmpty) ? "Required" : null,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      TextFormField(
                        controller: _category,
                        decoration: _decoration("Category", hint: "Emerald, Ruby, Sapphire...", icon: Icons.category_outlined),
                        validator: (v) => (v == null || v.trim().isEmpty) ? "Required" : null,
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 14),

                // Gem details as dropdowns + Other
                _card(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _sectionTitle("Gem Details", subtitle: "Select values or choose Other to type custom."),
                      const SizedBox(height: 12),

                      _dropdown(
                        label: "Gem Type",
                        icon: Icons.diamond_outlined,
                        value: _selectedGemType,
                        items: _gemTypes,
                        onChanged: (v) => setState(() => _selectedGemType = v ?? _gemTypes.first),
                      ),
                      _otherFieldIfNeeded(
                        selected: _selectedGemType,
                        controller: _gemTypeOther,
                        label: "Custom Gem Type",
                      ),

                      const SizedBox(height: 12),

                      _dropdown(
                        label: "Color",
                        icon: Icons.palette_outlined,
                        value: _selectedColor,
                        items: _colors,
                        onChanged: (v) => setState(() => _selectedColor = v ?? _colors.first),
                      ),
                      _otherFieldIfNeeded(
                        selected: _selectedColor,
                        controller: _colorOther,
                        label: "Custom Color",
                      ),

                      const SizedBox(height: 12),

                      _dropdown(
                        label: "Origin",
                        icon: Icons.public_outlined,
                        value: _selectedOrigin,
                        items: _origins,
                        onChanged: (v) => setState(() => _selectedOrigin = v ?? _origins.first),
                      ),
                      _otherFieldIfNeeded(
                        selected: _selectedOrigin,
                        controller: _originOther,
                        label: "Custom Origin",
                      ),

                      const SizedBox(height: 12),

                      TextFormField(
                        controller: _weight,
                        decoration: _decoration("Weight (Carat)", hint: "e.g. 5.2", icon: Icons.scale_outlined),
                        keyboardType: TextInputType.number,
                        validator: (v) =>
                        (double.tryParse((v ?? "").trim()) == null) ? "Enter valid number" : null,
                      ),

                      const SizedBox(height: 12),

                      _dropdown(
                        label: "Cut",
                        icon: Icons.auto_fix_high_outlined,
                        value: _selectedCut,
                        items: _cuts,
                        onChanged: (v) => setState(() => _selectedCut = v ?? _cuts.first),
                      ),
                      _otherFieldIfNeeded(
                        selected: _selectedCut,
                        controller: _cutOther,
                        label: "Custom Cut",
                      ),

                      const SizedBox(height: 12),

                      _dropdown(
                        label: "Clarity",
                        icon: Icons.visibility_outlined,
                        value: _selectedClarity,
                        items: _clarities,
                        onChanged: (v) => setState(() => _selectedClarity = v ?? _clarities.first),
                      ),
                      _otherFieldIfNeeded(
                        selected: _selectedClarity,
                        controller: _clarityOther,
                        label: "Custom Clarity",
                      ),

                      const SizedBox(height: 12),

                      _dropdown(
                        label: "Treatment",
                        icon: Icons.science_outlined,
                        value: _selectedTreatment,
                        items: _treatments,
                        onChanged: (v) => setState(() => _selectedTreatment = v ?? _treatments.first),
                      ),
                      _otherFieldIfNeeded(
                        selected: _selectedTreatment,
                        controller: _treatmentOther,
                        label: "Custom Treatment",
                      ),

                      const SizedBox(height: 12),

                      SwitchListTile(
                        contentPadding: EdgeInsets.zero,
                        value: _certification,
                        onChanged: _saving ? null : (v) => setState(() => _certification = v),
                        title: const Text("Certification Available"),
                        subtitle: const Text("Turn on if you have lab certificate/proof."),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 16),

                SizedBox(
                  width: double.infinity,
                  height: 52,
                  child: ElevatedButton(
                    onPressed: _saving ? null : _submit,
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                    ),
                    child: Text(_saving ? "Publishing..." : "Publish"),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}