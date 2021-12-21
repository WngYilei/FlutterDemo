import 'package:xl_eyepetozer/viewmodle/base_change_notifier.dart';

class RecommendPhotoViewModel extends BaseChangeNotifier{
   int currentIndex = 1;

   changeIndex(int index) {
     this.currentIndex = index + 1;
     notifyListeners();
   }
}