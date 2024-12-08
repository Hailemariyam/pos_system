import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

// Cubit to manage navigation state
class NavigationCubit extends HydratedCubit<int> {
  NavigationCubit() : super(0); // Default selected index is 0 (Dashboard)

  void changeIndex(int index) => emit(index);

  @override
  int fromJson(Map<String, dynamic> json) {
    return json['index'] as int;
  }

  @override
  Map<String, dynamic> toJson(int state) {
    return {'index': state};
  }
}
