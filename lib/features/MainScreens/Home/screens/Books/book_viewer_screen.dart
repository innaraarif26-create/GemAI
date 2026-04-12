import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../../core/constants/colors.dart';
import '../../../../../core/utils/helpers/helper_functions.dart';
import '../../../../../services/Firebase/reading_progress_service.dart';
import '../../../../../widgets/appbar/appbar.dart';
import '../../models/book_model.dart';

/// Screen for viewing a book's PDF content.
///
/// • For [BookSource.local] books it uses [SfPdfViewer.asset].
/// • For [BookSource.firebase] books it uses [SfPdfViewer.network].
/// • For [BookSource.googleBooks] books it opens the browser preview link.
///
/// Reading progress is auto-saved to Firestore every time the user
/// navigates to a new page.
class BookViewerScreen extends StatefulWidget {
  final BookModel book;
  final String? userId;

  const BookViewerScreen({
    super.key,
    required this.book,
    this.userId,
  });

  @override
  State<BookViewerScreen> createState() => _BookViewerScreenState();
}

class _BookViewerScreenState extends State<BookViewerScreen> {
  final ReadingProgressService _progressService = ReadingProgressService();
  final PdfViewerController _pdfController = PdfViewerController();

  int _currentPage = 1;
  int _totalPages = 0;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _restoreProgress();
  }

  /// Restores the last-read page from Firestore (if any).
  Future<void> _restoreProgress() async {
    if (widget.userId == null) return;
    final progress = await _progressService.getProgress(
      userId: widget.userId!,
      bookId: widget.book.id,
    );

    if (progress != null && progress.currentPage > 1) {
      // Jump after the viewer has had time to load
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _pdfController.jumpToPage(progress.currentPage);
      });
    }
  }

  /// Persists the current page to Firestore.
  Future<void> _saveProgress() async {
    if (widget.userId == null || _totalPages == 0) return;
    await _progressService.saveProgress(
      userId: widget.userId!,
      bookId: widget.book.id,
      currentPage: _currentPage,
      totalPages: _totalPages,
    );
  }

  void _onPageChanged(PdfPageChangedDetails details) {
    setState(() {
      _currentPage = details.newPageNumber;
    });
    _saveProgress();
  }

  void _onDocumentLoaded(PdfDocumentLoadedDetails details) {
    setState(() {
      _totalPages = details.document.pages.count;
      _isLoading = false;
    });
  }

  /// Goes to the previous page.
  void _previousPage() {
    if (_currentPage > 1) {
      _pdfController.previousPage();
    }
  }

  /// Goes to the next page.
  void _nextPage() {
    if (_currentPage < _totalPages) {
      _pdfController.nextPage();
    }
  }

  @override
  Widget build(BuildContext context) {
    // Google Books without a PDF -> open in browser
    if (widget.book.source == BookSource.googleBooks &&
        widget.book.pdfUrl == null) {
      return _buildPreviewFallback(context);
    }

    final bool dark = AppHelperFunctions.isDarkMode(context);

    return Scaffold(
      appBar: AppAppBar(
        title: Text(
          widget.book.title,
          style: Theme.of(context).textTheme.titleMedium,
          overflow: TextOverflow.ellipsis,
        ),
        showBackArrow: true,
      ),
      body: Stack(
        children: [
          // PDF viewer
          _buildPdfViewer(),

          // Loading indicator
          if (_isLoading)
            const Center(child: CircularProgressIndicator()),
        ],
      ),

      // Bottom navigation bar with page controls
      bottomNavigationBar: _totalPages > 0
          ? Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: dark ? Colors.grey[900] : Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.1),
                    blurRadius: 8,
                    offset: const Offset(0, -2),
                  ),
                ],
              ),
              child: SafeArea(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Previous page button
                    IconButton(
                      onPressed: _currentPage > 1 ? _previousPage : null,
                      icon: Icon(
                        Icons.arrow_back_ios,
                        color: _currentPage > 1
                            ? AppColors.buttonSecondary
                            : Colors.grey,
                      ),
                    ),

                    // Page indicator + progress bar
                    Expanded(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'Page $_currentPage of $_totalPages',
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                          const SizedBox(height: 4),
                          LinearProgressIndicator(
                            value: _totalPages > 0
                                ? _currentPage / _totalPages
                                : 0,
                            backgroundColor: dark
                                ? Colors.grey[800]
                                : Colors.grey[300],
                            valueColor: AlwaysStoppedAnimation<Color>(
                              AppColors.buttonSecondary,
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Next page button
                    IconButton(
                      onPressed:
                          _currentPage < _totalPages ? _nextPage : null,
                      icon: Icon(
                        Icons.arrow_forward_ios,
                        color: _currentPage < _totalPages
                            ? AppColors.buttonSecondary
                            : Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
            )
          : null,
    );
  }

  /// Builds the appropriate PDF viewer widget based on the book source.
  Widget _buildPdfViewer() {
    if (widget.book.source == BookSource.local &&
        widget.book.pdfUrl != null) {
      return SfPdfViewer.asset(
        widget.book.pdfUrl!,
        controller: _pdfController,
        onPageChanged: _onPageChanged,
        onDocumentLoaded: _onDocumentLoaded,
        enableDoubleTapZooming: true,
        canShowScrollHead: true,
      );
    }

    if (widget.book.pdfUrl != null && widget.book.pdfUrl!.isNotEmpty) {
      return SfPdfViewer.network(
        widget.book.pdfUrl!,
        controller: _pdfController,
        onPageChanged: _onPageChanged,
        onDocumentLoaded: _onDocumentLoaded,
        enableDoubleTapZooming: true,
        canShowScrollHead: true,
      );
    }

    // No PDF available – show a placeholder
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.menu_book, size: 64, color: Colors.grey[400]),
          const SizedBox(height: 16),
          Text(
            'No PDF available for this book.',
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          if (widget.book.previewLink != null) ...[
            const SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: () => _openPreviewLink(),
              icon: const Icon(Icons.open_in_browser),
              label: const Text('Open Preview in Browser'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.buttonSecondary,
                foregroundColor: Colors.white,
              ),
            ),
          ],
        ],
      ),
    );
  }

  /// Fallback screen for Google Books entries that only have a web preview.
  Widget _buildPreviewFallback(BuildContext context) {
    return Scaffold(
      appBar: AppAppBar(
        title: Text(
          widget.book.title,
          style: Theme.of(context).textTheme.titleMedium,
          overflow: TextOverflow.ellipsis,
        ),
        showBackArrow: true,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.menu_book, size: 80, color: Colors.grey[400]),
              const SizedBox(height: 24),
              Text(
                widget.book.title,
                style: Theme.of(context).textTheme.headlineSmall,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(
                'by ${widget.book.author}',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Colors.grey,
                    ),
              ),
              if (widget.book.description != null) ...[
                const SizedBox(height: 16),
                Text(
                  widget.book.description!,
                  style: Theme.of(context).textTheme.bodySmall,
                  textAlign: TextAlign.center,
                  maxLines: 6,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
              const SizedBox(height: 32),
              if (widget.book.previewLink != null)
                ElevatedButton.icon(
                  onPressed: () => _openPreviewLink(),
                  icon: const Icon(Icons.open_in_browser),
                  label: const Text('Open Google Books Preview'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.buttonSecondary,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 12,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  /// Launches the Google Books preview link in the device browser.
  Future<void> _openPreviewLink() async {
    if (widget.book.previewLink == null) return;
    final uri = Uri.parse(widget.book.previewLink!);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      if (mounted) {
        Get.snackbar('Error', 'Could not open preview link.');
      }
    }
  }

  @override
  void dispose() {
    _pdfController.dispose();
    super.dispose();
  }
}
