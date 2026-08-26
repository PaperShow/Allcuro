import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../core/network/api_client.dart';

/// App-wide infrastructure providers. Feature-level dependencies (services,
/// repositories, view models) are defined and provided from within their
/// own feature folders — this file only holds what's shared across features.
final apiClientProvider = Provider<ApiClient>((ref) => ApiClient());
