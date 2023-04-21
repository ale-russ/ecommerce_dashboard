import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../models/product.dart';
import '../notifier/upload_notifier.dart';

final uploadInfoProvider =
    NotifierProvider.autoDispose<UploadNotifier, Product>(UploadNotifier.new);
