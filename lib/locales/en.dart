import 'package:flutter_multilingues/Homepage.dart';

class FrLocal extends AppLocal {
  @override
  HomeLocal get home => HomeLocal(
        question: 'Aimez vous cette application ?',
        ctaYes: 'Oui',
        ctaNo: 'Non',
      );
}
