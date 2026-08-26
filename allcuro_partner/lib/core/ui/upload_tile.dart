import 'package:flutter/material.dart';

import '../theme/app_theme.dart';
import 'surface.dart';

/// One document-upload row, shared by the nurse and centre sign-up
/// wizards' document steps. There's no real file picker/storage backend
/// yet — [onTap] is expected to simulate an upload (set a fake file name
/// after a short delay); this widget only renders the state.
class UploadTile extends StatelessWidget {
  final String label;
  final String? fileName;
  final bool uploading;
  final VoidCallback? onTap;

  const UploadTile({
    super.key,
    required this.label,
    this.fileName,
    this.uploading = false,
    this.onTap,
  });

  bool get _uploaded => fileName != null;

  @override
  Widget build(BuildContext context) {
    return Surface(
      onTap: uploading ? null : onTap,
      padding: const EdgeInsets.all(14),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: _uploaded ? AppColors.successSoft : AppColors.secondary,
              shape: BoxShape.circle,
            ),
            child: Icon(
              _uploaded ? Icons.check_circle_rounded : Icons.upload_file_outlined,
              size: 20,
              color: _uploaded ? AppColors.success : AppColors.mutedForeground,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: const TextStyle(fontWeight: FontWeight.w700, color: AppColors.ink),
                ),
                Text(
                  _uploaded ? fileName! : 'Not uploaded yet',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: _uploaded ? FontWeight.w600 : FontWeight.w500,
                    color: _uploaded ? AppColors.success : AppColors.mutedForeground,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          if (uploading)
            const SizedBox(
              width: 18,
              height: 18,
              child: CircularProgressIndicator(strokeWidth: 2.2),
            )
          else
            Text(
              _uploaded ? 'Replace' : 'Upload',
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w800,
                color: AppColors.primary,
              ),
            ),
        ],
      ),
    );
  }
}
