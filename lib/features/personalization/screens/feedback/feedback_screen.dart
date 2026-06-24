import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gemai/core/constants/colors.dart';
import 'package:gemai/core/constants/sizes.dart';
import 'package:gemai/core/utils/helpers/helper_functions.dart';
import 'package:gemai/core/utils/popups/login_required_dialog.dart';
import 'package:gemai/widgets/appbar/appbar.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import '../../../../core/utils/popups/loaders.dart';
import '../../../../data/repositories/feedback/feedback_repository.dart';
import '../../models/feedback_model.dart';

class FeedbackScreen extends StatefulWidget {
  const FeedbackScreen({super.key});

  @override
  State<FeedbackScreen> createState() => _FeedbackScreenState();
}

class _FeedbackScreenState extends State<FeedbackScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _messageController = TextEditingController();

  FeedbackCategory _selectedCategory = FeedbackCategory.suggestion;
  int? _selectedRating;
  bool _isLoading = false;

  @override
  void dispose() {
    _titleController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  Future<void> _submitFeedback() async {
    final currentUser = FirebaseAuth.instance.currentUser;

    if (currentUser == null) {
      await showLoginRequiredDialog(
        message: 'Please login to submit feedback.',
      );
      return;
    }

    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    final feedback = FeedbackModel(
      id: '',
      userId: currentUser.uid,
      title: _titleController.text.trim(),
      message: _messageController.text.trim(),
      rating: _selectedRating,
      category: _selectedCategory,
      createdAt: DateTime.now(),
    );

    try {
      await FeedbackRepository.instance.submitFeedback(feedback);

      _formKey.currentState!.reset();
      _titleController.clear();
      _messageController.clear();
      setState(() {
        _selectedCategory = FeedbackCategory.suggestion;
        _selectedRating = null;
        _isLoading = false;
      });

      AppLoaders.successSnackBar(
        title: 'Thank You!',
        message: 'Your feedback has been submitted successfully.',
      );
    } catch (e) {
      setState(() => _isLoading = false);
      AppLoaders.errorSnackBar(
        title: 'Submission Failed',
        message: e.toString(),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final dark = AppHelperFunctions.isDarkMode(context);

    return Scaffold(
      appBar: const AppAppBar(
        showBackArrow: true,
        title: Text('Feedback'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSizes.defaultSpace),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Send us your feedback',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(height: AppSizes.sm),
              Text(
                'We read every submission and use it to improve GemAI.',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(height: AppSizes.spaceBtwSections),

              /// Category
              Text(
                'Category',
                style: Theme.of(context).textTheme.labelLarge,
              ),
              const SizedBox(height: AppSizes.spaceBtwItems),
              DropdownButtonFormField<FeedbackCategory>(
                value: _selectedCategory,
                decoration: const InputDecoration(
                  prefixIcon: Icon(Iconsax.category),
                  border: OutlineInputBorder(),
                ),
                items: FeedbackCategory.values.map((cat) {
                  return DropdownMenuItem(
                    value: cat,
                    child: Text(FeedbackModel.categoryLabel(cat)),
                  );
                }).toList(),
                onChanged: (value) {
                  if (value != null) setState(() => _selectedCategory = value);
                },
              ),
              const SizedBox(height: AppSizes.spaceBtwSections),

              /// Title
              Text(
                'Title',
                style: Theme.of(context).textTheme.labelLarge,
              ),
              const SizedBox(height: AppSizes.spaceBtwItems),
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(
                  hintText: 'Brief summary of your feedback',
                  prefixIcon: Icon(Iconsax.edit),
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please enter a title.';
                  }
                  if (value.trim().length < 5) {
                    return 'Title must be at least 5 characters.';
                  }
                  return null;
                },
              ),
              const SizedBox(height: AppSizes.spaceBtwSections),

              /// Message
              Text(
                'Message',
                style: Theme.of(context).textTheme.labelLarge,
              ),
              const SizedBox(height: AppSizes.spaceBtwItems),
              TextFormField(
                controller: _messageController,
                maxLines: 5,
                decoration: const InputDecoration(
                  hintText: 'Describe your feedback in detail…',
                  alignLabelWithHint: true,
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please enter a message.';
                  }
                  if (value.trim().length < 10) {
                    return 'Message must be at least 10 characters.';
                  }
                  return null;
                },
              ),
              const SizedBox(height: AppSizes.spaceBtwSections),

              /// Rating (optional)
              Text(
                'Rating (optional)',
                style: Theme.of(context).textTheme.labelLarge,
              ),
              const SizedBox(height: AppSizes.spaceBtwItems),
              Row(
                children: List.generate(5, (index) {
                  final star = index + 1;
                  return IconButton(
                    icon: Icon(
                      (_selectedRating != null && _selectedRating! >= star)
                          ? Iconsax.star1
                          : Iconsax.star,
                      color: (_selectedRating != null &&
                              _selectedRating! >= star)
                          ? Colors.amber
                          : (dark ? AppColors.grey : AppColors.darkGrey),
                    ),
                    onPressed: () => setState(() {
                      _selectedRating =
                          (_selectedRating == star) ? null : star;
                    }),
                  );
                }),
              ),
              const SizedBox(height: AppSizes.spaceBtwSections),

              /// Submit Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _isLoading ? null : _submitFeedback,
                  child: _isLoading
                      ? const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: Colors.white,
                          ),
                        )
                      : const Text('Submit Feedback'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
