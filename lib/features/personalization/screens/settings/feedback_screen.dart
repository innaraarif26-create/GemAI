import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:gemai/models/feedback_model.dart';
import 'package:gemai/services/Firebase/feedback_service.dart';
import 'package:gemai/core/utils/popups/loaders.dart';

class FeedbackScreen extends StatefulWidget {
  const FeedbackScreen({super.key});

  @override
  State<FeedbackScreen> createState() => _FeedbackScreenState();
}

class _FeedbackScreenState extends State<FeedbackScreen> {
  final _feedbackController = TextEditingController();
  final _feedbackService = FeedbackService();
  int _rating = 0;
  bool _isSubmitting = false;

  @override
  void dispose() {
    _feedbackController.dispose();
    super.dispose();
  }

  Future<void> _submitFeedback() async {
    if (_rating == 0) {
      AppLoaders.warningSnackBar(title: 'Rating required', message: 'Please select a star rating.');
      return;
    }

    if (_feedbackController.text.trim().isEmpty) {
      AppLoaders.warningSnackBar(title: 'Feedback required', message: 'Please enter your feedback.');
      return;
    }

    final userId = _feedbackService.currentUserId;
    final email = _feedbackService.currentUserEmail;

    if (userId == null || email == null) {
      AppLoaders.errorSnackBar(title: 'Not logged in', message: 'Please sign in to submit feedback.');
      return;
    }

    setState(() => _isSubmitting = true);

    try {
      final feedback = FeedbackModel(
        userId: userId,
        email: email,
        feedbackText: _feedbackController.text.trim(),
        rating: _rating,
        createdAt: DateTime.now(),
      );

      final success = await _feedbackService.submitFeedback(feedback);

      if (!mounted) return;

      if (success) {
        Navigator.of(context).pop();
        AppLoaders.successSnackBar(title: 'Thank you!', message: 'Your feedback has been submitted.');
      } else {
        AppLoaders.errorSnackBar(title: 'Error', message: 'Failed to submit feedback. Please try again.');
      }
    } catch (e) {
      if (mounted) {
        AppLoaders.errorSnackBar(title: 'Error', message: 'An unexpected error occurred.');
      }
    } finally {
      if (mounted) setState(() => _isSubmitting = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              /// Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Send Feedback',
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  IconButton(
                    onPressed: () => Navigator.of(context).pop(),
                    icon: const Icon(Icons.close),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              /// Rating Section
              Text(
                'How would you rate your experience?',
                style: Theme.of(context).textTheme.titleSmall,
              ),
              const SizedBox(height: 8),
              Row(
                children: List.generate(5, (index) {
                  return GestureDetector(
                    onTap: () => setState(() => _rating = index + 1),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      child: Icon(
                        _rating > index ? Iconsax.star1 : Icons.star_outline,
                        color: _rating > index ? Colors.amber : Colors.grey,
                        size: 32,
                      ),
                    ),
                  );
                }),
              ),
              const SizedBox(height: 24),

              /// Feedback Text Field
              Text(
                'Your Feedback',
                style: Theme.of(context).textTheme.titleSmall,
              ),
              const SizedBox(height: 8),
              TextField(
                controller: _feedbackController,
                maxLines: 5,
                maxLength: 500,
                decoration: InputDecoration(
                  hintText: 'Share your suggestions and feedback...',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  counterText: '${_feedbackController.text.length}/500',
                ),
                onChanged: (_) => setState(() {}),
              ),
              const SizedBox(height: 24),

              /// Action Buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: _isSubmitting ? null : () => Navigator.of(context).pop(),
                    child: const Text('Cancel'),
                  ),
                  const SizedBox(width: 12),
                  ElevatedButton.icon(
                    onPressed: _isSubmitting ? null : _submitFeedback,
                    icon: _isSubmitting
                        ? const SizedBox(
                            width: 18,
                            height: 18,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                        : const Icon(Iconsax.send1),
                    label: Text(_isSubmitting ? 'Submitting...' : 'Submit'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
